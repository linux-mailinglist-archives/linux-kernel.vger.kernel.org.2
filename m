Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3C30E7F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhBCXyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:54:54 -0500
Received: from mail.v3.sk ([167.172.186.51]:51562 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233429AbhBCXys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:54:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 492C0E07B5;
        Wed,  3 Feb 2021 23:49:12 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XWmy_te0AVSW; Wed,  3 Feb 2021 23:49:03 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BFE73E070D;
        Wed,  3 Feb 2021 23:49:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X9qLw4JJh2CU; Wed,  3 Feb 2021 23:49:03 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 1087DE09D2;
        Wed,  3 Feb 2021 23:49:03 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 3/5] docs: arm: marvell: replace stale links with archive links
Date:   Thu,  4 Feb 2021 00:53:03 +0100
Message-Id: <20210203235305.506528-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203235305.506528-1-lkundrak@v3.sk>
References: <20210203235305.506528-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell has an annoying habit of moving stuff around their web site
every full moon, and often just removing documents altogether.

At this point basically none but four of the links still works and even
those that work today weren't working for a long period of time
previously. That is a shame because (short of the product briefs) the
documents tend to be quite useful.

Let's replace them with known working versions of IA's Wayback Machine
links. That seems to be about the only way of getting a URL that's going
to work the next week.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Adjust for removal of "[PATCH 1/5] docs: arm: marvell: turn the automat=
ic
  links into labels"
- Replace http URLs with https
- Fix some more links

 Documentation/arm/marvel.rst | 130 ++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 64 deletions(-)

diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvel.rst
index ab0c38dc108a8..bcf3f4e3e8faf 100644
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
+               - Datasheet: https://web.archive.org/web/20210124231420/h=
ttp://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-datasheet.pdf
+               - Programmer's User Guide: https://web.archive.org/web/20=
210124231536/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-opensourc=
e-manual.pdf
+               - User Manual: https://web.archive.org/web/20210124231631=
/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-usermanual.pdf
         - 88F5281
=20
-               - Datasheet: http://www.ocmodshop.com/images/reviews/netw=
orking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
+               - Datasheet: https://web.archive.org/web/20131028144728/h=
ttp://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5=
281_data_sheet.pdf
         - 88F6183
   Core:
 	Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
@@ -38,31 +38,31 @@ Kirkwood family
   Flavors:
         - 88F6282 a.k.a Armada 300
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/armada-300/assets/armada_310.pdf
+                - Product Brief  : https://web.archive.org/web/201110270=
32509/http://www.marvell.com/embedded-processors/armada-300/assets/armada=
_310.pdf
         - 88F6283 a.k.a Armada 310
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/armada-300/assets/armada_310.pdf
+                - Product Brief  : https://web.archive.org/web/201110270=
32509/http://www.marvell.com/embedded-processors/armada-300/assets/armada=
_310.pdf
         - 88F6190
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/88F6190-003_WEB.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/HW_88F619x_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : https://web.archive.org/web/201307300=
72715/http://www.marvell.com/embedded-processors/kirkwood/assets/88F6190-=
003_WEB.pdf
+                - Hardware Spec  : https://web.archive.org/web/201210211=
82835/http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F61=
9x_OpenSource.pdf
+                - Functional Spec: https://web.archive.org/web/201307300=
91033/http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F61=
80_9x_6281_OpenSource.pdf
         - 88F6192
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/88F6192-003_ver1.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/HW_88F619x_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : https://web.archive.org/web/201311131=
21446/http://www.marvell.com/embedded-processors/kirkwood/assets/88F6192-=
003_ver1.pdf
+                - Hardware Spec  : https://web.archive.org/web/201210211=
82835/http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F61=
9x_OpenSource.pdf
+                - Functional Spec: https://web.archive.org/web/201307300=
91033/http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F61=
80_9x_6281_OpenSource.pdf
         - 88F6182
         - 88F6180
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/88F6180-003_ver1.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/HW_88F6180_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : https://web.archive.org/web/201206162=
01621/http://www.marvell.com/embedded-processors/kirkwood/assets/88F6180-=
003_ver1.pdf
+                - Hardware Spec  : https://web.archive.org/web/201307300=
91654/http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F61=
80_OpenSource.pdf
+                - Functional Spec: https://web.archive.org/web/201307300=
91033/http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F61=
80_9x_6281_OpenSource.pdf
         - 88F6281
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/88F6281-004_ver1.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/HW_88F6281_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : https://web.archive.org/web/201201311=
33709/http://www.marvell.com/embedded-processors/kirkwood/assets/88F6281-=
004_ver1.pdf
+                - Hardware Spec  : https://web.archive.org/web/201206200=
73511/http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F62=
81_OpenSource.pdf
+                - Functional Spec: https://web.archive.org/web/201307300=
91033/http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F61=
80_9x_6281_OpenSource.pdf
   Core:
 	Feroceon 88fr131 ARMv5 compatible
   Linux kernel mach directory:
@@ -76,14 +76,15 @@ Discovery family
   Flavors:
         - MV78100
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/MV78100-003_WEB.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/HW_MV78100_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
+                - Product Brief  : https://web.archive.org/web/201206161=
94711/http://www.marvell.com/embedded-processors/discovery-innovation/ass=
ets/MV78100-003_WEB.pdf
+                - Hardware Spec  : https://web.archive.org/web/201410051=
20451/http://www.marvell.com/embedded-processors/discovery-innovation/ass=
ets/HW_MV78100_OpenSource.pdf
+                - Functional Spec: https://web.archive.org/web/201111100=
81125/http://www.marvell.com/embedded-processors/discovery-innovation/ass=
ets/FS_MV76100_78100_78200_OpenSource.pdf
         - MV78200
=20
-                - Product Brief  : http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/MV78200-002_WEB.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/HW_MV78200_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-proce=
ssors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
+                - Product Brief  : https://web.archive.org/web/201408011=
21623/http://www.marvell.com/embedded-processors/discovery-innovation/ass=
ets/MV78200-002_WEB.pdf
+                - Hardware Spec  : https://web.archive.org/web/201410051=
20458/http://www.marvell.com/embedded-processors/discovery-innovation/ass=
ets/HW_MV78200_OpenSource.pdf
+                - Functional Spec: https://web.archive.org/web/201111100=
81125/http://www.marvell.com/embedded-processors/discovery-innovation/ass=
ets/FS_MV76100_78100_78200_OpenSource.pdf
+
         - MV76100
=20
                 Not supported by the Linux kernel.
@@ -104,9 +105,9 @@ EBU Armada family
         - 88F6707
         - 88F6W11
=20
-    - Product Brief:   http://www.marvell.com/embedded-processors/armada=
-300/assets/Marvell_ARMADA_370_SoC.pdf
-    - Hardware Spec:   http://www.marvell.com/embedded-processors/armada=
-300/assets/ARMADA370-datasheet.pdf
-    - Functional Spec: http://www.marvell.com/embedded-processors/armada=
-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
+    - Product Brief:   https://web.archive.org/web/20121115063038/http:/=
/www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370=
_SoC.pdf
+    - Hardware Spec:   https://web.archive.org/web/20140617183747/http:/=
/www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-datashee=
t.pdf
+    - Functional Spec: https://web.archive.org/web/20140617183701/http:/=
/www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-Function=
alSpec-datasheet.pdf
=20
   Core:
 	Sheeva ARMv7 compatible PJ4B
@@ -114,7 +115,7 @@ EBU Armada family
   Armada 375 Flavors:
 	- 88F6720
=20
-    - Product Brief: http://www.marvell.com/embedded-processors/armada-3=
00/assets/ARMADA_375_SoC-01_product_brief.pdf
+    - Product Brief: https://web.archive.org/web/20131216023516/http://w=
ww.marvell.com/embedded-processors/armada-300/assets/ARMADA_375_SoC-01_pr=
oduct_brief.pdf
=20
   Core:
 	ARM Cortex-A9
@@ -124,7 +125,7 @@ EBU Armada family
 	- 88F6820 Armada 385
 	- 88F6828 Armada 388
=20
-    - Functional Spec: https://www.marvell.com/content/dam/marvell/en/pu=
blic-collateral/embedded-processors/marvell-embedded-processors-armada-38=
x-functional-specifications-2015-11.pdf
+    - Functional Spec: https://web.archive.org/web/20200420191927/https:=
//www.marvell.com/content/dam/marvell/en/public-collateral/embedded-proce=
ssors/marvell-embedded-processors-armada-38x-functional-specifications-20=
15-11.pdf
=20
   Core:
 	ARM Cortex-A9
@@ -145,16 +146,16 @@ EBU Armada family
 	not to be confused with the non-SMP 78xx0 SoCs
=20
     Product Brief:
-	http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-Arm=
adaXP-SoC-product%20brief.pdf
+	https://web.archive.org/web/20121021173528/http://www.marvell.com/embed=
ded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
=20
     Functional Spec:
 	http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-F=
unctional-SpecDatasheet.pdf
=20
     - Hardware Specs:
=20
-        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW=
_MV78230_OS.PDF
-        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW=
_MV78260_OS.PDF
-        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW=
_MV78460_OS.PDF
+        - https://web.archive.org/web/20141127013651/http://www.marvell.=
com/embedded-processors/armada-xp/assets/HW_MV78230_OS.PDF
+        - https://web.archive.org/web/20141222000224/http://www.marvell.=
com/embedded-processors/armada-xp/assets/HW_MV78260_OS.PDF
+        - https://web.archive.org/web/20141222000230/http://www.marvell.=
com/embedded-processors/armada-xp/assets/HW_MV78460_OS.PDF
=20
   Core:
 	Sheeva ARMv7 compatible Dual-core or Quad-core PJ4B-MP
@@ -175,7 +176,7 @@ EBU Armada family ARMv8
 	ARM Cortex A53 (ARMv8)
=20
   Product Brief:
-	http://www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
+	https://web.archive.org/web/20160309224849/http://www.marvell.com/embed=
ded-processors/assets/PB-88F3700-FNL.pdf
=20
   Device tree files:
 	arch/arm64/boot/dts/marvell/armada-37*
@@ -187,8 +188,8 @@ EBU Armada family ARMv8
   Core: ARM Cortex A72
=20
   Product Brief:
-	  - http://www.marvell.com/embedded-processors/assets/Armada7020PB-Jan2=
016.pdf
-	  - http://www.marvell.com/embedded-processors/assets/Armada7040PB-Jan2=
016.pdf
+	  - https://web.archive.org/web/20161010105541/http://www.marvell.com/e=
mbedded-processors/assets/Armada7020PB-Jan2016.pdf
+	  - https://web.archive.org/web/20160928154533/http://www.marvell.com/e=
mbedded-processors/assets/Armada7040PB-Jan2016.pdf
=20
   Device tree files:
 	arch/arm64/boot/dts/marvell/armada-70*
@@ -200,8 +201,8 @@ EBU Armada family ARMv8
 	ARM Cortex A72
=20
   Product Brief:
-	  - http://www.marvell.com/embedded-processors/assets/Armada8020PB-Jan2=
016.pdf
-	  - http://www.marvell.com/embedded-processors/assets/Armada8040PB-Jan2=
016.pdf
+	  - https://web.archive.org/web/20210124233728/https://www.marvell.com/=
content/dam/marvell/en/public-collateral/embedded-processors/marvell-embe=
dded-processors-armada-8020-product-brief-2017-12.pdf
+	  - https://web.archive.org/web/20161010105532/http://www.marvell.com/e=
mbedded-processors/assets/Armada8040PB-Jan2016.pdf
=20
   Device tree files:
 	arch/arm64/boot/dts/marvell/armada-80*
@@ -216,7 +217,7 @@ Avanta family
        - 88F6560
=20
   Product Brief:
-	http://www.marvell.com/broadband/assets/Marvell_Avanta_88F6510_305_060-=
001_product_brief.pdf
+	https://web.archive.org/web/20180829171057/http://www.marvell.com/broad=
band/assets/Marvell_Avanta_88F6510_305_060-001_product_brief.pdf
=20
   No public datasheet available.
=20
@@ -246,13 +247,13 @@ Dove family (application processor)
         - 88AP510 a.k.a Armada 510
=20
    Product Brief:
-	http://www.marvell.com/application-processors/armada-500/assets/Marvell=
_Armada510_SoC.pdf
+	https://web.archive.org/web/20111102020643/http://www.marvell.com/appli=
cation-processors/armada-500/assets/Marvell_Armada510_SoC.pdf
=20
    Hardware Spec:
 	http://www.marvell.com/application-processors/armada-500/assets/Armada-=
510-Hardware-Spec.pdf
=20
   Functional Spec:
-	http://www.marvell.com/application-processors/armada-500/assets/Armada-=
510-Functional-Spec.pdf
+	https://web.archive.org/web/20120130172443/http://www.marvell.com/appli=
cation-processors/armada-500/assets/Armada-510-Functional-Spec.pdf
=20
   Core:
 	ARMv7 compatible
@@ -269,22 +270,22 @@ PXA 2xx/3xx/93x/95x family
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
+             - Product Brief         : https://web.archive.org/web/20150=
927135510/http://www.marvell.com/application-processors/pxa-family/assets=
/pxa_27x_pb.pdf
+             - Design guide          : https://web.archive.org/web/20120=
111181937/http://www.marvell.com/application-processors/pxa-family/assets=
/pxa_27x_design_guide.pdf
+             - Developers manual     : https://web.archive.org/web/20150=
927164805/http://www.marvell.com/application-processors/pxa-family/assets=
/pxa_27x_dev_man.pdf
+             - Specification         : https://web.archive.org/web/20140=
211221535/http://www.marvell.com/application-processors/pxa-family/assets=
/pxa_27x_emts.pdf
+             - Specification update  : https://web.archive.org/web/20120=
111104906/http://www.marvell.com/application-processors/pxa-family/assets=
/pxa_27x_spec_update.pdf
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
+             - PXA 300 Product Brief : https://web.archive.org/web/20120=
111121203/http://www.marvell.com/application-processors/pxa-family/assets=
/PXA300_PB_R4.pdf
+             - PXA 310 Product Brief : https://web.archive.org/web/20120=
111104515/http://www.marvell.com/application-processors/pxa-family/assets=
/PXA310_PB_R4.pdf
+             - PXA 320 Product Brief : https://web.archive.org/web/20121=
021182826/http://www.marvell.com/application-processors/pxa-family/assets=
/PXA320_PB_R4.pdf
+             - Design guide          : https://web.archive.org/web/20130=
727144625/http://www.marvell.com/application-processors/pxa-family/assets=
/PXA3xx_Design_Guide.pdf
+             - Developers manual     : https://web.archive.org/web/20130=
727144605/http://www.marvell.com/application-processors/pxa-family/assets=
/PXA3xx_Developers_Manual.zip
+             - Specifications        : https://web.archive.org/web/20130=
727144559/http://www.marvell.com/application-processors/pxa-family/assets=
/PXA3xx_EMTS.pdf
+             - Specification Update  : https://web.archive.org/web/20150=
927183411/http://www.marvell.com/application-processors/pxa-family/assets=
/PXA3xx_Spec_Update.zip
+             - Reference Manual      : https://web.archive.org/web/20120=
111103844/http://www.marvell.com/application-processors/pxa-family/assets=
/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
              - Application processor only
              - Core: ARMv5 XScale3 core
         - PXA930, PXA935
@@ -315,25 +316,26 @@ MMP/MMP2/MMP3 family (communication processor)
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
+             - Homepage             : https://web.archive.org/web/201109=
26014256/http://www.marvell.com/application-processors/armada-100/armada-=
168.jsp
+             - Product brief        : https://web.archive.org/web/201111=
02030100/http://www.marvell.com/application-processors/armada-100/assets/=
pxa_168_pb.pdf
+             - Hardware manual      : https://web.archive.org/web/201604=
28165359/http://www.marvell.com/application-processors/armada-100/assets/=
armada_16x_datasheet.pdf
+             - Software manual      : https://web.archive.org/web/201604=
28154454/http://www.marvell.com/application-processors/armada-100/assets/=
armada_16x_software_manual.pdf
+             - Specification update : https://web.archive.org/web/201509=
27160338/http://www.marvell.com/application-processors/armada-100/assets/=
ARMADA16x_Spec_update.pdf
+             - Boot ROM manual      : https://web.archive.org/web/201307=
27205559/http://www.marvell.com/application-processors/armada-100/assets/=
armada_16x_ref_manual.pdf
+             - App node package     : https://web.archive.org/web/201410=
05090706/http://www.marvell.com/application-processors/armada-100/assets/=
armada_16x_app_note_package.pdf
              - Application processor only
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
         - PXA910/PXA920
-             - Product Brief        : http://www.marvell.com/communicati=
on-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.pdf
+             - Product Brief        : https://archive.org/download/marve=
ll-pxa910-pb/Marvell_PXA910_Platform-001_PB.pdf
              - Application processor with Communication processor
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
         - PXA688, a.k.a. MMP2, a.k.a Armada 610
-             - Product Brief        : http://www.marvell.com/application=
-processors/armada-600/assets/armada610_pb.pdf
+             - Product Brief        : https://web.archive.org/web/201111=
02023255/http://www.marvell.com/application-processors/armada-600/assets/=
armada610_pb.pdf
              - Application processor only
              - Core: ARMv7 compatible Sheeva PJ4 88sv581x core
 	- PXA2128, a.k.a. MMP3 (OLPC XO4, Linux support not upstream)
-	     - Product Brief	  : http://www.marvell.com/application-processors/=
armada/pxa2128/assets/Marvell-ARMADA-PXA2128-SoC-PB.pdf
+	     - Product Brief	    : https://web.archive.org/web/20120824055155/h=
ttp://www.marvell.com/application-processors/armada/pxa2128/assets/Marvel=
l-ARMADA-PXA2128-SoC-PB.pdf
+
 	     - Application processor only
 	     - Core: Dual-core ARMv7 compatible Sheeva PJ4C core
 	- PXA960/PXA968/PXA978 (Linux support not upstream)
--=20
2.29.2

