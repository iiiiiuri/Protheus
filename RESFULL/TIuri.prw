

#include "TOTVS.CH"
#include "RESTFUL.CH"
#include "protheus.ch"

User Function TIuri()
    // Define a URL da API
    cURL := "http://192.168.0.54:80"
    // Define o caminho da API
    cPath := "/bible/api/v1/"

    // Cria uma instância do objeto FWRest
    oRest := FWRest():new(cURL)
    oRest:setPath(cPath)

    // Verifica se a solicitação GET foi bem-sucedida
    If oRest:Get()
        // Obtém o resultado da solicitação
        cJSON := DecodeUtf8(oRest:getResult())
        
        // Cria uma instância do objeto JsonObject
        oJson := JsonObject():New()

        // Transforma o texto em objeto JSON
        ret := oJson:FromJson(cJSON)

        If ValType(ret) == "C"
            // Se houver um erro na transformação, exibe uma mensagem de erro
            MsgStop("Falha ao transformar texto em objeto json. Erro: " + ret, "Erro")
        Else
            // Extrai os valores das chaves "text" e "book"
            cText := oJson["text"]
            cBook := oJson["book"]

            MsgInfo( "Seja bem-vindo Iuri," + Chr(13) + Chr(10) + "O versículo do dia é: " + cText + ", " + cBook)
        EndIf

        // Libera o objeto JSON
        FreeObj(oJson)
    Else
        // Se houver um erro na solicitação, exibe uma mensagem de erro
        MsgStop(oRest:getLastError(), "Erro")
    EndIf

Return

