Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3188421F88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhJEHko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhJEHkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:40:43 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E43C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 00:38:52 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id n65so13728281ybb.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mCCG0TZuJ3VQddK3ds0UKsyp103aPaFqEsL+R25NeQE=;
        b=CsBaDxVVahcD88Q5t4Zv1CMaE0810mE9kdSiBNA6OwrxtIQLvqrYN+3jZkLyZBhfYP
         kPcPPE6he3La5jRaxB8V+3O2+gW6Ps2qKBCGVr8PTUbveooeG1zcBZyEs5ZaOlP2OsXK
         pR0WuPJYVwkGYwLY0ZEhQ5pk+4VDLitw+HWQVobVaipOwLuZHWA73+bOKOcEadpCI9uZ
         BGbZF4AgwU5Igfs2/vsIiK9M9zOCWjulpKeZ1HnZ0D5ZmX2/14fTe8rsflRdCyJrLD7H
         o2CBGbGA91t0POVm6uaVV9JxPiXR3zsy9tD0DdEVDObLnSslEYvJbPRRsqzxNDAJ/Csr
         LgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mCCG0TZuJ3VQddK3ds0UKsyp103aPaFqEsL+R25NeQE=;
        b=UjpfGiNj8Ncuvwr32weF13vtja8TWQTLgN5yFjFZntgoVk6FNmHaH0pSTP0a0fQQlI
         RSFFhDBzszXyg22AeT2lalAUaNSA5+jQrnPSGJZp4bCX1+5IuxyV0qWO8s3SagNkna8q
         CtbARowy9dVNo3au4D0OJLhk7vUipNlWP0ugsKTJipLPjs5CNplGXNK2EXR1cOmSrH0m
         2PveC0GDHOSVRcr5P1ng5Zwdmg4O/3r7KsK0W4zX7NVgni8RgconGj8u+bRd06scJZWj
         n1CdTYLywfpJzveCwsVpP6JI/SoPIQlmuZqMxh/FKw3DUhFVvpEgrEZJPraIlM77q+r1
         bPnw==
X-Gm-Message-State: AOAM532j6qNcfCsYjtBBxGrIT6JxL/ztg2zdts4bXbSYHEL+crdssy4X
        jmKUbEmBcG9OnS8Xg+E6LsjQV6sbGyeiGHO8Zig=
X-Google-Smtp-Source: ABdhPJzEvcYrqRD6j5JpFcvkYDO8UD+/Ui8Q9g3ezk82Mq/mOslf0hQlCTCNXrER9jYloioKtwGxSzID+a/DKuBIGQU=
X-Received: by 2002:a25:5488:: with SMTP id i130mr20948047ybb.454.1633419532148;
 Tue, 05 Oct 2021 00:38:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:4586:0:0:0:0 with HTTP; Tue, 5 Oct 2021 00:38:51
 -0700 (PDT)
Reply-To: cristinacampeell@outlook.com
From:   "Mrs. Cristina Campbell" <john69345@gmail.com>
Date:   Tue, 5 Oct 2021 08:38:51 +0100
Message-ID: <CAFEch-Bi-ToHK3XVvk_OVXyt2Vbsi2y8AL1u0j2BcNcYPF_-VQ@mail.gmail.com>
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
