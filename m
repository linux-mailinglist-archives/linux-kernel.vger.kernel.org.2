Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8673450340
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhKOLQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:16:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:10569 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhKOLQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:16:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233259944"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233259944"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 03:13:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="734932781"
Received: from pg-vnc03.altera.com ([10.142.129.92])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2021 03:13:06 -0800
From:   sin.hui.kho@linux.intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sin Hui Kho <sin.hui.kho@intel.com>
Subject: [PATCH] HSD #14014983934: arm64: dts: Update NAND MTD partition for Agilex and Stratix 10
Date:   Mon, 15 Nov 2021 19:12:15 +0800
Message-Id: <20211115111215.107992-1-sin.hui.kho@linux.intel.com>
X-Mailer: git-send-email 2.13.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sin Hui Kho <sin.hui.kho@intel.com>

Change NAND flash MTD partition in device tree after implementation of
UBI and UBIFS. "u-boot" partition remain for raw u-boot image, but "root"
partition is use for UBI image containing all other components.

Signed-off-by: Sin Hui Kho <sin.hui.kho@intel.com>
---
 .../dts/altera/socfpga_stratix10_socdk_nand.dts    | 24 ++--------------------
 .../boot/dts/intel/socfpga_agilex_socdk_nand.dts   | 20 ++----------------
 2 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index c07966740e14..9511f2bf2d25 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -119,28 +119,8 @@
 		};
 
 		partition@200000 {
-			label = "env";
-			reg = <0x200000 0x40000>;
-		};
-
-		partition@240000 {
-			label = "dtb";
-			reg = <0x240000 0x40000>;
-		};
-
-		partition@280000 {
-			label = "kernel";
-			reg = <0x280000 0x2000000>;
-		};
-
-		partition@2280000 {
-			label = "misc";
-			reg = <0x2280000 0x2000000>;
-		};
-
-		partition@4280000 {
-			label = "rootfs";
-			reg = <0x4280000 0x3bd80000>;
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
index 979aa59a6bd0..2327af820cb4 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
@@ -99,24 +99,8 @@
 			reg = <0 0x200000>;
 		};
 		partition@200000 {
-			label = "env";
-			reg = <0x200000 0x40000>;
-		};
-		partition@240000 {
-			label = "dtb";
-			reg = <0x240000 0x40000>;
-		};
-		partition@280000 {
-			label = "kernel";
-			reg = <0x280000 0x2000000>;
-		};
-		partition@2280000 {
-			label = "misc";
-			reg = <0x2280000 0x2000000>;
-		};
-		partition@4280000 {
-			label = "rootfs";
-			reg = <0x4280000 0x3bd80000>;
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
 		};
 	};
 };
-- 
2.13.0

