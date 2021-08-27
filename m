Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BAC3FA028
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhH0T4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:56:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:26658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231259AbhH0T4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:56:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="218024428"
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="218024428"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 12:55:56 -0700
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="528422078"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 12:55:55 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 3/6] x86/sgx: Initial poison handling for dirty and free pages
Date:   Fri, 27 Aug 2021 12:55:40 -0700
Message-Id: <20210827195543.1667168-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210827195543.1667168-1-tony.luck@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
 <20210827195543.1667168-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory controller patrol scrubber can report poison in a page
that isn't currently being used.

Add "poison" field in the sgx_epc_page that can be set for an
sgx_epc_page. Check for it:
1) When sanitizing dirty pages
2) When freeing epc pages

Poison is a new field separated from flags to avoid having to make
all updates to flags atomic, or integrate poison state changes into
some other locking scheme to protect flags.

In both cases place the poisoned page on a list of poisoned epc pages
to make sure it will not be reallocated.

Add debugfs files /sys/kernel/debug/sgx/poison_page_list so that system
administrators get a list of those pages that have been dropped because
of poison.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 30 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h  |  3 ++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 261f81b3f8af..c08df4e35ff0 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
 
+#include <linux/debugfs.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
 #include <linux/highmem.h>
@@ -43,6 +44,7 @@ static nodemask_t sgx_numa_mask;
 static struct sgx_numa_node *sgx_numa_nodes;
 
 static LIST_HEAD(sgx_dirty_page_list);
+static LIST_HEAD(sgx_poison_page_list);
 
 /*
  * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
@@ -62,6 +64,12 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
 
 		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
 
+		if (page->poison) {
+			list_del(&page->list);
+			list_add(&page->list, &sgx_poison_page_list);
+			continue;
+		}
+
 		ret = __eremove(sgx_get_epc_virt_addr(page));
 		if (!ret) {
 			/*
@@ -626,7 +634,10 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	spin_lock(&node->lock);
 
 	page->private = NULL;
-	list_add_tail(&page->list, &node->free_page_list);
+	if (page->poison)
+		list_add(&page->list, &sgx_poison_page_list);
+	else
+		list_add_tail(&page->list, &node->free_page_list);
 	sgx_nr_free_pages++;
 
 	spin_unlock(&node->lock);
@@ -657,6 +668,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
 		section->pages[i].flags = 0;
+		section->pages[i].poison = 0;
 		section->pages[i].private = "dirty";
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
@@ -801,8 +813,21 @@ int sgx_set_attribute(unsigned long *allowed_attributes,
 }
 EXPORT_SYMBOL_GPL(sgx_set_attribute);
 
+static int poison_list_show(struct seq_file *m, void *private)
+{
+	struct sgx_epc_page *page;
+
+	list_for_each_entry(page, &sgx_poison_page_list, list)
+		seq_printf(m, "0x%lx\n", sgx_get_epc_phys_addr(page));
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(poison_list);
+
 static int __init sgx_init(void)
 {
+	struct dentry *dir;
 	int ret;
 	int i;
 
@@ -834,6 +859,9 @@ static int __init sgx_init(void)
 	if (sgx_vepc_init() && ret)
 		goto err_provision;
 
+	dir = debugfs_create_dir("sgx", arch_debugfs_dir);
+	debugfs_create_file("poison_page_list", 0400, dir, NULL, &poison_list_fops);
+
 	return 0;
 
 err_provision:
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 6a55b1971956..77f3d98c9fbf 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -28,7 +28,8 @@
 
 struct sgx_epc_page {
 	unsigned int section;
-	int flags;
+	u16 flags;
+	u16 poison;
 	union {
 		void *private;
 		struct sgx_encl_page *owner;
-- 
2.29.2

