Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8653D9A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhG2AmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 20:42:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:3511 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232837AbhG2AmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:42:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="193055855"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="193055855"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 17:42:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="506802079"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 17:42:09 -0700
Date:   Wed, 28 Jul 2021 17:42:08 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] x86/sgx: Provide indication of life-cycle of EPC
 pages
Message-ID: <20210729004208.GA1510081@agluck-desk2.amr.corp.intel.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-2-tony.luck@intel.com>
 <17054ca5-0ef7-4b28-ab26-b1b96aa7403f@intel.com>
 <f2685d7c8dc14792a4e0f9807f742ea6@intel.com>
 <fd8f8e79-f63f-7d6f-277e-1ad08ab7b6b8@intel.com>
 <YQHpGq0GyAsYpE+D@google.com>
 <b05acb65cebc4718a5cc2503ced7455d@intel.com>
 <YQHxLG5fSTWPgez6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQHxLG5fSTWPgez6@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 12:07:08AM +0000, Sean Christopherson wrote:
> On Wed, Jul 28, 2021, Luck, Tony wrote:
> > > -       epc_page = sgx_alloc_epc_page(NULL, true);
> > > +       epc_page = sgx_alloc_epc_page(va_page, true);
> > 
> > Providing a real value for the owner seems much better than all the hacks
> > to invent a value to use instead of NULL.
> > 
> > Can you add a "Signed-off-by"? Then I'll replace my part 0001 with your version.

My commit comment (updated to match how the code actually changed).
Sean's code.

N.B. I added the kernel doc entry for the new argument to sgx_alloc_va_page()

+ * @va_page:   struct sgx_va_page connected to this VA page

If you have something better, then I will swap that line out too.

-Tony

From: Sean Christopherson <seanjc@google.com>
Subject: [PATCH] x86/sgx: Provide indication of life-cycle of EPC pages

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

Fix up the one holdout to provide a non-NULL owner.

Also change the type of "owner" to "void *" (since it can have other
types besides "struct sgx_encl_page *").

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c  | 5 +++--
 arch/x86/kernel/cpu/sgx/encl.h  | 2 +-
 arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
 arch/x86/kernel/cpu/sgx/sgx.h   | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 001808e3901c..ad8c61933b0a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -667,6 +667,7 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 
 /**
  * sgx_alloc_va_page() - Allocate a Version Array (VA) page
+ * @va_page:	struct sgx_va_page connected to this VA page
  *
  * Allocate a free EPC page and convert it to a Version Array (VA) page.
  *
@@ -674,12 +675,12 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
  *   a VA page,
  *   -errno otherwise
  */
-struct sgx_epc_page *sgx_alloc_va_page(void)
+struct sgx_epc_page *sgx_alloc_va_page(struct sgx_va_page *va_page)
 {
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(NULL, true);
+	epc_page = sgx_alloc_epc_page(va_page, true);
 	if (IS_ERR(epc_page))
 		return ERR_CAST(epc_page);
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index fec43ca65065..3d12dbeae14a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -111,7 +111,7 @@ void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
 
-struct sgx_epc_page *sgx_alloc_va_page(void);
+struct sgx_epc_page *sgx_alloc_va_page(struct sgx_va_page *va_page);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 83df20e3e633..655ce0bb069d 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -30,7 +30,7 @@ static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 		if (!va_page)
 			return ERR_PTR(-ENOMEM);
 
-		va_page->epc_page = sgx_alloc_va_page();
+		va_page->epc_page = sgx_alloc_va_page(va_page);
 		if (IS_ERR(va_page->epc_page)) {
 			err = ERR_CAST(va_page->epc_page);
 			kfree(va_page);
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

