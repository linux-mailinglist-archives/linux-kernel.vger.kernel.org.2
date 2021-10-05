Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEFD421F89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhJEHl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:41:27 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A04C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 00:39:37 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id g10so5097714vsb.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 00:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mCCG0TZuJ3VQddK3ds0UKsyp103aPaFqEsL+R25NeQE=;
        b=NZridutPMmie0KUSJON0UzorxJSDKSwNVSj1D2YdUCcsO0Tb8BBE1Niy1F06EYHcjz
         kocBydyE9e4wl69JkYvPNZqpqfWGHTdRxXYADeGFSIPCgdVee8FwoSx1zOb7QZyALvvD
         VMR1Pz6CN3FbH1j+cXeEedGuVEYGtqJ5aGAfX5NZ1vUYxJbD2CIProOEQI+aDUqNu/AX
         mavhW09R1TmJIP10/bwVC+MLdWFMVxoUHhVKh5lY8yZ7DqmemF9mdaA+90bEjWOGHIFO
         bn0SURdHEdDaOKSF84VB3rhJ+pN6LTwDMRyI9Xugne5TZLAiP3YO0fpXG9oHWunYRQa6
         XxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mCCG0TZuJ3VQddK3ds0UKsyp103aPaFqEsL+R25NeQE=;
        b=zaYcxzoTfXUge8Ix87oOe96IIR8aogWRtNVNWb9Qw8buuGqNq4frGOHNgkCyerhvVA
         1QVVXvTL6bd/Cyims/sa6RkMVMEywGeSOkqSdS0Kcb5Lvk5dRQIfz0WoBSR2FiKNjuv0
         IBNlon/rMq9HYbsUf902MeRH24rPLgO6OQFbt+dFITFrtWJOf14hlgbFLPRzCzQWYSop
         aHhv+AN4pwbeImKnB9XOVyDYDzOF3ftPqAThjEoIq7cxuduVwCb7N3uzSGj1nGI8mRDJ
         Snynn/ogqm+9Ql7Z7Kob/hzBt8Sd751x4+V09GmmuWe1BBe8c6dna8fz2EGA3sXV2SMk
         zeVQ==
X-Gm-Message-State: AOAM532an09vZcwtvYITZeJQKo5uQprbkM7wHKcuIsMC9iF5qHzwLEkS
        crh/X4mZA7VcPTctzZBdh3kpKDzbhwZDiQ2qeCM=
X-Google-Smtp-Source: ABdhPJw/l++MWuMUj16pydJ/d9T2U0PUSzP8TSonzQv2eqIBZ1Nh3H/jLt3vk7mFkqM0QHchor7oKCEpTjBAqH2J/Zs=
X-Received: by 2002:a67:43c1:: with SMTP id q184mr17683591vsa.50.1633419576640;
 Tue, 05 Oct 2021 00:39:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:1d5e:0:b0:235:819b:712d with HTTP; Tue, 5 Oct 2021
 00:39:36 -0700 (PDT)
Reply-To: cristinacampeell@outlook.com
From:   "Mrs. Cristina Campbell" <smith76544@gmail.com>
Date:   Tue, 5 Oct 2021 08:39:36 +0100
Message-ID: <CAAYzYtM5pKaDdqF=hjsPv7G_aEfg4dqY0EHaM1QWdqNCtZq-AA@mail.gmail.com>
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
