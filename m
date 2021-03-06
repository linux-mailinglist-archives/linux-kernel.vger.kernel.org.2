Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC632F739
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhCFAVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:21:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:53491 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhCFAVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:21:05 -0500
IronPort-SDR: 1bRadGoNre/Y4iu0SSN1YDmxo9ewz5gGEc/zyg2CgzzVMQddmayoSdiHv7w9EDy7b+l+ombmG+
 DMtViLO7rTnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="167011707"
X-IronPort-AV: E=Sophos;i="5.81,226,1610438400"; 
   d="scan'208";a="167011707"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 16:21:04 -0800
IronPort-SDR: i7QUPl2AxJigkWlqmhiLhr3wBCRlgLJpB3w5+mJnQTkAuaHVlty3YQHmFFAxS5nsY6YW8c1c4X
 nSq9gfVT3Duw==
X-IronPort-AV: E=Sophos;i="5.81,226,1610438400"; 
   d="scan'208";a="408569483"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 16:21:04 -0800
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] x86: Remove unnecessary kmap() from sgx_ioc_enclave_init()
Date:   Fri,  5 Mar 2021 16:20:58 -0800
Message-Id: <20210306002058.303796-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap is inefficient and we are trying to reduce the usage in the kernel.
There is no readily apparent reason why initp_page needs to be allocated
and kmap'ed() but sigstruct needs to be page aligned and token
512 byte aligned.

kmalloc() can give us this alignment but we need to allocate PAGE_SIZE
bytes to do so.  Rather than change this kmap() to kmap_local_page() use
kmalloc() instead.

Remove the alloc_page()/kmap() and replace with kmalloc(PAGE_SIZE, ...)
to get a page aligned kernel address to use.

In addition add a comment to document the alignment requirements so that
others like myself don't attempt to 'fix' this again.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Jethro Beekman <jethro@fortanix.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v4[4]:
	Add Ack and Reviews
	Send to the correct maintainers

Changes from v3[3]:
	Remove BUILD_BUG_ONs

Changes from v2[2]:
        When allocating a power of 2 size kmalloc() now guarantees the
        alignment of the respective size.  So go back to using kmalloc() but
        with a PAGE_SIZE allocation to get the alignment.  This also follows
        the pattern in sgx_ioc_enclave_create()

Changes from v1[1]:
	Use page_address() instead of kcmalloc() to ensure sigstruct is
	page aligned
	Use BUILD_BUG_ON to ensure token and sigstruct don't collide.

[1] https://lore.kernel.org/lkml/20210129001459.1538805-1-ira.weiny@intel.com/
[2] https://lore.kernel.org/lkml/20210202013725.3514671-1-ira.weiny@intel.com/
[3] https://lore.kernel.org/lkml/20210205050850.GC5033@iweiny-DESK2.sc.intel.com/#t
[4] https://lore.kernel.org/lkml/YCBY02iEKLVyj7Ix@kernel.org/

---
 arch/x86/kernel/cpu/sgx/ioctl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 90a5caf76939..38e540de5e2a 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -604,7 +604,6 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
 {
 	struct sgx_sigstruct *sigstruct;
 	struct sgx_enclave_init init_arg;
-	struct page *initp_page;
 	void *token;
 	int ret;
 
@@ -615,11 +614,14 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
 	if (copy_from_user(&init_arg, arg, sizeof(init_arg)))
 		return -EFAULT;
 
-	initp_page = alloc_page(GFP_KERNEL);
-	if (!initp_page)
+	/*
+	 * sigstruct must be on a page boundry and token on a 512 byte boundry
+	 * kmalloc() gives us this alignment when allocating PAGE_SIZE bytes
+	 */
+	sigstruct = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!sigstruct)
 		return -ENOMEM;
 
-	sigstruct = kmap(initp_page);
 	token = (void *)((unsigned long)sigstruct + PAGE_SIZE / 2);
 	memset(token, 0, SGX_LAUNCH_TOKEN_SIZE);
 
@@ -645,8 +647,7 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
 	ret = sgx_encl_init(encl, sigstruct, token);
 
 out:
-	kunmap(initp_page);
-	__free_page(initp_page);
+	kfree(sigstruct);
 	return ret;
 }
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

