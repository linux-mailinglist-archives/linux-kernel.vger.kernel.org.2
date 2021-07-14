Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD633C7BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbhGNCYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:24:08 -0400
Received: from foss.arm.com ([217.140.110.172]:55752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237580AbhGNCYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:24:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CCC71FB;
        Tue, 13 Jul 2021 19:21:16 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.65.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F1BBA3F7D8;
        Tue, 13 Jul 2021 19:21:12 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC 03/10] arm64/mm: Add FEAT_LPA2 specific TCR_EL1.DS field
Date:   Wed, 14 Jul 2021 07:51:24 +0530
Message-Id: <1626229291-6569-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626229291-6569-1-git-send-email-anshuman.khandual@arm.com>
References: <1626229291-6569-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per ARM ARM (0487G.A) TCR_EL1.DS fields controls whether 52 bit input
and output address get supported on 4K and 16K page size configuration,
when FEAT_LPA2 is known to have been implemented. This adds TCR_DS field
definition which would be used when FEAT_LPA2 gets enabled.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 66671ff..1eb5574 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -275,6 +275,7 @@
 #define TCR_E0PD1		(UL(1) << 56)
 #define TCR_TCMA0		(UL(1) << 57)
 #define TCR_TCMA1		(UL(1) << 58)
+#define TCR_DS			(UL(1) << 59)
 
 /*
  * TTBR.
-- 
2.7.4

