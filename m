Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EDA32057A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 14:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhBTNAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 08:00:02 -0500
Received: from mout.web.de ([212.227.17.12]:54189 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhBTM7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 07:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1613825880;
        bh=jbIaYmFaOqq0clqt0lvEdAqigbIkxFOQTe0r7vbPqKA=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=dTufpZboUv8d2v3DM8Xe2kUPNItkFZ+hevfRErL/TFZn648JdayFElAHsogGwclig
         JIBSiNoBTptJTSc05SrPjFrcxhh5MDUhpuX3PLjvnLbd0e/76w/fPoWUHPkSCEwhzJ
         2eDsL5bkrrRCaE3wfY9pY6TlZpDEnUSw04F6tRgo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.10.10] ([88.215.87.53]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8zSL-1l7i0M0bN7-00CPCE; Sat, 20
 Feb 2021 13:49:55 +0100
From:   Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] arm64: dts: ti: k3-am65-mcu: Add RTI watchdog entry
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <279c20fa-6e5e-4f88-9cd1-f76297a28a19@web.de>
Date:   Sat, 20 Feb 2021 13:49:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jIVLv6c7lrDzDxsW6xCEDy+iQKWCdOtQcWp0reorhUE8T9V9i8h
 bWJ12B1tnUeHC8qT8U70s8PzbJZHFCMfJ/ga/V2yR9ndA1sHsgchpXbaDBsYhYCxlnVwEB8
 7EUa6E9V5fKmk1R9prfitiPbpxrLeRuF7Axct11XnXzb/cGTDQjLgFStx4m5HsiYdSNgj1N
 kIpt7hqIBkEkO7Iu40UWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T91gGQkcBlY=:i2CYnlzEYoO0ShILacv0Dw
 gqvLd9EPNVqanltvKMplTFrlQK8Bek6WwVMSTzRA+gBaxLJz1eVq8s4Ypyxo5smxM/z/UAoNP
 BjZkd+hMmcVgtPZIVMK37jpsQJD24hbUmqqZrL+WCWQQ6GHsMsHIdR91fSU7ltVPvOFsNdQEL
 1UXIpXtPCzZX3XvYFbAXGK2yD7DBsGfwheNsyN+ryqE8vc2ooey6OzqV1QunBAlefUedXvcK8
 hQfYiHWUr01XliI56ryf8u+LRN3JxWbnVvCtDwNaf5AKEO8arN0Xc5fS97wWxqn9fIpG9iPMw
 bllOi92ZSCNX3Sl5dNnLMYZffByjw1LxYt09aluu8W4F9JrrOnOQteG23s3LdsmfEpHtHQGyz
 n3KEwiDd4XWLxKfvPisk7hL5jFBEMhiqfbR8fbaQmpPeyqVj4gafyCc+pw94UgWLEP+UbYqlB
 avRlZXgFRhGO/7p4NhEXzz6x4SyzFwAAaQW6GDKDh/77vfrkNbZDbKEwIcjduPDnGZDIDUQkl
 phQmZWXbwmDjOl8TdgRvtfp7cO3ur9sKGPMyIrRr4fHXGAuacie7yGoEoAlvGNyVcif3YUFcw
 gAx0nkATp9LtWNRvP99G0xUiflcHOPF+S6qUiOtkEuwPU/dDLnDDp6npOtro3ZPhKOSIYfSUa
 b3vq+nL9zflM3J/tBls3P5BsaZlzWs7EQh0Pp1flQzsMJPdvSeoQLYijtkh9tdiikKoXMD1kR
 rUZVVogXPQdwQbPp27YKrLnhYvtonnGDXlg4/W0MmmyTfpduOM9Wgmz/58z4L5dg4BtlmVq3D
 L3+78INT0HFPcdzRC6o7IUBgzdJC7JkokBgdejYoLU2Mo7kyEsyTGV0QevymyElu9GHZs+xJJ
 3dMLChfM/Rrx2cPmc5ww==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Add the DT entry for a watchdog based on RTI1.

On SR1.0 silicon, it requires additional firmware on the MCU R5F cores
to handle the expiry, e.g. https://github.com/siemens/k3-rti-wdt. As
this firmware will also lock the power domain to protect it against
premature shutdown, mark it shared.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts=
/ti/k3-am65-mcu.dtsi
index 7454c8cec0cc..903796bf7d64 100644
=2D-- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -308,4 +308,13 @@ mcu_r5fss0_core1: r5f@41400000 {
 			ti,loczrama =3D <1>;
 		};
 	};
+
+	mcu_rti1: rti@40610000 {
+		compatible =3D "ti,j7-rti-wdt";
+		reg =3D <0x0 0x40610000 0x0 0x100>;
+		clocks =3D <&k3_clks 135 0>;
+		power-domains =3D <&k3_pds 135 TI_SCI_PD_SHARED>;
+		assigned-clocks =3D <&k3_clks 135 0>;
+		assigned-clock-parents =3D <&k3_clks 135 4>;
+	};
 };
=2D-
2.26.2

