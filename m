Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E79C3751FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhEFKHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:07:18 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:30090 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbhEFKHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:07:17 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1469pSEe024643;
        Thu, 6 May 2021 17:51:28 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from localhost.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 May
 2021 18:03:14 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <steven_lee@aspeedtech.com>, <Hongweiz@ami.com>,
        <ryan_chen@aspeedtech.com>, <chin-ting_kuo@aspeedtech.com>
Subject: [PATCH v3 3/5] ARM: dts: aspeed: ast2600evb: Add phase correction for emmc controller.
Date:   Thu, 6 May 2021 18:03:10 +0800
Message-ID: <20210506100312.1638-4-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210506100312.1638-1-steven_lee@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1469pSEe024643
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set MMC timing-phase register by adding the phase correction binding in the
device tree.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 1ae0facc3d5f..fa63cb033c57 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -122,7 +122,8 @@
 &emmc {
 	non-removable;
 	bus-width = <4>;
-	max-frequency = <52000000>;
+	max-frequency = <100000000>;
+	clk-phase-mmc-hs200 = <9>, <225>;
 };
 
 &rtc {
-- 
2.17.1

