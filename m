Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E330ECE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhBDHCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:02:12 -0500
Received: from foss.arm.com ([217.140.110.172]:52862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhBDHCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:02:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA5D1396;
        Wed,  3 Feb 2021 23:01:16 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.94.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 983C73F694;
        Wed,  3 Feb 2021 23:01:12 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/3] arm64/hugetlb: Enable HUGETLB_PAGE_SIZE_VARIABLE
Date:   Thu,  4 Feb 2021 12:31:23 +0530
Message-Id: <1612422084-30429-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612422084-30429-1-git-send-email-anshuman.khandual@arm.com>
References: <1612422084-30429-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_ORDER which invariably depends on FORCE_MAX_ZONEORDER can be a variable
for a given page size, depending on whether TRANSPARENT_HUGEPAGE is enabled
or not. In certain page size and THP combinations HUGETLB_PAGE_ORDER can be
greater than MAX_ORDER, making it unusable as pageblock_order.

This enables HUGETLB_PAGE_SIZE_VARIABLE making pageblock_order a variable
rather than the compile time constant HUGETLB_PAGE_ORDER which could break
MAX_ORDER rule for certain configurations.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 175914f2f340..c4acf8230f20 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1918,6 +1918,10 @@ config ARCH_ENABLE_THP_MIGRATION
 	def_bool y
 	depends on TRANSPARENT_HUGEPAGE
 
+config HUGETLB_PAGE_SIZE_VARIABLE
+	def_bool y
+	depends on HUGETLB_PAGE
+
 menu "Power management options"
 
 source "kernel/power/Kconfig"
-- 
2.20.1

