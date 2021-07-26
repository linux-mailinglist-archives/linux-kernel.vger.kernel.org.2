Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866043D534A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhGZF5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:57:08 -0400
Received: from foss.arm.com ([217.140.110.172]:45692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232216AbhGZF5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:57:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C07FC139F;
        Sun, 25 Jul 2021 23:37:35 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C988D3F66F;
        Sun, 25 Jul 2021 23:37:31 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V2 10/10] arm64/mm: Enable CONFIG_ARM64_PA_BITS_52 on CONFIG_ARM64_[4K|16K]_PAGES
Date:   Mon, 26 Jul 2021 12:07:25 +0530
Message-Id: <1627281445-12445-11-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All required FEAT_LPA2 components for 52 bit PA range are already in place.
Just enable CONFIG_ARM64_PA_BITS_52 on 4K and 16K pages which would select
CONFIG_ARM64_PA_BITS_52_LPA2 activating 52 bit PA range via FEAT_LPA2.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1999ac6..ce139415 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -952,9 +952,9 @@ config ARM64_PA_BITS_48
 
 config ARM64_PA_BITS_52
 	bool "52-bit (ARMv8.2)"
-	depends on ARM64_64K_PAGES
 	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	select ARM64_PA_BITS_52_LPA if ARM64_64K_PAGES
+	select ARM64_PA_BITS_52_LPA2 if (ARM64_4K_PAGES  || ARM64_16K_PAGES)
 	help
 	  Enable support for a 52-bit physical address space, introduced as
 	  part of the ARMv8.2-LPA extension.
-- 
2.7.4

