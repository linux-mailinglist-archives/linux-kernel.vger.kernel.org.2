Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11E53C660E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 00:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhGLWMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 18:12:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:34283 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhGLWMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 18:12:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="190442554"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="190442554"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:09:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="464386166"
Received: from jzloch-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.136.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:09:19 -0700
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     x86@kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH 05/14] ARM: dts: aspeed: Add PECI controller nodes
Date:   Tue, 13 Jul 2021 00:04:38 +0200
Message-Id: <20210712220447.957418-6-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712220447.957418-1-iwona.winiarska@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PECI controller nodes with all required information.

Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 14 ++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index c5aeb3cf3a09..de733c03ec18 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -385,6 +385,20 @@ ibt: ibt@140 {
 				};
 			};
 
+			peci0: peci-controller@1e78b000 {
+				compatible = "aspeed,ast2400-peci";
+				reg = <0x1e78b000 0x60>;
+				interrupts = <15>;
+				clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
+				resets = <&syscon ASPEED_RESET_PECI>;
+				clock-divider = <0>;
+				msg-timing = <1>;
+				addr-timing = <1>;
+				rd-sampling-point = <8>;
+				cmd-timeout-ms = <1000>;
+				status = "disabled";
+			};
+
 			uart2: serial@1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x20>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 329eaeef66fb..e7db9cf56114 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -506,6 +506,20 @@ ibt: ibt@140 {
 				};
 			};
 
+			peci0: peci-controller@1e78b000 {
+				compatible = "aspeed,ast2500-peci";
+				reg = <0x1e78b000 0x60>;
+				interrupts = <15>;
+				clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
+				resets = <&syscon ASPEED_RESET_PECI>;
+				clock-divider = <0>;
+				msg-timing = <1>;
+				addr-timing = <1>;
+				rd-sampling-point = <8>;
+				cmd-timeout-ms = <1000>;
+				status = "disabled";
+			};
+
 			uart2: serial@1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x20>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index f96607b7b4e2..1e951bb7ff65 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -459,6 +459,20 @@ wdt4: watchdog@1e7850c0 {
 				status = "disabled";
 			};
 
+			peci0: peci-controller@1e78b000 {
+				compatible = "aspeed,ast2600-peci";
+				reg = <0x1e78b000 0x100>;
+				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
+				resets = <&syscon ASPEED_RESET_PECI>;
+				clock-divider = <0>;
+				msg-timing = <1>;
+				addr-timing = <1>;
+				rd-sampling-point = <8>;
+				cmd-timeout-ms = <1000>;
+				status = "disabled";
+			};
+
 			lpc: lpc@1e789000 {
 				compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-- 
2.31.1

