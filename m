Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192D03A5F42
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhFNJoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:44:08 -0400
Received: from foss.arm.com ([217.140.110.172]:59044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232579AbhFNJoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:44:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D3181FB;
        Mon, 14 Jun 2021 02:42:02 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.85.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F0733F694;
        Mon, 14 Jun 2021 02:42:00 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Use CONT_PMD_SHIFT for ARM64_MEMSTART_SHIFT
Date:   Mon, 14 Jun 2021 15:12:35 +0530
Message-Id: <1623663755-8949-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64_MEMSTART_SIZE needs to be aligned with CONT_PMD_SIZE on 16K page size
config. Hence just directly use CONT_PMD_SHIFT.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.13-rc6.

 arch/arm64/include/asm/kernel-pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 88b8d681ad91..a848da2b4d90 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -125,7 +125,7 @@
 #if defined(CONFIG_ARM64_4K_PAGES)
 #define ARM64_MEMSTART_SHIFT		PUD_SHIFT
 #elif defined(CONFIG_ARM64_16K_PAGES)
-#define ARM64_MEMSTART_SHIFT		(PMD_SHIFT + 5)
+#define ARM64_MEMSTART_SHIFT		CONT_PMD_SHIFT
 #else
 #define ARM64_MEMSTART_SHIFT		PMD_SHIFT
 #endif
-- 
2.20.1

