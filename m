Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404E845729A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbhKSQTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhKSQTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:19:34 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B432DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:16:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so9227858pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eibhgHyEnDty6prD7kw2qZTGk1uH223Sz/QXKL+fHLw=;
        b=ZZT+647Uz8SpqIzDGjkCorUYqTbdRKcZfquePZQtptm3RyD6TXHuAvyBBOOJX4kKEL
         IaRtyMOttCu5u9ILhRb1tcMIX6B5AQd1/MH/qNaQCeY0OOXWBojBbsPZ0wFKbY3g0Tpr
         OvDrA36yTgG7Vnl4RDT0DsLx4pC0ATqDE4O6kCc0peHMw/Rw1CzsOZq5i4dKyyBZCIht
         +DbPnZhT8x0D3dJZTlI/vsUYmQQR09Oj1GONUnU7EtsrCCQTF9WmEoK1yl6LDCs36qdw
         JJtYZd9+ufI2JvQqME3ckPt3JP/T+27UAoehGZi4ZDsEOZ9VdG0LESwCe40W2x2HBWIt
         LCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=eibhgHyEnDty6prD7kw2qZTGk1uH223Sz/QXKL+fHLw=;
        b=GBGTw4L1sie0b1UsQauUj4nTsNCvvZmG3nflmfyEtn116y/allDyxorm+8PYZ3iIIm
         53JI7gCAPLHTqK3T2GY+/0YG8+amKMV8O9fnB0BHVb+IlRqV6phx+mEXtsOCxOAMIKoN
         pIFdhiJQf+c4H5JDxYf1UqhYgOtunWWuZPfCYq1mkSOeLxxJ8+mdWYffYuwz6+AGLJyg
         978tFVtGK07e5tJhH+Ql6yyd3w6NN70giKsAu/BVrd7sRrXMkA3i6yjhA5L+rCldFD8U
         cD/sELcuQDS9rIjg9NaqAYflqSbi7r5KuHYj0QwGSckRkkW04MxVbMfgn4rbFHCLwSx0
         qF1A==
X-Gm-Message-State: AOAM532olwyNjKQZl2CmY1+dA9+TGZIChTDXdoUmnDMsocNv/pvSEaTd
        ZI2wW40lg4y0a6E+Xej6kOw3dXevQcWM6H6dX3M=
X-Google-Smtp-Source: ABdhPJx3h925az28R2FGXXKehSs96JNHe8xARoAmfIHgXvmk9Mb6Se8YwelLzQjrn+b4Xm8VOpr796J3HhtdQGPKjow=
X-Received: by 2002:a17:90b:3890:: with SMTP id mu16mr975971pjb.186.1637338591155;
 Fri, 19 Nov 2021 08:16:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a20:44d:b0:5b:6541:6b4b with HTTP; Fri, 19 Nov 2021
 08:16:30 -0800 (PST)
Reply-To: msbelinaya892@gmail.com
From:   msbelinaya <huisterlui75@gmail.com>
Date:   Fri, 19 Nov 2021 16:16:30 +0000
Message-ID: <CAAcQqWju=KN9KfNSG1YT8eYi=+99c9JL5dm0hk8LRARRLk4eBA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ich biete meine Freundschaft an und glaube, dass Sie mich mit gutem
Herzen akzeptieren werden. Ich wurde gedr=C3=A4ngt, Sie zu kontaktieren und
zu sehen, wie wir einander am besten unterst=C3=BCtzen k=C3=B6nnen. Ich bin=
 Frau
Kodjovi Hegbor aus der T=C3=BCrkei und arbeite als Divisionsleiterin f=C3=
=BCr
Operationen bei der StandardBNP bank limited Turkey . Ich glaube, es
ist der Wille Gottes, dass ich Ihnen jetzt begegnen werde. Ich habe
ein wichtiges gesch=C3=A4ftliches Gespr=C3=A4ch, das ich mit Ihnen teilen
m=C3=B6chte, von dem ich glaube, dass es Sie interessiert, da es mit Ihrem
Nachnamen in Verbindung steht und Sie davon profitieren werden.

 Im Jahr 2006 hat ein B=C3=BCrger Ihres Landes ein Nicht-Residentenkonto
f=C3=BCr 36 Monate des Kalenders im Wert von =C2=A38.400.000,00 bei meiner =
Bank
eingerichtet. Das Ablaufdatum f=C3=BCr diesen Einlagenvertrag war der 16.
Januar 2009. Leider starb er w=C3=A4hrend einer Gesch=C3=A4ftsreise bei ein=
em
t=C3=B6dlichen Erdbeben am 12. Mai 2008 in Sichuan, China, bei dem
mindestens 68.000 Menschen ums Leben kamen.

Das Management meiner Bank hat noch nichts von seinem Tod erfahren,
ich wusste davon, weil er mein Freund war und ich sein Kontof=C3=BChrer
war, als das Konto vor meiner Bef=C3=B6rderung er=C3=B6ffnet wurde. Jedoch =
Herr
 erw=C3=A4hnte bei der Kontoer=C3=B6ffnung keine n=C3=A4chsten Verwandten/E=
rben, und
er war nicht verheiratet und hatte keine Kinder. Letzte Woche hat
meine Bankdirektion mich gebeten, Anweisungen zu geben, was mit seinen
Geldern zu tun ist, wenn der Vertrag verl=C3=A4ngert werden soll.

Ich wei=C3=9F, dass dies passieren wird, und deshalb habe ich nach einem
Mittel gesucht, um mit der Situation umzugehen, denn wenn meine
Bankdirektoren wissen, dass sie tot sind und keinen Erben haben,
werden sie das Geld f=C3=BCr ihren pers=C3=B6nlichen Gebrauch nehmen, also =
Ich
m=C3=B6chte nicht, dass so etwas passiert. Das war, als ich Ihren Nachnamen
sah, ich war gl=C3=BCcklich und suche jetzt Ihre Mitarbeit, um Sie als Next
of Kin/Erbe des Kontos zu pr=C3=A4sentieren, da Sie den gleichen Nachnamen
wie er haben und meine Bankzentrale das Konto freigeben wird f=C3=BCr dich.
Es besteht kein Risiko; die Transaktion wird im Rahmen einer legitimen
Vereinbarung ausgef=C3=BChrt, die Sie vor Rechtsverletzungen sch=C3=BCtzt.

Es ist besser, dass wir das Geld beanspruchen, als es den
Bankdirektoren zu erlauben, es zu nehmen, sie sind bereits reich. Ich
bin kein gieriger Mensch, daher schlage ich vor, dass wir das Geld zu
gleichen Teilen teilen, 50/50% auf beide Parteien. Mein Anteil wird
mir helfen, mein eigenes Unternehmen zu gr=C3=BCnden und den Erl=C3=B6s f=
=C3=BCr
wohlt=C3=A4tige Zwecke zu verwenden, was mein Traum war.

Teilen Sie mir Ihre Meinung zu meinem Vorschlag mit, bitte ich brauche
wirklich Ihre Hilfe bei dieser Transaktion. Ich habe Sie ausgew=C3=A4hlt,
um mir zu helfen, nicht durch mein eigenes Tun, meine Liebe, sondern
durch Gott wollte ich, dass Sie wissen, dass ich mir Zeit zum Beten
genommen habe =C3=BCber diese Mitteilung, bevor ich Sie jemals kontaktiert
habe, teilen Sie mir Ihre Meinung dazu mit und behandeln Sie diese
Informationen bitte als STRENG GEHEIM. Nach Erhalt Ihrer Antwort,
ausschlie=C3=9Flich =C3=BCber meine pers=C3=B6nliche E-Mail-Adresse,
msbelinaya892@gmail.com
gibt Ihnen Details zur Transaktion. Und eine Kopie der
Einlagenbescheinigung des Fonds sowie die Gr=C3=BCndungsurkunde der
Gesellschaft, die den Fonds erstellt hat.
Gott segne, in Erwartung Ihrer dringenden Antwort
Mit freundlichen Gr=C3=BC=C3=9Fen
Frau Kodjovi Hegbor
msbelinaya892@gmail.com
