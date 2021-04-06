Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331CC35534C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbhDFMMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:12:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:56321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235527AbhDFMMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617711110;
        bh=tZBy5KAAZ9vu5ip+BcWqftbm3tGw9rhGKlIlf9459yg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=B5rt/n8dyE/K24eR8WBvlExqIrrgOUX6kl0CJy/Ug1GIK+2lJH99U47pWhOWIan0y
         7Bp4KMyV1TkxpiRVoUx3ZeZn3Pn1B8xmcC1cBc4ivQfiEIBc4DLOh7XavIUJco+dH3
         GiOx4tY057o0dmQvj001yLFovIlChjiM3YwbeXbU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1lpX8c3fHj-00xL35; Tue, 06
 Apr 2021 14:11:49 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     Tomer Maimon <tmaimon77@gmail.com>, Joel Stanley <joel@jms.id.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 08/10] ARM: dts: Add devicetree for Nuvoton WPCM450 BMC chip
Date:   Tue,  6 Apr 2021 14:09:19 +0200
Message-Id: <20210406120921.2484986-9-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
References: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tfnzukyq6T5j6Jov6LVF0Wy9HPGJ9303YpWehXV3q7sfViq6gSc
 I9KMKchj0t79wSxluPJLzvTVFe8BJpT+qQDKKPH9TMPEfU1wwJxHA7gArdCXKb/C+Nl9mBC
 S6ZutBpD4tPQw1VFx2IsT+d3xyCWkhhHG7dlc4Ty+JiWkECu3vRNrVIu8K++MUuXFKRpeBQ
 9ZdP3Tdv2iQk94q2yPaxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CU+yLTsdxR4=:fu1bMWWg3P5326h8pIIrhg
 L18WyNLhEKyvTqLezBQdsG2jP1le8u5RNlg/gr1sV6J4jekTDTlJTFCU9M/4tw0xIhQFZLnss
 LZeZmzhrFie+eSe7qIqWaDU3h1ZOS59ajqKLrEOHg+5nNtCb48IM9h1tqqB+RQAl1MgRj1Yex
 WRnLC6P4jXIvSa6Rrgp0FgyFWI+98CEqWJwYKDyAGIcqc9hnPWUKXqVTI3aE0HF0MJZcaDawF
 vhSuXuxqGnf9jpMqaNjAhazFX0pqEV+XSBvxuHymGqiWPOsvkLL4B8kURCUZO/pNjwS+ASOBL
 8/HpPt0ZZgkvsCy1Wy4lx4rQf1v+JlDgWRshBeTJILZJRmDcurvS0vLkkfqqHVxwPRQHLnrCu
 WSDJwF7ICO4G2rjbQIO1n+JubtmPnBNsaDNOazTxiYtXxM9dCHaMp+junqqQDS87r1j17utI2
 0lirKtwLlelu6b2o7Wc7V4eaBOPBJbt31jR2vo577bHapelBGpa3vFcrO6npLDsPT5vCUp2Qe
 fDGCtAeRnvKeZULdrNEloF1UuiNmRQDwjjpWjq3evTeYUE2Wff6TGV5bw0h5Ibz/N98EWpN+N
 92Mce9O5Y3Bo9J70Q0iYnJn5Bwkl1/3l+TqmBoMTqtja2WINpxtGMfBhB+Mvv7PzoLxZjdsIG
 piTeAaHSnzoE0uxriHgOmOl0k+wKz/5GLNRekgLyIGfm18ME3dJXMjn9F+yRRyT8lvRqCU4LS
 9WtENt0KC+GfFxC1PI+TMlckyGSkCdbOrqHxIKh0WjPsbn9ylD2YtYfcNtWe4aUl4gMERtiDx
 MreWu9Pd8WMhuEqg7Xai1VmsvJcbGv1tV+XzcOBVX127B4v8XaIu28dL8eg3DyMaJ/NqaRGVw
 dZWNcYo7PkbKizWJPIHxqkJVgAZ7jnT6jDm6HgV/QlSoz8Vr3qxpLjDsGF37Hr0gFff7AE/7l
 VJuvvSE9gz8+jyvSpRLVtoWMv0BYBWJA2NfD2L4ZjI3zqJ+yFXCLt5nWySm6ZDBNg5iSZFs/+
 6ahTOGXljEDXF7P+02AzcMKJykaGUsEdDzJrxnryWZYmUftWB5HzsUDy6Fwc38sv1D23kUVW1
 1D6Z5wblngB31WF7uSUWwUy7CZVUk2jF0mYx3oM2il+ztfmqSVyy8/gnpeqgVOzVuqxljrrir
 SnuAeOQjHWyxChlgsg01OtW/wP8TStnYMdox/bIhbhpBx4SgAmh/nErKkhvwdqcdzJEJB7E4c
 XCVKnXySvUTK0Uqls
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WPCM450 is an older BMC SoC in the Nuvoton NPCM family, originally
marketed as Winbond WPCM450.

This patch adds a devicetree with basic functionality.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- no changes
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 76 ++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 arch/arm/boot/dts/nuvoton-wpcm450.dtsi

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
new file mode 100644
index 0000000000000..d7cbeb1874840
=2D-- /dev/null
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+// Copyright 2021 Jonathan Neusch=C3=A4fer
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible =3D "nuvoton,wpcm450";
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		cpu@0 {
+			compatible =3D "arm,arm926ej-s";
+			device_type =3D "cpu";
+			reg =3D <0>;
+		};
+	};
+
+	clk24m: clock-24mhz {
+		/* 24 MHz dummy clock */
+		compatible =3D "fixed-clock";
+		clock-frequency =3D <24000000>;
+		#clock-cells =3D <0>;
+	};
+
+	soc {
+		compatible =3D "simple-bus";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		interrupt-parent =3D <&aic>;
+		ranges;
+
+		serial0: serial@b8000000 {
+			compatible =3D "nuvoton,wpcm450-uart";
+			reg =3D <0xb8000000 0x20>;
+			reg-shift =3D <2>;
+			interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clk24m>;
+			status =3D "disabled";
+		};
+
+		serial1: serial@b8000100 {
+			compatible =3D "nuvoton,wpcm450-uart";
+			reg =3D <0xb8000100 0x20>;
+			reg-shift =3D <2>;
+			interrupts =3D <8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&clk24m>;
+			status =3D "disabled";
+		};
+
+		timer0: timer@b8001000 {
+			compatible =3D "nuvoton,wpcm450-timer";
+			interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH>;
+			reg =3D <0xb8001000 0x1c>;
+			clocks =3D <&clk24m>;
+		};
+
+		watchdog0: watchdog@b800101c {
+			compatible =3D "nuvoton,wpcm450-wdt";
+			interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH>;
+			reg =3D <0xb800101c 0x4>;
+			clocks =3D <&clk24m>;
+			status =3D "disabled";
+		};
+
+		aic: interrupt-controller@b8002000 {
+			compatible =3D "nuvoton,wpcm450-aic";
+			reg =3D <0xb8002000 0x1000>;
+			interrupt-controller;
+			#interrupt-cells =3D <2>;
+		};
+	};
+};
=2D-
2.30.2

