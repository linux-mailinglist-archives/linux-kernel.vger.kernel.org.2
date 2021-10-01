Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505BF41E898
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352619AbhJAH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhJAH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:59:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23A3C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 00:57:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u7so7187126pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=RbYHo/mBBUJTVbakewm8fXHU6Jcb1pgLkx3oJErKmK0=;
        b=H3pwA5WTgkijoexe7QnwCtXBMMcouTnZdGekKeBb3+2WILYP1HRm1bQ/07fLhdVOcg
         qf10ycFupIvs2pPkR57PNsEbqK2FTgRTGAJg5QWVP3jg1s/zxVfkTu9GZK2Z0izJZl1w
         ZSEsKIDVpjVI+JUmBHKFK1LuUq3vtgrY4cGIsD/Hmztk9PO+PWqTitg/pUg2EWONL8r/
         0Tz6cEOZBqX0NEEBAo9sslqdxHAQKg6FNuYWrdfTsa5Zkt8i+Mp+hCsb9GUA/RvhI0A/
         A58Q73eKPzVGf+wPQv837yg3ICY8d+TsvIsq8vhIp1SNb69jEov33ciXQ8SHTbG8fNce
         WUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=RbYHo/mBBUJTVbakewm8fXHU6Jcb1pgLkx3oJErKmK0=;
        b=blzrkeVQsRiF7D1siezf12W3h3tpSYzOfcHKH8RSYFcavhmpP9UIw1Iv6IuABp69ha
         xQkpxahw2JgBclbsWhWK0hIeUcDXGe3y0oOt/AO3gze9mjpS9ysXNcS6Tg7U/ntTYUyw
         4XdBiRrr+fx5ktu0fiNtq5fx+xYUk4+g0RwSViciW60tslLHmCI+eU3rt9levhHf/q2W
         +SPwqbDVFiRM05WNPFp5y7B47rI3OLRJdQ4fdGjHGV5U+sMy2Od6uL0u5/AQF2KgEHd7
         xOGHRlOBT0NMpoknZGVXQUS36Hnh/KmdeFGEpB72s8SVPNfX9wboG5NPxnX/weW2MbhX
         d6zQ==
X-Gm-Message-State: AOAM531GBDoff+e3ZFHkeR8yXdyTO2H3ibmKRR6lTr16zCyW9U+3VAeo
        2sLP0pTLKALA0A5VDfyHW5ndNRVb+owj2m/zGAk=
X-Google-Smtp-Source: ABdhPJx1ps0FJJc/dw32oa5l4l7iM2Kc9lKH31AKSQmOSnQvLxkr/c//kJduIMjvzuUkNEeTOfmSZI+gHj7GU5wFHzM=
X-Received: by 2002:a63:184a:: with SMTP id 10mr8640228pgy.149.1633075069320;
 Fri, 01 Oct 2021 00:57:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:648:0:0:0:0 with HTTP; Fri, 1 Oct 2021 00:57:47
 -0700 (PDT)
Reply-To: banqueatlantiquetogobranch@gmail.com
In-Reply-To: <CADRB3KprHTqZE4xLBCZZ2kQ5R1mgRamOPFnv8ZQWfoaLspEVOg@mail.gmail.com>
References: <CADRB3KprHTqZE4xLBCZZ2kQ5R1mgRamOPFnv8ZQWfoaLspEVOg@mail.gmail.com>
From:   "Ms. Kristalina Georgieva" <tonywoodto@gmail.com>
Date:   Fri, 1 Oct 2021 09:57:47 +0200
Message-ID: <CADRB3Kq9=7JQyhYqDyufafX3ymZp0yQJwxfVbNkWF7mqE-U44Q@mail.gmail.com>
Subject: 1/10/2021
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V=C3=A1=C5=BEen=C3=BD vlastn=C3=ADk e -mailu / pr=C3=ADjemca fondu,
Som pani Kristalina Georgieva, v=C3=BDkonn=C3=A1 riadite=C4=BEka a preziden=
tka
Medzin=C3=A1rodn=C3=A9ho menov=C3=A9ho fondu. Skuto=C4=8Dne sme presk=C3=BA=
mali v=C5=A1etky prek=C3=A1=C5=BEky
a probl=C3=A9my, ktor=C3=A9 sprev=C3=A1dzali va=C5=A1u ne=C3=BApln=C3=BA tr=
ansakciu a va=C5=A1u
neschopnos=C5=A5 vyrovna=C5=A5 sa s poplatkami za prevody =C3=BA=C4=8Dtovan=
=C3=BDmi za minul=C3=A9
mo=C5=BEnosti prevodu, nav=C5=A1t=C3=ADvte na=C5=A1e potvrdenie. strana 38 =
=C2=B0 53'56 "N 77 =C2=B0
2" 39 =E2=80=B3 F.

Predstavenstvo Svetov=C3=A1 banka a Medzin=C3=A1rodn=C3=BD menov=C3=BD fond=
 (MMF)
Washington DC v spolupr=C3=A1ci s ministerstvom financi=C3=AD USA a niektor=
=C3=BDmi
=C4=8Fal=C5=A1=C3=ADmi relevantn=C3=BDmi vy=C5=A1etrovac=C3=ADmi agent=C3=
=BArami v USA nariadili na=C5=A1ej
zahrani=C4=8Dnej prevodnej jednotke BANQUE ATLANTIQUE INTERNATIONAL TOGO
previes=C5=A5 kompenza=C4=8Dn=C3=BD fond v hodnote =E2=82=AC 761 000,00 na =
hlavn=C3=BA kartu
bankomatu a odo=C5=A1leme v=C3=A1m.

Po=C4=8Das n=C3=A1=C5=A1ho vy=C5=A1etrovania sme s hr=C3=B4zou zistili, =C5=
=BEe v=C3=A1=C5=A1 fond zbyto=C4=8Dne
zdr=C5=BEiavali skorumpovan=C3=AD =C3=BAradn=C3=ADci b=C3=A1nk, ktor=C3=AD =
sa pok=C3=BA=C5=A1ali presmerova=C5=A5
va=C5=A1e prostriedky na svoje s=C3=BAkromn=C3=A9 =E2=80=8B=E2=80=8B=C3=BA=
=C4=8Dty kv=C3=B4li svojim sebeck=C3=BDm
z=C3=A1ujmom. Dnes by sme v=C3=A1s chceli informova=C5=A5, =C5=BEe v=C3=A1=
=C5=A1 fond bol ulo=C5=BEen=C3=BD v
BANQUEATLANTIQUE INTERNATIONAL TOGO je pripraven=C3=A9 aj na doru=C4=8Denie=
,
teraz kontaktujte prof. Susana Robinsona, riadite=C4=BEa zahrani=C4=8Dn=C3=
=BDch
poukazov, BANQUE ATLANTIQUE INTERNATIONAL TOGO, e-mail:
banqueatlantiquetogobranch@gmail.com, po=C5=A1lite jej nasleduj=C3=BAce
inform=C3=A1cie, aby mohla previes=C5=A5 v=C3=A1=C5=A1 celkov=C3=BD kompenz=
a=C4=8Dn=C3=BD fond v hodnote
761 000,00 EUR do bankomatu Master Card a po=C5=A1leme v=C3=A1m ju bez
akejko=C4=BEvek chyby alebo oneskorenia.

(1) Va=C5=A1e =C3=BApln=C3=A9 meno ........................................=
...
(2) Va=C5=A1a adresa bydliska ..............................
(3) K=C3=B3pia v=C3=A1=C5=A1ho ob=C4=8Dianskeho preukazu alebo pasu .......=
....
(4) Va=C5=A1a krajina ...........................................
(5) PS=C4=8C =E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=
=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6.
(6) Va=C5=A1e s=C3=BAkromn=C3=A9 =E2=80=8B=E2=80=8Btelef=C3=B3nne =C4=8D=C3=
=ADslo ........................

S pozdravom
Pani Kristalina Georgieva
Gener=C3=A1lny riadite=C4=BE a prezident Medzin=C3=A1rodn=C3=A9ho menov=C3=
=A9ho fondu.
