Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D6F41D7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350083AbhI3Kgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:36:48 -0400
Received: from foss.arm.com ([217.140.110.172]:52138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350087AbhI3Kgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:36:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3FCF113E;
        Thu, 30 Sep 2021 03:35:00 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5A8A3F793;
        Thu, 30 Sep 2021 03:34:57 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        steven.price@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V3 12/13] arm64/mm: Enable CONFIG_ARM64_PA_BITS_52 on CONFIG_ARM64_[4K|16K]_PAGES
Date:   Thu, 30 Sep 2021 16:05:15 +0530
Message-Id: <1632998116-11552-13-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
References: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All required FEAT_LPA2 components for 52 bit PA range are already in place.
Just enable CONFIG_ARM64_PA_BITS_52 on 4K and 16K pages which would select
CONFIG_ARM64_PA_BITS_52_LPA2 activating 52 bit PA range via FEAT_LPA2.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f58ef62..926a802 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -948,17 +948,17 @@ config ARM64_PA_BITS_48
 	bool "48-bit"
 
 config ARM64_PA_BITS_52
-	bool "52-bit (ARMv8.2)"
-	depends on ARM64_64K_PAGES
+	bool "52-bit"
 	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	select ARM64_PA_BITS_52_LPA if ARM64_64K_PAGES
+	select ARM64_PA_BITS_52_LPA2 if (ARM64_4K_PAGES  || ARM64_16K_PAGES)
 	help
 	  Enable support for a 52-bit physical address space, introduced as
-	  part of the ARMv8.2-LPA extension.
+	  part of the ARMv8.2-LPA or ARMv8.7-LPA2 extension.
 
 	  With this enabled, the kernel will also continue to work on CPUs that
-	  do not support ARMv8.2-LPA, but with some added memory overhead (and
-	  minor performance overhead).
+	  do not support ARMv8.2-LPA or ARMv8.7-LPA2, but with some added memory
+	  overhead (and minor performance overhead).
 
 endchoice
 
-- 
2.7.4

