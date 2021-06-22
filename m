Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57403B0E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhFVUIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhFVUIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:08:06 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A35C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:49 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v134-20020a37618c0000b02902fa5329f2b4so4976088qkb.18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=h9C5XJrlV2du+jCCBdcRQqIsaVMGFR3Dp5ea/2spNSQ=;
        b=UjMTXaf8mt8UkwYjdrw+LgfbwFyyDmQCiDkXS53dXKlGLwZOe73fPx2LJMncbTXdUb
         PGK+ik25J0KwWlQ26yuleHd5XyElHG2pXtZYklS/gZxRS22JHWfZSsYxncotklmxHq4R
         LHTsZ00X64+EkUBE/Fdd8H09i5nbXWU3FMEyQEpmmynWZI8FfQJxWaw4NYS4Bje7hKOl
         i9RgQyNXw80fYXDMM+AU2UyyYMc/zwXnIGEpEAvevvDqlRlnYpcCgou1t5W61OfVI/II
         agVlxyR5aOK7P2RbLOcJRCzuPVqeZz0DCJV5oo0MDqlx/fhkUC51eoi7JXGU/TPPQBIc
         1h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=h9C5XJrlV2du+jCCBdcRQqIsaVMGFR3Dp5ea/2spNSQ=;
        b=pXwmGcccWl9cQC+NgYo0zOljM5lNqKsKhILNp0txwBo4X+G1UyaAzO1V3KRmZSlAAo
         AFNHLywAZuSWhFN6g55rY+6Zy9S38Z0xytOdYyCZBG/OGwFc4ME5WxAseNsHhWb3zAZ3
         HFJiXefzqWhSHAoe/ifwS2XWroKJZDvSJBRpKqF6jFWWeusUD3/ZmFqUnA7qTjhl9HZE
         20H9V/3TBJjbFXyvo3E5DDG3SJdzNEJGKS4oTXD/zK5XBeBloYt5mpUfppsUyRaeVuvk
         q0VOV7XVoXFxWnm9eGPIBy11ZVrK/bSWJr/fuxCzR2/kvN2W5QuVETzescBYxs6/aIES
         RKEQ==
X-Gm-Message-State: AOAM53247v9ieE4oaf7vjV61ASDFpchvfoateGdRzUpY21Du/VfrV6/H
        Ui1ysHdQgwOOHS9lAbZBT+3byoJHvkI=
X-Google-Smtp-Source: ABdhPJwUDsBtaM8vjykTWRheuY39bqVHMFfaVuO6KB6eCVIep8NFoj7AA0sWQH0h7uOQaCz0zMDfgH/jrqo=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:7d90:4528:3c45:18fb])
 (user=seanjc job=sendgmr) by 2002:a25:6f55:: with SMTP id k82mr7349655ybc.490.1624392348443;
 Tue, 22 Jun 2021 13:05:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 13:05:14 -0700
In-Reply-To: <20210622200529.3650424-1-seanjc@google.com>
Message-Id: <20210622200529.3650424-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210622200529.3650424-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 04/19] KVM: selftests: Unconditionally use memslot 0 for x86's
 GDT/TSS setup
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor x86's GDT/TSS allocations to for memslot '0' at its
vm_addr_alloc() call sites instead of passing in '0' from on high.  This
is a step toward using a common helper for allocating pages.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/lib/x86_64/processor.c       | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index efe235044421..b1fb4c60dd73 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -518,24 +518,22 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 	exit(EXIT_FAILURE);
 }
 
-static void kvm_setup_gdt(struct kvm_vm *vm, struct kvm_dtable *dt, int gdt_memslot,
-			  int pgd_memslot)
+static void kvm_setup_gdt(struct kvm_vm *vm, struct kvm_dtable *dt)
 {
 	if (!vm->gdt)
 		vm->gdt = vm_vaddr_alloc(vm, getpagesize(),
-			KVM_UTIL_MIN_VADDR, gdt_memslot, pgd_memslot);
+			KVM_UTIL_MIN_VADDR, 0, 0);
 
 	dt->base = vm->gdt;
 	dt->limit = getpagesize();
 }
 
 static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
-				int selector, int gdt_memslot,
-				int pgd_memslot)
+				int selector)
 {
 	if (!vm->tss)
 		vm->tss = vm_vaddr_alloc(vm, getpagesize(),
-			KVM_UTIL_MIN_VADDR, gdt_memslot, pgd_memslot);
+			KVM_UTIL_MIN_VADDR, 0, 0);
 
 	memset(segp, 0, sizeof(*segp));
 	segp->base = vm->tss;
@@ -546,7 +544,7 @@ static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
 	kvm_seg_fill_gdt_64bit(vm, segp);
 }
 
-static void vcpu_setup(struct kvm_vm *vm, int vcpuid, int pgd_memslot, int gdt_memslot)
+static void vcpu_setup(struct kvm_vm *vm, int vcpuid)
 {
 	struct kvm_sregs sregs;
 
@@ -555,7 +553,7 @@ static void vcpu_setup(struct kvm_vm *vm, int vcpuid, int pgd_memslot, int gdt_m
 
 	sregs.idt.limit = 0;
 
-	kvm_setup_gdt(vm, &sregs.gdt, gdt_memslot, pgd_memslot);
+	kvm_setup_gdt(vm, &sregs.gdt);
 
 	switch (vm->mode) {
 	case VM_MODE_PXXV48_4K:
@@ -567,7 +565,7 @@ static void vcpu_setup(struct kvm_vm *vm, int vcpuid, int pgd_memslot, int gdt_m
 		kvm_seg_set_kernel_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs.cs);
 		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.ds);
 		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.es);
-		kvm_setup_tss_64bit(vm, &sregs.tr, 0x18, gdt_memslot, pgd_memslot);
+		kvm_setup_tss_64bit(vm, &sregs.tr, 0x18);
 		break;
 
 	default:
@@ -588,7 +586,7 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 
 	/* Create VCPU */
 	vm_vcpu_add(vm, vcpuid);
-	vcpu_setup(vm, vcpuid, 0, 0);
+	vcpu_setup(vm, vcpuid);
 
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vm, vcpuid, &regs);
-- 
2.32.0.288.g62a8d224e6-goog

