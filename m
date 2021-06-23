Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF783B208C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhFWSrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:47:29 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4117C061574;
        Wed, 23 Jun 2021 11:45:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c7so4857617edn.6;
        Wed, 23 Jun 2021 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=in-reply-to:references:thread-topic:user-agent:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=ah7pBnbhzP9GnkQ3rGPkhU3+DWS7Z2OsFCqpYUElow8=;
        b=BpaIaUQ0ce5ob/JOAjBlVv9KSNyieeU75lx7Oa5EBtX0KVeCAmDz32DP88jgmxyEuV
         f9Q6pdyYTGNeDZBwzAyVuO3q5iE9Zp8faxFfC0qdZ3nV8JYztbuUQ1jL+RBf5cR6DrCz
         qpPnh7RMD0a6a8ENUr3R+YDmAymdkAlE/HoH2NBRDWz2ZCpWP5phK87DdN838uUFlHe2
         4V5DXvhm46VPf1n/pW+DFn0mRfefTPgz2tGgBtYp4+eeXNObwoSE2lTd0IVokYf+vqTG
         48axfLBYdyUw0jryfa0OCMnhUpBHS7S15VzedNegaqWU+URoq8Ast6I5N3pXnG867Bu6
         dLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:in-reply-to:references:thread-topic:user-agent
         :mime-version:content-transfer-encoding:subject:from:date:to:cc
         :message-id;
        bh=ah7pBnbhzP9GnkQ3rGPkhU3+DWS7Z2OsFCqpYUElow8=;
        b=Xn0aQXoIdvcVTq/jOiF0vxt4x+1Ptq00ERGn2AhsSfLWVDLhY2ExRmt9OdkiTu6b1e
         SR+aCIntwCqxn8+TFLw9NrdoMchPLhIEnzi6sMpGQBnZz/FovcO6wop55l+iMmSAaX6x
         xjco5CQWjtMiCF4/K0/J/Rxx4KDzhoXevIV7Ni4Y2cZ6KIr5vQNH262xXFI5v81H2kYl
         UdFk+HPgV8RUHFAurQxqfVRonGf4jMnAU60IRnkFSkfnchfkoAQMg3WAG2TAoXiYfpYo
         ivUFIVhfg/8am/nJ0T7TMvHUQL64E/I900ty5fazlmmNv13A8m5VO0JupUdjW91D66+y
         5MPA==
X-Gm-Message-State: AOAM531XnuLY8BUh1fI62PKdiQc9KwKGRCsego6ogNJFu9TU3OleDNEb
        5aYeQn9wDn+V4i8v3wUhYSU=
X-Google-Smtp-Source: ABdhPJzDkrQhtZZC+CyPDsfo0g8ANdWq9ib6iNs7UYbxId9ryLzi0Ubw98iPpKpjsPeS1sq4mAl06w==
X-Received: by 2002:aa7:dbc3:: with SMTP id v3mr1656874edt.63.1624473909523;
        Wed, 23 Jun 2021 11:45:09 -0700 (PDT)
Received: from 2001-1c01-471c-ce00-7d60-ae46-0c29-c0bb.cable.dynamic.v6.ziggo.nl (2001-1c01-471c-ce00-7d60-ae46-0c29-c0bb.cable.dynamic.v6.ziggo.nl. [2001:1c01:471c:ce00:7d60:ae46:c29:c0bb])
        by smtp.gmail.com with ESMTPSA id c6sm460084ede.17.2021.06.23.11.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 11:45:08 -0700 (PDT)
In-Reply-To: <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org>
References: <20210619121927.32699-1-ericwouds@gmail.com> <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org> <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com> <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org>
X-Referenced-Uid: 5591
Thread-Topic: Re: [PATCH] Fix mt7622.dtsi thermal cpu
User-Agent: Android
X-Is-Generated-Message-Id: true
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Local-Message-Id: <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com>
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] Fix mt7622.dtsi thermal cpu
From:   Eric Woudstra <ericwouds@gmail.com>
Date:   Wed, 23 Jun 2021 20:43:15 +0200
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I choose "hot" before, because 87 degrees seems ok to start frequency thro=
ttling=2E But, yes, it should be passive=2E

87 is still quite low if I com=
pare this temperature with the wrt3200acm Marvell dual core arm soc=2E They=
 even went above 100 degrees so I feel for an arm processor inside a router=
 box it is fine to use 87 degrees But maybe someone at Mediatek can give so=
me more details about operating temperatures=2E

It may be possible to leav=
e the active map in the device tree as some users of the bananapi might cho=
ose to install a fan as it is one of the options=2E

=E2=81=A3Get BlueMail =
for Android =E2=80=8B

On Jun 23, 2021, 5:58 PM, at 5:58 PM, Daniel Lezcano=
 <daniel=2Elezcano@linaro=2Eorg> wrote:
>On 23/06/2021 17:35, Eric Woudstra=
 wrote:
>> It is only useful to set 1 map with the regulated temperature fo=
r cpu
>> frequency throttling=2E Same as in the kernel document example=2E
=
>> 
>> 
>> It has no use to set frequency scaling on 2 different temperatur=
e
>> trip points, as the lowest one makes sure the higher one(s) are never
=
>> reached=2E
>
>I looked more closely the DT and there is a misunderstandi=
ng of the
>thermal framework in the definition=2E
>
>There is one trip poin=
t with the passive type and the cpu cooling
>device, followed by a second t=
rip point with the active type *but* the
>same cpu cooling device=2E That i=
s wrong=2E
>
>And finally, there is the hot trip point as a third mapping a=
nd the
>same
>cooling device=2E
>
>The hot trip point is only there to noti=
fy userspace and let it take an
>immediate action to prevent an emergency s=
hutdown when reaching the
>critical temperature=2E
>
>> It can be applied o=
nly at 1 trip point=2E Multiple trip points
>> is only usefully for fan con=
trol to make sure the fan is not too
>> noisy when it is not necessary to b=
e noisy=2E
>> 
>> 
>> The CPU will almost come to a dead stop when it start=
s to pass the
>> lowest thermal map with frequency throttling=2E
>> 
>> Thi=
s is why it is a bug and needs a fix, not only adjustment=2E
>
>Yes, you ar=
e right=2E It should be something like (verbatim copy):
>
>diff --git a/arc=
h/arm64/boot/dts/mediatek/mt7622=2Edtsi
>b/arch/arm64/boot/dts/mediatek/mt7=
622=2Edtsi
>index 890a942ec608=2E=2E88c81d24f4ff 100644
>--- a/arch/arm64/b=
oot/dts/mediatek/mt7622=2Edtsi
>+++ b/arch/arm64/boot/dts/mediatek/mt7622=
=2Edtsi
>@@ -136,24 +136,18 @@ secmon_reserved: secmon@43000000 {
>
> 	ther=
mal-zones {
> 		cpu_thermal: cpu-thermal {
>-			polling-delay-passive =3D <=
1000>;
>+			polling-delay-passive =3D <250>;
> 			polling-delay =3D <1000>;=

>
> 			thermal-sensors =3D <&thermal 0>;
>
> 			trips {
> 				cpu_passive:=
 cpu-passive {
>-					temperature =3D <47000>;
>+					temperature =3D <7700=
0>;
> 					hysteresis =3D <2000>;
> 					type =3D "passive";
> 				};
>
>-	=
			cpu_active: cpu-active {
>-					temperature =3D <67000>;
>-					hysteres=
is =3D <2000>;
>-					type =3D "active";
>-				};
>-
> 				cpu_hot: cpu-hot=
 {
> 					temperature =3D <87000>;
> 					hysteresis =3D <2000>;
>@@ -173,1=
8 +167,6 @@ map0 {
> 					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMA=
L_NO_LIMIT>,
> 							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 				};
=
>-
>-				map1 {
>-					trip =3D <&cpu_active>;
>-					cooling-device =3D <&=
cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>-							 <&cpu1 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>;
>-				};
>-
>-				map2 {
>-					trip =3D <&cpu_hot>;
>-	=
				cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>-							=
 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>-				};
> 			};
> 		};
> 	};
>=

>
>-- 
><http://www=2Elinaro=2Eorg/> Linaro=2Eorg =E2=94=82 Open source so=
ftware for ARM SoCs
>
>Follow Linaro:  <http://www=2Efacebook=2Ecom/pages/L=
inaro> Facebook |
><http://twitter=2Ecom/#!/linaroorg> Twitter |
><http://w=
ww=2Elinaro=2Eorg/linaro-blog/> Blog

