Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5CF458D95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbhKVLlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:41:32 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:50749 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238857AbhKVLlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637581098; x=1669117098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/UGJ3+fHU7JmClFTUHJ8cW0RVcw4MaeYNHd1GBgQznU=;
  b=nIBIjQ++tYvK1IE8BtsEX1NfDlgv2RDyhvOiuGjVRVOObdc3rnWq39Yz
   phNjD4UFzz/dP81saEmbgslsC8Zs1V2JjqDxE1c4h9bygLqH4cN51sepA
   N1ymLpukz1lhjYmVsaWpfiPURGY/JCxuCbOf889TffSsBtFXP5t7VTIOD
   CyprgD5JaExMNbQ/K400X8ThaeGd5Yf6Ph3V4r8IszJT2ZyOtdxnuvP+p
   MWyUqiUAGsQLyqt4m26JT/YiAr5/TXzwlHkJYFoSRuaATSCuU6rzoKjOJ
   c4hXzb4NJyYa+MQ4xqwFZhltHyCGTrQCwsMfwCR2KAYiBylmwMTTZdUZS
   w==;
X-IronPort-AV: E=Sophos;i="5.87,254,1631570400"; 
   d="scan'208";a="20593898"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 22 Nov 2021 12:38:15 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 22 Nov 2021 12:38:16 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 22 Nov 2021 12:38:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637581095; x=1669117095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/UGJ3+fHU7JmClFTUHJ8cW0RVcw4MaeYNHd1GBgQznU=;
  b=QwbdPh6Ixgm+OjolYFGkVHt8DUJmiuHIom+XVkOKmI/b9zC1t+4+kvOb
   kayMAREkduzNG37Ix89cL6DwfQktHDuYSDaGSL1tpfXIHtpD+mu9SIpUh
   FfWCVVw/q7n2nMAhP9ddkTobz5+lwcKiVLF0qKavjYmwB1tBQEFCTa4bd
   kd/Lyt7xyBoJ0F9JKpPolNFOZ39p8YQ/E67gqW9R8MXdF1zD8hOfpwTd3
   zHj3qxrD+EAdtaFWxGJhI+tq6GQ1Y5yBhObtVhNpg0U02gjFWXb5bdp3+
   LZ83Uxn7tsSh0GNLgbYWp2dw4w6p4i6bn/FuHnrT0sOtp5rHxGxwYa7+T
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,254,1631570400"; 
   d="scan'208";a="20593897"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Nov 2021 12:38:15 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id B9DFB280075;
        Mon, 22 Nov 2021 12:38:15 +0100 (CET)
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
Subject: [PATCH v3 2/3] ARM: dts: imx6qdl-tqma6: add ERR006687 hardware workaround for "a" variant
Date:   Mon, 22 Nov 2021 12:37:39 +0100
Message-Id: <20211122113740.2348-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122113740.2348-1-matthias.schiffer@ew.tq-group.com>
References: <20211122113740.2348-1-matthias.schiffer@ew.tq-group.com>
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
v3: changed commit title

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

