Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5D43277B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhJRTX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhJRTX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:23:26 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCE5C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:21:14 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so1185154otk.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=w44//2eXLGXS5FENoyNj0OHUbjoQNnYElfzxl74VOjo=;
        b=jLZyB8aMRvPdMJaWoNU3+BFC+pVFwJRmkpMlPBkeyIokpbWc3bIIDslTir1pRFkqy7
         VGOMucNZC9U2YGAC4b/424uCKH+FmA33Bazgd1xPD1cul8BhHR7e47+iGshye5er4Qku
         41jA4aNKc/+1Zq0w7fHUM+jNSu08J1/mROceJOcvtlY1zVA1tBbLvsNUjcqYYaGVqfxu
         fqrpdBinBet2a7fgLE8rvqkpp3pAKTGJuSAyncJY1FuPZ/qggzKtcRVu/P5/wFx0WmIM
         e+V3XPSstyFmsmQnc1fnQlSh7kW3tLi2SoOWo3pTGKOduhpgx44NJ7z2RlwliqzIX5sw
         BCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=w44//2eXLGXS5FENoyNj0OHUbjoQNnYElfzxl74VOjo=;
        b=7+/giyukYoDVHN1jDNXc63mCzzsPU+8IrCI5q+knp+N+eUu5tOEcu8OEa/x3b8z7If
         jMsfKdEvjU0he0S8Qz8LDBclHAutbYD/e5rRY2V659sUApFxaMldVMRxSaYtUGjhmaYW
         i0SKddahVVGR39Tq9ZGkNOQa6M8CbrMkk/TKRuKKL19A9xICXzlKa6oDEKGqB9wWRS9r
         eUvePSvOl8L/4eDt+9zHdVTCQBUc9qmIlKDqfnteHDG5oKYtkK+I9f7FDcH0SEp0xFp0
         6KSTxz9AJmNeFFWhurl/U75pAw3h2zyGmf9DNaUDdEOO19IK9jk1eUaUiJmf2pZHrU3q
         CYjA==
X-Gm-Message-State: AOAM532Bub2ir3OeES/JsLyg7oxZZQbFCPnjtEH16uA/jGhgAreBFRYz
        DVuIkoOFhAz1l2+k15qyaUcwtzLjfGJDaSbsmvs=
X-Google-Smtp-Source: ABdhPJzau9WkWxmEhxgfrxB+g7RKeATDk8ZOV4+5r28KVX7ZNwbch9QkbOHb52RrRgpiaciKHieLVGFo8IFKhqn1X/8=
X-Received: by 2002:a9d:4616:: with SMTP id y22mr1398483ote.215.1634584873489;
 Mon, 18 Oct 2021 12:21:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6820:203:0:0:0:0 with HTTP; Mon, 18 Oct 2021 12:21:12
 -0700 (PDT)
Reply-To: uchennailobitenone@gmail.com
From:   uchenna <uchekalu0211@gmail.com>
Date:   Mon, 18 Oct 2021 12:21:12 -0700
Message-ID: <CADXpZ39y6VKGDNPrpVEtF=MFWWtr_Dsc6wAKodBG0ShZEpbiJA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caro amigo,

Como voc=C3=AA est=C3=A1? Eu acho que voc=C3=AA est=C3=A1 bem e saud=C3=A1v=
el. Isto =C3=A9 para informar
voc=C3=AA que conclu=C3=AD a transa=C3=A7=C3=A3o com sucesso. Tem sido um l=
ongo
tempo desde a nossa =C3=BAltima comunica=C3=A7=C3=A3o. Foi uma pena que sua=
 parceria
comigo n=C3=A3o conseguiu concluir a transfer=C3=AAncia do fundo. Acho que =
chegou a hora
quando havia tanta press=C3=A3o e confus=C3=A3o que voc=C3=AA se tornou men=
os
interessado na transa=C3=A7=C3=A3o.


Em qualquer caso, tenho o prazer de inform=C3=A1-lo sobre meu sucesso em
obter o fundo
transferidos sob a coopera=C3=A7=C3=A3o do novo parceiro. Estou atualmente =
em
Venezuela em investimento. No entanto; eu n=C3=A3o esqueci seu esfor=C3=A7o=
 passado e
tenta me ajudar na transfer=C3=AAncia do fundo, apesar do fato de que
n=C3=A3o conseguiu chegar a uma conclus=C3=A3o espec=C3=ADfica.

Em agradecimento por sua tentativa de ajudar, eu e meu novo parceiro
chegamos a um
decis=C3=A3o que voc=C3=AA merece ser compensado, esta carta =C3=A9, portan=
to, para
informo que deixei uma indeniza=C3=A7=C3=A3o de $ 350.000,00 em seu nome pa=
ra que
voc=C3=AA vai compartilhar a alegria comigo. Aconselho voc=C3=AA a entrar e=
m
contato com o banco BTCI para o
transfer=C3=AAncia dos $ 350.000,00. Para evitar um longo atraso do fundo
de compensa=C3=A7=C3=A3o
transfer=C3=AAncia, instru=C3=AD o banco BTCI a emitir um cart=C3=A3o inter=
nacional
de visto de ATM
e envie-o para o seu endere=C3=A7o residencial por meio de uma empresa de e=
ntregas.

As informa=C3=A7=C3=B5es de contato do banco s=C3=A3o indicadas abaixo:

Nome do banco: Banco BTCI
Endere=C3=A7o de e-mail: btcbanktg478@gmail.com
Endere=C3=A7o: 169, Boulevard du 13 janvier BP 363 Lom=C3=A9, Togo
Pessoa de contato: Sr. Leonard Mathias

Informe-me assim que receber o cart=C3=A3o Visa ATM do banco BTCI. eu desej=
o
voc=C3=AA sucesso em todos os seus empreendimentos.

Cumprimentos
Barrister uchenna ilobi
