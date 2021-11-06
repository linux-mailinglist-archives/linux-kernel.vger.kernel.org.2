Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D377446DAC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 12:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhKFLpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 07:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhKFLpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 07:45:18 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC64C061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 04:42:37 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 2so10336519iou.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 04:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EFS/qJJq2u3i9HcnYLVF3IVNVvcjNp8ZLU4zo+G1R0U=;
        b=iBlcjP96QoRQNDYF+lY/mZDV5h+ZXDlmpowfvwOyvslO7oOZTdrS6uc+WMoravCebi
         7MFvwWC/ZkRQ+Afbv9Lw6J21sqhoekIMf5fls75+q1DhZ8Gkq6pQv3oNIC3iuyoeSK2q
         QawSkb2XC2Gw2Oq1adgKEgsLe4dwopRQ4Y5VsXml1EnmYFJGEqkCow1hL2H5fkidkt1i
         ade3ZRH01YFZZnuBe20/lEsJfaJC46wrbMj5l8sldfXAevEzZseBN3OmsIa+xTD74fL+
         8IK2gXgErFUw4O7hYMOKzGWL6CZ8VASldr8x9mOFzuQZEBHegzAbiZrXE+4KAQ3Mji3r
         3wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=EFS/qJJq2u3i9HcnYLVF3IVNVvcjNp8ZLU4zo+G1R0U=;
        b=yCMdROWMVVHuWrnqrHr4BQVU0r11U5gEPyE9duB/KeBabY28lHeGysjD08Epps2qNG
         x86EDxpAdkPhOHOD4XvHZifigcb++rq6WyTUqc5rSabVkLcwh3pa9ibFUHTyIFi4z7RL
         NH4IlVpGZ1gNrK93LjTilTkeWDzsPsZ6egpBxgSbDt2P+EgRrcuk7cQ0ijkgbhrycyzG
         yFqV78aqnMcvG8t+PdLUi1u0Ia/uFQiTAs7JZjEAmEnVw2ZBvr+UY7FAGgPg/5oBG0xs
         vQJ0p9Yv87XDNOGiRMasbd3f2sujtivCCgDMBHfvkQyxGFZhGPtjVDX+y+joWQV8rf3Y
         doKA==
X-Gm-Message-State: AOAM533MS1Mih2U4jVqVmgIf99D9OG2XBLd92RLhiTxlm9GyQXUPBL1j
        LwPASM18cJp0vurMKtWUHBc0WAnSkYtqgdutf4E=
X-Google-Smtp-Source: ABdhPJwlyR94RgBspI8yHyXXsAI+7On9mWM1TyLymJ8Fws6d5WEM46lTkjxS3TP+wryECZqxBK7VLYLCTdoe/N17mpc=
X-Received: by 2002:a05:6602:1cc:: with SMTP id w12mr3827984iot.63.1636198956841;
 Sat, 06 Nov 2021 04:42:36 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: unnation1860@gmail.com
Received: by 2002:a6b:8d11:0:0:0:0:0 with HTTP; Sat, 6 Nov 2021 04:42:36 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Sat, 6 Nov 2021 12:42:36 +0100
X-Google-Sender-Auth: S7O7BBbA9tUxX_5GAUkmlpWTcOI
Message-ID: <CAMKcg84X4+ipPkw2eaFD0MVL0D5wncLiUkQEOYHBcmJ2gDftYA@mail.gmail.com>
Subject: =?UTF-8?B?w4kgdW0gcHJhemVyIGluZm9ybcOhLWxv?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oi,

Como voc=C3=AA est=C3=A1? Estou muito feliz em inform=C3=A1-lo sobre meu su=
cesso. No
momento, estou fora do pa=C3=ADs para fazer um investimento com parte da
minha parte, ap=C3=B3s concluir a transfer=C3=AAncia com um empres=C3=A1rio=
 indiano.
Mas irei visitar o seu pa=C3=ADs, no pr=C3=B3ximo ano, ap=C3=B3s a conclus=
=C3=A3o do meu
projeto. Por favor, contacte a minha secret=C3=A1ria para enviar-lhe o
cart=C3=A3o (multibanco) que j=C3=A1 creditei no valor de ($ 300.000,00). B=
asta
entrar em contato com ela para ajud=C3=A1-lo a receber o cart=C3=A3o (ATM).=
 J=C3=A1
expliquei tudo para ela antes da minha viagem. Isso =C3=A9 o que posso
fazer por voc=C3=AA porque voc=C3=AA n=C3=A3o p=C3=B4de ajudar na transfer=
=C3=AAncia, mas pelo
fato de ser a pessoa com quem entrei em contato inicialmente para a
transfer=C3=AAncia. Decidi dar este ($ 300.000,00) como compensa=C3=A7=C3=
=A3o por ter
sido contatado inicialmente para a transfer=C3=AAncia. Sempre procuro fazer
a diferen=C3=A7a, no trato com as pessoas sempre que entro em contato com
elas. Tamb=C3=A9m estou tentando mostrar que sou uma pessoa bem diferente
das outras que podem ter um prop=C3=B3sito diferente dentro delas. Acredito
que voc=C3=AA me prestar=C3=A1 alguma ajuda quando eu, visitar seu pa=C3=AD=
s, para
outro investimento l=C3=A1. Portanto, entre em contato com minha secret=C3=
=A1ria
para obter o cart=C3=A3o. Os contatos dela s=C3=A3o os seguintes,

Nome completo: Sra., Jovita Dumuije,
Pa=C3=ADs: Burkina Faso
Email: jovitadumuije@gmail.com

Obrigado e espero por uma boa empresa com voc=C3=AA no futuro.

Godwin Peter,
