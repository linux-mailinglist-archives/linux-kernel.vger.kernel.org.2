Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DCA3A5FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhFNKLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:11:37 -0400
Received: from foss.arm.com ([217.140.110.172]:59472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232579AbhFNKLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:11:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EBC11FB;
        Mon, 14 Jun 2021 03:09:33 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.85.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D719C3F694;
        Mon, 14 Jun 2021 03:09:30 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop SWAPPER_INIT_MAP_SIZE
Date:   Mon, 14 Jun 2021 15:40:11 +0530
Message-Id: <1623665411-20055-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit cdef5f6e9e0e ("arm64: mm: allocate pagetables anywhere") had
dropped the last reference to SWAPPER_INIT_MAP_SIZE. Hence just clean up.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.13-rc6.

 arch/arm64/include/asm/kernel-pgtable.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index a848da2b4d90..1260187adb31 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -100,9 +100,6 @@
 #define SWAPPER_TABLE_SHIFT	PMD_SHIFT
 #endif
 
-/* The size of the initial kernel direct mapping */
-#define SWAPPER_INIT_MAP_SIZE	(_AC(1, UL) << SWAPPER_TABLE_SHIFT)
-
 /*
  * Initial memory map attributes.
  */
-- 
2.20.1

