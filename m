Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33F3B2C08
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhFXKB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhFXKBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:01:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91066C06175F;
        Thu, 24 Jun 2021 02:59:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id q14so7664988eds.5;
        Thu, 24 Jun 2021 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=in-reply-to:references:thread-topic:user-agent:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=owJIkwgTJJrr321dtXmmzgJyCT9kVjIZQoA7WhwaN5E=;
        b=Bp+2sNTW3g7PLme41cAL37qFxYrxSKMOPJuG59AGYho73N1c4S7rgqtgL2bP2eBI4x
         gbWj08J6lCp22LGJFh2ZCOTaDh68MnWmU+05//X+P1iwmwbPM3MQLNr9B8tr3QybaCHn
         tY9tmfkvw1J6sbtg47CqzmPRRBwpIleB8agyesqa2+FWifSIVU4qeZUxLRSS8/F4l5lX
         gWL4vciaaBftqwXgTIFiqUjqfSb5Xf/OIXa5fwadozwvF1E3q04Stm12WUjifrFbBp+0
         hx3V8FD7Kf50pvFzlq1375v/nCBbecIneAME8HbDXzN+yhchRw+wIIrAfYp5qWbZH3wd
         igWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:in-reply-to:references:thread-topic:user-agent
         :mime-version:content-transfer-encoding:subject:from:date:to:cc
         :message-id;
        bh=owJIkwgTJJrr321dtXmmzgJyCT9kVjIZQoA7WhwaN5E=;
        b=kmx+HihG28ydNBAZ3knNfEB1dGioKQEfz1h8lOUn5b8NWv5e8kbJO91ZY+WQ7rq1rO
         cEkgsMaoWivinAnR9tzcnzM+10CIwdxiS5DWZujqyKl+QyAyDgkOYnWn7LgnRwtCfahM
         B3Rizfd9PgFPltBQGubvcPx149uGyP/0TiUjMn2HVInJhNlmjtzOn2tA26pM/PeR8yW7
         k1M+bbF3N1JHSfr4Glb0TZPEzMH9At9QOEOrFM5VXq3bBUYPp5wQtwvo9rlD7lxS5LKK
         GvRluzSClM0JPSDB3RgL6G/PN7LIrTJCf1GP1fS+EFCbjBtUx4SzXbN9t0+X8fQ5m4o1
         t4Zw==
X-Gm-Message-State: AOAM533CArS9UOA0toVnAu/t0PuHx0XGUH4DRr5dv0ghH6AtxpnJhg0v
        o7v93/nS+N60DMeeQaRJFZM=
X-Google-Smtp-Source: ABdhPJx2dWphuRerA3LvDrqmt1OS8hcogXtPG+lKZI9IKpFkm0eAdkFt4zUb2comrFjGml2G+matMg==
X-Received: by 2002:a05:6402:144e:: with SMTP id d14mr5808846edx.339.1624528772180;
        Thu, 24 Jun 2021 02:59:32 -0700 (PDT)
Received: from [192.168.178.102] (82-72-98-83.cable.dynamic.v4.ziggo.nl. [82.72.98.83])
        by smtp.gmail.com with ESMTPSA id h20sm939287ejl.7.2021.06.24.02.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 02:59:31 -0700 (PDT)
In-Reply-To: <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org>
References: <20210619121927.32699-1-ericwouds@gmail.com> <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org> <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com> <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org> <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com> <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org>
X-Referenced-Uid: 5594
Thread-Topic: Re: [PATCH] Fix mt7622.dtsi thermal cpu
User-Agent: Android
X-Is-Generated-Message-Id: true
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Local-Message-Id: <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com>
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] Fix mt7622.dtsi thermal cpu
From:   Eric Woudstra <ericwouds@gmail.com>
Date:   Thu, 24 Jun 2021 11:59:30 +0200
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For Marvell:

https://www=2Egoogle=2Ecom/url?sa=3Dt&source=3Dweb&rct=3Dj&u=
rl=3Dhttps://wiki=2Ekobol=2Eio/helios4/files/som/brochure_a38x_microsom_201=
7-09-05=2Epdf

Armada38x maximum die temperature 115 degrees Celcius=2E The=
y really get hotter then 100=2E

But for mt7622 I cannot find this value

=
=E2=81=A3Get BlueMail for Android =E2=80=8B

On Jun 23, 2021, 10:08 PM, at =
10:08 PM, Daniel Lezcano <daniel=2Elezcano@linaro=2Eorg> wrote:
>On 23/06/2=
021 20:43, Eric Woudstra wrote:
>> 
>> I choose "hot" before, because 87 de=
grees seems ok to start frequency
>> throttling=2E But, yes, it should be p=
assive=2E
>> 
>> 87 is still quite low if I compare this temperature with t=
he
>> wrt3200acm Marvell dual core arm soc=2E They even went above 100
>> d=
egrees so I feel for an arm processor inside a router box it is fine
>> to =
use 87 degrees But maybe someone at Mediatek can give some more
>> details =
about operating temperatures=2E
>
>Sometimes, the SoC vendor puts a high te=
mperature in the DT just to
>export the thermal zone and deal with it from =
userspace=2E So putting the
>high temp allow the userspace (usually a therm=
al engine - Android
>stuff)
>to deal with the mitigation without a kernel i=
nteraction=2E
>
>Having more than 100=C2=B0C could be this kind of setup=2E=
 Only the operating
>temperature from the hardware documentation will tell =
the safe
>temperature for the silicon=2E
>
>IMO, 77=C2=B0C is a good compro=
mise until getting the documented temp=2E 87=C2=B0C
>sounds to me a bit too=
 hot=2E
>
>> It may be possible to leave the active map in the device tree =
as some
>> users of the bananapi might choose to install a fan as it is one=
 of
>> the options=2E
>
>The active trip only makes sense if the cooling de=
vice is a fan (or any
>active device), so the mapping points to a fan node,=
 like:
>
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/thermal/linux=
=2Egit/tree/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge=2Edtsi#n192
>
>=
If there is no such [pwm] fan output on the board, no active trip point
>sh=
ould be added=2E
>
>> =E2=81=A3Get BlueMail for Android =E2=80=8B
>> 
>> On=
 Jun 23, 2021, 5:58 PM, at 5:58 PM, Daniel Lezcano
>> <daniel=2Elezcano@lin=
aro=2Eorg> wrote:
>>> On 23/06/2021 17:35, Eric Woudstra wrote:
>>>> It is =
only useful to set 1 map with the regulated temperature for
>>>> cpu freque=
ncy throttling=2E Same as in the kernel document
>>>> example=2E
>>>> 
>>>>=
 
>>>> It has no use to set frequency scaling on 2 different
>>>> temperatu=
re trip points, as the lowest one makes sure the higher
>>>> one(s) are nev=
er reached=2E
>>> 
>>> I looked more closely the DT and there is a misunder=
standing of
>>> the thermal framework in the definition=2E
>>> 
>>> There i=
s one trip point with the passive type and the cpu cooling 
>>> device, fol=
lowed by a second trip point with the active type *but*
>>> the same cpu co=
oling device=2E That is wrong=2E
>>> 
>>> And finally, there is the hot tri=
p point as a third mapping and
>>> the same cooling device=2E
>>> 
>>> The =
hot trip point is only there to notify userspace and let it
>>> take an imm=
ediate action to prevent an emergency shutdown when
>>> reaching the critic=
al temperature=2E
>>> 
>>>> It can be applied only at 1 trip point=2E Multi=
ple trip points is
>>>> only usefully for fan control to make sure the fan =
is not too 
>>>> noisy when it is not necessary to be noisy=2E
>>>> 
>>>> 
=
>>>> The CPU will almost come to a dead stop when it starts to pass
>>>> th=
e lowest thermal map with frequency throttling=2E
>>>> 
>>>> This is why it=
 is a bug and needs a fix, not only adjustment=2E
>>> 
>>> Yes, you are rig=
ht=2E It should be something like (verbatim copy):
>>> 
>>> diff --git a/ar=
ch/arm64/boot/dts/mediatek/mt7622=2Edtsi 
>>> b/arch/arm64/boot/dts/mediate=
k/mt7622=2Edtsi index
>>> 890a942ec608=2E=2E88c81d24f4ff 100644 ---
>>> a/a=
rch/arm64/boot/dts/mediatek/mt7622=2Edtsi +++
>>> b/arch/arm64/boot/dts/med=
iatek/mt7622=2Edtsi @@ -136,24 +136,18 @@
>>> secmon_reserved: secmon@43000=
000 {
>>> 
>>> thermal-zones { cpu_thermal: cpu-thermal { -
>>> polling-del=
ay-passive =3D <1000>; +			polling-delay-passive =3D <250>; 
>>> polling-de=
lay =3D <1000>;
>>> 
>>> thermal-sensors =3D <&thermal 0>;
>>> 
>>> trips {=
 cpu_passive: cpu-passive { -					temperature =3D <47000>; +
>>> temperatur=
e =3D <77000>; hysteresis =3D <2000>; type =3D "passive"; };
>>> 
>>> -				=
cpu_active: cpu-active { -					temperature =3D <67000>; -
>>> hysteresis =
=3D <2000>; -					type =3D "active"; -				}; - cpu_hot:
>>> cpu-hot { tempe=
rature =3D <87000>; hysteresis =3D <2000>; @@ -173,18
>>> +167,6 @@ map0 { =
cooling-device =3D <&cpu0 THERMAL_NO_LIMIT
>>> THERMAL_NO_LIMIT>, <&cpu1 TH=
ERMAL_NO_LIMIT THERMAL_NO_LIMIT>; }; - 
>>> -				map1 { -					trip =3D <&cp=
u_active>; -					cooling-device =3D
>>> <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_=
LIMIT>, -							 <&cpu1
>>> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>; -				}; - -=
				map2 { -
>>> trip =3D <&cpu_hot>; -					cooling-device =3D <&cpu0 THERM=
AL_NO_LIMIT
>>> THERMAL_NO_LIMIT>, -							 <&cpu1 THERMAL_NO_LIMIT
>>> THE=
RMAL_NO_LIMIT>; -				}; }; }; };
>>> 
>>> 
>>> -- <http://www=2Elinaro=2Eor=
g/> Linaro=2Eorg =E2=94=82 Open source software for
>>> ARM SoCs
>>> 
>>> F=
ollow Linaro:  <http://www=2Efacebook=2Ecom/pages/Linaro> Facebook | 
>>> <=
http://twitter=2Ecom/#!/linaroorg> Twitter | 
>>> <http://www=2Elinaro=2Eor=
g/linaro-blog/> Blog
>> 
>
>
>-- 
><http://www=2Elinaro=2Eorg/> Linaro=2Eor=
g =E2=94=82 Open source software for ARM SoCs
>
>Follow Linaro:  <http://ww=
w=2Efacebook=2Ecom/pages/Linaro> Facebook |
><http://twitter=2Ecom/#!/linar=
oorg> Twitter |
><http://www=2Elinaro=2Eorg/linaro-blog/> Blog

