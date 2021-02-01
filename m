Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9BF30A8C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhBANbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhBANbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:31:08 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB166C0613ED;
        Mon,  1 Feb 2021 05:30:25 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3849922F99;
        Mon,  1 Feb 2021 14:30:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1612186221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=maCy+B6n2Fbcr8Fi1rd2zituw4tm1nmh1LwbMnO7xG0=;
        b=cCRPHZpfACpoomwp39XDrTGc1ktrC32CNpTL95mm5zVxuzHcG0f4FzccdC0I4aPmaHC8nn
        xjDRFxVRZ79j58RM1cOuJnZ9cfTZ1bxCo+VDq4J31xWbgzTJmWM+JAnCImR1Oj/bxzWQ4R
        MrYWNEVTW2Z9nDefyFL4zJPQXzMNeow=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] ARM: dts: ebaz4205: add pinctrl entries for switches
Date:   Mon,  1 Feb 2021 14:30:00 +0100
Message-Id: <20210201133000.23402-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pinctrl entries for the GPIOs which are connected to the
push buttons on this board.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/zynq-ebaz4205.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-ebaz4205.dts b/arch/arm/boot/dts/zynq-ebaz4205.dts
index e802d4ae8804..b0b836aedd76 100644
--- a/arch/arm/boot/dts/zynq-ebaz4205.dts
+++ b/arch/arm/boot/dts/zynq-ebaz4205.dts
@@ -43,7 +43,30 @@
 	};
 };
 
+&gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio0_default>;
+};
+
 &pinctrl0 {
+	pinctrl_gpio0_default: gpio0-default {
+		mux {
+			groups = "gpio0_20_grp", "gpio0_32_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_20_grp", "gpio0_32_grp";
+			io-standard = <3>;
+			slew-rate = <0>;
+		};
+
+		conf-pull-up {
+			pins = "MIO20", "MIO32";
+			bias-disable;
+		};
+	};
+
 	pinctrl_sdhci0_default: sdhci0-default {
 		mux {
 			groups = "sdio0_2_grp";
-- 
2.20.1

