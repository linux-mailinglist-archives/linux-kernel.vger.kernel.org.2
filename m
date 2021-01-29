Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EDF308CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhA2Sl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:41:28 -0500
Received: from mail.v3.sk ([167.172.186.51]:56748 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232628AbhA2Skw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:40:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 88492E0B45;
        Fri, 29 Jan 2021 18:36:00 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BppXVmRuI74a; Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 79EAFE0B3E;
        Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YMCmuQUoU7En; Fri, 29 Jan 2021 18:35:47 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D2279E0B3D;
        Fri, 29 Jan 2021 18:35:46 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/5] docs: arm: marvell: replace stale links with archive links
Date:   Fri, 29 Jan 2021 19:39:48 +0100
Message-Id: <20210129183950.75405-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210129183950.75405-1-lkundrak@v3.sk>
References: <20210129183950.75405-1-lkundrak@v3.sk>
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
 Documentation/arm/marvel.rst | 76 ++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvel.rst
index 8577f8324f6c7..0c291d1091f1d 100644
--- a/Documentation/arm/marvel.rst
+++ b/Documentation/arm/marvel.rst
@@ -32,10 +32,10 @@ Orion family
   Linux kernel plat directory:
 	arch/arm/plat-orion
=20
-.. _MV88F5182-datasheet.pdf: http://www.embeddedarm.com/documentation/th=
ird-party/MV88F5182-datasheet.pdf
-.. _MV88F5182-opensource-manual.pdf: http://www.embeddedarm.com/document=
ation/third-party/MV88F5182-opensource-manual.pdf
-.. _MV88F5182-usermanual.pdf: http://www.embeddedarm.com/documentation/t=
hird-party/MV88F5182-usermanual.pdf
-.. _marvel_88f5281_data_sheet.pdf: http://www.ocmodshop.com/images/revie=
ws/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
+.. _MV88F5182-datasheet.pdf: http://web.archive.org/web/20210124231420/h=
ttp://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-datasheet.pdf
+.. _MV88F5182-opensource-manual.pdf: http://web.archive.org/web/20210124=
231536/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-opensource-manu=
al.pdf
+.. _MV88F5182-usermanual.pdf: http://web.archive.org/web/20210124231631/=
http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-usermanual.pdf
+.. _marvel_88f5281_data_sheet.pdf: http://web.archive.org/web/2013102814=
4728/http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marve=
l_88f5281_data_sheet.pdf
=20
 Kirkwood family
 ---------------
@@ -75,18 +75,18 @@ Kirkwood family
   Linux kernel plat directory:
 	none
=20
-.. _armada_310.pdf: http://www.marvell.com/embedded-processors/armada-30=
0/assets/armada_310.pdf
-.. _armada_310.pdf: http://www.marvell.com/embedded-processors/armada-30=
0/assets/armada_310.pdf
+.. _armada_310.pdf: http://web.archive.org/web/20111027032509/http://www=
.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
+.. _armada_310.pdf: http://web.archive.org/web/20111027032509/http://www=
.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
 .. _88F6190-003_WEB.pdf: http://www.marvell.com/embedded-processors/kirk=
wood/assets/88F6190-003_WEB.pdf
-.. _HW_88F619x_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/kirkwood/assets/HW_88F619x_OpenSource.pdf
+.. _HW_88F619x_OpenSource.pdf: http://web.archive.org/web/20121021182835=
/http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_Op=
enSource.pdf
 .. _FS_88F6180_9x_6281_OpenSource.pdf: http://www.marvell.com/embedded-p=
rocessors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
-.. _88F6192-003_ver1.pdf: http://www.marvell.com/embedded-processors/kir=
kwood/assets/88F6192-003_ver1.pdf
-.. _HW_88F619x_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/kirkwood/assets/HW_88F619x_OpenSource.pdf
+.. _88F6192-003_ver1.pdf: http://web.archive.org/web/20131113121446/http=
://www.marvell.com/embedded-processors/kirkwood/assets/88F6192-003_ver1.p=
df
+.. _HW_88F619x_OpenSource.pdf: http://web.archive.org/web/20121021182835=
/http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_Op=
enSource.pdf
 .. _FS_88F6180_9x_6281_OpenSource.pdf: http://www.marvell.com/embedded-p=
rocessors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
 .. _88F6180-003_ver1.pdf: http://www.marvell.com/embedded-processors/kir=
kwood/assets/88F6180-003_ver1.pdf
 .. _HW_88F6180_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/kirkwood/assets/HW_88F6180_OpenSource.pdf
 .. _FS_88F6180_9x_6281_OpenSource.pdf: http://www.marvell.com/embedded-p=
rocessors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
-.. _88F6281-004_ver1.pdf: http://www.marvell.com/embedded-processors/kir=
kwood/assets/88F6281-004_ver1.pdf
+.. _88F6281-004_ver1.pdf: http://web.archive.org/web/20120131133709/http=
://www.marvell.com/embedded-processors/kirkwood/assets/88F6281-004_ver1.p=
df
 .. _HW_88F6281_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/kirkwood/assets/HW_88F6281_OpenSource.pdf
 .. _FS_88F6180_9x_6281_OpenSource.pdf: http://www.marvell.com/embedded-p=
rocessors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
=20
@@ -116,10 +116,10 @@ Discovery family
   Linux kernel plat directory:
 	arch/arm/plat-orion
=20
-.. _MV78100-003_WEB.pdf: http://www.marvell.com/embedded-processors/disc=
overy-innovation/assets/MV78100-003_WEB.pdf
-.. _HW_MV78100_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/discovery-innovation/assets/HW_MV78100_OpenSource.pdf
+.. _MV78100-003_WEB.pdf: http://web.archive.org/web/20120616194711/http:=
//www.marvell.com/embedded-processors/discovery-innovation/assets/MV78100=
-003_WEB.pdf
+.. _HW_MV78100_OpenSource.pdf: http://web.archive.org/web/20141005120451=
/http://www.marvell.com/embedded-processors/discovery-innovation/assets/H=
W_MV78100_OpenSource.pdf
 .. _FS_MV76100_78100_78200_OpenSource.pdf: http://www.marvell.com/embedd=
ed-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSour=
ce.pdf
-.. _MV78200-002_WEB.pdf: http://www.marvell.com/embedded-processors/disc=
overy-innovation/assets/MV78200-002_WEB.pdf
+.. _MV78200-002_WEB.pdf: http://web.archive.org/web/20140801121623/http:=
//www.marvell.com/embedded-processors/discovery-innovation/assets/MV78200=
-002_WEB.pdf
 .. _HW_MV78200_OpenSource.pdf: http://www.marvell.com/embedded-processor=
s/discovery-innovation/assets/HW_MV78200_OpenSource.pdf
 .. _FS_MV76100_78100_78200_OpenSource.pdf: http://www.marvell.com/embedd=
ed-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSour=
ce.pdf
=20
@@ -191,16 +191,16 @@ EBU Armada family
   Linux kernel plat directory:
 	none
=20
-.. _Marvell_ARMADA_370_SoC.pdf: http://www.marvell.com/embedded-processo=
rs/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
+.. _Marvell_ARMADA_370_SoC.pdf: http://web.archive.org/web/2012111506303=
8/http://www.marvell.com/embedded-processors/armada-300/assets/Marvell_AR=
MADA_370_SoC.pdf
 .. _ARMADA370-datasheet.pdf: http://www.marvell.com/embedded-processors/=
armada-300/assets/ARMADA370-datasheet.pdf
 .. _ARMADA370-FunctionalSpec-datasheet.pdf: http://www.marvell.com/embed=
ded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
-.. _ARMADA_375_SoC-01_product_brief.pdf: http://www.marvell.com/embedded=
-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
-.. _marvell-embedded-processors-armada-38x-functional-specifications-201=
5-11.pdf: https://www.marvell.com/content/dam/marvell/en/public-collatera=
l/embedded-processors/marvell-embedded-processors-armada-38x-functional-s=
pecifications-2015-11.pdf
-.. _Marvell-ArmadaXP-SoC-product%20brief.pdf: http://www.marvell.com/emb=
edded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pd=
f
+.. _ARMADA_375_SoC-01_product_brief.pdf: http://web.archive.org/web/2013=
1216023516/http://www.marvell.com/embedded-processors/armada-300/assets/A=
RMADA_375_SoC-01_product_brief.pdf
+.. _marvell-embedded-processors-armada-38x-functional-specifications-201=
5-11.pdf: http://web.archive.org/web/20200420191927/https://www.marvell.c=
om/content/dam/marvell/en/public-collateral/embedded-processors/marvell-e=
mbedded-processors-armada-38x-functional-specifications-2015-11.pdf
+.. _Marvell-ArmadaXP-SoC-product%20brief.pdf: http://web.archive.org/web=
/20121021173528/http://www.marvell.com/embedded-processors/armada-xp/asse=
ts/Marvell-ArmadaXP-SoC-product%20brief.pdf
 .. _ARMADA-XP-Functional-SpecDatasheet.pdf: http://www.marvell.com/embed=
ded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf
-.. _HW_MV78230_OS.PDF: http://www.marvell.com/embedded-processors/armada=
-xp/assets/HW_MV78230_OS.PDF
+.. _HW_MV78230_OS.PDF: http://web.archive.org/web/20141127013651/http://=
www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78230_OS.PDF
 .. _HW_MV78260_OS.PDF: http://www.marvell.com/embedded-processors/armada=
-xp/assets/HW_MV78260_OS.PDF
-.. _HW_MV78460_OS.PDF: http://www.marvell.com/embedded-processors/armada=
-xp/assets/HW_MV78460_OS.PDF
+.. _HW_MV78460_OS.PDF: http://web.archive.org/web/20141222000230/http://=
www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78460_OS.PDF
=20
 EBU Armada family ARMv8
 -----------------------
@@ -244,10 +244,10 @@ EBU Armada family ARMv8
   Device tree files:
 	arch/arm64/boot/dts/marvell/armada-80*
=20
-.. _PB-88F3700-FNL.pdf: http://www.marvell.com/embedded-processors/asset=
s/PB-88F3700-FNL.pdf
-.. _Armada7020PB-Jan2016.pdf: http://www.marvell.com/embedded-processors=
/assets/Armada7020PB-Jan2016.pdf
-.. _Armada7040PB-Jan2016.pdf: http://www.marvell.com/embedded-processors=
/assets/Armada7040PB-Jan2016.pdf
-.. _Armada8020PB-Jan2016.pdf: http://www.marvell.com/embedded-processors=
/assets/Armada8020PB-Jan2016.pdf
+.. _PB-88F3700-FNL.pdf: http://web.archive.org/web/20160309224849/http:/=
/www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
+.. _Armada7020PB-Jan2016.pdf: http://web.archive.org/web/20161010105541/=
http://www.marvell.com/embedded-processors/assets/Armada7020PB-Jan2016.pd=
f
+.. _Armada7040PB-Jan2016.pdf: http://web.archive.org/web/20160928154533/=
http://www.marvell.com/embedded-processors/assets/Armada7040PB-Jan2016.pd=
f
+.. _Armada8020PB-Jan2016.pdf: https://web.archive.org/web/20210124233728=
/https://www.marvell.com/content/dam/marvell/en/public-collateral/embedde=
d-processors/marvell-embedded-processors-armada-8020-product-brief-2017-1=
2.pdf
 .. _Armada8040PB-Jan2016.pdf: http://www.marvell.com/embedded-processors=
/assets/Armada8040PB-Jan2016.pdf
=20
 Avanta family
@@ -272,7 +272,7 @@ Avanta family
   Linux kernel plat directory:
 	no code in mainline yet, planned for the future
=20
-.. _Marvell_Avanta_88F6510_305_060-001_product_brief.pdf: http://www.mar=
vell.com/broadband/assets/Marvell_Avanta_88F6510_305_060-001_product_brie=
f.pdf
+.. _Marvell_Avanta_88F6510_305_060-001_product_brief.pdf: http://web.arc=
hive.org/web/20180829171057/http://www.marvell.com/broadband/assets/Marve=
ll_Avanta_88F6510_305_060-001_product_brief.pdf
=20
 Storage family
 --------------
@@ -307,9 +307,9 @@ Dove family (application processor)
 	- arch/arm/mach-mvebu (DT enabled platforms)
         - arch/arm/mach-dove (non-DT enabled platforms)
=20
-.. _Marvell_Armada510_SoC.pdf: http://www.marvell.com/application-proces=
sors/armada-500/assets/Marvell_Armada510_SoC.pdf
+.. _Marvell_Armada510_SoC.pdf: http://web.archive.org/web/20111102020643=
/http://www.marvell.com/application-processors/armada-500/assets/Marvell_=
Armada510_SoC.pdf
 .. _Armada-510-Hardware-Spec.pdf: http://www.marvell.com/application-pro=
cessors/armada-500/assets/Armada-510-Hardware-Spec.pdf
-.. _Armada-510-Functional-Spec.pdf: http://www.marvell.com/application-p=
rocessors/armada-500/assets/Armada-510-Functional-Spec.pdf
+.. _Armada-510-Functional-Spec.pdf: http://web.archive.org/web/201201301=
72443/http://www.marvell.com/application-processors/armada-500/assets/Arm=
ada-510-Functional-Spec.pdf
=20
 PXA 2xx/3xx/93x/95x family
 --------------------------
@@ -360,19 +360,19 @@ PXA 2xx/3xx/93x/95x family
    Linux kernel plat directory:
 	arch/arm/plat-pxa
=20
-.. _pxa_27x_pb.pdf: http://www.marvell.com/application-processors/pxa-fa=
mily/assets/pxa_27x_pb.pdf
-.. _pxa_27x_design_guide.pdf: http://www.marvell.com/application-process=
ors/pxa-family/assets/pxa_27x_design_guide.pdf
-.. _pxa_27x_dev_man.pdf: http://www.marvell.com/application-processors/p=
xa-family/assets/pxa_27x_dev_man.pdf
+.. _pxa_27x_pb.pdf: http://web.archive.org/web/20150927135510/http://www=
.marvell.com/application-processors/pxa-family/assets/pxa_27x_pb.pdf
+.. _pxa_27x_design_guide.pdf: http://web.archive.org/web/20120111181937/=
http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_d=
esign_guide.pdf
+.. _pxa_27x_dev_man.pdf: http://web.archive.org/web/20150927164805/http:=
//www.marvell.com/application-processors/pxa-family/assets/pxa_27x_dev_ma=
n.pdf
 .. _pxa_27x_emts.pdf: http://www.marvell.com/application-processors/pxa-=
family/assets/pxa_27x_emts.pdf
 .. _pxa_27x_spec_update.pdf: http://www.marvell.com/application-processo=
rs/pxa-family/assets/pxa_27x_spec_update.pdf
-.. _PXA300_PB_R4.pdf: http://www.marvell.com/application-processors/pxa-=
family/assets/PXA300_PB_R4.pdf
+.. _PXA300_PB_R4.pdf: http://web.archive.org/web/20120111121203/http://w=
ww.marvell.com/application-processors/pxa-family/assets/PXA300_PB_R4.pdf
 .. _PXA310_PB_R4.pdf: http://www.marvell.com/application-processors/pxa-=
family/assets/PXA310_PB_R4.pdf
-.. _PXA320_PB_R4.pdf: http://www.marvell.com/application-processors/pxa-=
family/assets/PXA320_PB_R4.pdf
+.. _PXA320_PB_R4.pdf: http://web.archive.org/web/20121021182826/http://w=
ww.marvell.com/application-processors/pxa-family/assets/PXA320_PB_R4.pdf
 .. _PXA3xx_Design_Guide.pdf: http://www.marvell.com/application-processo=
rs/pxa-family/assets/PXA3xx_Design_Guide.pdf
-.. _PXA3xx_Developers_Manual.zip: http://www.marvell.com/application-pro=
cessors/pxa-family/assets/PXA3xx_Developers_Manual.zip
+.. _PXA3xx_Developers_Manual.zip: http://web.archive.org/web/20130727144=
605/http://www.marvell.com/application-processors/pxa-family/assets/PXA3x=
x_Developers_Manual.zip
 .. _PXA3xx_EMTS.pdf: http://www.marvell.com/application-processors/pxa-f=
amily/assets/PXA3xx_EMTS.pdf
 .. _PXA3xx_Spec_Update.zip: http://www.marvell.com/application-processor=
s/pxa-family/assets/PXA3xx_Spec_Update.zip
-.. _PXA3xx_TavorP_BootROM_Ref_Manual.pdf: http://www.marvell.com/applica=
tion-processors/pxa-family/assets/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
+.. _PXA3xx_TavorP_BootROM_Ref_Manual.pdf: http://web.archive.org/web/201=
20111103844/http://www.marvell.com/application-processors/pxa-family/asse=
ts/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
=20
 MMP/MMP2/MMP3 family (communication processor)
 ----------------------------------------------
@@ -429,13 +429,13 @@ MMP/MMP2/MMP3 family (communication processor)
 	arch/arm/plat-pxa
=20
 .. _armada-168.jsp: http://www.marvell.com/application-processors/armada=
-100/armada-168.jsp
-.. _pxa_168_pb.pdf: http://www.marvell.com/application-processors/armada=
-100/assets/pxa_168_pb.pdf
+.. _pxa_168_pb.pdf: http://web.archive.org/web/20111102030100/http://www=
.marvell.com/application-processors/armada-100/assets/pxa_168_pb.pdf
 .. _armada_16x_datasheet.pdf: http://www.marvell.com/application-process=
ors/armada-100/assets/armada_16x_datasheet.pdf
-.. _armada_16x_software_manual.pdf: http://www.marvell.com/application-p=
rocessors/armada-100/assets/armada_16x_software_manual.pdf
+.. _armada_16x_software_manual.pdf: http://web.archive.org/web/201604281=
54454/http://www.marvell.com/application-processors/armada-100/assets/arm=
ada_16x_software_manual.pdf
 .. _ARMADA16x_Spec_update.pdf: http://www.marvell.com/application-proces=
sors/armada-100/assets/ARMADA16x_Spec_update.pdf
-.. _armada_16x_ref_manual.pdf: http://www.marvell.com/application-proces=
sors/armada-100/assets/armada_16x_ref_manual.pdf
-.. _armada_16x_app_note_package.pdf: http://www.marvell.com/application-=
processors/armada-100/assets/armada_16x_app_note_package.pdf
-.. _Marvell_PXA910_Platform-001_PB_final.pdf: http://www.marvell.com/com=
munication-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.=
pdf
+.. _armada_16x_ref_manual.pdf: http://web.archive.org/web/20130727205559=
/http://www.marvell.com/application-processors/armada-100/assets/armada_1=
6x_ref_manual.pdf
+.. _armada_16x_app_note_package.pdf: http://web.archive.org/web/20141005=
090706/http://www.marvell.com/application-processors/armada-100/assets/ar=
mada_16x_app_note_package.pdf
+.. _Marvell_PXA910_Platform-001_PB_final.pdf: https://archive.org/downlo=
ad/marvell-pxa910-pb/Marvell_PXA910_Platform-001_PB.pdf
 .. _armada610_pb.pdf: http://www.marvell.com/application-processors/arma=
da-600/assets/armada610_pb.pdf
 .. _Marvell-ARMADA-PXA2128-SoC-PB.pdf: http://www.marvell.com/applicatio=
n-processors/armada/pxa2128/assets/Marvell-ARMADA-PXA2128-SoC-PB.pdf
=20
--=20
2.29.2

