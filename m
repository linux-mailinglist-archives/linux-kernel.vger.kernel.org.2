Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190D73E1C1B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbhHETGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:06:14 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:55877 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242235AbhHETEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:09 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 17EEE5810BB;
        Thu,  5 Aug 2021 15:03:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 05 Aug 2021 15:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=orYSo+lwOeqVc
        rCXP6bMLdXhBxG79CHa8pLqvu93F90=; b=JLiPNY0alezfanhcEGypspe2ruEbc
        +S3RVW03KEkS07YejHfFIg6iCZiCQsu9h5DwzMb0jG/b0FrkS4c9Y/NdKeacdvTK
        5IEMf1NOtxdyT73Rrqkne+wzqMExrCYGUhVRLM03HCgH5m3P+z644LCalPwbCIVm
        pRvg3/y4tHPT7QOKLXK7FYSnNes3rxiWEY2Fen+iycw4IPFF11hOpw2BCMjH5s6z
        h5CWBKWlUi+I5CIkqwWeoiOd5Brg/GLBCxFsUeeC1gqF3j1D29yY23T4ZAfbI2fn
        9TUNpofZvkpjxrWCLsbmytqsxyFTB838/bJYc4+xyvgFCm88NUZWSPgqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=orYSo+lwOeqVcrCXP6bMLdXhBxG79CHa8pLqvu93F90=; b=tvn74sNC
        FppmdcuF0YkjcIsFmOlGO1oUWpkEbiGuwrgia1EXDOKlIC/zLyaHOHfhbYtbhkWN
        7g8yMwgdPehka5KZaWsaChTzPoZKaUEQj1pJxR/gAF+2F20xDi5lM8YPawRtracc
        QWoEsFmHsl199Ji6XBbG7EfaBsygOXf8YUMjjuymzwm1BOUVI1kFPP+vjzdxsBVL
        yqzrJZtkow5KsmlTgNLtGxS7UPkMG8UZhiFB+QFdtaZ6hceTPyMdsIRgdk94f6lc
        tuA3WgTCU4tme0WjeqbcAd9Nj178lT6Q7iAFqheIt/2/RpgDVTGcRrKUOq03SUNa
        Ib0cAzncyRmNKQ==
X-ME-Sender: <xms:GjYMYblLQyvLZp_im3A4fUPXsv23VUERHObmLyW7BuOD5wP9KPTXdg>
    <xme:GjYMYe2PMWY06JRym_891cI4jeQkNR0Waxz9GxSab5qjHhQYMfDB_8f09wf8SK0vl
    a8Qogx5_bB9rKysgg>
X-ME-Received: <xmr:GjYMYRqORTbgLIfZ8TjjZbAP2euIOS8PINIKEpQkgNWzM5b3UE7GJFMy4UM_CQGBmuTU0cSV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:GjYMYTlJJGrF43OPYNoVtwdTSVlisgWa3hS9DyaUKdTWtAbDl_VTlw>
    <xmx:GjYMYZ0nDPbKL7-mTw9EM97dDsICkSS1kIlZXFyVTruRvNXhNW_9Ww>
    <xmx:GjYMYSuIZtpiENpMWAvpQxDhmJfsokuAMjpq1SyK6_JD--ocpYJzag>
    <xmx:GzYMYXNN1zvq4GhORLnR5Mt44bIzcjmGUtYwHmiQIHvd4hv0pEy6xQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 15:03:54 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 12/15] mm: Make MAX_ORDER of buddy allocator configurable via Kconfig SET_MAX_ORDER.
Date:   Thu,  5 Aug 2021 15:02:50 -0400
Message-Id: <20210805190253.2795604-13-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210805190253.2795604-1-zi.yan@sent.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

With SPARSEMEM_VMEMMAP, all struct page are virtually contigous,
thus kernel can manipulate arbitrarily large pages. By checking
PFN validity during buddy page merging process, all free pages in buddy
allocator's free area have their PFNs contiguous even if the system has
several not physically contiguous memory sections. With these two
conditions, it is OK to remove the restriction of
MAX_ORDER - 1 + PAGE_SHIFT < SECTION_SIZE_BITS and change MAX_ORDER
freely.

Add SET_MAX_ORDER to allow MAX_ORDER adjustment when arch does not set
its own MAX_ORDER via ARCH_FORCE_MAX_ORDER. Make it depend
on SPARSEMEM_VMEMMAP, when MAX_ORDER is not limited by SECTION_SIZE_BITS.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 arch/Kconfig           |  4 ++++
 include/linux/mmzone.h | 14 +++++++++++++-
 mm/Kconfig             | 16 ++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 01a3f8048cb7..40bd222adeb8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -11,6 +11,10 @@ source "arch/$(SRCARCH)/Kconfig"
=20
 menu "General architecture-dependent options"
=20
+config ARCH_FORCE_MAX_ORDER
+    int
+    default "0"
+
 config CRASH_CORE
 	bool
=20
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 04f790ed81b7..322b995942e5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -25,10 +25,14 @@
=20
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_ARCH_FORCE_MAX_ORDER
+#ifdef CONFIG_SET_MAX_ORDER
+#define MAX_ORDER CONFIG_SET_MAX_ORDER
+#else
 #define MAX_ORDER 11
+#endif /* CONFIG_SET_MAX_ORDER */
 #else
 #define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
-#endif
+#endif /* CONFIG_ARCH_FORCE_MAX_ORDER */
 #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
=20
 /*
@@ -1245,12 +1249,20 @@ static inline struct zoneref *first_zones_zonelist(=
struct zonelist *zonelist,
 #define SECTION_BLOCKFLAGS_BITS \
 	((1UL << (PFN_SECTION_SHIFT - pageblock_order)) * NR_PAGEBLOCK_BITS)
=20
+/*
+ * The MAX_ORDER check is not necessary when CONFIG_SET_MAX_ORDER is set, =
since
+ * it depends on CONFIG_SPARSEMEM_VMEMMAP, where all struct page are virtu=
ally
+ * contiguous, thus > section size pages can be allocated and manipulated
+ * without worrying about non-contiguous struct page.
+ */
+#ifndef CONFIG_SET_MAX_ORDER
 /* NO_MAX_ORDER_CHECK when compiling x64 32bit VDSO for 64bit system */
 #ifndef NO_MAX_ORDER_CHECK
 #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
 #endif /* NO_MAX_ORDER_CHECK */
+#endif /* CONFIG_SET_MAX_ORDER*/
=20
 static inline unsigned long pfn_to_section_nr(unsigned long pfn)
 {
diff --git a/mm/Kconfig b/mm/Kconfig
index 1f9bd3371765..3a030b439501 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -89,6 +89,22 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.
=20
+config SET_MAX_ORDER
+	int "Set maximum order of buddy allocator"
+    depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER =3D 0)
+	range 11 255
+	default "11"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 11 means that the largest free memory block is 2^10 pages.
+
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
=20
--=20
2.30.2

