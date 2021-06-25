Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB33B422E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhFYLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhFYLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:10:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A50CC061574;
        Fri, 25 Jun 2021 04:07:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h2so12892296edt.3;
        Fri, 25 Jun 2021 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=in-reply-to:references:thread-topic:user-agent:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=zS+Sy2JuyXUjHyIS0w19cZln6zoHhOgeM0Qhc+/cXBs=;
        b=R9EzdJqKI8fn9iZhp0YgJ8pfmVFefMTQMKVqSscunCMLjkjqYZfF3rRvJKIsiNHY2R
         SzPAZOKlqWsCCjE8VOAunUzBWWUL2M/ep75WyXHfk0Ro8KUSvcPLV6Dxt6FObgsyB8eg
         JHL8+fxD/v9BEALcIQDv7HS/g/dgsLKOOxgfqMf1vSsWcXD/HjtTMg0PJrQWnuNHO6nq
         jWyi32oA/WGhWp1ww+q4UuecpGmmCBaqbDqaEGciBpqeuY/GTpgVEiPl52bBTr9w6Ttf
         JfRYrpXFPCRvLReavNC2tBgVdoxqFX/7GxPADzdV1No0Ln2xvCdvBGiXvuiqr8Bx97Id
         W8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:in-reply-to:references:thread-topic:user-agent
         :mime-version:content-transfer-encoding:subject:from:date:to:cc
         :message-id;
        bh=zS+Sy2JuyXUjHyIS0w19cZln6zoHhOgeM0Qhc+/cXBs=;
        b=UbwJ/DzR7KsjdvMNO4/Ava6ixSKBjq6wOz4AxeBAd75/Sahe12nePTe1J90q9iVtKs
         Y1BW85jWtwiZbT3UB/2TITvmYy0tC/Fb59/Hu4Pt6wdiSARFvATfSueldtWudhIT+sO0
         3lbPDwLxSFhL/XgVJ00ixriXKZrhyQaVcc3cW3VXpsbO3XyRwJ/BaFdM5IPGZICxR9wk
         GWPA8xMUl8NJXy+cXrgePuhlzuamjH0FtbNxE1Y1ANmH93tqXLs2WVmhE7emz5CEFH+2
         JYNZDBzFCuK4oM2FJPbFTi8lMkRNFT80i92AjSpezLJPQoqy/nVrbauqyn0SwBIqNRHC
         n1gQ==
X-Gm-Message-State: AOAM533SpQ9EumDdyaQUMzolZSAZTycxBYXyRnSiMHv45DCmbcBT5JiL
        5Lko2bjhwKnnvEDy7cqoUPg=
X-Google-Smtp-Source: ABdhPJxAA2PYThH5HCe4nhv2JuPudiiWFmx883/ndYXLhIfPMVK4qdlr8pZNqHIVId0VJm5M1V6Ppg==
X-Received: by 2002:a05:6402:31b4:: with SMTP id dj20mr14094807edb.186.1624619264824;
        Fri, 25 Jun 2021 04:07:44 -0700 (PDT)
Received: from [10.73.177.209] ([89.205.226.136])
        by smtp.gmail.com with ESMTPSA id j19sm2626800ejo.3.2021.06.25.04.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 04:07:44 -0700 (PDT)
In-Reply-To: <trinity-2eb7c0ac-d9dc-446c-8907-69b5f4df6838-1624618996538@3c-app-gmx-bs66>
References: <20210619121927.32699-1-ericwouds@gmail.com> <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org> <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com> <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org> <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com> <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org> <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com> <173e6bab-9d21-eb28-9b91-a5f80c01fd03@linaro.org> <3dd22cf2-1186-4870-aa49-e5cddc18c6e9@gmail.com> <trinity-7580d955-3187-41e5-9297-1ac8f628a9d5-1624609003739@3c-app-gmx-bs66> <8b27246b-721e-fa0e-5c2b-b1b4b4d6fdd3@linaro.org> <trinity-2eb7c0ac-d9dc-446c-8907-69b5f4df6838-1624618996538@3c-app-gmx-bs66>
X-Referenced-Uid: 5607
Thread-Topic: Aw: Re:  Re: [PATCH] Fix mt7622.dtsi thermal cpu
X-Blue-Identity: !l=334&o=43&fo=5970&pl=224&po=0&qs=PREFIX&f=HTML&m=!%3ANzRiZDk5M2QtNTJhNy00MTE4LThlNmYtYTk2ZDg2NDQzNGU0%3ASU5CT1g%3D%3ANTYwNw%3D%3D%3AANSWERED&p=195&q=SHOW
X-Is-Generated-Message-Id: true
User-Agent: Android
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Local-Message-Id: <52767351-83da-41e2-a746-3407ee9c73e8@gmail.com>
Content-Type: text/plain;
 charset=UTF-8
Subject: Re:  Re: [PATCH] Fix mt7622.dtsi thermal cpu
From:   Eric Woudstra <ericwouds@gmail.com>
Date:   Fri, 25 Jun 2021 13:07:42 +0200
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>
Message-ID: <52767351-83da-41e2-a746-3407ee9c73e8@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I choose "hot* with CPU, because it was the best temperature=2E But it shou=
ld really be passive only with the cooling device CPU but with a much highe=
r temperature=2E For me 87 degrees is fine and tested=2E But for mainline w=
e would better ask Mediatek for the correct maximum temperature=2E

=E2=81=
=A3Get BlueMail for Android =E2=80=8B

On Jun 25, 2021, 1:03 PM, at 1:03 PM=
, Frank Wunderlich <frank-w@public-files=2Ede> wrote:
>Hi
>
>> Gesendet: Fr=
eitag, 25=2E Juni 2021 um 11:57 Uhr
>> Von: "Daniel Lezcano" <daniel=2Elezc=
ano@linaro=2Eorg>
>
>> You should not add the fan in the mt7622=2Edtsi itse=
lf but in the board
>> specific file where there is a fan output on it=2E m=
t7622=2Edtsi is
>supposed
>> to be the SoC itself AFAICT=2E
>>
>> For insta=
nce:
>>
>>
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/thermal/lin=
ux=2Egit/tree/arch/arm64/boot/dts/rockchip/rk3399-sapphire=2Edtsi#n39
>>
>>=

>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/thermal/linux=2Egit/t=
ree/arch/arm64/boot/dts/rockchip/rk3399-sapphire=2Edtsi#n164
>
>> > @@ -170=
,14 +177,12 @@
>> >  			cooling-maps {
>> >  				map0 {
>> >  					trip =3D=
 <&cpu_passive>;
>> > -					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THER=
MAL_NO_LIMIT>,
>> > -							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> =
> +					cooling-device =3D <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> > =
 				};
>>
>> fan =3D=3D active trip point
>>
>> This is referring to the p=
assive trip point=2E So it should point to
>the
>> CPU as it is now=2E Note=
 the order of mitigation is inverted regarding
>the
>> proposal description=
=2E
>
>but we need to disable the passive trip as cpu-trotteling starts
>th=
ere=2E=2E=2Ethe higher temperature trips are currently not reached
>
>summa=
ry
>
>moving fan and cpu_thermal-override to bananapi-r64=2Edts
>
>passive-=
trip: cooling-device =3D <&cpu0/1 0 0> as in erics Patch
>active trip: cool=
ing-device =3D <&fan0 THERMAL_NO_LIMIT
>THERMAL_NO_LIMIT>;
>the other 2 unc=
hanged
>
>but i suggest changing the temperature points in mt7622 dtsi as t=
his is
>SoC specific
>
>so basicly:
>
>--- a/arch/arm64/boot/dts/mediatek/m=
t7622=2Edtsi
>+++ b/arch/arm64/boot/dts/mediatek/mt7622=2Edtsi
>@@ -143,13 =
+143,13 @@ cpu_thermal: cpu-thermal {
>
>                        trips {
> =
                               cpu_passive: cpu-passive {
>-               =
                        temperature =3D <47000>;
>+                        =
               temperature =3D <70000>;
>                                  =
      hysteresis =3D <2000>;
>                                        type =
=3D "passive";
>                                };
>
>                     =
           cpu_active: cpu-active {
>-                                     =
  temperature =3D <67000>;
>+                                       tempera=
ture =3D <80000>;
>                                        hysteresis =3D <=
2000>;
>                                        type =3D "active";
>       =
                         };
>@@ -170,8 +170,8 @@ cpu-crit {
>              =
          cooling-maps {
>                                map0 {
>         =
                               trip =3D <&cpu_passive>;
>-                 =
                      cooling-device =3D <&cpu0
>THERMAL_NO_LIMIT THERMAL_N=
O_LIMIT>,
>-                                                        <&cpu1
=
>THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>+                                    =
   cooling-device =3D <&cpu0 0 0>,
>+                                      =
                  <&cpu1 0 0>;
>                                };
>
>     =
                           map1 {
>@@ -428,6 +428,7 @@ uart3: serial@110050=
00 {
>        pwm: pwm@11006000 {
>                compatible =3D "mediatek=
,mt7622-pwm";
>                reg =3D <0 0x11006000 0 0x1000>;
>+         =
      #pwm-cells =3D <3>;
>                interrupts =3D <GIC_SPI 77 IRQ_T=
YPE_LEVEL_LOW>;
>                clocks =3D <&topckgen CLK_TOP_PWM_SEL>,
> =
                        <&pericfg CLK_PERI_PWM_PD>,
>
>--- a/arch/arm64/boo=
t/dts/mediatek/mt7622-bananapi-bpi-r64=2Edts
>+++ b/arch/arm64/boot/dts/med=
iatek/mt7622-bananapi-bpi-r64=2Edts
>@@ -37,6 +37,13 @@ cpu@1 {
>          =
      };
>        };
>
>+       fan0: pwm-fan {
>+               compatible=
 =3D "pwm-fan";
>+               #cooling-cells =3D <2>;
>+               p=
wms =3D <&pwm 2 10000 0>;
>+               cooling-levels =3D <0 102 170 23=
0>;
>+       };
>+
>        gpio-keys {
>                compatible =3D "gp=
io-keys";
>
>@@ -582,6 +589,29 @@ &u3phy {
>        status =3D "okay";
> };=

>
>+&cpu_thermal {
>+       cooling-maps {
>+               map1 {
>+     =
                  trip =3D <&cpu_active>;
>+                       cooling-=
device =3D <&fan0 THERMAL_NO_LIMIT
>THERMAL_NO_LIMIT>;
>+               };
=
>+       };
>+};
>+
> &uart0 {
>        pinctrl-names =3D "default";
>     =
   pinctrl-0 =3D <&uart0_pins>;

