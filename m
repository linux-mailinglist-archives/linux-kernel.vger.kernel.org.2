Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BE14440EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 12:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhKCL7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 07:59:30 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:1749 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231460AbhKCL71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 07:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1635940611; x=1667476611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=AjCatsvsAwdT8YVRiZph5a+q3FYEFUIVNX1Zhj7OUGs=;
  b=BVLJ6SG8Md8yNz9+rBG9KP/c93koRqSP9rPVrsd8ubsVqWaKH+qdio4w
   9TbH5J4hSX0VxyaPgXCOYwSv2VwW0qpLsW2WZAZwrzG6PVyFnZCWit4JF
   lpQeG05+qxPPsMd0yoICNSkaODsdc8cgDzeKnAIlD2fNRXgE20hUpPNhv
   gl0O8zIbNn2mWMSB8oyMeSxeleqPY67aYy+ZajuoYgBQrRDX9JWySjoyF
   qNPYoXO63oct4Y6aZhBNcfMqJQdqbnWKsbPlnyw/+8ofgs3+R37pIc7MN
   IOUv8ANXIgLWIp36o76oaOr3Uj0CGawAryNxz06m1nQQhDmbiYIuslscY
   A==;
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="20323804"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Nov 2021 12:56:49 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 03 Nov 2021 12:56:49 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 03 Nov 2021 12:56:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1635940609; x=1667476609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=AjCatsvsAwdT8YVRiZph5a+q3FYEFUIVNX1Zhj7OUGs=;
  b=Ps8hRGuzpFm7VUIhVXuOP+PiYH0ryINOttTt0TMeeR8YGiByLVme7AHH
   Ch4AqYDUOzZ83UxQehzLbdKHM7hZvtQTi5jLQ19uKN308sVeBEixJWqZD
   wMFNHVXHI46mdQyniuB1jKAXAL5tHUpt5f5jJL0C/s3UwjkcZgms0qpeH
   kdA1QdPPcir+jlZdHcFH2izkZfFJ8qg0fRnJlw/ADrKGcP9504ZsBRYz7
   kuHaSc7Aj4Njn1KseHtipIo19WAcLS+ZWHm9dObW1p2dpi/bpSq1OP9ZU
   wuXtbzge3dr6QPfZnVVD8Nd15Q3gnxXuVxOPjxnmKwlOdxtB/mllFmmOX
   w==;
X-IronPort-AV: E=Sophos;i="5.87,205,1631570400"; 
   d="scan'208";a="20323801"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Nov 2021 12:56:49 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id CD7BB280075;
        Wed,  3 Nov 2021 12:56:48 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl: tqma6: add ERR006687 hardware workaround for "a" variant
Date:   Wed,  3 Nov 2021 12:56:17 +0100
Message-Id: <20211103115618.13927-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103115618.13927-1-matthias.schiffer@ew.tq-group.com>
References: <20211103115618.13927-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TQMa6x "a" has a workaround for ERR006687 implemented in hardware.
Add the required pinmuxing and related setup to make use of this.

As board DTS files based on the TQMa6x SoMs will define their own
pinmuxing for the FEC ethernet controller as well, we can't apply this
pin group unconditionally; instead, it is the responsibility of the
board DTs derived from imx6qdl-tqma6a.dtsi to include this group.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes

 arch/arm/boot/dts/imx6qdl-tqma6a.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
index b679bec78e6c..bfb67da64b96 100644
--- a/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
@@ -4,6 +4,12 @@
  * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
  */
 
+&fec {
+	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
+			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
+	fsl,err006687-workaround-present;
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
@@ -26,3 +32,17 @@
 		pagesize = <32>;
 	};
 };
+
+&iomuxc {
+	/*
+	 * This pinmuxing is required for the ERR006687 workaround. Board
+	 * DTS files that enable the FEC controller with
+	 * fsl,err006687-workaround-present must include this group.
+	 */
+	pinctrl_enet_fix: enetfixgrp {
+		fsl,pins = <
+			/* ENET ping patch */
+			MX6QDL_PAD_GPIO_6__ENET_IRQ 0x000b1
+		>;
+	};
+};
-- 
2.17.1

