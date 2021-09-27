Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5B6418DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 04:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhI0CdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 22:33:12 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:25105 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbhI0CdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 22:33:11 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18R2AI0a038749;
        Mon, 27 Sep 2021 10:10:18 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 27 Sep
 2021 10:30:55 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <openbmc@lists.ozlabs.org>
CC:     <osk@google.com>
Subject: [PATCH v7 1/5] ARM: dts: aspeed: Drop reg-io-width from LPC nodes
Date:   Mon, 27 Sep 2021 10:30:49 +0800
Message-ID: <20210927023053.6728-2-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18R2AI0a038749
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'reg-io-width' properties are not used by LPC drivers
nor documented as part of bindings. Therefore drop them.

This is in preparation to move aspeed-lpc.txt to YAML schema.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 1 -
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
 arch/arm/boot/dts/aspeed-g6.dtsi | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index c5aeb3cf3a09..45a25eb4baa4 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -345,7 +345,6 @@
 			lpc: lpc@1e789000 {
 				compatible = "aspeed,ast2400-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 73ca1ec6fc24..8e1d00d8445e 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -436,7 +436,6 @@
 			lpc: lpc@1e789000 {
 				compatible = "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 1b47be1704f8..0d1aae6887cd 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -490,7 +490,6 @@
 			lpc: lpc@1e789000 {
 				compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.17.1

