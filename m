Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB3414A04
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhIVNDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:03:35 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:16292 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhIVNDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1632315725; x=1663851725;
  h=from:to:cc:subject:date:message-id;
  bh=PqxTd4Dl9iY4lGq+Yt6hJ/nCvl9+hu34HCcKs1aNf8U=;
  b=C9o2tXBj7olPvVZZ0Kr5spSWl76AAE8BUWO2NTZGuhNr4JKqdNbXABXl
   jDabsvcBsVJsm0psyE0xb/4YWLS65ENMcpaaaiXMgu27uWMXohj4lU4Be
   SXWEmbh+hGIQM9nIrs0Xb2oPAiZv/oEvfDjYHbud7Bav1ReVjtWc0QEol
   vxw/fyIesnK6A/Poa9coRwuKZIsExsgjLoa1bfyFGeoMofWR4mQwtnE6N
   BzOj579jbryk5N6zvY/ddQYY0MzkXj7BlYCW+xKPZAHfAjQMcn0insUCf
   gkMcb5rhRuyVTakQiuEZxnVOlA3s3HASUzSDqh9isaUQrinlwXXy0xWJU
   g==;
X-IronPort-AV: E=Sophos;i="5.85,314,1624312800"; 
   d="scan'208";a="19650006"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 22 Sep 2021 15:01:38 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 22 Sep 2021 15:01:39 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 22 Sep 2021 15:01:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1632315699; x=1663851699;
  h=from:to:cc:subject:date:message-id;
  bh=PqxTd4Dl9iY4lGq+Yt6hJ/nCvl9+hu34HCcKs1aNf8U=;
  b=kE5qtGBfBGfYh6xZH4txsizSQ2w37E71u8hAnyzm4j3DWmGyFrOS9MeC
   KoX1UO04WVA6ZEjqMXyT+OKroLi7+5/KKBUQ2ZCCoWHrXDe1Z2EQJR9S6
   rEGbAD60sTK7d6suwDGBz97H0SheOyimlg/LZAXCYJmoMpR5Qi+qhjpk4
   Acbi5Vcjra6U46bHcDDcDGz/ASQ3Sm71RKVHP2fhoBsN/GULhVn8P7dtd
   auliG1hh3E5r5VuYR3ZJ3Av1oM72ieRMttnCaBSYrgdtn+w3xNmrbmW2T
   Gi29oQ5zm2xFyf4X+lPVetK3Qb0IxKbWGZSKhCKXilNXkB046n8l8LbF2
   g==;
X-IronPort-AV: E=Sophos;i="5.85,314,1624312800"; 
   d="scan'208";a="19649854"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Sep 2021 15:01:02 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id A1776280070;
        Wed, 22 Sep 2021 15:01:01 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/3] ARM: dts: imx7-tqma7/mba7: correct spelling of "TQ-Systems"
Date:   Wed, 22 Sep 2021 15:00:52 +0200
Message-Id: <941f977a8f98a26a4f14fd2c8caf5374a67e9345.1632314390.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"TQ-Systems" is written with a dash.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: new patch


 arch/arm/boot/dts/imx7-mba7.dtsi   | 4 ++--
 arch/arm/boot/dts/imx7-tqma7.dtsi  | 4 ++--
 arch/arm/boot/dts/imx7d-mba7.dts   | 6 +++---
 arch/arm/boot/dts/imx7d-tqma7.dtsi | 4 ++--
 arch/arm/boot/dts/imx7s-mba7.dts   | 6 +++---
 arch/arm/boot/dts/imx7s-tqma7.dtsi | 4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index 5e6bef230dc7..0212962b2189 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR X11
 /*
- * Device Tree Include file for TQ Systems MBa7 carrier board.
+ * Device Tree Include file for TQ-Systems MBa7 carrier board.
  *
- * Copyright (C) 2016 TQ Systems GmbH
+ * Copyright (C) 2016 TQ-Systems GmbH
  * Author: Markus Niebel <Markus.Niebel@tq-group.com>
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  *
diff --git a/arch/arm/boot/dts/imx7-tqma7.dtsi b/arch/arm/boot/dts/imx7-tqma7.dtsi
index 8773344b54aa..065e1668e280 100644
--- a/arch/arm/boot/dts/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/imx7-tqma7.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR X11
 /*
- * Device Tree Include file for TQ Systems TQMa7x boards with full mounted PCB.
+ * Device Tree Include file for TQ-Systems TQMa7x boards with full mounted PCB.
  *
- * Copyright (C) 2016 TQ Systems GmbH
+ * Copyright (C) 2016 TQ-Systems GmbH
  * Author: Markus Niebel <Markus.Niebel@tq-group.com>
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  */
diff --git a/arch/arm/boot/dts/imx7d-mba7.dts b/arch/arm/boot/dts/imx7d-mba7.dts
index 36ef6a3cdb0b..32bf9fa9d00e 100644
--- a/arch/arm/boot/dts/imx7d-mba7.dts
+++ b/arch/arm/boot/dts/imx7d-mba7.dts
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR X11
 /*
- * Device Tree Source for TQ Systems TQMa7D board on MBa7 carrier board.
+ * Device Tree Source for TQ-Systems TQMa7D board on MBa7 carrier board.
  *
- * Copyright (C) 2016 TQ Systems GmbH
+ * Copyright (C) 2016 TQ-Systems GmbH
  * Author: Markus Niebel <Markus.Niebel@tq-group.com>
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  */
@@ -13,7 +13,7 @@
 #include "imx7-mba7.dtsi"
 
 / {
-	model = "TQ Systems TQMa7D board on MBa7 carrier board";
+	model = "TQ-Systems TQMa7D board on MBa7 carrier board";
 	compatible = "tq,imx7d-mba7", "tq,imx7d-tqma7", "fsl,imx7d";
 };
 
diff --git a/arch/arm/boot/dts/imx7d-tqma7.dtsi b/arch/arm/boot/dts/imx7d-tqma7.dtsi
index 598aed1ffd99..3ee2017c1ab3 100644
--- a/arch/arm/boot/dts/imx7d-tqma7.dtsi
+++ b/arch/arm/boot/dts/imx7d-tqma7.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR X11
 /*
- * Device Tree Include file for TQ Systems TQMa7D board with NXP i.MX7Dual SoC.
+ * Device Tree Include file for TQ-Systems TQMa7D board with NXP i.MX7Dual SoC.
  *
- * Copyright (C) 2016 TQ Systems GmbH
+ * Copyright (C) 2016 TQ-Systems GmbH
  * Author: Markus Niebel <Markus.Niebel@tq-group.com>
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  */
diff --git a/arch/arm/boot/dts/imx7s-mba7.dts b/arch/arm/boot/dts/imx7s-mba7.dts
index d7d3f530f843..8e4cf589c92c 100644
--- a/arch/arm/boot/dts/imx7s-mba7.dts
+++ b/arch/arm/boot/dts/imx7s-mba7.dts
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR X11
 /*
- * Device Tree Source for TQ Systems TQMa7S board on MBa7 carrier board.
+ * Device Tree Source for TQ-Systems TQMa7S board on MBa7 carrier board.
  *
- * Copyright (C) 2016 TQ Systems GmbH
+ * Copyright (C) 2016 TQ-Systems GmbH
  * Author: Markus Niebel <Markus.Niebel@tq-group.com>
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  */
@@ -13,6 +13,6 @@
 #include "imx7-mba7.dtsi"
 
 / {
-	model = "TQ Systems TQMa7S board on MBa7 carrier board";
+	model = "TQ-Systems TQMa7S board on MBa7 carrier board";
 	compatible = "tq,imx7s-mba7", "tq,imx7s-tqma7", "fsl,imx7s";
 };
diff --git a/arch/arm/boot/dts/imx7s-tqma7.dtsi b/arch/arm/boot/dts/imx7s-tqma7.dtsi
index 5f5433eb7dd7..7a190fdb2d30 100644
--- a/arch/arm/boot/dts/imx7s-tqma7.dtsi
+++ b/arch/arm/boot/dts/imx7s-tqma7.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR X11
 /*
- * Device Tree Include file for TQ Systems TQMa7S board with NXP i.MX7Solo SoC.
+ * Device Tree Include file for TQ-Systems TQMa7S board with NXP i.MX7Solo SoC.
  *
- * Copyright (C) 2016 TQ Systems GmbH
+ * Copyright (C) 2016 TQ-Systems GmbH
  * Author: Markus Niebel <Markus.Niebel@tq-group.com>
  * Copyright (C) 2019 Bruno Thomsen <bruno.thomsen@gmail.com>
  */
-- 
2.17.1

