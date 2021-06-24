Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AEB3B2FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhFXNcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:31:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E45C061574;
        Thu, 24 Jun 2021 06:29:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nd37so9575157ejc.3;
        Thu, 24 Jun 2021 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=in-reply-to:references:thread-topic:user-agent:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=qa66//SU9/ohbzIK8e/3GeCiVXURO91vpsDRPo61J0c=;
        b=qmhbdfqdU5gLpg6/DnJMsaL1rUSmLfLvOMmZqEQExOJ7LOLjVG8hjs7gdxAgIqHZ2t
         DKee+i8iSTV6xfP+Su7MbF9npb0GJFw9QDbq0mbHRq58HDhrM3LCJ4cRB5lgun3EXW0M
         ABLGgstLLNENzeQGkzYnuf3cjKNO6J/s5mWBweX5dDIMTdL+fx+D8NDopMch9HsSP16W
         HOg+c+iJn93SUIKskD9MHmn1f8DBD61q32A+QOwKfIL+44ZhF8nMNwqix+285actih2E
         KrIxJi33OWpCYGimnWwvH1mzqhMglAAFf2n/cp4SDwhjb6X1XuJerb+JZZ9Z+/hprt/I
         yEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:in-reply-to:references:thread-topic:user-agent
         :mime-version:content-transfer-encoding:subject:from:date:to:cc
         :message-id;
        bh=qa66//SU9/ohbzIK8e/3GeCiVXURO91vpsDRPo61J0c=;
        b=SHrhy0MFGjKgjrMRZ9Y0a9wqc0KBva06pOTreKaPogJhxeimbGUiqQufLxPB7WJbTN
         U+gVBpUmyIAhOSrWRPhrQv+3gHCeI3YfFDS00+iSHe6NpTqQyUCQAKiP07dxNjOun0JZ
         YF12X134MDX0Dv/plZqdC4r90KEx0nSZ3lv//srQ//aN3VzUqO/cpphox6KpOQ8ft3GZ
         GFxuvZM7xLcZKAR7qgto6Pf/h70/b3C2s0jDQUkZZsJlozb15czXPwPjgqvRqCspC9fF
         sn+s/i7tq57etu22XB12MDgeTjdcqHLUJUd+Tn8t6Rob5NYzEg0oDaOhfEqMeTr7QDzB
         pF9Q==
X-Gm-Message-State: AOAM533XtWRZ9Tu8SEeviGQqhthlvcaJHkIhgzMHNxxHIvooCCVX+wXt
        jIClY325VWpCnNK74PdWtcM=
X-Google-Smtp-Source: ABdhPJw3RJnlKA9nmpW4hZDrAlOwNf4zITHIfgf/Hk6iTcoDhmst/QZV/DSEqIrpLOLvBnVk6XxtHA==
X-Received: by 2002:a17:907:9ec:: with SMTP id ce12mr5123185ejc.434.1624541374989;
        Thu, 24 Jun 2021 06:29:34 -0700 (PDT)
Received: from [192.168.178.102] (82-72-98-83.cable.dynamic.v4.ziggo.nl. [82.72.98.83])
        by smtp.gmail.com with ESMTPSA id g8sm1934698edw.89.2021.06.24.06.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 06:29:34 -0700 (PDT)
In-Reply-To: <173e6bab-9d21-eb28-9b91-a5f80c01fd03@linaro.org>
References: <20210619121927.32699-1-ericwouds@gmail.com> <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org> <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com> <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org> <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com> <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org> <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com> <173e6bab-9d21-eb28-9b91-a5f80c01fd03@linaro.org>
X-Referenced-Uid: 5597
Thread-Topic: Re: [PATCH] Fix mt7622.dtsi thermal cpu
X-Blue-Identity: !l=762&o=43&fo=8707&pl=623&po=0&qs=PREFIX&f=HTML&m=!%3ANzRiZDk5M2QtNTJhNy00MTE4LThlNmYtYTk2ZDg2NDQzNGU0%3ASU5CT1g%3D%3ANTU5Nw%3D%3D%3AANSWERED&p=546&q=SHOW
X-Is-Generated-Message-Id: true
User-Agent: Android
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Local-Message-Id: <3dd22cf2-1186-4870-aa49-e5cddc18c6e9@gmail.com>
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] Fix mt7622.dtsi thermal cpu
From:   Eric Woudstra <ericwouds@gmail.com>
Date:   Thu, 24 Jun 2021 15:29:32 +0200
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <3dd22cf2-1186-4870-aa49-e5cddc18c6e9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SOC runs unthrotlled slowly to 80 degrees=2E This takes minutes=2E Poll=
ing interval 1 second or less does not matter much when looking at these te=
mperature rise times 

After that in more then an hour it slowly creeps up =
to 85=2E I believe the design is so that the SOC, under normal circumstance=
s, can run at 1=2E35 GHz without throttling frequency, without heatsink=2E =
It just needs a safeguard for different circumstances=2E

Most of these SOC=
s can also run in industrial grade circumstances, which means up to 85 degr=
ees ambient temperature already =2E If not industrial then this would be 60=
 degrees ambient already 

But only someone at Mediatek can confirm this 

=
=E2=81=A3Get BlueMail for Android =E2=80=8B

On Jun 24, 2021, 12:21 PM, at =
12:21 PM, Daniel Lezcano <daniel=2Elezcano@linaro=2Eorg> wrote:
>On 24/06/2=
021 11:59, Eric Woudstra wrote:
>> 
>> For Marvell:
>> 
>>
>https://www=2Eg=
oogle=2Ecom/url?sa=3Dt&source=3Dweb&rct=3Dj&url=3Dhttps://wiki=2Ekobol=2Eio=
/helios4/files/som/brochure_a38x_microsom_2017-09-05=2Epdf
>> 
>> Armada38x=
 maximum die temperature 115 degrees Celcius=2E They really
>get hotter the=
n 100=2E
>> 
>> But for mt7622 I cannot find this value
>
>Found that:
>
>h=
ttps://download=2Ekamami=2Epl/p579344-MT7622A_Datasheet_for_BananaPi_Only%2=
81%29=2Epdf
>
>Chapter 3=2E3 - Thermal Characteristics
>
>Given the values =
I suggest:
>
> - Passive - 80=C2=B0C
>
> - Hot - 90=C2=B0C
>
> - Critical -=
 100=C2=B0C
>
>And passive polling set to 250ms=2E
>
>It sounds like the se=
nsor is not supporting the interrupt mode yet, so
>a
>big gap is needed wit=
h the Tj IMO to give the time to detect the trip
>point crossing with the p=
olling=2E
>
>> =E2=81=A3Get BlueMail for Android =E2=80=8B
>> 
>> On Jun 23=
, 2021, 10:08 PM, at 10:08 PM, Daniel Lezcano
><daniel=2Elezcano@linaro=2Eo=
rg> wrote:
>>> On 23/06/2021 20:43, Eric Woudstra wrote:
>>>>
>>>> I choose=
 "hot" before, because 87 degrees seems ok to start
>frequency
>>>> throttl=
ing=2E But, yes, it should be passive=2E
>>>>
>>>> 87 is still quite low if=
 I compare this temperature with the
>>>> wrt3200acm Marvell dual core arm =
soc=2E They even went above 100
>>>> degrees so I feel for an arm processor=
 inside a router box it is
>fine
>>>> to use 87 degrees But maybe someone a=
t Mediatek can give some more
>>>> details about operating temperatures=2E
=
>>>
>>> Sometimes, the SoC vendor puts a high temperature in the DT just to=

>>> export the thermal zone and deal with it from userspace=2E So putting
=
>the
>>> high temp allow the userspace (usually a thermal engine - Android
=
>>> stuff)
>>> to deal with the mitigation without a kernel interaction=2E
=
>>>
>>> Having more than 100=C2=B0C could be this kind of setup=2E Only the=

>operating
>>> temperature from the hardware documentation will tell the s=
afe
>>> temperature for the silicon=2E
>>>
>>> IMO, 77=C2=B0C is a good com=
promise until getting the documented temp=2E
>87=C2=B0C
>>> sounds to me a =
bit too hot=2E
>>>
>>>> It may be possible to leave the active map in the d=
evice tree as
>some
>>>> users of the bananapi might choose to install a fa=
n as it is one of
>>>> the options=2E
>>>
>>> The active trip only makes se=
nse if the cooling device is a fan (or
>any
>>> active device), so the mapp=
ing points to a fan node, like:
>>>
>>>
>https://git=2Ekernel=2Eorg/pub/scm=
/linux/kernel/git/thermal/linux=2Egit/tree/arch/arm64/boot/dts/rockchip/rk3=
399-khadas-edge=2Edtsi#n192
>>>
>>> If there is no such [pwm] fan output on=
 the board, no active trip
>point
>>> should be added=2E
>>>
>>>> =E2=81=A3=
Get BlueMail for Android =E2=80=8B
>>>>
>>>> On Jun 23, 2021, 5:58 PM, at 5=
:58 PM, Daniel Lezcano
>>>> <daniel=2Elezcano@linaro=2Eorg> wrote:
>>>>> On=
 23/06/2021 17:35, Eric Woudstra wrote:
>>>>>> It is only useful to set 1 m=
ap with the regulated temperature for
>>>>>> cpu frequency throttling=2E Sa=
me as in the kernel document
>>>>>> example=2E
>>>>>>
>>>>>>
>>>>>> It has =
no use to set frequency scaling on 2 different
>>>>>> temperature trip poin=
ts, as the lowest one makes sure the higher
>>>>>> one(s) are never reached=
=2E
>>>>>
>>>>> I looked more closely the DT and there is a misunderstandin=
g of
>>>>> the thermal framework in the definition=2E
>>>>>
>>>>> There is =
one trip point with the passive type and the cpu cooling 
>>>>> device, fol=
lowed by a second trip point with the active type *but*
>>>>> the same cpu =
cooling device=2E That is wrong=2E
>>>>>
>>>>> And finally, there is the ho=
t trip point as a third mapping and
>>>>> the same cooling device=2E
>>>>>
=
>>>>> The hot trip point is only there to notify userspace and let it
>>>>>=
 take an immediate action to prevent an emergency shutdown when
>>>>> reach=
ing the critical temperature=2E
>>>>>
>>>>>> It can be applied only at 1 tr=
ip point=2E Multiple trip points is
>>>>>> only usefully for fan control to=
 make sure the fan is not too 
>>>>>> noisy when it is not necessary to be =
noisy=2E
>>>>>>
>>>>>>
>>>>>> The CPU will almost come to a dead stop when =
it starts to pass
>>>>>> the lowest thermal map with frequency throttling=
=2E
>>>>>>
>>>>>> This is why it is a bug and needs a fix, not only adjustm=
ent=2E
>>>>>
>>>>> Yes, you are right=2E It should be something like (verba=
tim copy):
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7622=2Ed=
tsi 
>>>>> b/arch/arm64/boot/dts/mediatek/mt7622=2Edtsi index
>>>>> 890a942=
ec608=2E=2E88c81d24f4ff 100644 ---
>>>>> a/arch/arm64/boot/dts/mediatek/mt7=
622=2Edtsi +++
>>>>> b/arch/arm64/boot/dts/mediatek/mt7622=2Edtsi @@ -136,2=
4 +136,18 @@
>>>>> secmon_reserved: secmon@43000000 {
>>>>>
>>>>> thermal-z=
ones { cpu_thermal: cpu-thermal { -
>>>>> polling-delay-passive =3D <1000>;=
 +			polling-delay-passive =3D <250>;
>
>>>>> polling-delay =3D <1000>;
>>>=
>>
>>>>> thermal-sensors =3D <&thermal 0>;
>>>>>
>>>>> trips { cpu_passive:=
 cpu-passive { -					temperature =3D <47000>; +
>>>>> temperature =3D <7700=
0>; hysteresis =3D <2000>; type =3D "passive"; };
>>>>>
>>>>> -				cpu_acti=
ve: cpu-active { -					temperature =3D <67000>; -
>>>>> hysteresis =3D <200=
0>; -					type =3D "active"; -				}; - cpu_hot:
>>>>> cpu-hot { temperature=
 =3D <87000>; hysteresis =3D <2000>; @@ -173,18
>>>>> +167,6 @@ map0 { cool=
ing-device =3D <&cpu0 THERMAL_NO_LIMIT
>>>>> THERMAL_NO_LIMIT>, <&cpu1 THER=
MAL_NO_LIMIT THERMAL_NO_LIMIT>; }; -
>
>>>>> -				map1 { -					trip =3D <&c=
pu_active>; -					cooling-device =3D
>>>>> <&cpu0 THERMAL_NO_LIMIT THERMAL_=
NO_LIMIT>, -							 <&cpu1
>>>>> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>; -				}=
; - -				map2 { -
>>>>> trip =3D <&cpu_hot>; -					cooling-device =3D <&cpu=
0 THERMAL_NO_LIMIT
>>>>> THERMAL_NO_LIMIT>, -							 <&cpu1 THERMAL_NO_LIMI=
T
>>>>> THERMAL_NO_LIMIT>; -				}; }; }; };
>>>>>
>>>>>
>>>>> -- <http://ww=
w=2Elinaro=2Eorg/> Linaro=2Eorg =E2=94=82 Open source software for
>>>>> AR=
M SoCs
>>>>>
>>>>> Follow Linaro:  <http://www=2Efacebook=2Ecom/pages/Linar=
o> Facebook | 
>>>>> <http://twitter=2Ecom/#!/linaroorg> Twitter | 
>>>>> <=
http://www=2Elinaro=2Eorg/linaro-blog/> Blog
>>>>
>>>
>>>
>>> -- 
>>> <http=
://www=2Elinaro=2Eorg/> Linaro=2Eorg =E2=94=82 Open source software for ARM=

>SoCs
>>>
>>> Follow Linaro:  <http://www=2Efacebook=2Ecom/pages/Linaro> F=
acebook |
>>> <http://twitter=2Ecom/#!/linaroorg> Twitter |
>>> <http://www=
=2Elinaro=2Eorg/linaro-blog/> Blog
>> 
>
>
>-- 
><http://www=2Elinaro=2Eorg=
/> Linaro=2Eorg =E2=94=82 Open source software for ARM SoCs
>
>Follow Linar=
o:  <http://www=2Efacebook=2Ecom/pages/Linaro> Facebook |
><http://twitter=
=2Ecom/#!/linaroorg> Twitter |
><http://www=2Elinaro=2Eorg/linaro-blog/> Bl=
og

