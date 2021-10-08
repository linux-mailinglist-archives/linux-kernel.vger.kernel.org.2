Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02AE42725A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243026AbhJHUfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231579AbhJHUfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C4B560F5A;
        Fri,  8 Oct 2021 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633725215;
        bh=S6Dg7a7PNNy4f3QJ3GpgWjmhsNNkFfEZ3pQcGRy11jw=;
        h=From:To:Cc:Subject:Date:From;
        b=l/mLinhdiwApAhNkbfRl2eSnOqoKDDPPsWOKvc+mEtwopPtJ4+7z65L//M705x89Z
         CuYm7z+bwT5JCE08+oLj8U1H3sUgn4Uo+a3lhPJcSwDF/sTeKjhTuMBYbclwAw/8vc
         ZMFVZKNg/QL8032wGvDFz9UzavWV2gH1kTbXdxyVIvHTKeaglieagceXgIJ57KGizg
         3XLre7QX3gA+k1NrT/pICCu8XHJZs0XMwQVR8a7c0Ldp14L8ufDM2MeCn16hH2o/VW
         gUOvcCDxKF07IOw8fj8Bks1sDHBjvA8riKMHdlHt9Pkdw+z3CwO76jWAQdZLwMbiVJ
         bpSLkZJ3wqjoA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     reinette.chatre@intel.com, tony.luck@intel.com,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] x86/sgx: Rename fallback labels in sgx_init()
Date:   Fri,  8 Oct 2021 23:33:07 +0300
Message-Id: <20211008203308.20963-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's hard to add new content to this function because it is time
consuming to match fallback and its cause. Rename labels in a way
that the name of error label refers to the site where failure
happened. This way it is easier to keep on track what is going
on.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v5:
* A new patch.
---
 arch/x86/kernel/cpu/sgx/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 63d3de02bbcc..a6e313f1a82d 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -803,12 +803,12 @@ static int __init sgx_init(void)
 
 	if (!sgx_page_reclaimer_init()) {
 		ret = -ENOMEM;
-		goto err_page_cache;
+		goto err_reclaimer;
 	}
 
 	ret = misc_register(&sgx_dev_provision);
 	if (ret)
-		goto err_kthread;
+		goto err_provision;
 
 	/*
 	 * Always try to initialize the native *and* KVM drivers.
@@ -821,17 +821,17 @@ static int __init sgx_init(void)
 	ret = sgx_drv_init();
 
 	if (sgx_vepc_init() && ret)
-		goto err_provision;
+		goto err_driver;
 
 	return 0;
 
-err_provision:
+err_driver:
 	misc_deregister(&sgx_dev_provision);
 
-err_kthread:
+err_provision:
 	kthread_stop(ksgxd_tsk);
 
-err_page_cache:
+err_reclaimer:
 	for (i = 0; i < sgx_nr_epc_sections; i++) {
 		vfree(sgx_epc_sections[i].pages);
 		memunmap(sgx_epc_sections[i].virt_addr);
-- 
2.25.1

