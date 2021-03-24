Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E447F347BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhCXPKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbhCXPJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:09:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6311CC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GIPWMzY1eO6+8dI6aOLX4t4C8NfhMLlIzQAR1wFUDnE=; b=bMEFQJ7WZrulsAqxvuRM2BZzDI
        lYxhlKV2CO49u+/hjZ9uj2pTNZLQZAUmXCjuuXD/wlzLyfI6Jz5HYRfJihKJB+NUlIoiNkGqf9IDZ
        hrh3nApEyZwPJ7Brx0HaTPdqfWuDm/DoxMayp0B6E4TlrOFnijaVlfplDs30v+0tEzhTHWVYOhM9A
        FeJ8VrgT7JBW4uwk3bNQwh6sUOvp0SWWbnkWQMEiYh0/U6KWIdnFrwC675xy6IpPtS6JAwJ7hVDX1
        o1s/Qb/hYhvQvBQLrX/0bqe/RVH2e5l3ZbwEiH2sMUOJIqOlhiEkBBJyukluKtFvkt72wfesdEI1e
        58hMDvJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lP570-00BUQZ-KA; Wed, 24 Mar 2021 15:08:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 4/4] MAINTAINERS: Add Vlad Rezki as vmalloc maintainer
Date:   Wed, 24 Mar 2021 15:05:18 +0000
Message-Id: <20210324150518.2734402-5-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210324150518.2734402-1-willy@infradead.org>
References: <20210324150518.2734402-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People should know to cc Vlad on vmalloc-related patches.  With this,
get-maintainer.pl suggests:

Uladzislau Rezki <urezki@gmail.com> (maintainer:VMALLOC)
Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT)
linux-mm@kvack.org (open list:VMALLOC)
linux-kernel@vger.kernel.org (open list)

which looks appropriate to me.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 MAINTAINERS                   | 7 +++++++
 arch/arm64/kernel/module.c    | 3 +--
 arch/arm64/net/bpf_jit_comp.c | 3 +--
 arch/parisc/kernel/module.c   | 5 ++---
 arch/x86/hyperv/hv_init.c     | 3 +--
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c44fd8fd85d..8b9cb5525cb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19282,6 +19282,13 @@ S:	Maintained
 F:	drivers/vlynq/vlynq.c
 F:	include/linux/vlynq.h
 
+VMALLOC
+M:	Uladzislau Rezki <urezki@gmail.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	mm/vmalloc.c
+F:	include/linux/vmalloc.h
+
 VME SUBSYSTEM
 M:	Martyn Welch <martyn@welchs.me.uk>
 M:	Manohar Vanga <manohar.vanga@gmail.com>
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index fa4186459927..5e31bc901631 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -53,8 +53,7 @@ void *module_alloc(unsigned long size)
 		 */
 		p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
 				module_alloc_base + SZ_2G, GFP_KERNEL,
-				PAGE_KERNEL, 0, NUMA_NO_NODE,
-				_RET_IP_);
+				PAGE_KERNEL, 0, NUMA_NO_NODE, _RET_IP_);
 
 	if (p && (kasan_module_alloc(p, size) < 0)) {
 		vfree(p);
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8aca5bf74685..f3a6c1b49c4e 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1133,8 +1133,7 @@ void *bpf_jit_alloc_exec(unsigned long size)
 {
 	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
 				    BPF_JIT_REGION_END, GFP_KERNEL,
-				    PAGE_KERNEL, 0, NUMA_NO_NODE,
-				    _RET_IP_);
+				    PAGE_KERNEL, 0, NUMA_NO_NODE, _RET_IP_);
 }
 
 void bpf_jit_free_exec(void *addr)
diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index 320807f755a7..7181c4f99059 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -198,9 +198,8 @@ void *module_alloc(unsigned long size)
 	 * easier than trying to map the text, data, init_text and
 	 * init_data correctly */
 	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
-				    GFP_KERNEL,
-				    PAGE_KERNEL_RWX, 0, NUMA_NO_NODE,
-				    _RET_IP_);
+				    GFP_KERNEL, PAGE_KERNEL_RWX, 0,
+				    NUMA_NO_NODE, _RET_IP_);
 }
 
 #ifndef CONFIG_64BIT
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 4866351282b0..a256a955d05f 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -427,8 +427,7 @@ void __init hyperv_init(void)
 
 	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
 			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
-			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
-			_RET_IP_);
+			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE, _RET_IP_);
 	if (hv_hypercall_pg == NULL) {
 		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 		goto remove_cpuhp_state;
-- 
2.30.2

