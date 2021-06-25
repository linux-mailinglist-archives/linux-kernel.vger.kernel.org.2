Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55E43B3E54
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFYITT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:19:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:45153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229799AbhFYITS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624609003;
        bh=KPSrVHtFgQjR0DccR13l5IWzueT0aS5xNt0lrvk59Oc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YGWHfdTXSfOQ4LmR7/hDAc2DAh1Io6AaVX9/oWX9+KScNU7XqxZizggmy1oxsBEi5
         i0V2DWKGr5pqMHEFw09+PS6575nydXNOacuvqfwLzjwUJSDZr/keEYBOecdcTrfYg+
         dj94cM6JWV0aR84xBjqzNU0zP5s9GsxJDY8KBgbI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.157.219] ([217.61.157.219]) by web-mail.gmx.net
 (3c-app-gmx-bs66.server.lan [172.19.170.210]) (via HTTP); Fri, 25 Jun 2021
 10:16:43 +0200
MIME-Version: 1.0
Message-ID: <trinity-7580d955-3187-41e5-9297-1ac8f628a9d5-1624609003739@3c-app-gmx-bs66>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Eric Woudstra <ericwouds@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Aw: Re: [PATCH] Fix mt7622.dtsi thermal cpu
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Jun 2021 10:16:43 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <3dd22cf2-1186-4870-aa49-e5cddc18c6e9@gmail.com>
References: <20210619121927.32699-1-ericwouds@gmail.com>
 <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org>
 <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
 <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org>
 <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com>
 <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org>
 <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com>
 <173e6bab-9d21-eb28-9b91-a5f80c01fd03@linaro.org>
 <3dd22cf2-1186-4870-aa49-e5cddc18c6e9@gmail.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:4154xVDgSfyG4t08O7Ht9tPl5ySlXuRPX9mO546NB9MEsmBGYGbuNdW1daSYpnkev6AqM
 q8ii1ZC6PODAWiCN6EDefPVGOxPhdR0BJT5+s5s6oh948EnixcAJNO6fbZgJzfgqU9SSzOpHBIFq
 mKMSWO0QdldOBlNGJjdVNIJtH0hCWu0/QBIwHjtLpbKcYOcbR9eBDnGhWNdv/TsQDo8VbGwpkPbW
 OXEei+hhi5DnplcNorFsuqzv47Q4ykmYafc6huTcnSz8ClT4MrqhPY/zod4vn2bzjB6aRHw16Vxv
 FU=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UkCnIuOiaLQ=:1EtElga8OjLd/1aVJ8OeWg
 GOB7UgKTLZ3X1+WANSd7qmaG+M9DdejmOHur5CPAb/FfDE2y+MOtZOye6qDv6kbbnXLGAbzVs
 lOyLusA2Pr1veBOj27hwlgMSKWVusSzxghFTLDaA3m6bG26zPbUFo1FKmDYTkmd/Dk9vzVT6K
 dAM62vO7h2IOdjJfmZEn4cA0bBIRY8MgaAZxCAbh3exjN/DRfSahsn0jV2OCraQBUK7tLVrk5
 9odlS2gY4bvAyls5QvFgXmA8hvyuJoJUtMPTe5ORA3jm7xh+bBo5S7WoXxrObwJtGnECQbtVD
 rxhjLWdWDTmOA6ZOlNZh0xUH44q91Nx7vC5ae3gwTfYhL/TiayOJZmPdpvUdgU1sdQE+k/qaI
 D9Iy/3O5B3XUUk6df7M4EgtIf0+twphoK4Ex4wVIT8f65p06qXxLcHM+066t9RffQFCATXHRW
 sbl6GHa+MUqbmljLzWWebn/M2g9AEfMeOVQq8pDLVcZu0AahDmnjMrLYWzx7CmKfgtyp3HGq5
 60AWujl+lokqm9j7J4ovmR+MPIypcYbi3CDvtE7uugnCc/OHEy46Xc8nRMVNckBUWFNHvB1QQ
 PFcsFfqmREYMOksGDz7O2y2zpws5SBpnUCAhJtaS6duN620UlOg5KblzepmMqKemlsx+O8WUP
 j/ASMap2nID/kgU6/S7aa1Gy85V+ZN+wNFDr+j+ZGYl8UT3HSqHrgjIq+QdjgKEWDVYNRR7fe
 i3EyIRCqtQlw8Y9vYduNJjzu5wuk2ixqeAZtB95itD8gR+0yCEKjrCCKWo6+0iAOyhtIFI93O
 Yvh95Otll1gfCxYyI6v5PAHHNPl5pau2IBepPDbfinPHH1OUf4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Gesendet: Donnerstag, 24=2E Juni 2021 um 15:29 Uhr
> Von: "Eric Woudstra" <ericwouds@gmail=2Ecom>
> The SOC runs unthrotlled slowly to 80 degrees=2E This takes minutes=2E P=
olling interval 1 second or less does not matter much when looking at these=
 temperature rise times=20
>=20
> After that in more then an hour it slowly creeps up to 85=2E I believe t=
he design is so that the SOC, under normal circumstances, can run at 1=2E35=
 GHz without throttling frequency, without heatsink=2E It just needs a safe=
guard for different circumstances=2E
>=20
> Most of these SOCs can also run in industrial grade circumstances, which=
 means up to 85 degrees ambient temperature already =2E If not industrial t=
hen this would be 60 degrees ambient already=20
>=20
> But only someone at Mediatek can confirm this=20

maybe Matthias knows anybody?
get_maintainers-script shows no mtk employee for mtk_thermal driver, added=
 Sean and Ryder as common Linux-Contacts=2E=2E=2E

Daniel from openwrt have some other mt7622 Boards maybe he can test the Fa=
n approach below

> On Jun 24, 2021, 12:21 PM, at 12:21 PM, Daniel Lezcano <daniel=2Elezcano=
@linaro=2Eorg> wrote:
> >Found that:
> >
> >https://download=2Ekamami=2Epl/p579344-MT7622A_Datasheet_for_BananaPi_O=
nly%281%29=2Epdf
> >
> >Chapter 3=2E3 - Thermal Characteristics
> >
> >Given the values I suggest:
> >
> > - Passive - 80=C2=B0C
> >
> > - Hot - 90=C2=B0C
> >
> > - Critical - 100=C2=B0C

maybe adding FAN (r64, don't know for other mt7622 boards) for lower 2 tri=
ps (with adjusted temperature points) and cpu-throtteling for upper 2 trips

something like this (used the 70/80 trip points discussed before):

--- a/arch/arm64/boot/dts/mediatek/mt7622=2Edtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622=2Edtsi
@@ -134,6 +134,13 @@
 		};
 	};
=20
+	fan0: pwm-fan {
+		compatible =3D "pwm-fan";
+		#cooling-cells =3D <2>;
+		pwms =3D <&pwm 2 10000 0>;
+		cooling-levels =3D <0 102 170 230>;
+	};
+
 	thermal-zones {
 		cpu_thermal: cpu-thermal {
 			polling-delay-passive =3D <1000>;
@@ -143,13 +150,13 @@
=20
 			trips {
 				cpu_passive: cpu-passive {
-					temperature =3D <47000>;
+					temperature =3D <70000>;
 					hysteresis =3D <2000>;
 					type =3D "passive";
 				};
=20
 				cpu_active: cpu-active {
-					temperature =3D <67000>;
+					temperature =3D <80000>;
 					hysteresis =3D <2000>;
 					type =3D "active";
 				};
@@ -170,14 +177,12 @@
 			cooling-maps {
 				map0 {
 					trip =3D <&cpu_passive>;
-					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device =3D <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
=20
 				map1 {
 					trip =3D <&cpu_active>;
-					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device =3D <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
=20
 				map2 {
@@ -428,6 +433,7 @@
 	pwm: pwm@11006000 {
 		compatible =3D "mediatek,mt7622-pwm";
 		reg =3D <0 0x11006000 0 0x1000>;
+		#pwm-cells =3D <3>;
 		interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
 		clocks =3D <&topckgen CLK_TOP_PWM_SEL>,
 			 <&pericfg CLK_PERI_PWM_PD>,


regards Frank
