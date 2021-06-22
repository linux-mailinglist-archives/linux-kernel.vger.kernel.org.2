Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81003B0E45
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhFVUIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhFVUIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:08:30 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA2BC061198
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:06:09 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d194-20020a3768cb0000b02903ad9d001bb6so19421690qkc.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=tnYR9Ppkx4sQpE1iUiRV/INtxPpGEZzdadyw4PDcUUc=;
        b=TXRMPdpmjYCtF7T/XcTAG0DZg+4vSagBy5SOVKgK+1M00cc8Dk8vVtFlXNbBvfsSDV
         kjuAs7spHpkP6phAKmibQDBmTIQkCG/Kc3PD1WCiMmbkE6Kd1D1lunMRszKrtgnwBwaY
         JOC0m6kycF5Dj0hM+V/EiBXEW3ZzvyyIrV4IO2Y7V5VIHVYoBd9Bm8tLcH8Sd6hzlmaH
         QONBOPRR+DjZc8uDCO140HjNvZbeBWIgcPQHnS32RdbK5e4A1IKhdYcabBjGPIAi380U
         8ocyPCG+eikRSa9iRnBf1Jx4GMpxRsDw7MVbGfwr/dxkkKnWFO1ZGBNfUZEAU4FLizgK
         QMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=tnYR9Ppkx4sQpE1iUiRV/INtxPpGEZzdadyw4PDcUUc=;
        b=RngL/mfbojEqZXDR0WHLNCbbW37IqKHiS3wNbGutwWOA7zcVTRGeiiI6TfMMmFJ05u
         fm0Wb0ePFgmsa8GGLln6OhNqdsDqk1o+LNjV33tK4soXW6IxgVhhaQQViNaa9aOWM9PO
         zWkufvZFR8ARK+rS0efaah3Fwpkj6DDVTK9BxW7I1JdcJ/iDmVI99J+GyzasT0XOHhCL
         CRgVD2eeX8JnzszuNLHUAzCElupgmS19P7ftJ5ABDsfs+bWCE3i4xkaFbbRRcsOES9GB
         SiIJg7vVYuLLEXGRcftZ+DL4Z3RQo9x6tIB07wd8yn+OFqgub6WIqfLaO27/D9x+NNmE
         FzIQ==
X-Gm-Message-State: AOAM531os4P9JnSSrOI0PBZYPWqFGcgoLPGJu713uXkWCgPW9wGM+kuY
        TKXja0UJJ2qPuOsc6da3eTxPLqvkQtc=
X-Google-Smtp-Source: ABdhPJzd+Xows+RqxNYiyWfg7pWr26OPGSa4lAQ62L6VCq+gNYYOK+fluoFDcC9VBqlqE4mrjR6Qq2Q5fQc=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:7d90:4528:3c45:18fb])
 (user=seanjc job=sendgmr) by 2002:a05:6214:934:: with SMTP id
 dk20mr505391qvb.53.1624392368580; Tue, 22 Jun 2021 13:06:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 13:05:23 -0700
In-Reply-To: <20210622200529.3650424-1-seanjc@google.com>
Message-Id: <20210622200529.3650424-14-seanjc@google.com>
Mime-Version: 1.0
References: <20210622200529.3650424-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 13/19] KVM: selftests: Unconditionally allocate EPT tables in
 memslot 0
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

Drop the EPTP memslot param from all EPT helpers and shove the hardcoded
'0' down to the vm_phy_page_alloc() calls.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/vmx.h        | 10 ++++-----
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  | 21 ++++++++-----------
 .../kvm/x86_64/vmx_apic_access_test.c         |  2 +-
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c |  6 +++---
 4 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index 516c81d86353..583ceb0d1457 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -608,15 +608,13 @@ bool nested_vmx_supported(void);
 void nested_vmx_check_supported(void);
 
 void nested_pg_map(struct vmx_pages *vmx, struct kvm_vm *vm,
-		   uint64_t nested_paddr, uint64_t paddr, uint32_t eptp_memslot);
+		   uint64_t nested_paddr, uint64_t paddr);
 void nested_map(struct vmx_pages *vmx, struct kvm_vm *vm,
-		 uint64_t nested_paddr, uint64_t paddr, uint64_t size,
-		 uint32_t eptp_memslot);
+		 uint64_t nested_paddr, uint64_t paddr, uint64_t size);
 void nested_map_memslot(struct vmx_pages *vmx, struct kvm_vm *vm,
-			uint32_t memslot, uint32_t eptp_memslot);
+			uint32_t memslot);
 void prepare_eptp(struct vmx_pages *vmx, struct kvm_vm *vm,
 		  uint32_t eptp_memslot);
-void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm,
-				      uint32_t eptp_memslot);
+void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm);
 
 #endif /* SELFTEST_KVM_VMX_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index d568d8cfd44d..1d26c3979eda 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -393,7 +393,7 @@ void nested_vmx_check_supported(void)
 }
 
 void nested_pg_map(struct vmx_pages *vmx, struct kvm_vm *vm,
-	 	   uint64_t nested_paddr, uint64_t paddr, uint32_t eptp_memslot)
+		   uint64_t nested_paddr, uint64_t paddr)
 {
 	uint16_t index[4];
 	struct eptPageTableEntry *pml4e;
@@ -427,7 +427,7 @@ void nested_pg_map(struct vmx_pages *vmx, struct kvm_vm *vm,
 	pml4e = vmx->eptp_hva;
 	if (!pml4e[index[3]].readable) {
 		pml4e[index[3]].address = vm_phy_page_alloc(vm,
-			  KVM_EPT_PAGE_TABLE_MIN_PADDR, eptp_memslot)
+			  KVM_EPT_PAGE_TABLE_MIN_PADDR, 0)
 			>> vm->page_shift;
 		pml4e[index[3]].writable = true;
 		pml4e[index[3]].readable = true;
@@ -439,7 +439,7 @@ void nested_pg_map(struct vmx_pages *vmx, struct kvm_vm *vm,
 	pdpe = addr_gpa2hva(vm, pml4e[index[3]].address * vm->page_size);
 	if (!pdpe[index[2]].readable) {
 		pdpe[index[2]].address = vm_phy_page_alloc(vm,
-			  KVM_EPT_PAGE_TABLE_MIN_PADDR, eptp_memslot)
+			  KVM_EPT_PAGE_TABLE_MIN_PADDR, 0)
 			>> vm->page_shift;
 		pdpe[index[2]].writable = true;
 		pdpe[index[2]].readable = true;
@@ -451,7 +451,7 @@ void nested_pg_map(struct vmx_pages *vmx, struct kvm_vm *vm,
 	pde = addr_gpa2hva(vm, pdpe[index[2]].address * vm->page_size);
 	if (!pde[index[1]].readable) {
 		pde[index[1]].address = vm_phy_page_alloc(vm,
-			  KVM_EPT_PAGE_TABLE_MIN_PADDR, eptp_memslot)
+			  KVM_EPT_PAGE_TABLE_MIN_PADDR, 0)
 			>> vm->page_shift;
 		pde[index[1]].writable = true;
 		pde[index[1]].readable = true;
@@ -492,8 +492,7 @@ void nested_pg_map(struct vmx_pages *vmx, struct kvm_vm *vm,
  * page range starting at nested_paddr to the page range starting at paddr.
  */
 void nested_map(struct vmx_pages *vmx, struct kvm_vm *vm,
-		uint64_t nested_paddr, uint64_t paddr, uint64_t size,
-		uint32_t eptp_memslot)
+		uint64_t nested_paddr, uint64_t paddr, uint64_t size)
 {
 	size_t page_size = vm->page_size;
 	size_t npages = size / page_size;
@@ -502,7 +501,7 @@ void nested_map(struct vmx_pages *vmx, struct kvm_vm *vm,
 	TEST_ASSERT(paddr + size > paddr, "Paddr overflow");
 
 	while (npages--) {
-		nested_pg_map(vmx, vm, nested_paddr, paddr, eptp_memslot);
+		nested_pg_map(vmx, vm, nested_paddr, paddr);
 		nested_paddr += page_size;
 		paddr += page_size;
 	}
@@ -512,7 +511,7 @@ void nested_map(struct vmx_pages *vmx, struct kvm_vm *vm,
  * physical pages in VM.
  */
 void nested_map_memslot(struct vmx_pages *vmx, struct kvm_vm *vm,
-			uint32_t memslot, uint32_t eptp_memslot)
+			uint32_t memslot)
 {
 	sparsebit_idx_t i, last;
 	struct userspace_mem_region *region =
@@ -528,8 +527,7 @@ void nested_map_memslot(struct vmx_pages *vmx, struct kvm_vm *vm,
 		nested_map(vmx, vm,
 			   (uint64_t)i << vm->page_shift,
 			   (uint64_t)i << vm->page_shift,
-			   1 << vm->page_shift,
-			   eptp_memslot);
+			   1 << vm->page_shift);
 	}
 }
 
@@ -541,8 +539,7 @@ void prepare_eptp(struct vmx_pages *vmx, struct kvm_vm *vm,
 	vmx->eptp_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->eptp);
 }
 
-void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm,
-				      uint32_t eptp_memslot)
+void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm)
 {
 	vmx->apic_access = (void *)vm_vaddr_alloc_page(vm);
 	vmx->apic_access_hva = addr_gva2hva(vm, (uintptr_t)vmx->apic_access);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
index d14888b34adb..d438c4d3228a 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
@@ -96,7 +96,7 @@ int main(int argc, char *argv[])
 	}
 
 	vmx = vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	prepare_virtualize_apic_accesses(vmx, vm, 0);
+	prepare_virtualize_apic_accesses(vmx, vm);
 	vcpu_args_set(vm, VCPU_ID, 2, vmx_pages_gva, high_gpa);
 
 	while (!done) {
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
index 18f636197827..06a64980a5d2 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
@@ -107,9 +107,9 @@ int main(int argc, char *argv[])
 	 * meaning after the last call to virt_map.
 	 */
 	prepare_eptp(vmx, vm, 0);
-	nested_map_memslot(vmx, vm, 0, 0);
-	nested_map(vmx, vm, NESTED_TEST_MEM1, GUEST_TEST_MEM, 4096, 0);
-	nested_map(vmx, vm, NESTED_TEST_MEM2, GUEST_TEST_MEM, 4096, 0);
+	nested_map_memslot(vmx, vm, 0);
+	nested_map(vmx, vm, NESTED_TEST_MEM1, GUEST_TEST_MEM, 4096);
+	nested_map(vmx, vm, NESTED_TEST_MEM2, GUEST_TEST_MEM, 4096);
 
 	bmap = bitmap_alloc(TEST_MEM_PAGES);
 	host_test_mem = addr_gpa2hva(vm, GUEST_TEST_MEM);
-- 
2.32.0.288.g62a8d224e6-goog

