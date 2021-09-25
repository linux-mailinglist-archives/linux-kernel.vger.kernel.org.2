Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9665C4181B8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 13:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244686AbhIYLr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 07:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbhIYLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 07:47:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD52C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 04:46:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n23so8413356pfv.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mCCG0TZuJ3VQddK3ds0UKsyp103aPaFqEsL+R25NeQE=;
        b=YbO5mbcjBgtikmksEn5Icxe8NHwbZf/qXCPi7mcTY6JgTgjV81SpE43gvSvmtzfc0K
         Pgd2Jr5iG5ecIqy/pmg9yTUhmk4PrN3w5D5ymYMITm11l3ydKtooM5Im/sN2eI0k2Vjt
         j9KF1FDnbKSkjXk7Wicgj1lmTgQ0lFqREukORd00oLdPBncyV5g9elCXIUD1fvySPJyO
         irQcDnzeUP56rWDVqD0NRMzsrQ0AlUVlKcY9qQD75T9i7WwYogcvdRGE3fpFx0IwYoly
         Zy2wANuFeTSKFK/XeCy5gwlEY3H42j/qZp4LrqyFTYSqz+PwiqtQ6lgOKgI/Hh7m5Ww3
         /uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mCCG0TZuJ3VQddK3ds0UKsyp103aPaFqEsL+R25NeQE=;
        b=D5phMoEAIcEgNxAzikkYlLVS8NeKKqpRwoMZAAf5XuS+u1l/bwm8U/tkI8om0OA+wC
         4nTr5rY8KdyILOGfkgEvnFPHGXG29GT/2IDyB5sYTcS9viPc8SSos+tc/OjhUkuztnqd
         x2Z+ZT5FGJpF65FCr4hWfpjXEiqyVw1D0+IXgEI52OK7LQnAPSaZq8dH7WYMqWpbobZS
         qk7XtbU+mh91HiqHbLgWKtKi5X/HaZEtFyBfkMw1100qm47twEci5s70LgJC6lizwKgT
         MxowUxNZtfPgwcUwOXP23bR4iAupICroaN0Bx7Lpz0j3JNsaHCL0lW6+a37tZtiDiWUS
         hLEQ==
X-Gm-Message-State: AOAM532YTg9YOq8xcOy5VDxg6tBeQ2hc1PSqByDIPHZH7dpRmCfZ7iuZ
        622SlrCwQ3SJsKKDY2LEwX/fShUNWDY8SlU1G20=
X-Google-Smtp-Source: ABdhPJxMDHcNrokdpTtYbaLrGqvke9nNX8pj6V0oX9lFZ04udgNPv1QpG2r5dTAUSWFSl4csS1oI4Flnd0pGSepFpj4=
X-Received: by 2002:a62:1b08:0:b0:43e:88f8:8f5e with SMTP id
 b8-20020a621b08000000b0043e88f88f5emr14307310pfb.41.1632570381360; Sat, 25
 Sep 2021 04:46:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:a11:0:0:0:0 with HTTP; Sat, 25 Sep 2021 04:46:20
 -0700 (PDT)
Reply-To: cristinacampeell@outlook.com
From:   "Mrs. Cristina Campbell" <sp2295675@gmail.com>
Date:   Sat, 25 Sep 2021 12:46:20 +0100
Message-ID: <CANV8sVHG0RyY_BiR4NR5yKk9yOQdmHZrkjnvmmQqFW4DGQ67Tg@mail.gmail.com>
Subject: Kannst du mir helfen?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lieber geliebter,

Bitte lesen Sie dies langsam und sorgf=C3=A4ltig durch, da es sich
m=C3=B6glicherweise um eine der wichtigsten E-Mails handelt, die Sie jemals
erhalten. Ich bin Mrs. Cristina Campbell, ich war mit dem sp=C3=A4ten
Edward Campbell verheiratet. Er arbeitete fr=C3=BCher f=C3=BCr die Shell
Petroleum Development Company London und war auch ein erfahrener
Bauunternehmer in der Region Ostasien. Er starb am Montag, 31. Juli
2003 in Paris. Wir waren sieben Jahre ohne Kind verheiratet.

W=C3=A4hrend Sie dies lesen, m=C3=B6chte ich nicht, dass Sie Mitleid mit mi=
r
haben, denn ich glaube, dass jeder eines Tages sterben wird. Bei mir
wurde Speiser=C3=B6hrenkrebs diagnostiziert und mein Arzt sagte mir, dass
ich aufgrund meiner komplizierten Gesundheitsprobleme nicht lange
durchhalten w=C3=BCrde.

Ich m=C3=B6chte, dass Gott mir barmherzig ist und meine Seele akzeptiert,
deshalb habe ich beschlossen, Almosen an Wohlt=C3=A4tigkeitsorganisationen
/ Kirchen / buddhistische Tempel / Moscheen / mutterlose Babys /
weniger Privilegierte und Witwen zu geben, da ich m=C3=B6chte, dass dies
eine der letzten guten Taten ist Ich tue es auf der Erde, bevor ich
sterbe. Bisher habe ich Geld an einige Wohlt=C3=A4tigkeitsorganisationen in
Schottland, Wales, Luxemburg, Finnland und Brasilien verteilt. Jetzt,
wo sich mein Gesundheitszustand so stark verschlechtert hat, kann ich
das nicht mehr selbst machen.

Ich habe einmal Mitglieder meiner Familie gebeten, eines meiner Konten
zu schlie=C3=9Fen und das Geld, das ich dort habe, an
Wohlt=C3=A4tigkeitsorganisationen in =C3=96sterreich, Belgien, Deutschland,
Italien und der Schweiz zu verteilen, sie weigerten sich und behielten
das Geld f=C3=BCr sich. Daher vertraue ich nicht sie nicht mehr, da sie
anscheinend nicht mit dem zufrieden sind, was ich ihnen hinterlassen
habe. Das letzte von meinem Geld, von dem niemand wei=C3=9F, ist die
riesige Bareinzahlung von sechs Millionen US-Dollar $ 6.000.000,00,
die ich bei einer Bank in Thailand habe, bei der ich den Fonds
hinterlegt habe. Ich m=C3=B6chte, dass Sie diesen Fonds f=C3=BCr
Wohlt=C3=A4tigkeitsprogramme verwenden und die Menschheit in Ihrem Land
unterst=C3=BCtzen, wenn Sie nur aufrichtig sind.

Ich habe diese Entscheidung getroffen, weil ich kein Kind habe, das
dieses Geld erben wird, ich habe keine Angst vor dem Tod, daher wei=C3=9F
ich, wohin ich gehe. Ich wei=C3=9F, dass ich im Scho=C3=9F des Herrn sein w=
erde.
Sobald ich Ihre Antwort erhalten habe, werde ich Ihnen den Kontakt der
Bank mitteilen und Ihnen eine Vollmacht ausstellen, die Sie als
urspr=C3=BCnglichen Beg=C3=BCnstigten dieses Fonds erm=C3=A4chtigt, dieses
Wohlt=C3=A4tigkeitsprogramm sofort in Ihrem Land zu beginnen.

Ich m=C3=B6chte, dass Sie immer f=C3=BCr mich beten. Jede Verz=C3=B6gerung =
Ihrer
Antwort wird mir Raum geben, eine andere Person zu diesem Zweck zu
finden. Wenn Sie kein Interesse haben, bitte ich um Entschuldigung f=C3=BCr
die Kontaktaufnahme. Sie erreichen mich mit oder antworten Sie mir
unter meiner privaten E-Mail: (cristinacampeell@outlook.com).


Vielen Dank,
Dein,
Frau Cristina Campbell
Email; cristinacampeell@outlook.com
