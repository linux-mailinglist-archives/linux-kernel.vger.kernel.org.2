Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B713B1DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhFWPh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhFWPht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:37:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5EBC061574;
        Wed, 23 Jun 2021 08:35:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ji1so4713193ejc.4;
        Wed, 23 Jun 2021 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=in-reply-to:references:thread-topic:user-agent:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=0lBN5wng9HjRZe2/VE+AfmR/BJx2jekBW1owJUvPIs4=;
        b=h+Z/Q3I8U2g4dr0t/lT+8F+hVSpsLMIycNMr9vhko3jbLFZf6hap9ZtyFVnTsjN99k
         L7cDeN+imOdYOrDR6h+H1shCdYD0Upuewpi9LEYFOJyeDB+JA/zumdFHc3S7ax/u2uKY
         +yl3M+Vp6uVxVLZe5zN7mgIiNnKe9xRi/7le9+jlMQoAZqxKEOdfqm5pD4OJjgv5yXtJ
         cdGahnhHKDVphy7zDXQ0lUS0rw/AHcvBp5dkyTGt9gh1ofHwF/6Izl7iwnOpOWalJzQH
         zzVcE/h0PNoheyjVpheOy4yzb0PVhVtgF2c8uSBEns86+UWz2ZdjpQMiqwLyjKg/OFhs
         C0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:in-reply-to:references:thread-topic:user-agent
         :mime-version:content-transfer-encoding:subject:from:date:to:cc
         :message-id;
        bh=0lBN5wng9HjRZe2/VE+AfmR/BJx2jekBW1owJUvPIs4=;
        b=bA5fazliMPKzbD6+L7V2kgLn8uvVVSLWFsP0W5Kx6smz10p3ektQ+/N2dlp0sWvyvM
         0RlUUvQ1CJl1qCpvVICgvHElBxY8ejaYKimexghMZ4HJFa93GPpj3wVXZDjBDSKrgvBc
         elM6l2YHBaVt8anwB+RO9l2O14vnAnXbYnT8q9WrVBBC6iheq1gd6HkMIL3Yt7S178FU
         1oxMtNgt9P6bOWS9MqEs8ZppVqL+Lruc/sWEalbdkQ+XRprTCCb7LUebn4p4uAr8a40k
         QGD4qK6YK3MuipxSKdPv70H4GwEOjJoPfAHZONTcc5Xv0j4bJfWlkmo+8pJjRuukgw9x
         O6eQ==
X-Gm-Message-State: AOAM531SVrJE0d+aWtiivMqgVEPOKn/Qi+iP48rGHjvz3NzXlTiz7jq1
        j43iBSTcuwlRXTSV2V8w0ec=
X-Google-Smtp-Source: ABdhPJz1gI6TE3EPMu7ywc8G3XlQhPA8Fh69loCONFm7DukNz4LavOCitwHQTB6/97WIDf1Qxt1jYQ==
X-Received: by 2002:a17:906:1704:: with SMTP id c4mr670525eje.182.1624462530204;
        Wed, 23 Jun 2021 08:35:30 -0700 (PDT)
Received: from [10.69.29.103] ([89.205.226.226])
        by smtp.gmail.com with ESMTPSA id aq12sm56854ejc.77.2021.06.23.08.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 08:35:29 -0700 (PDT)
In-Reply-To: <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org>
References: <20210619121927.32699-1-ericwouds@gmail.com> <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org>
X-Referenced-Uid: 5577
Thread-Topic: Re: [PATCH] Fix mt7622.dtsi thermal cpu
X-Blue-Identity: !l=368&o=43&fo=3760&pl=202&po=0&qs=PREFIX&f=HTML&m=!%3ANzRiZDk5M2QtNTJhNy00MTE4LThlNmYtYTk2ZDg2NDQzNGU0%3ASU5CT1g%3D%3ANTU3Nw%3D%3D%3AANSWERED&p=171&q=SHOW
X-Is-Generated-Message-Id: true
User-Agent: Android
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Local-Message-Id: <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] Fix mt7622.dtsi thermal cpu
From:   Eric Woudstra <ericwouds@gmail.com>
Date:   Wed, 23 Jun 2021 17:35:27 +0200
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is only useful to set 1 map with the regulated temperature for cpu frequ=
ency throttling=2E Same as in the kernel document example=2E


It has no us=
e to set frequency scaling on 2 different temperature trip points, as the l=
owest one makes sure the higher one(s) are never reached=2E It can be appli=
ed only at 1 trip point=2E Multiple trip points is only usefully for fan co=
ntrol to make sure the fan is not too noisy when it is not necessary to be =
noisy=2E


The CPU will almost come to a dead stop when it starts to pass t=
he lowest thermal map with frequency throttling=2E 

This is why it is a bu=
g and needs a fix, not only adjustment=2E




There is no fan=2E=2E=2E On t=
he bpi r64=2E


Anyway without throttling at all a kernel build for more th=
en an hour temperature creeps up to 85 degrees=2E

=E2=81=A3Get BlueMail fo=
r Android =E2=80=8B

On Jun 21, 2021, 8:29 PM, at 8:29 PM, Daniel Lezcano <=
daniel=2Elezcano@linaro=2Eorg> wrote:
>On 19/06/2021 14:19, ericwouds@gmail=
=2Ecom wrote:
>> From: Eric Woudstra <ericwouds@gmail=2Ecom>
>> 
>> Cpu-the=
rmal is set to use all frequencies already at 47 degrees=2E 
>> Using the C=
PU at 50 for a minute, the CPU has reached 48 degrees, is 
>> throttled bac=
k to lowest setting, making the mt7622 terrribly slow=2E 
>> Even at this l=
ow speed, the CPU does not cool down lower then 47 so
>> the CPU is stuck a=
t lowest possible frequency until it shut down and
>> stays off for 15 minu=
tes=2E
>> 
>> cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,=

>>                  <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> 
>> This=
 should not be set al every cooling map=2E It should only be set at
>> the =
highest cooling map=2E Same as in the example:
>> 
>> https://www=2Ekernel=
=2Eorg/doc/Documentation/devicetree/bindings/
>> thermal/thermal=2Etxt  lin=
e 272
>> 
>> But then without the fan and added a third map=2E
>> 
>> Now t=
emperature will be regulated at 87 degrees celcius=2E At
>temperatures
>> l=
ower then 87, all frequencies can be used=2E
>
>47=C2=B0C is really a too l=
ow temperature and this performance drop is
>normal=2E
>
>I would not remov=
e the passive mitigation but try by increasing the CPU
>temp to 70=C2=B0C a=
nd by changing the active trip point to 80=C2=B0C=2E If it works
>fine, try=
 75=C2=B0C and 85=C2=B0C=2E
>
>To test, the thermal killer is dhrystone (on=
e thread per cpu)=2E
>
>With a 75=C2=B0C passive trip point, the step wise =
thermal governor, I think
>the mitigation will happen smoothly providing be=
tter performances, and
>probably the fan won't fire=2E
>
>> Also see the po=
st:
>> 
>> http://forum=2Ebanana-pi=2Eorg/t/bpi-r64-only-10-cpu-speed-at-al=
ready-48-
>> degrees-celcius-speed-not-increasing-anymore/12262
>> 
>> Sign=
ed-off-by: Eric Woudstra <ericwouds@gmail=2Ecom>
>> ---
>>  arch/arm64/boot=
/dts/mediatek/mt7622=2Edtsi | 8 ++++----
>>  1 file changed, 4 insertions(+=
), 4 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7622=
=2Edtsi
>b/arch/arm64/boot/dts/mediatek/mt7622=2Edtsi
>> index 890a942ec=2E=
=2Eb779c7aa6 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7622=2Edtsi
>> =
+++ b/arch/arm64/boot/dts/mediatek/mt7622=2Edtsi
>> @@ -170,14 +170,14 @@ c=
pu-crit {
>>  			cooling-maps {
>>  				map0 {
>>  					trip =3D <&cpu_pass=
ive>;
>> -					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>=
,
>> -							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +					cooling-d=
evice =3D <&cpu0 0 0>,
>> +							 <&cpu1 0 0>;
>>  				};
>>  
>>  				map=
1 {
>>  					trip =3D <&cpu_active>;
>> -					cooling-device =3D <&cpu0 THE=
RMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> -							 <&cpu1 THERMAL_NO_LIMIT THERMA=
L_NO_LIMIT>;
>> +					cooling-device =3D <&cpu0 0 0>,
>> +							 <&cpu1 0 =
0>;
>>  				};
>>  
>>  				map2 {
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

