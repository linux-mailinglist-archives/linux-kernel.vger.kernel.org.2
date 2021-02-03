Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0777630E7F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhBCXyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:54:13 -0500
Received: from mail.v3.sk ([167.172.186.51]:51512 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232458AbhBCXyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:54:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2F4F2E0B3B;
        Wed,  3 Feb 2021 23:49:04 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RaFOSZfLB4BZ; Wed,  3 Feb 2021 23:49:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8F5E7DF89D;
        Wed,  3 Feb 2021 23:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r09q_9CoCYGp; Wed,  3 Feb 2021 23:49:02 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 341F9DF61E;
        Wed,  3 Feb 2021 23:49:02 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 1/5] docs: arm: marvell: drop some dead links
Date:   Thu,  4 Feb 2021 00:53:01 +0100
Message-Id: <20210203235305.506528-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203235305.506528-1-lkundrak@v3.sk>
References: <20210203235305.506528-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just remove these; there's good chance there wasn't anything useful
there anyway.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Adjust for removal of "[PATCH 1/5] docs: arm: marvell: turn the automat=
ic
  links into labels"
- Split off the hunk that fixes 38x functional spec link

 Documentation/arm/marvel.rst | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvel.rst
index 16ab2eb085b86..502a1b89a2c85 100644
--- a/Documentation/arm/marvel.rst
+++ b/Documentation/arm/marvel.rst
@@ -63,8 +63,6 @@ Kirkwood family
                 - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/88F6281-004_ver1.pdf
                 - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/HW_88F6281_OpenSource.pdf
                 - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
-  Homepage:
-	http://www.marvell.com/embedded-processors/kirkwood/
   Core:
 	Feroceon 88fr131 ARMv5 compatible
   Linux kernel mach directory:
@@ -126,7 +124,6 @@ EBU Armada family
 	- 88F6820 Armada 385
 	- 88F6828 Armada 388
=20
-    - Product infos:   http://www.marvell.com/embedded-processors/armada=
-38x/
     - Functional Spec: https://marvellcorp.wufoo.com/forms/marvell-armad=
a-38x-functional-specifications/
=20
   Core:
@@ -136,8 +133,6 @@ EBU Armada family
 	- 88F6920 Armada 390
 	- 88F6928 Armada 398
=20
-    - Product infos: http://www.marvell.com/embedded-processors/armada-3=
9x/
-
   Core:
 	ARM Cortex-A9
=20
@@ -179,9 +174,6 @@ EBU Armada family ARMv8
   Core:
 	ARM Cortex A53 (ARMv8)
=20
-  Homepage:
-	http://www.marvell.com/embedded-processors/armada-3700/
-
   Product Brief:
 	http://www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
=20
@@ -194,9 +186,6 @@ EBU Armada family ARMv8
=20
   Core: ARM Cortex A72
=20
-  Homepage:
-	http://www.marvell.com/embedded-processors/armada-70xx/
-
   Product Brief:
 	  - http://www.marvell.com/embedded-processors/assets/Armada7020PB-Jan2=
016.pdf
 	  - http://www.marvell.com/embedded-processors/assets/Armada7040PB-Jan2=
016.pdf
@@ -210,9 +199,6 @@ EBU Armada family ARMv8
   Core:
 	ARM Cortex A72
=20
-  Homepage:
-	http://www.marvell.com/embedded-processors/armada-80xx/
-
   Product Brief:
 	  - http://www.marvell.com/embedded-processors/assets/Armada8020PB-Jan2=
016.pdf
 	  - http://www.marvell.com/embedded-processors/assets/Armada8040PB-Jan2=
016.pdf
@@ -229,9 +215,6 @@ Avanta family
        - 88F6550
        - 88F6560
=20
-  Homepage:
-	http://www.marvell.com/broadband/
-
   Product Brief:
 	http://www.marvell.com/broadband/assets/Marvell_Avanta_88F6510_305_060-=
001_product_brief.pdf
=20
@@ -251,9 +234,6 @@ Storage family
   Armada SP:
 	- 88RC1580
=20
-  Product infos:
-	http://www.marvell.com/storage/armada-sp/
-
   Core:
 	Sheeva ARMv7 comatible Quad-core PJ4C
=20
@@ -274,9 +254,6 @@ Dove family (application processor)
   Functional Spec:
 	http://www.marvell.com/application-processors/armada-500/assets/Armada-=
510-Functional-Spec.pdf
=20
-  Homepage:
-	http://www.marvell.com/application-processors/armada-500/
-
   Core:
 	ARMv7 compatible
=20
@@ -348,7 +325,6 @@ MMP/MMP2/MMP3 family (communication processor)
              - Application processor only
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
         - PXA910/PXA920
-             - Homepage             : http://www.marvell.com/communicati=
on-processors/pxa910/
              - Product Brief        : http://www.marvell.com/communicati=
on-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.pdf
              - Application processor with Communication processor
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
@@ -394,7 +370,6 @@ Berlin family (Multimedia Solutions)
   - Flavors:
 	- 88DE3010, Armada 1000 (no Linux support)
 		- Core:		Marvell PJ1 (ARMv5TE), Dual-core
-		- Product Brief:	http://www.marvell.com.cn/digital-entertainment/asset=
s/armada_1000_pb.pdf
 	- 88DE3005, Armada 1500 Mini
 		- Design name:	BG2CD
 		- Core:		ARM Cortex-A9, PL310 L2CC
--=20
2.29.2

