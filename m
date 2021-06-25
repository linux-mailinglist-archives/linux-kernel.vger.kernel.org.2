Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F583B420F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFYLF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:05:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:38403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFYLFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624618996;
        bh=g/1l77n9SRFOvqNNHUd97uMSJe2gTcM2ug+hsnbl3Gk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EMeCoMdPzNQZym6nwtrXDEQeWas1h+MMoYjDX6eep49P5tjRFBjTLvnxdU7gU66M+
         JXjIXJZuisw0H+Q+0R8bDU9AdSJblpjIMNJ+d5OAFWoHTn5XXx2YCaD1cCRGY3BGxX
         jlGsTxNWLvqMfFxg83E2Q06TyoQVj/hWBYjeyvxU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.157.219] ([217.61.157.219]) by web-mail.gmx.net
 (3c-app-gmx-bs66.server.lan [172.19.170.210]) (via HTTP); Fri, 25 Jun 2021
 13:03:16 +0200
MIME-Version: 1.0
Message-ID: <trinity-2eb7c0ac-d9dc-446c-8907-69b5f4df6838-1624618996538@3c-app-gmx-bs66>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eric Woudstra <ericwouds@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Aw: Re:  Re: [PATCH] Fix mt7622.dtsi thermal cpu
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Jun 2021 13:03:16 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <8b27246b-721e-fa0e-5c2b-b1b4b4d6fdd3@linaro.org>
References: <20210619121927.32699-1-ericwouds@gmail.com>
 <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org>
 <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
 <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org>
 <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com>
 <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org>
 <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com>
 <173e6bab-9d21-eb28-9b91-a5f80c01fd03@linaro.org>
 <3dd22cf2-1186-4870-aa49-e5cddc18c6e9@gmail.com>
 <trinity-7580d955-3187-41e5-9297-1ac8f628a9d5-1624609003739@3c-app-gmx-bs66>
 <8b27246b-721e-fa0e-5c2b-b1b4b4d6fdd3@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:0os7uhuK8TvkyvnXgZYkBKOUKqVXeknBjyVhU8kcofVYZisfTdOZDW21UW96lmFSKWJe3
 BB/hvXUJMiJizJhW1zn2Dl+fzi2CM+bBKg4Pt8OAXChs9W65IU3PA2FK4akf+z4jgP4quoY1Qkae
 gM35Jxb+STndPOC3BdW9tz3fMxfOHG0d2RlOHInF0eyZ8nLyOKkLGVqZiak/C06iKYR0L+Ubu6/t
 EXxyVbdVfi+jAvDGgGKvz+7HYpYdyfgPfX5+AXX16wIYD9IXADjmz7/8XuyjkZBhHTvGxmGLmuMl
 9U=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9rdLbwbOXq0=:bT2NbFMJ3ks1ap4pjutQ9b
 gaQrK+8Jm7K3t1+Ep/+5qd16A8xx6FisDmJHZH+Pf1Bw/EKufuvej8ZOS1Y0P/DUlnPgs9f1I
 VoYyA46sUU/s5fP6UWBJeizpcKIXXtBts6G04Ngr0q3Sg8xsa5FX/gjS5o2FqsfwqEwxPhOi5
 vDgXN8OHQ2q8vWf0tSoki7tqRwEO4Hp+fzN9nEJz3EbuN+3pWVKyJ+0CUfkYpWaV9WhLr2Fq3
 +4APmI8rgavyJKWbnqf6QPc26KSwgT85uEqfyhN/bRH4TOs0mnN0TPsRnUnZ6SPGdP48tMbz8
 ki0Iy7nL90+rEZo7s210HCcPrDikZ+ATelOYJWE9e+HwBSYPt4XvFJ+PTwu64z7Nb3duGJxze
 ZA/j9W9kOP1WSVk83667UZd/vR1UzoNqnjQdkyxdEduidpvVj8EO3F7EANrF3hirSOsZHURHi
 15tn1Q/a8x3/rqghUlqcZShwlzXL3v86Hj7qhEkPHRcZvHatcFf/mgVXRMdDwha2+GxtYxW3C
 mgYrljdFDyzvuFt2ZE8Fpgo+bN5ngvkKHXbW+1kRsE+3yqBEGAe9O6x0oEZpOIPOq4JlrEHYX
 7JX3fVNIdqx39dKQkkulqWid4O/hzjmsangdCKzot23TGh8h8u8sscMLR1cTjgy8aWWjakUqh
 wZzY799FuWrZHejdwRzgze84Z6GFlr4198vlT8VXBP/3/Cd220qF8rR5VU/hIkp02c1eMqKUh
 hc4i4RdYqBV6ERFFgRnyBDZy4CBvYFki2Yi4A+9nTnXS/A29mQFgh26pZDV0WsUhm7Kh2HqSt
 hPm92VPi5tnDAmYZydAe3ud6wRYgiwRt4+RaLLbZxCBARe+was=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Freitag, 25. Juni 2021 um 11:57 Uhr
> Von: "Daniel Lezcano" <daniel.lezcano@linaro.org>

> You should not add the fan in the mt7622.dtsi itself but in the board
> specific file where there is a fan output on it. mt7622.dtsi is supposed
> to be the SoC itself AFAICT.
>
> For instance:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/a=
rch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi#n39
>
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/a=
rch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi#n164

> > @@ -170,14 +177,12 @@
> >  			cooling-maps {
> >  				map0 {
> >  					trip =3D <&cpu_passive>;
> > -					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > -							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +					cooling-device =3D <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >  				};
>
> fan =3D=3D active trip point
>
> This is referring to the passive trip point. So it should point to the
> CPU as it is now. Note the order of mitigation is inverted regarding the
> proposal description.

but we need to disable the passive trip as cpu-trotteling starts there...t=
he higher temperature trips are currently not reached

summary

moving fan and cpu_thermal-override to bananapi-r64.dts

passive-trip: cooling-device =3D <&cpu0/1 0 0> as in erics Patch
active trip: cooling-device =3D <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
the other 2 unchanged

but i suggest changing the temperature points in mt7622 dtsi as this is So=
C specific

so basicly:

=2D-- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -143,13 +143,13 @@ cpu_thermal: cpu-thermal {

                        trips {
                                cpu_passive: cpu-passive {
-                                       temperature =3D <47000>;
+                                       temperature =3D <70000>;
                                        hysteresis =3D <2000>;
                                        type =3D "passive";
                                };

                                cpu_active: cpu-active {
-                                       temperature =3D <67000>;
+                                       temperature =3D <80000>;
                                        hysteresis =3D <2000>;
                                        type =3D "active";
                                };
@@ -170,8 +170,8 @@ cpu-crit {
                        cooling-maps {
                                map0 {
                                        trip =3D <&cpu_passive>;
-                                       cooling-device =3D <&cpu0 THERMAL_=
NO_LIMIT THERMAL_NO_LIMIT>,
-                                                        <&cpu1 THERMAL_NO=
_LIMIT THERMAL_NO_LIMIT>;
+                                       cooling-device =3D <&cpu0 0 0>,
+                                                        <&cpu1 0 0>;
                                };

                                map1 {
@@ -428,6 +428,7 @@ uart3: serial@11005000 {
        pwm: pwm@11006000 {
                compatible =3D "mediatek,mt7622-pwm";
                reg =3D <0 0x11006000 0 0x1000>;
+               #pwm-cells =3D <3>;
                interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
                clocks =3D <&topckgen CLK_TOP_PWM_SEL>,
                         <&pericfg CLK_PERI_PWM_PD>,

=2D-- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -37,6 +37,13 @@ cpu@1 {
                };
        };

+       fan0: pwm-fan {
+               compatible =3D "pwm-fan";
+               #cooling-cells =3D <2>;
+               pwms =3D <&pwm 2 10000 0>;
+               cooling-levels =3D <0 102 170 230>;
+       };
+
        gpio-keys {
                compatible =3D "gpio-keys";

@@ -582,6 +589,29 @@ &u3phy {
        status =3D "okay";
 };

+&cpu_thermal {
+       cooling-maps {
+               map1 {
+                       trip =3D <&cpu_active>;
+                       cooling-device =3D <&fan0 THERMAL_NO_LIMIT THERMAL=
_NO_LIMIT>;
+               };
+       };
+};
+
 &uart0 {
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&uart0_pins>;

