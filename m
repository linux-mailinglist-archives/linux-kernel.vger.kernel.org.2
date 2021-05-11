Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B53837A448
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhEKKH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231432AbhEKKHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:07:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F138E61939;
        Tue, 11 May 2021 10:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620727575;
        bh=SlugFhiHPFE6544Op5mwYlOkGJajxXxh97whxO6/BpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYDF4IQVMwKctvrPMNf95/Pi4DLD45vn6Bg51bGOwMZencaGiwj43fkKPQm08bIwu
         DW9MDtK5hN9JDa0rWQ4zWqCsuTlu+Wl7qkZwUObbIm+xN9ndU6m3MiOMBDRowd5d6S
         1k/2vv/YoYPPXlm2tyD6M2BU4/wVFX7FOfcb9nU9G4F3berrlBwG0srn9nJ6Wc9AQK
         WZiOsUaUxrSlRrqmQvV2ieZsfBfn5FxYmLPBoAsLStxaRckXJR7h7yUFFU3K28jFWe
         c1+klc10Szz9z2s/c0OcwmBRJkQQKgKUR+dVkXDmqrq2kPmqZKUDXTSNMgnIkcUpjc
         X5xLsM/+3/ZVg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 4/4] arm64: drop pfn_valid_within() and simplify pfn_valid()
Date:   Tue, 11 May 2021 13:05:50 +0300
Message-Id: <20210511100550.28178-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210511100550.28178-1-rppt@kernel.org>
References: <20210511100550.28178-1-rppt@kernel.org>
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
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/Kconfig   | 3 ---
 arch/arm64/mm/init.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f1d8566bbf9..d7dc8698cf8e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1052,9 +1052,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool y
 	depends on NUMA
 
-config HOLES_IN_ZONE
-	def_bool y
-
 source "kernel/Kconfig.hz"
 
 config ARCH_SPARSEMEM_ENABLE
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 798f74f501d5..fb07218da2c0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -251,7 +251,7 @@ int pfn_valid(unsigned long pfn)
 	if (!early_section(ms))
 		return pfn_section_valid(ms, pfn);
 
-	return memblock_is_map_memory(addr);
+	return memblock_is_memory(addr);
 }
 EXPORT_SYMBOL(pfn_valid);
 
-- 
2.28.0

