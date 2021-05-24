Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B951738E1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhEXHfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:35:32 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:17874 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhEXHf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:35:27 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 14O7KKWh005017;
        Mon, 24 May 2021 15:20:20 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from slee-VirtualBox.localdomain (192.168.100.253) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 May 2021 15:33:14 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>
CC:     <steven_lee@aspeedtech.com>, <Hongweiz@ami.com>,
        <ryan_chen@aspeedtech.com>, <chin-ting_kuo@aspeedtech.com>
Subject: [PATCH v5 3/4] ARM: dts: aspeed: ast2600evb: Add dts file for A1 and A0.
Date:   Mon, 24 May 2021 15:32:55 +0800
Message-ID: <20210524073308.9328-4-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210524073308.9328-1-steven_lee@aspeedtech.com>
References: <20210524073308.9328-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 14O7KKWh005017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aspeed-ast2600-evb.dts was modified for supporting A2 evb.
Since A1/A0 evbs don't have GPIO regulators and SD clock frequency(SCU210)
is different to A2 as well. Adding a new dts that removes new nodes
created in aspeed-ast2600-evb.dts is necessary.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
new file mode 100644
index 000000000000..dd7148060c4a
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2021 IBM Corp.
+
+#include "aspeed-ast2600-evb.dts"
+
+/ {
+	model = "AST2600 A1 EVB";
+
+	/delete-node/regulator-vcc-sdhci0;
+	/delete-node/regulator-vcc-sdhci1;
+	/delete-node/regulator-vccq-sdhci0;
+	/delete-node/regulator-vccq-sdhci1;
+};
+
+/delete-node/ &sdc;
-- 
2.17.1

