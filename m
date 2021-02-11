Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74755318532
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 07:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBKGW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 01:22:59 -0500
Received: from foss.arm.com ([217.140.110.172]:47430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhBKGWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 01:22:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E6CC1396;
        Wed, 10 Feb 2021 22:22:08 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.94.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 804593F73B;
        Wed, 10 Feb 2021 22:22:03 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org, will@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64/hugetlb: Enable HUGETLB_PAGE_SIZE_VARIABLE
Date:   Thu, 11 Feb 2021 11:52:10 +0530
Message-Id: <1613024531-19040-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
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
index f39568b28ec1..8e3a5578f663 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1909,6 +1909,10 @@ config ARCH_ENABLE_THP_MIGRATION
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

