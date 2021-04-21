Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE643665B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 08:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbhDUGwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 02:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236304AbhDUGwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 02:52:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63128613ED;
        Wed, 21 Apr 2021 06:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618987892;
        bh=15Yty9Stc/s7dDkOEgwIyIbN8ST3TSGYU3qMkcXC9hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmrcFIb08lfBH7VLeugKq4BbEtT6ScBiCAusHWFXcACDAT9opqtVqCujIpyrOKLH6
         HmEMAvcHI/0+ziMxSNgj7LAnWtjlra9aVXMDDZgbt6gxW73TntknR63NiRjV7E+YPB
         2FeVpn/9oGhfE6uGETTV12ae5sk0dIXAc3hWUamjsew5hccK6HCjX+/V/S5rHE+EXj
         gu3G/Ez8OOl4UFKHMqPV15Ycke5deiFTulaN4l2hXOXl4s74Tb6aIeYzh7NkgShF60
         aeG8U7oUpz5xSpmhsQdZlkFEHobmPMmkiunZI+xgWK5kpoKT9dnC5/TmjhQz1LYQzK
         nVWz+T/5RCEFA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 4/4] arm64: drop pfn_valid_within() and simplify pfn_valid()
Date:   Wed, 21 Apr 2021 09:51:08 +0300
Message-Id: <20210421065108.1987-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210421065108.1987-1-rppt@kernel.org>
References: <20210421065108.1987-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The arm64's version of pfn_valid() differs from the generic because of two
reasons:

* Parts of the memory map are freed during boot. This makes it necessary to
  verify that there is actual physical memory that corresponds to a pfn
  which is done by querying memblock.

* There are NOMAP memory regions. These regions are not mapped in the
  linear map and until the previous commit the struct pages representing
  these areas had default values.

As the consequence of absence of the special treatment of NOMAP regions in
the memory map it was necessary to use memblock_is_map_memory() in
pfn_valid() and to have pfn_valid_within() aliased to pfn_valid() so that
generic mm functionality would not treat a NOMAP page as a normal page.

Since the NOMAP regions are now marked as PageReserved(), pfn walkers and
the rest of core mm will treat them as unusable memory and thus
pfn_valid_within() is no longer required at all and can be disabled by
removing CONFIG_HOLES_IN_ZONE on arm64.

pfn_valid() can be slightly simplified by replacing
memblock_is_map_memory() with memblock_is_memory().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/Kconfig   | 3 ---
 arch/arm64/mm/init.c | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e4e1b6550115..58e439046d05 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1040,9 +1040,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool y
 	depends on NUMA
 
-config HOLES_IN_ZONE
-	def_bool y
-
 source "kernel/Kconfig.hz"
 
 config ARCH_SPARSEMEM_ENABLE
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index dc03bdc12c0f..eb3f56fb8c7c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -243,7 +243,7 @@ int pfn_valid(unsigned long pfn)
 
 	/*
 	 * ZONE_DEVICE memory does not have the memblock entries.
-	 * memblock_is_map_memory() check for ZONE_DEVICE based
+	 * memblock_is_memory() check for ZONE_DEVICE based
 	 * addresses will always fail. Even the normal hotplugged
 	 * memory will never have MEMBLOCK_NOMAP flag set in their
 	 * memblock entries. Skip memblock search for all non early
@@ -254,7 +254,7 @@ int pfn_valid(unsigned long pfn)
 		return pfn_section_valid(ms, pfn);
 }
 #endif
-	return memblock_is_map_memory(addr);
+	return memblock_is_memory(addr);
 }
 EXPORT_SYMBOL(pfn_valid);
 
-- 
2.28.0

