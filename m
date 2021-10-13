Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED7742BEBD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJMLPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:15:31 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:61892 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230054AbhJMLP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634123606; x=1665659606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MMVC8Cj/r5CWKskBUeOs3cYU/+tk7nMQILUJfgpN5dw=;
  b=cmTIOeZYSrC7pkf6vKATsVmRPfqr+6vSAhBg81A8YBX0ENu/tykR9cgb
   OOXmMMUtbjOh0zBT/VBKkDCMkqgCO18GQWnV+PuoUXnn9Olw2XDrVILsj
   3FiOrQ+61NfNkSlzz/JI4BCGe6mrG81oGTxfewtKb/+Xw7g99yT65v0sj
   NOZeE2TJuIdN/rIwhdniyblz9hS6fCf42h7aQqajeFmfLFUFQcjygHnle
   HDVWTi39D5iyIAmqnnjmssNdCliiwPJxmItEQ9+DWVRbg5l9aGW7oymkV
   cWz+gHeKzKRfAl9axlDLxALOf71+IbE+rg8zN6JoFyKKgQFCIhwx+JzET
   w==;
X-IronPort-AV: E=Sophos;i="5.85,370,1624312800"; 
   d="scan'208";a="20020842"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Oct 2021 13:13:25 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 13 Oct 2021 13:13:25 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 13 Oct 2021 13:13:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634123605; x=1665659605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MMVC8Cj/r5CWKskBUeOs3cYU/+tk7nMQILUJfgpN5dw=;
  b=FQShdrDXyqWNWqsBq6C2fyyU42LoHylnMpB5layNRCS1rrO/viB4XSbY
   Mv5T/tFv1u3zMYjpkhElS7bBsUzpsFaKyZigyMgV2Arp54PwKAiBvELXJ
   rTS/P3czj26GVbii0nKNR+xlzJyz39IpTrIS971zJqop6Yn9jPuZKxOAt
   KqlMVMUCufmGRKraTPApxx/m4QKPO5Z6rU/Ilb3upMovg8I7jCT7m1cTS
   +eGGb/HK3qVzbne1xUc893E3M3W9gEguWFK7mu3QhP+MkweNspD3as/9Z
   aQkB+yuR4d1emY4IQVLloz+pCnF5xS2VviOg6YlgXsZCgWu0wEdgvt8Sf
   g==;
X-IronPort-AV: E=Sophos;i="5.85,370,1624312800"; 
   d="scan'208";a="20020841"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Oct 2021 13:13:24 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id C42A5280075;
        Wed, 13 Oct 2021 13:13:24 +0200 (CEST)
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
Subject: [PATCH 2/3] ARM: dts: imx6qdl: tqma6: add ERR006687 hardware workaround for "a" variant
Date:   Wed, 13 Oct 2021 13:12:01 +0200
Message-Id: <20211013111202.6231-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211013111202.6231-1-matthias.schiffer@ew.tq-group.com>
References: <20211013111202.6231-1-matthias.schiffer@ew.tq-group.com>
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

