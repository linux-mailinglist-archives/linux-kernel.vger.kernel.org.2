Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC283E1C1E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhHETGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:06:19 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:40991 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242142AbhHETEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 39C435810C0;
        Thu,  5 Aug 2021 15:03:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 05 Aug 2021 15:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=Wc0GbL6NTbU4P
        ARfHU3RQzdhaDIhKKBfKRDAFccFqtg=; b=Ryn5X3bXridco5AVtFQnjx1sBJgN+
        i0WN0ZlrHQY24/6dWbGmZlBP5f+R1hCAooamyTV2td/YJdtB0D48TdX+CrCcrv5J
        fBqNkSldXCisN2TyzlAn/jd3xfwgS3DvtcCcwTzPdQiK6Pnu5zGPNoll5+WfY1sX
        cizJiEKtN5BskiTXIINYptCOBvh/B4WhrebIB0wDIBDjdXXWZyaiuyc5DX6GCOq1
        tFE4Eio+7r5rPV3O8xb6W5xGhw6qNzF1AFQ4a7qwUg9M5QSRitrJN1Bl1mhrdwHx
        rUvgf8VJr6qAq5YKfY8A0eE8IWmECcqT84UOalmBbrO4OK6/N/hRe0IiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Wc0GbL6NTbU4PARfHU3RQzdhaDIhKKBfKRDAFccFqtg=; b=HjLaHum4
        z+hmthhaW4rvC0GeGl9U5UYBcmA90+RQv9sCg6rMXHd1ZlYPVuSxt71+e7RNUKD0
        qIeGa+HDZkRYHcB/Fhxjh7knYdxN0hJCHRT91drZUP6AAxQscn17ZiVm5Xn/K6E9
        aJpA4zMfDIBgormznM23Try4ZqJ5YOTHNR8HHnVlE3pg2Pf2KSY/S2aLjG+xykHb
        Kou1tXaeQ2ZzrvuQIROGJesn60DmnuEScMZFaQFgP/ySyCowFAexIsgIjT9l+GSg
        2URe3BzG1ig9qat9r7NF7QrS3MeLNKUrt4p7bmwtC93DTTlVahtGcN+yKL32RHrD
        24g7hHJ33EIP4A==
X-ME-Sender: <xms:HDYMYVk7LPcI9jl5CSuHBLV_gBkuKinGd2y-ATOLeokS4JlyPjHZuA>
    <xme:HDYMYQ1XKSdIE757rufolagX1UHrSbZeomZx1kO6DMpR75B4KAF-iTPSwHcSWqDN6
    pA8iovIcC8f4N9ePg>
X-ME-Received: <xmr:HDYMYboWLE72og3iEJEY5MrrykVUyOlqG1gVLcZiu8G5WD0Yc8jCl11kuyVYnRloKSEb_Rp2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:HDYMYVk1jGmEg7t41xCh6ieigHGvK3kQW8TizR5nSCgfcPshShYb9Q>
    <xmx:HDYMYT1x8IAndSEEpLdXnQdVKCIWPGyIrdEIPo0tlEKaftKBNdALqQ>
    <xmx:HDYMYUuhP7ehHGfhxvKWfVRafch4zLWW4_PDtuJClufpvzScAGmI7A>
    <xmx:HTYMYdORrFrikq5fpA6Xqfue4h7xa9J6zCejuO9gQURSa8jY8_D0MA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 15:03:56 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH 14/15] mm: introduce MIN_MAX_ORDER to replace MAX_ORDER as compile time constant.
Date:   Thu,  5 Aug 2021 15:02:52 -0400
Message-Id: <20210805190253.2795604-15-zi.yan@sent.com>
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

For other MAX_ORDER uses (described below), there is no need or too much
hassle to convert certain static array to dynamic ones. Add
MIN_MAX_ORDER to serve as compile time constant in place of MAX_ORDER.

ARM64 hypervisor maintains its own free page list and does not import
any core kernel symbols, so soon-to-be runtime variable MAX_ORDER is not
accessible in ARM64 hypervisor code. Also there is no need to allocating
very large pages.

In SLAB/SLOB/SLUB, 2-D array kmalloc_caches uses MAX_ORDER in its second
dimension. It is too much hassle to allocate memory for kmalloc_caches
before any proper memory allocator is set up.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Quentin Perret <qperret@google.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h | 2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 3 ++-
 include/linux/mmzone.h                | 3 +++
 include/linux/slab.h                  | 8 ++++----
 mm/slab.c                             | 2 +-
 mm/slub.c                             | 7 ++++---
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/inc=
lude/nvhe/gfp.h
index fb0f523d1492..c774b4a98336 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -16,7 +16,7 @@ struct hyp_pool {
 	 * API at EL2.
 	 */
 	hyp_spinlock_t lock;
-	struct list_head free_area[MAX_ORDER];
+	struct list_head free_area[MIN_MAX_ORDER];
 	phys_addr_t range_start;
 	phys_addr_t range_end;
 	unsigned short max_order;
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe=
/page_alloc.c
index 41fc25bdfb34..a1cc1b648de0 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -226,7 +226,8 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsig=
ned int nr_pages,
 	int i;
=20
 	hyp_spin_lock_init(&pool->lock);
-	pool->max_order =3D min(MAX_ORDER, get_order(nr_pages << PAGE_SHIFT));
+
+	pool->max_order =3D min(MIN_MAX_ORDER, get_order(nr_pages << PAGE_SHIFT));
 	for (i =3D 0; i < pool->max_order; i++)
 		INIT_LIST_HEAD(&pool->free_area[i]);
 	pool->range_start =3D phys;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 09aafc05aef4..379dada82d4b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -27,11 +27,14 @@
 #ifndef CONFIG_ARCH_FORCE_MAX_ORDER
 #ifdef CONFIG_SET_MAX_ORDER
 #define MAX_ORDER CONFIG_SET_MAX_ORDER
+#define MIN_MAX_ORDER CONFIG_SET_MAX_ORDER
 #else
 #define MAX_ORDER 11
+#define MIN_MAX_ORDER MAX_ORDER
 #endif /* CONFIG_SET_MAX_ORDER */
 #else
 #define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
+#define MIN_MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
 #endif /* CONFIG_ARCH_FORCE_MAX_ORDER */
 #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
=20
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 2c0d80cca6b8..d8747c158db6 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -244,8 +244,8 @@ static inline void __check_heap_object(const void *ptr,=
 unsigned long n,
  * to do various tricks to work around compiler limitations in order to
  * ensure proper constant folding.
  */
-#define KMALLOC_SHIFT_HIGH	((MAX_ORDER + PAGE_SHIFT - 1) <=3D 25 ? \
-				(MAX_ORDER + PAGE_SHIFT - 1) : 25)
+#define KMALLOC_SHIFT_HIGH	((MIN_MAX_ORDER + PAGE_SHIFT - 1) <=3D 25 ? \
+				(MIN_MAX_ORDER + PAGE_SHIFT - 1) : 25)
 #define KMALLOC_SHIFT_MAX	KMALLOC_SHIFT_HIGH
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	5
@@ -258,7 +258,7 @@ static inline void __check_heap_object(const void *ptr,=
 unsigned long n,
  * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
  */
 #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
-#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
+#define KMALLOC_SHIFT_MAX	(MIN_MAX_ORDER + PAGE_SHIFT - 1)
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	3
 #endif
@@ -271,7 +271,7 @@ static inline void __check_heap_object(const void *ptr,=
 unsigned long n,
  * be allocated from the same page.
  */
 #define KMALLOC_SHIFT_HIGH	PAGE_SHIFT
-#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
+#define KMALLOC_SHIFT_MAX	(MIN_MAX_ORDER + PAGE_SHIFT - 1)
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	3
 #endif
diff --git a/mm/slab.c b/mm/slab.c
index d0f725637663..0041de8ec0e9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -466,7 +466,7 @@ static int __init slab_max_order_setup(char *str)
 {
 	get_option(&str, &slab_max_order);
 	slab_max_order =3D slab_max_order < 0 ? 0 :
-				min(slab_max_order, MAX_ORDER - 1);
+				min(slab_max_order, MIN_MAX_ORDER - 1);
 	slab_max_order_set =3D true;
=20
 	return 1;
diff --git a/mm/slub.c b/mm/slub.c
index b6c5205252eb..228e4a77c678 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3564,8 +3564,9 @@ static inline int calculate_order(unsigned int size)
 	/*
 	 * Doh this slab cannot be placed using slub_max_order.
 	 */
-	order =3D slab_order(size, 1, MAX_ORDER, 1);
-	if (order < MAX_ORDER)
+
+	order =3D slab_order(size, 1, MIN_MAX_ORDER, 1);
+	if (order < MIN_MAX_ORDER)
 		return order;
 	return -ENOSYS;
 }
@@ -4079,7 +4080,7 @@ __setup("slub_min_order=3D", setup_slub_min_order);
 static int __init setup_slub_max_order(char *str)
 {
 	get_option(&str, (int *)&slub_max_order);
-	slub_max_order =3D min(slub_max_order, (unsigned int)MAX_ORDER - 1);
+	slub_max_order =3D min(slub_max_order, (unsigned int)MIN_MAX_ORDER - 1);
=20
 	return 1;
 }
--=20
2.30.2

