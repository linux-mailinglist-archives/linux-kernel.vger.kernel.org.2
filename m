Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4565C308CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhA2SlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:41:08 -0500
Received: from mail.v3.sk ([167.172.186.51]:56722 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232670AbhA2Skt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:40:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9035BE0B46;
        Fri, 29 Jan 2021 18:35:56 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1rhXN8W2bJvM; Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 32315E0B41;
        Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9VRIdhK8x0kz; Fri, 29 Jan 2021 18:35:46 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C6727E0B3E;
        Fri, 29 Jan 2021 18:35:45 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/5] docs: arm: marvell: turn the automatic links into labels
Date:   Fri, 29 Jan 2021 19:39:46 +0100
Message-Id: <20210129183950.75405-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210129183950.75405-1-lkundrak@v3.sk>
References: <20210129183950.75405-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lines ending with obscenely long URLs at the end don't look good.

Even if these links are not that long at this point, they will be when
replaced with an archive link in a subsequent patch -- let's prepare for
that.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/arm/marvel.rst | 209 ++++++++++++++++++++++++-----------
 1 file changed, 143 insertions(+), 66 deletions(-)

diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvel.rst
index 16ab2eb085b86..716551f9b60a1 100644
--- a/Documentation/arm/marvel.rst
+++ b/Documentation/arm/marvel.rst
@@ -18,12 +18,12 @@ Orion family
         - 88F5181L
         - 88F5182
=20
-               - Datasheet: http://www.embeddedarm.com/documentation/thi=
rd-party/MV88F5182-datasheet.pdf
-               - Programmer's User Guide: http://www.embeddedarm.com/doc=
umentation/third-party/MV88F5182-opensource-manual.pdf
-               - User Manual: http://www.embeddedarm.com/documentation/t=
hird-party/MV88F5182-usermanual.pdf
+               - Datasheet: `MV88F5182-datasheet.pdf`_
+               - Programmer's User Guide: `MV88F5182-opensource-manual.p=
df`_
+               - User Manual: `MV88F5182-usermanual.pdf`_
         - 88F5281
=20
-               - Datasheet: http://www.ocmodshop.com/images/reviews/netw=
orking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
+               - Datasheet: `marvel_88f5281_data_sheet.pdf`_
         - 88F6183
   Core:
 	Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
@@ -32,37 +32,42 @@ Orion family
   Linux kernel plat directory:
 	arch/arm/plat-orion
=20
+.. _MV88F5182-datasheet.pdf: http://www.embeddedarm.com/documentation/th=
ird-party/MV88F5182-datasheet.pdf
+.. _MV88F5182-opensource-manual.pdf: http://www.embeddedarm.com/document=
ation/third-party/MV88F5182-opensource-manual.pdf
+.. _MV88F5182-usermanual.pdf: http://www.embeddedarm.com/documentation/t=
hird-party/MV88F5182-usermanual.pdf
+.. _marvel_88f5281_data_sheet.pdf: http://www.ocmodshop.com/images/revie=
ws/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
+
 Kirkwood family
 ---------------
=20
   Flavors:
         - 88F6282 a.k.a Armada 300
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/armada-300/assets/armada_310.pdf
+                - Product Brief  : `armada_310.pdf`_
         - 88F6283 a.k.a Armada 310
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/armada-300/assets/armada_310.pdf
+                - Product Brief  : `armada_310.pdf`_
         - 88F6190
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/88F6190-003_WEB.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/HW_88F619x_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : `88F6190-003_WEB.pdf`_
+                - Hardware Spec  : `HW_88F619x_OpenSource.pdf`_
+                - Functional Spec: `FS_88F6180_9x_6281_OpenSource.pdf`_
         - 88F6192
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/88F6192-003_ver1.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/HW_88F619x_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : `88F6192-003_ver1.pdf`_
+                - Hardware Spec  : `HW_88F619x_OpenSource.pdf`_
+                - Functional Spec: `FS_88F6180_9x_6281_OpenSource.pdf`_
         - 88F6182
         - 88F6180
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/88F6180-003_ver1.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/HW_88F6180_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : `88F6180-003_ver1.pdf`_
+                - Hardware Spec  : `HW_88F6180_OpenSource.pdf`_
+                - Functional Spec: `FS_88F6180_9x_6281_OpenSource.pdf`_
         - 88F6281
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/88F6281-004_ver1.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/HW_88F6281_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : `88F6281-004_ver1.pdf`_
+                - Hardware Spec  : `HW_88F6281_OpenSource.pdf`_
+                - Functional Spec: `FS_88F6180_9x_6281_OpenSource.pdf`_
   Homepage:
 	http://www.marvell.com/embedded-processors/kirkwood/
   Core:
@@ -72,20 +77,35 @@ Kirkwood family
   Linux kernel plat directory:
 	none
=20
+.. _armada_310.pdf: http://www.marvell.com/embedded-processors/armada-30=
0/assets/armada_310.pdf
+.. _armada_310.pdf: http://www.marvell.com/embedded-processors/armada-30=
0/assets/armada_310.pdf
+.. _88F6190-003_WEB.pdf: http://www.marvell.com/embedded-processors/kirk=
wood/assets/88F6190-003_WEB.pdf
+.. _HW_88F619x_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/kirkwood/assets/HW_88F619x_OpenSource.pdf
+.. _FS_88F6180_9x_6281_OpenSource.pdf: http://www.marvell.com/embedded-p=
rocessors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+.. _88F6192-003_ver1.pdf: http://www.marvell.com/embedded-processors/kir=
kwood/assets/88F6192-003_ver1.pdf
+.. _HW_88F619x_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/kirkwood/assets/HW_88F619x_OpenSource.pdf
+.. _FS_88F6180_9x_6281_OpenSource.pdf: http://www.marvell.com/embedded-p=
rocessors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+.. _88F6180-003_ver1.pdf: http://www.marvell.com/embedded-processors/kir=
kwood/assets/88F6180-003_ver1.pdf
+.. _HW_88F6180_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/kirkwood/assets/HW_88F6180_OpenSource.pdf
+.. _FS_88F6180_9x_6281_OpenSource.pdf: http://www.marvell.com/embedded-p=
rocessors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+.. _88F6281-004_ver1.pdf: http://www.marvell.com/embedded-processors/kir=
kwood/assets/88F6281-004_ver1.pdf
+.. _HW_88F6281_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/kirkwood/assets/HW_88F6281_OpenSource.pdf
+.. _FS_88F6180_9x_6281_OpenSource.pdf: http://www.marvell.com/embedded-p=
rocessors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+
 Discovery family
 ----------------
=20
   Flavors:
         - MV78100
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/MV78100-003_WEB.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/HW_MV78100_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
+                - Product Brief  : `MV78100-003_WEB.pdf`_
+                - Hardware Spec  : `HW_MV78100_OpenSource.pdf`_
+                - Functional Spec: `FS_MV76100_78100_78200_OpenSource.pd=
f`_
         - MV78200
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/MV78200-002_WEB.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/HW_MV78200_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
+                - Product Brief  : `MV78200-002_WEB.pdf`_
+                - Hardware Spec  : `HW_MV78200_OpenSource.pdf`_
+                - Functional Spec: `FS_MV76100_78100_78200_OpenSource.pd=
f`_
         - MV76100
=20
                 Not supported by the Linux kernel.
@@ -98,6 +118,13 @@ Discovery family
   Linux kernel plat directory:
 	arch/arm/plat-orion
=20
+.. _MV78100-003_WEB.pdf: http://www.marvell.com/embedded-processors/disc=
overy-innovation/assets/MV78100-003_WEB.pdf
+.. _HW_MV78100_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/discovery-innovation/assets/HW_MV78100_OpenSource.pdf
+.. _FS_MV76100_78100_78200_OpenSource.pdf: http://www.marvell.com/embedd=
ed-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSour=
ce.pdf
+.. _MV78200-002_WEB.pdf: http://www.marvell.com/embedded-processors/disc=
overy-innovation/assets/MV78200-002_WEB.pdf
+.. _HW_MV78200_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/discovery-innovation/assets/HW_MV78200_OpenSource.pdf
+.. _FS_MV76100_78100_78200_OpenSource.pdf: http://www.marvell.com/embedd=
ed-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSour=
ce.pdf
+
 EBU Armada family
 -----------------
=20
@@ -106,9 +133,9 @@ EBU Armada family
         - 88F6707
         - 88F6W11
=20
-    - Product Brief:   http://www.marvell.com/embedded-processors/armada=
-300/assets/Marvell_ARMADA_370_SoC.pdf
-    - Hardware Spec:   http://www.marvell.com/embedded-processors/armada=
-300/assets/ARMADA370-datasheet.pdf
-    - Functional Spec: http://www.marvell.com/embedded-processors/armada=
-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
+    - Product Brief:   `Marvell_ARMADA_370_SoC.pdf`_
+    - Hardware Spec:   `ARMADA370-datasheet.pdf`_
+    - Functional Spec: `ARMADA370-FunctionalSpec-datasheet.pdf`_
=20
   Core:
 	Sheeva ARMv7 compatible PJ4B
@@ -116,7 +143,7 @@ EBU Armada family
   Armada 375 Flavors:
 	- 88F6720
=20
-    - Product Brief: http://www.marvell.com/embedded-processors/armada-3=
00/assets/ARMADA_375_SoC-01_product_brief.pdf
+    - Product Brief: `ARMADA_375_SoC-01_product_brief.pdf`_
=20
   Core:
 	ARM Cortex-A9
@@ -150,16 +177,16 @@ EBU Armada family
 	not to be confused with the non-SMP 78xx0 SoCs
=20
     Product Brief:
-	http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-Arm=
adaXP-SoC-product%20brief.pdf
+	`Marvell-ArmadaXP-SoC-product%20brief.pdf`_
=20
     Functional Spec:
-	http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-F=
unctional-SpecDatasheet.pdf
+	`ARMADA-XP-Functional-SpecDatasheet.pdf`_
=20
     - Hardware Specs:
=20
-        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW=
_MV78230_OS.PDF
-        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW=
_MV78260_OS.PDF
-        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW=
_MV78460_OS.PDF
+        - `HW_MV78230_OS.PDF`_
+        - `HW_MV78260_OS.PDF`_
+        - `HW_MV78460_OS.PDF`_
=20
   Core:
 	Sheeva ARMv7 compatible Dual-core or Quad-core PJ4B-MP
@@ -169,6 +196,16 @@ EBU Armada family
   Linux kernel plat directory:
 	none
=20
+.. _Marvell_ARMADA_370_SoC.pdf: http://www.marvell.com/embedded-processo=
rs/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
+.. _ARMADA370-datasheet.pdf: http://www.marvell.com/embedded-processors/=
armada-300/assets/ARMADA370-datasheet.pdf
+.. _ARMADA370-FunctionalSpec-datasheet.pdf: http://www.marvell.com/embed=
ded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
+.. _ARMADA_375_SoC-01_product_brief.pdf: http://www.marvell.com/embedded=
-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
+.. _Marvell-ArmadaXP-SoC-product%20brief.pdf: http://www.marvell.com/emb=
edded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pd=
f
+.. _ARMADA-XP-Functional-SpecDatasheet.pdf: http://www.marvell.com/embed=
ded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf
+.. _HW_MV78230_OS.PDF: http://www.marvell.com/embedded-processors/armada=
-xp/assets/HW_MV78230_OS.PDF
+.. _HW_MV78260_OS.PDF: http://www.marvell.com/embedded-processors/armada=
-xp/assets/HW_MV78260_OS.PDF
+.. _HW_MV78460_OS.PDF: http://www.marvell.com/embedded-processors/armada=
-xp/assets/HW_MV78460_OS.PDF
+
 EBU Armada family ARMv8
 -----------------------
=20
@@ -183,7 +220,7 @@ EBU Armada family ARMv8
 	http://www.marvell.com/embedded-processors/armada-3700/
=20
   Product Brief:
-	http://www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
+	`PB-88F3700-FNL.pdf`_
=20
   Device tree files:
 	arch/arm64/boot/dts/marvell/armada-37*
@@ -198,8 +235,8 @@ EBU Armada family ARMv8
 	http://www.marvell.com/embedded-processors/armada-70xx/
=20
   Product Brief:
-	  - http://www.marvell.com/embedded-processors/assets/Armada7020PB-Jan2=
016.pdf
-	  - http://www.marvell.com/embedded-processors/assets/Armada7040PB-Jan2=
016.pdf
+	  - `Armada7020PB-Jan2016.pdf`_
+	  - `Armada7040PB-Jan2016.pdf`_
=20
   Device tree files:
 	arch/arm64/boot/dts/marvell/armada-70*
@@ -214,12 +251,18 @@ EBU Armada family ARMv8
 	http://www.marvell.com/embedded-processors/armada-80xx/
=20
   Product Brief:
-	  - http://www.marvell.com/embedded-processors/assets/Armada8020PB-Jan2=
016.pdf
-	  - http://www.marvell.com/embedded-processors/assets/Armada8040PB-Jan2=
016.pdf
+	  - `Armada8020PB-Jan2016.pdf`_
+	  - `Armada8040PB-Jan2016.pdf`_
=20
   Device tree files:
 	arch/arm64/boot/dts/marvell/armada-80*
=20
+.. _PB-88F3700-FNL.pdf: http://www.marvell.com/embedded-processors/asset=
s/PB-88F3700-FNL.pdf
+.. _Armada7020PB-Jan2016.pdf: http://www.marvell.com/embedded-processors=
/assets/Armada7020PB-Jan2016.pdf
+.. _Armada7040PB-Jan2016.pdf: http://www.marvell.com/embedded-processors=
/assets/Armada7040PB-Jan2016.pdf
+.. _Armada8020PB-Jan2016.pdf: http://www.marvell.com/embedded-processors=
/assets/Armada8020PB-Jan2016.pdf
+.. _Armada8040PB-Jan2016.pdf: http://www.marvell.com/embedded-processors=
/assets/Armada8040PB-Jan2016.pdf
+
 Avanta family
 -------------
=20
@@ -233,7 +276,7 @@ Avanta family
 	http://www.marvell.com/broadband/
=20
   Product Brief:
-	http://www.marvell.com/broadband/assets/Marvell_Avanta_88F6510_305_060-=
001_product_brief.pdf
+	`Marvell_Avanta_88F6510_305_060-001_product_brief.pdf`_
=20
   No public datasheet available.
=20
@@ -245,6 +288,8 @@ Avanta family
   Linux kernel plat directory:
 	no code in mainline yet, planned for the future
=20
+.. _Marvell_Avanta_88F6510_305_060-001_product_brief.pdf: http://www.mar=
vell.com/broadband/assets/Marvell_Avanta_88F6510_305_060-001_product_brie=
f.pdf
+
 Storage family
 --------------
=20
@@ -266,13 +311,13 @@ Dove family (application processor)
         - 88AP510 a.k.a Armada 510
=20
    Product Brief:
-	http://www.marvell.com/application-processors/armada-500/assets/Marvell=
_Armada510_SoC.pdf
+	`Marvell_Armada510_SoC.pdf`_
=20
    Hardware Spec:
-	http://www.marvell.com/application-processors/armada-500/assets/Armada-=
510-Hardware-Spec.pdf
+	`Armada-510-Hardware-Spec.pdf`_
=20
   Functional Spec:
-	http://www.marvell.com/application-processors/armada-500/assets/Armada-=
510-Functional-Spec.pdf
+	`Armada-510-Functional-Spec.pdf`_
=20
   Homepage:
 	http://www.marvell.com/application-processors/armada-500/
@@ -284,6 +329,10 @@ Dove family (application processor)
 	- arch/arm/mach-mvebu (DT enabled platforms)
         - arch/arm/mach-dove (non-DT enabled platforms)
=20
+.. _Marvell_Armada510_SoC.pdf: http://www.marvell.com/application-proces=
sors/armada-500/assets/Marvell_Armada510_SoC.pdf
+.. _Armada-510-Hardware-Spec.pdf: http://www.marvell.com/application-pro=
cessors/armada-500/assets/Armada-510-Hardware-Spec.pdf
+.. _Armada-510-Functional-Spec.pdf: http://www.marvell.com/application-p=
rocessors/armada-500/assets/Armada-510-Functional-Spec.pdf
+
 PXA 2xx/3xx/93x/95x family
 --------------------------
=20
@@ -292,22 +341,22 @@ PXA 2xx/3xx/93x/95x family
              - Application processor only
              - Core: ARMv5 XScale1 core
         - PXA270, PXA271, PXA272
-             - Product Brief         : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/pxa_27x_pb.pdf
-             - Design guide          : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/pxa_27x_design_guide.pdf
-             - Developers manual     : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/pxa_27x_dev_man.pdf
-             - Specification         : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/pxa_27x_emts.pdf
-             - Specification update  : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/pxa_27x_spec_update.pdf
+             - Product Brief         : `pxa_27x_pb.pdf`_
+             - Design guide          : `pxa_27x_design_guide.pdf`_
+             - Developers manual     : `pxa_27x_dev_man.pdf`_
+             - Specification         : `pxa_27x_emts.pdf`_
+             - Specification update  : `pxa_27x_spec_update.pdf`_
              - Application processor only
              - Core: ARMv5 XScale2 core
         - PXA300, PXA310, PXA320
-             - PXA 300 Product Brief : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/PXA300_PB_R4.pdf
-             - PXA 310 Product Brief : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/PXA310_PB_R4.pdf
-             - PXA 320 Product Brief : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/PXA320_PB_R4.pdf
-             - Design guide          : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/PXA3xx_Design_Guide.pdf
-             - Developers manual     : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/PXA3xx_Developers_Manual.zip
-             - Specifications        : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/PXA3xx_EMTS.pdf
-             - Specification Update  : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/PXA3xx_Spec_Update.zip
-             - Reference Manual      : http://www.marvell.com/applicatio=
n-processors/pxa-family/assets/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
+             - PXA 300 Product Brief : `PXA300_PB_R4.pdf`_
+             - PXA 310 Product Brief : `PXA310_PB_R4.pdf`_
+             - PXA 320 Product Brief : `PXA320_PB_R4.pdf`_
+             - Design guide          : `PXA3xx_Design_Guide.pdf`_
+             - Developers manual     : `PXA3xx_Developers_Manual.zip`_
+             - Specifications        : `PXA3xx_EMTS.pdf`_
+             - Specification Update  : `PXA3xx_Spec_Update.zip`_
+             - Reference Manual      : `PXA3xx_TavorP_BootROM_Ref_Manual=
.pdf`_
              - Application processor only
              - Core: ARMv5 XScale3 core
         - PXA930, PXA935
@@ -333,31 +382,45 @@ PXA 2xx/3xx/93x/95x family
    Linux kernel plat directory:
 	arch/arm/plat-pxa
=20
+.. _pxa_27x_pb.pdf: http://www.marvell.com/application-processors/pxa-fa=
mily/assets/pxa_27x_pb.pdf
+.. _pxa_27x_design_guide.pdf: http://www.marvell.com/application-process=
ors/pxa-family/assets/pxa_27x_design_guide.pdf
+.. _pxa_27x_dev_man.pdf: http://www.marvell.com/application-processors/p=
xa-family/assets/pxa_27x_dev_man.pdf
+.. _pxa_27x_emts.pdf: http://www.marvell.com/application-processors/pxa-=
family/assets/pxa_27x_emts.pdf
+.. _pxa_27x_spec_update.pdf: http://www.marvell.com/application-processo=
rs/pxa-family/assets/pxa_27x_spec_update.pdf
+.. _PXA300_PB_R4.pdf: http://www.marvell.com/application-processors/pxa-=
family/assets/PXA300_PB_R4.pdf
+.. _PXA310_PB_R4.pdf: http://www.marvell.com/application-processors/pxa-=
family/assets/PXA310_PB_R4.pdf
+.. _PXA320_PB_R4.pdf: http://www.marvell.com/application-processors/pxa-=
family/assets/PXA320_PB_R4.pdf
+.. _PXA3xx_Design_Guide.pdf: http://www.marvell.com/application-processo=
rs/pxa-family/assets/PXA3xx_Design_Guide.pdf
+.. _PXA3xx_Developers_Manual.zip: http://www.marvell.com/application-pro=
cessors/pxa-family/assets/PXA3xx_Developers_Manual.zip
+.. _PXA3xx_EMTS.pdf: http://www.marvell.com/application-processors/pxa-f=
amily/assets/PXA3xx_EMTS.pdf
+.. _PXA3xx_Spec_Update.zip: http://www.marvell.com/application-processor=
s/pxa-family/assets/PXA3xx_Spec_Update.zip
+.. _PXA3xx_TavorP_BootROM_Ref_Manual.pdf: http://www.marvell.com/applica=
tion-processors/pxa-family/assets/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
+
 MMP/MMP2/MMP3 family (communication processor)
 ----------------------------------------------
=20
    Flavors:
         - PXA168, a.k.a Armada 168
-             - Homepage             : http://www.marvell.com/application=
-processors/armada-100/armada-168.jsp
-             - Product brief        : http://www.marvell.com/application=
-processors/armada-100/assets/pxa_168_pb.pdf
-             - Hardware manual      : http://www.marvell.com/application=
-processors/armada-100/assets/armada_16x_datasheet.pdf
-             - Software manual      : http://www.marvell.com/application=
-processors/armada-100/assets/armada_16x_software_manual.pdf
-             - Specification update : http://www.marvell.com/application=
-processors/armada-100/assets/ARMADA16x_Spec_update.pdf
-             - Boot ROM manual      : http://www.marvell.com/application=
-processors/armada-100/assets/armada_16x_ref_manual.pdf
-             - App node package     : http://www.marvell.com/application=
-processors/armada-100/assets/armada_16x_app_note_package.pdf
+             - Homepage             : `armada-168.jsp`_
+             - Product brief        : `pxa_168_pb.pdf`_
+             - Hardware manual      : `armada_16x_datasheet.pdf`_
+             - Software manual      : `armada_16x_software_manual.pdf`_
+             - Specification update : `ARMADA16x_Spec_update.pdf`_
+             - Boot ROM manual      : `armada_16x_ref_manual.pdf`_
+             - App node package     : `armada_16x_app_note_package.pdf`_
              - Application processor only
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
         - PXA910/PXA920
              - Homepage             : http://www.marvell.com/communicati=
on-processors/pxa910/
-             - Product Brief        : http://www.marvell.com/communicati=
on-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.pdf
+             - Product Brief        : `Marvell_PXA910_Platform-001_PB_fi=
nal.pdf`_
              - Application processor with Communication processor
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
         - PXA688, a.k.a. MMP2, a.k.a Armada 610
-             - Product Brief        : http://www.marvell.com/application=
-processors/armada-600/assets/armada610_pb.pdf
+             - Product Brief        : `armada610_pb.pdf`_
              - Application processor only
              - Core: ARMv7 compatible Sheeva PJ4 88sv581x core
 	- PXA2128, a.k.a. MMP3 (OLPC XO4, Linux support not upstream)
-	     - Product Brief	  : http://www.marvell.com/application-processors/=
armada/pxa2128/assets/Marvell-ARMADA-PXA2128-SoC-PB.pdf
+	     - Product Brief	  : `Marvell-ARMADA-PXA2128-SoC-PB.pdf`_
 	     - Application processor only
 	     - Core: Dual-core ARMv7 compatible Sheeva PJ4C core
 	- PXA960/PXA968/PXA978 (Linux support not upstream)
@@ -388,13 +451,24 @@ MMP/MMP2/MMP3 family (communication processor)
    Linux kernel plat directory:
 	arch/arm/plat-pxa
=20
+.. _armada-168.jsp: http://www.marvell.com/application-processors/armada=
-100/armada-168.jsp
+.. _pxa_168_pb.pdf: http://www.marvell.com/application-processors/armada=
-100/assets/pxa_168_pb.pdf
+.. _armada_16x_datasheet.pdf: http://www.marvell.com/application-process=
ors/armada-100/assets/armada_16x_datasheet.pdf
+.. _armada_16x_software_manual.pdf: http://www.marvell.com/application-p=
rocessors/armada-100/assets/armada_16x_software_manual.pdf
+.. _ARMADA16x_Spec_update.pdf: http://www.marvell.com/application-proces=
sors/armada-100/assets/ARMADA16x_Spec_update.pdf
+.. _armada_16x_ref_manual.pdf: http://www.marvell.com/application-proces=
sors/armada-100/assets/armada_16x_ref_manual.pdf
+.. _armada_16x_app_note_package.pdf: http://www.marvell.com/application-=
processors/armada-100/assets/armada_16x_app_note_package.pdf
+.. _Marvell_PXA910_Platform-001_PB_final.pdf: http://www.marvell.com/com=
munication-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.=
pdf
+.. _armada610_pb.pdf: http://www.marvell.com/application-processors/arma=
da-600/assets/armada610_pb.pdf
+.. _Marvell-ARMADA-PXA2128-SoC-PB.pdf: http://www.marvell.com/applicatio=
n-processors/armada/pxa2128/assets/Marvell-ARMADA-PXA2128-SoC-PB.pdf
+
 Berlin family (Multimedia Solutions)
 -------------------------------------
=20
   - Flavors:
 	- 88DE3010, Armada 1000 (no Linux support)
 		- Core:		Marvell PJ1 (ARMv5TE), Dual-core
-		- Product Brief:	http://www.marvell.com.cn/digital-entertainment/asset=
s/armada_1000_pb.pdf
+		- Product Brief:	`armada_1000_pb.pdf`_
 	- 88DE3005, Armada 1500 Mini
 		- Design name:	BG2CD
 		- Core:		ARM Cortex-A9, PL310 L2CC
@@ -414,6 +488,7 @@ Berlin family (Multimedia Solutions)
 		- Core:		ARM Cortex-A53
=20
   Homepage: https://www.synaptics.com/products/multimedia-solutions
+
   Directory: arch/arm/mach-berlin
=20
   Comments:
@@ -423,6 +498,8 @@ Berlin family (Multimedia Solutions)
=20
    * The Berlin family was acquired by Synaptics from Marvell in 2017.
=20
+.. _armada_1000_pb.pdf: http://www.marvell.com.cn/digital-entertainment/=
assets/armada_1000_pb.pdf
+
 CPU Cores
 ---------
=20
--=20
2.29.2

