Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E7444F440
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 17:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhKMQ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 11:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbhKMQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 11:57:09 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE3DC061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 08:54:17 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id v3so25405674uam.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 08:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Y5xrcoQVIg2YEh3v1j5Qs7Wbw0zmiBD1dx0P9N3lmL4=;
        b=APjZLNr2le1bOAyeDx+Y5htjuml86bb6J150NrEQgGoUi1cfTKK7sIE1Yt1npvknZ2
         xJ4ZV3mm/vUgPTveryPFHfTfx9JcMqevSvmfWLbjQEUbdJFqiOfo+CrohuQvQrrSNN8f
         keHt0OhtLISNbut3PUiaGwgcGPuzyYAi0gUjcXYMrHEn3ilC3niSDnXtFfomMgXmOctt
         AR7AgAF44+XlX5K4dczB+uw28aUQulT5MXzKMfqO5+URB1Ep/nNeg9adnJqhFyRkLXAE
         uMpPKqtLMZu+yo5s6NuZylcNMq4WVZfx6/Uods+m5wTwhrUHE+rMEV6GLn5h6tc5tO7V
         z9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Y5xrcoQVIg2YEh3v1j5Qs7Wbw0zmiBD1dx0P9N3lmL4=;
        b=unT/Z1sKRCCP4EcpyLKgzFaszDDK5Vrg0yEGve3YXrBsT0WJ3UYoEHjWCliscxVCkc
         nwc6limef3B+LkeYgcueNVB7LeM8slMJvI+bppDOZLIF/lxxWtNAaVfrq6+vGdQYoR6H
         JhAQskyKZysXGyGMaXqd/2s1DgdQh4u6YTeUOjDkzCYUsm1uVTEcdtNfAkxT4skb1SZV
         P1PUDx9FFuAMTzd3YvQDfDEMR8dOF20sJzHNP0O6Fbjk2Z/0+NI3zPw3zQqG/BYVxr14
         Ff0bSjmq8WBDDsvgkgoko9ev4WU3SDHhARTd2s8ludFituZVySeMW4tr2WOJ/FWY5Slo
         t/VA==
X-Gm-Message-State: AOAM530Qi1wHkZ41IqRD9ike6QDcxdI0mb7X3dRGEw22SQRczpzNAdno
        PI5E/gjAb1UKVGqu31b71gIpxBAMMcx6eYKfdA4=
X-Google-Smtp-Source: ABdhPJxQxi9gh2fFmFRhFxBiWeLd/kZ7RqEiRJ+EXXVc4qHzzdDDVSsAEIXK/tPA9eKHYGqosYgRk3oqkYswcEQ5HJ4=
X-Received: by 2002:a67:fad4:: with SMTP id g20mr23222178vsq.1.1636822456589;
 Sat, 13 Nov 2021 08:54:16 -0800 (PST)
MIME-Version: 1.0
Sender: jameswiliamsjw682@gmail.com
Received: by 2002:a59:adcd:0:b0:238:c90d:602 with HTTP; Sat, 13 Nov 2021
 08:54:16 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Sat, 13 Nov 2021 16:54:16 +0000
X-Google-Sender-Auth: Ek7tC7d5TMU7huwIEIge4rs7Lrs
Message-ID: <CAJMpOnd7ueNsXHNNV7f0FGfUaoDA-hM+OcN0t7PXQNo3ahPeQQ@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my dear ,.

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Mckenna. Howley, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply.

May God Bless you,
Mrs. Dina. Mckenna.
