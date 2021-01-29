Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACCF308CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhA2Skp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:40:45 -0500
Received: from mail.v3.sk ([167.172.186.51]:56702 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232628AbhA2Skh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:40:37 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4384CE0B4A;
        Fri, 29 Jan 2021 18:35:50 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id K45bM_bl_Hih; Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DD03FE0B44;
        Fri, 29 Jan 2021 18:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j6DHGKtftkME; Fri, 29 Jan 2021 18:35:46 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5A776E0B3F;
        Fri, 29 Jan 2021 18:35:46 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/5] docs: arm: marvell: drop some dead links
Date:   Fri, 29 Jan 2021 19:39:47 +0100
Message-Id: <20210129183950.75405-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210129183950.75405-1-lkundrak@v3.sk>
References: <20210129183950.75405-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just remove these; there's good chance there wasn't anything useful
there anyway.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/arm/marvel.rst | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvel.rst
index 716551f9b60a1..8577f8324f6c7 100644
--- a/Documentation/arm/marvel.rst
+++ b/Documentation/arm/marvel.rst
@@ -68,8 +68,6 @@ Kirkwood family
                 - Product Brief  : `88F6281-004_ver1.pdf`_
                 - Hardware Spec  : `HW_88F6281_OpenSource.pdf`_
                 - Functional Spec: `FS_88F6180_9x_6281_OpenSource.pdf`_
-  Homepage:
-	http://www.marvell.com/embedded-processors/kirkwood/
   Core:
 	Feroceon 88fr131 ARMv5 compatible
   Linux kernel mach directory:
@@ -153,8 +151,7 @@ EBU Armada family
 	- 88F6820 Armada 385
 	- 88F6828 Armada 388
=20
-    - Product infos:   http://www.marvell.com/embedded-processors/armada=
-38x/
-    - Functional Spec: https://marvellcorp.wufoo.com/forms/marvell-armad=
a-38x-functional-specifications/
+    - Functional Spec: `marvell-embedded-processors-armada-38x-functiona=
l-specifications-2015-11.pdf`_
=20
   Core:
 	ARM Cortex-A9
@@ -163,8 +160,6 @@ EBU Armada family
 	- 88F6920 Armada 390
 	- 88F6928 Armada 398
=20
-    - Product infos: http://www.marvell.com/embedded-processors/armada-3=
9x/
-
   Core:
 	ARM Cortex-A9
=20
@@ -200,6 +195,7 @@ EBU Armada family
 .. _ARMADA370-datasheet.pdf: http://www.marvell.com/embedded-processors/=
armada-300/assets/ARMADA370-datasheet.pdf
 .. _ARMADA370-FunctionalSpec-datasheet.pdf: http://www.marvell.com/embed=
ded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
 .. _ARMADA_375_SoC-01_product_brief.pdf: http://www.marvell.com/embedded=
-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
+.. _marvell-embedded-processors-armada-38x-functional-specifications-201=
5-11.pdf: https://www.marvell.com/content/dam/marvell/en/public-collatera=
l/embedded-processors/marvell-embedded-processors-armada-38x-functional-s=
pecifications-2015-11.pdf
 .. _Marvell-ArmadaXP-SoC-product%20brief.pdf: http://www.marvell.com/emb=
edded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pd=
f
 .. _ARMADA-XP-Functional-SpecDatasheet.pdf: http://www.marvell.com/embed=
ded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf
 .. _HW_MV78230_OS.PDF: http://www.marvell.com/embedded-processors/armada=
-xp/assets/HW_MV78230_OS.PDF
@@ -216,9 +212,6 @@ EBU Armada family ARMv8
   Core:
 	ARM Cortex A53 (ARMv8)
=20
-  Homepage:
-	http://www.marvell.com/embedded-processors/armada-3700/
-
   Product Brief:
 	`PB-88F3700-FNL.pdf`_
=20
@@ -231,9 +224,6 @@ EBU Armada family ARMv8
=20
   Core: ARM Cortex A72
=20
-  Homepage:
-	http://www.marvell.com/embedded-processors/armada-70xx/
-
   Product Brief:
 	  - `Armada7020PB-Jan2016.pdf`_
 	  - `Armada7040PB-Jan2016.pdf`_
@@ -247,9 +237,6 @@ EBU Armada family ARMv8
   Core:
 	ARM Cortex A72
=20
-  Homepage:
-	http://www.marvell.com/embedded-processors/armada-80xx/
-
   Product Brief:
 	  - `Armada8020PB-Jan2016.pdf`_
 	  - `Armada8040PB-Jan2016.pdf`_
@@ -272,9 +259,6 @@ Avanta family
        - 88F6550
        - 88F6560
=20
-  Homepage:
-	http://www.marvell.com/broadband/
-
   Product Brief:
 	`Marvell_Avanta_88F6510_305_060-001_product_brief.pdf`_
=20
@@ -296,9 +280,6 @@ Storage family
   Armada SP:
 	- 88RC1580
=20
-  Product infos:
-	http://www.marvell.com/storage/armada-sp/
-
   Core:
 	Sheeva ARMv7 comatible Quad-core PJ4C
=20
@@ -319,9 +300,6 @@ Dove family (application processor)
   Functional Spec:
 	`Armada-510-Functional-Spec.pdf`_
=20
-  Homepage:
-	http://www.marvell.com/application-processors/armada-500/
-
   Core:
 	ARMv7 compatible
=20
@@ -411,7 +389,6 @@ MMP/MMP2/MMP3 family (communication processor)
              - Application processor only
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
         - PXA910/PXA920
-             - Homepage             : http://www.marvell.com/communicati=
on-processors/pxa910/
              - Product Brief        : `Marvell_PXA910_Platform-001_PB_fi=
nal.pdf`_
              - Application processor with Communication processor
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
--=20
2.29.2

