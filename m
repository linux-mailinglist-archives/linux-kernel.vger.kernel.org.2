Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAE330FBFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbhBDSwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbhBDSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:46:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A7C06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:45:28 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 190so4038014wmz.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDlKe0WbpqBDHIpCDDh4FugA9Yl2NTww4rbLOTGr+nM=;
        b=BSD24lcMJFm1yoPHDL+vPC2t6eYWXJl+gb63Lc2kEu4Y6EX8foAiW4INgUcC7527BK
         is+2hBSUdsPg0+Z3aHdGn8s4rSjiYJZI/Wed+PMMBRS5JJPUJEcRXT6pfG8B2lPQ4COf
         jC+i/6A1QM62BytlMc5wKaK52uyyRjCdedByQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDlKe0WbpqBDHIpCDDh4FugA9Yl2NTww4rbLOTGr+nM=;
        b=KYgQSn8HArPqzodh43R452eAkX7YVfqu/jDfszvi6CPl4LgT3RBW2+szLiTZxtnqno
         OeYzfXYjQcM/vq/r3PensxYElIu9ZfxnURJUt/+2FBZb5s9k/6vqBwbbFQha3j2CJ3aY
         w8xrTIFn2sIPlYb+TOOsFlXFx5OC4R+T6Kf+XiLSAuNM96rt17Pr0lJEsWWz9Me/aTK4
         VRUDfO9XYqMqEiBRmW426LDMSVtJ7ixDRzUk+h6QK60m+/9maBraJQ0SiQCrk/taJM9Y
         e2571IurEPv4ismiivRV1J/YBDvBuB1iXBf3bB4JjclvEiN6TpRQLQdJ85/FIba09DRS
         bXqg==
X-Gm-Message-State: AOAM5324eXBZNAQ5TIZIIq44mmgh9P4WAgOPmB4iYhCfAmumHnPTYaA2
        aKVrESVF0d/IDzV04fmGwL2VhYiH+n6S5J5c
X-Google-Smtp-Source: ABdhPJwr8sCr/vTIsvxni8hp5KegeEeUyEeymi2FitAM/6CHsPHduLd2lAH04rBfHoBvmYrzEYKENw==
X-Received: by 2002:a1c:105:: with SMTP id 5mr469215wmb.89.1612464326728;
        Thu, 04 Feb 2021 10:45:26 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m10sm9322997wro.7.2021.02.04.10.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:45:26 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-sgx@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] x86/sgx: Drop racy follow_pfn check
Date:   Thu,  4 Feb 2021 19:45:19 +0100
Message-Id: <20210204184519.2809313-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTE insertion is fundamentally racy, and this check doesn't do
anything useful. Quoting Sean:

"Yeah, it can be whacked.  The original, never-upstreamed code asserted that the
resolved PFN matched the PFN being installed by the fault handler as a sanity
check on the SGX driver's EPC management.  The WARN assertion got dropped for
whatever reason, leaving that useless chunk."

Jason stumbled over this as a new user of follow_pfn, and I'm trying
to get rid of unsafe callers of that function so it can be locked down
further.

This is independent prep work for the referenced patch series.

References: https://lore.kernel.org/dri-devel/20201127164131.2244124-1-daniel.vetter@ffwll.ch/
Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sean Christopherson <seanjc@google.com>
Fixes: 947c6e11fa43 ("x86/sgx: Add ptrace() support for the SGX driver")
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: linux-sgx@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index ee50a5010277..20a2dd5ba2b4 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -141,7 +141,6 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 	struct sgx_encl_page *entry;
 	unsigned long phys_addr;
 	struct sgx_encl *encl;
-	unsigned long pfn;
 	vm_fault_t ret;
 
 	encl = vma->vm_private_data;
@@ -168,13 +167,6 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 
 	phys_addr = sgx_get_epc_phys_addr(entry->epc_page);
 
-	/* Check if another thread got here first to insert the PTE. */
-	if (!follow_pfn(vma, addr, &pfn)) {
-		mutex_unlock(&encl->lock);
-
-		return VM_FAULT_NOPAGE;
-	}
-
 	ret = vmf_insert_pfn(vma, addr, PFN_DOWN(phys_addr));
 	if (ret != VM_FAULT_NOPAGE) {
 		mutex_unlock(&encl->lock);
-- 
2.30.0

