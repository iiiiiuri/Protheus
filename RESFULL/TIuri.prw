

#include "TOTVS.CH"
#include "RESTFUL.CH"
#include "protheus.ch"

User Function TIuri()
    // Define a URL da API
    cURL := "http://192.168.0.54:80"
    // Define o caminho da API
    cPath := "/bible/api/v1/"

    // Cria uma inst�ncia do objeto FWRest
    oRest := FWRest():new(cURL)
    oRest:setPath(cPath)

    // Verifica se a solicita��o GET foi bem-sucedida
    If oRest:Get()
        // Obt�m o resultado da solicita��o
        cJSON := DecodeUtf8(oRest:getResult())
        
        // Cria uma inst�ncia do objeto JsonObject
        oJson := JsonObject():New()

        // Transforma o texto em objeto JSON
        ret := oJson:FromJson(cJSON)

        If ValType(ret) == "C"
            // Se houver um erro na transforma��o, exibe uma mensagem de erro
            MsgStop("Falha ao transformar texto em objeto json. Erro: " + ret, "Erro")
        Else
            // Extrai os valores das chaves "text" e "book"
            cText := oJson["text"]
            cBook := oJson["book"]

            MsgInfo( "Seja bem-vindo Iuri," + Chr(13) + Chr(10) + "O vers�culo do dia �: " + cText + ", " + cBook)
        EndIf

        // Libera o objeto JSON
        FreeObj(oJson)
    Else
        // Se houver um erro na solicita��o, exibe uma mensagem de erro
        MsgStop(oRest:getLastError(), "Erro")
    EndIf

Return

