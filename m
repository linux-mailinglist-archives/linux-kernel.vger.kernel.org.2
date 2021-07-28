Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8C13D9706
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhG1UrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:47:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:60188 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231633AbhG1UrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:47:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="234634459"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="234634459"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 13:47:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="506679872"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 13:47:01 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 1/7] x86/sgx: Provide indication of life-cycle of EPC pages
Date:   Wed, 28 Jul 2021 13:46:47 -0700
Message-Id: <20210728204653.1509010-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210728204653.1509010-1-tony.luck@intel.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGX EPC pages go through the following life cycle:

	DIRTY ---> FREE ---> IN-USE --\
                    ^                 |
                    \-----------------/

Recovery action for poison for a DIRTY or FREE page is simple. Just
make sure never to allocate the page. IN-USE pages need some extra
handling.

It would be good to use the sgx_epc_page->owner field as an indicator
of where an EPC page is currently in that cycle (owner != NULL means
the EPC page is IN-USE). But there is one caller, sgx_alloc_va_page(),
that calls with NULL.

Make the following changes:

1) Change the type of "owner" to "void *" (it can have other types
   besides "struct sgx_encl_page *).
2) Add a check to sgx_free_epc_page(). If the caller specified the
   owner as NULL, then set the owner field to self-reference the
   SGX epc page itself.
3) Reset owner to NULL in sgx_free_epc_page().

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 3 ++-
 arch/x86/kernel/cpu/sgx/sgx.h  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 63d3de02bbcc..17d09186a6c2 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -581,7 +581,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 	for ( ; ; ) {
 		page = __sgx_alloc_epc_page();
 		if (!IS_ERR(page)) {
-			page->owner = owner;
+			page->owner = owner ? owner : page;
 			break;
 		}
 
@@ -624,6 +624,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 
 	spin_lock(&node->lock);
 
+	page->owner = NULL;
 	list_add_tail(&page->list, &node->free_page_list);
 	sgx_nr_free_pages++;
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 4628acec0009..4e1a410b8a62 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -29,7 +29,7 @@
 struct sgx_epc_page {
 	unsigned int section;
 	unsigned int flags;
-	struct sgx_encl_page *owner;
+	void *owner;
 	struct list_head list;
 };
 
-- 
2.29.2

