Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6129235732A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354857AbhDGR1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343919AbhDGR1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:27:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FDBB61359;
        Wed,  7 Apr 2021 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617816411;
        bh=DhbGFoc2tNGeP0tnKLDNLimXwoIro9RVSE4cWO0Vdus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zxf+EsWB4V/UE+Z5y0MJ/Dh3pf/TdjmOO5kxVWQkJpLZKnAifCdKg0Z+/cihJwlNZ
         PXSadzWl+VIfCjEuuk99vkCqrgXJ8ERt5Pq7gx6y0FUiUXGLM0qAORx7NtTZlFAmaa
         f55mSZ4mCcMvLqsnlPOCobv0CXMaKootC9Kw9j8S25C6LQ4Jr372eKmbPcmRwSds6V
         yi8+03DyG/w8IRr6FsyYqmrNMtkKg6r0Ify7KnkQoUsbYvb3okHWeCieen7UK6lw47
         lWV2bLzDCom2S/SbT6K6xOEgaDOOKVQBOHZ9WDWvx7pInfBPJbW7U1O50Woeeu41q1
         x1g/MD8UAwZyA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC/RFT PATCH 3/3] arm64: drop pfn_valid_within() and simplify pfn_valid()
Date:   Wed,  7 Apr 2021 20:26:07 +0300
Message-Id: <20210407172607.8812-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210407172607.8812-1-rppt@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
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
index 258b1905ed4a..bb6dd406b1f0 100644
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

