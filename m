Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD48B31741B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhBJXNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbhBJXJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:09:31 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B37C061224
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:07:00 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id l63so2839450qtd.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=UoVmn7fpCyRNxRM+3Np7r+DECkmDjVu43eW5UiZ+MBE=;
        b=FmQct8ROvMDTZ6Y9dfDGAyrs59mWfzPnEMPFaCQJ+BnmImH5W1jpeKxobWA1cA/0kU
         AlAzbAFrOQI1aqAOwvrTZjGtJ0zijXl6cEGPAbg4R7nlGZL0j+qFo4pjsg27ApQO7p3a
         EeNI0NzVUBiG7NvGMY4WM1XcMj3cA+KcRuzBjZPXucti/yYOtwQ0zQZlvS3GGMh6cqM2
         JLKGnSyetoyykmQEy4YaJViYKGIlahl4oq/nqGm+tDDhSAEKWgy1neObMsxRqQND1h12
         3YPZBCCbGRraccOSTLn4wt4wdmCzzDwzCbTx38Bt1Cw4bWoBYswq5Nf7H3HbNp/4Cx+P
         lKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=UoVmn7fpCyRNxRM+3Np7r+DECkmDjVu43eW5UiZ+MBE=;
        b=V5mq3SvKKVE9BBPny76tuw0U7ZiFx5siEtlOX650Pt/NyQ8LZkG748EvpvVEigGE8u
         6QecL+5QwNNvD2nWuBfvNC6/LhmkvpPhboPbRDBEDng8SoEIwh+eh1mvEvEZZjwkr/9T
         bLc1QH4jovUz+hBoQTOUZthHFmstq3iGCRmVeo4mGlV54uIMQai9iCwid3sCk1boug/a
         33jhOXyparB1wGX2+qHI1IGel+S0ofuao4qRz8ShkUT97I03dGcp1BLsH7RjfIjeWzVI
         6nsniNO209vVLMa6auXPfcwU6HMs0OOBNbSL27RumX/8wNAnA6gJaj9xHiRRDYsSwovL
         MFOw==
X-Gm-Message-State: AOAM5317a62/7PdzMlRCH3rZPSaXjZQXYwsguH251iCJXPaG6jgvoR6B
        d2PC7j9RkTSYMZjYTfLuIy4xhpKSf5k=
X-Google-Smtp-Source: ABdhPJw8V99g3m/NCGuvuwfBfxYgkAu9OQmH56KymDF8KZ6QMsat8EilVDY4q33kx0ZLagDbfo6zjY28p/U=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
 (user=seanjc job=sendgmr) by 2002:ad4:55aa:: with SMTP id f10mr5441086qvx.46.1612998419716;
 Wed, 10 Feb 2021 15:06:59 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 10 Feb 2021 15:06:22 -0800
In-Reply-To: <20210210230625.550939-1-seanjc@google.com>
Message-Id: <20210210230625.550939-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210210230625.550939-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 12/15] KVM: selftests: Fill per-vCPU struct during "perf_test"
 VM creation
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill the per-vCPU args when creating the perf_test VM instead of having
the caller do so.  This helps ensure that any adjustments to the number
of pages (and thus vcpu_memory_bytes) are reflected in the per-VM args.
Automatically filling the per-vCPU args will also allow a future patch
to do the sync to the guest during creation.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/demand_paging_test.c        |  6 +-
 .../selftests/kvm/dirty_log_perf_test.c       |  6 +-
 .../selftests/kvm/include/perf_test_util.h    |  6 +-
 .../selftests/kvm/lib/perf_test_util.c        | 74 ++++++++++---------
 .../kvm/memslot_modification_stress_test.c    |  6 +-
 5 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index b937a65b0e6d..00f2c795b68d 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -267,7 +267,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	int r;
 
 	vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
-				 VM_MEM_SRC_ANONYMOUS);
+				 VM_MEM_SRC_ANONYMOUS,
+				 p->partition_vcpu_memory_access);
 
 	perf_test_args.wr_fract = 1;
 
@@ -279,9 +280,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
 	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
 
-	perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size,
-			      p->partition_vcpu_memory_access);
-
 	if (p->use_uffd) {
 		uffd_handler_threads =
 			malloc(nr_vcpus * sizeof(*uffd_handler_threads));
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 04a2641261be..2c809452eac1 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -114,7 +114,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct timespec clear_dirty_log_total = (struct timespec){0};
 
 	vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
-				 p->backing_src);
+				 p->backing_src,
+				 p->partition_vcpu_memory_access);
 
 	perf_test_args.wr_fract = p->wr_fract;
 
@@ -132,9 +133,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
 	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
 
-	perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size,
-			      p->partition_vcpu_memory_access);
-
 	sync_global_to_guest(vm, perf_test_args);
 
 	/* Start the iterations */
diff --git a/tools/testing/selftests/kvm/include/perf_test_util.h b/tools/testing/selftests/kvm/include/perf_test_util.h
index 223fe6b79a04..3a21e82a0173 100644
--- a/tools/testing/selftests/kvm/include/perf_test_util.h
+++ b/tools/testing/selftests/kvm/include/perf_test_util.h
@@ -39,10 +39,8 @@ extern struct perf_test_args perf_test_args;
 
 struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
 				   uint64_t vcpu_memory_bytes,
-				   enum vm_mem_backing_src_type backing_src);
+				   enum vm_mem_backing_src_type backing_src,
+				   bool partition_vcpu_memory_access);
 void perf_test_destroy_vm(struct kvm_vm *vm);
-void perf_test_setup_vcpus(struct kvm_vm *vm, int vcpus,
-			   uint64_t vcpu_memory_bytes,
-			   bool partition_vcpu_memory_access);
 
 #endif /* SELFTEST_KVM_PERF_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 9b0cfdf10772..3aa99365726b 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -47,9 +47,45 @@ static void guest_code(uint32_t vcpu_id)
 	}
 }
 
+
+static void perf_test_setup_vcpus(struct kvm_vm *vm, int vcpus,
+				  uint64_t vcpu_memory_bytes,
+				  bool partition_vcpu_memory_access)
+{
+	struct perf_test_args *pta = &perf_test_args;
+	struct perf_test_vcpu_args *vcpu_args;
+	int vcpu_id;
+
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+		vcpu_args = &pta->vcpu_args[vcpu_id];
+
+		vcpu_args->vcpu_id = vcpu_id;
+		if (partition_vcpu_memory_access) {
+			vcpu_args->gva = guest_test_virt_mem +
+					 (vcpu_id * vcpu_memory_bytes);
+			vcpu_args->pages = vcpu_memory_bytes /
+					   pta->guest_page_size;
+			vcpu_args->gpa = pta->gpa +
+					 (vcpu_id * vcpu_memory_bytes);
+		} else {
+			vcpu_args->gva = guest_test_virt_mem;
+			vcpu_args->pages = (vcpus * vcpu_memory_bytes) /
+					   pta->guest_page_size;
+			vcpu_args->gpa = pta->gpa;
+		}
+
+		pr_debug("Added VCPU %d with test mem gpa [%lx, %lx)\n",
+			 vcpu_id, vcpu_args->gpa, vcpu_args->gpa +
+			 (vcpu_args->pages * pta->guest_page_size));
+	}
+}
+
+
+
 struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
 				   uint64_t vcpu_memory_bytes,
-				   enum vm_mem_backing_src_type backing_src)
+				   enum vm_mem_backing_src_type backing_src,
+				   bool partition_vcpu_memory_access)
 {
 	struct perf_test_args *pta = &perf_test_args;
 	struct kvm_vm *vm;
@@ -65,6 +101,7 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
 
 	guest_num_pages = vm_adjust_num_guest_pages(mode,
 				(vcpus * vcpu_memory_bytes) / pta->guest_page_size);
+	vcpu_memory_bytes = (guest_num_pages * pta->guest_page_size) / vcpus;
 
 	TEST_ASSERT(vcpu_memory_bytes % getpagesize() == 0,
 		    "Guest memory size is not host page size aligned.");
@@ -106,6 +143,9 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
 	/* Do mapping for the demand paging memory slot */
 	virt_map(vm, guest_test_virt_mem, pta->gpa, guest_num_pages, 0);
 
+	perf_test_setup_vcpus(vm, vcpus, vcpu_memory_bytes,
+			      partition_vcpu_memory_access);
+
 	ucall_init(vm, NULL);
 
 	return vm;
@@ -116,35 +156,3 @@ void perf_test_destroy_vm(struct kvm_vm *vm)
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
 }
-
-void perf_test_setup_vcpus(struct kvm_vm *vm, int vcpus,
-			   uint64_t vcpu_memory_bytes,
-			   bool partition_vcpu_memory_access)
-{
-	struct perf_test_args *pta = &perf_test_args;
-	struct perf_test_vcpu_args *vcpu_args;
-	int vcpu_id;
-
-	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
-		vcpu_args = &pta->vcpu_args[vcpu_id];
-
-		vcpu_args->vcpu_id = vcpu_id;
-		if (partition_vcpu_memory_access) {
-			vcpu_args->gva = guest_test_virt_mem +
-					 (vcpu_id * vcpu_memory_bytes);
-			vcpu_args->pages = vcpu_memory_bytes /
-					   pta->guest_page_size;
-			vcpu_args->gpa = pta->gpa +
-					 (vcpu_id * vcpu_memory_bytes);
-		} else {
-			vcpu_args->gva = guest_test_virt_mem;
-			vcpu_args->pages = (vcpus * vcpu_memory_bytes) /
-					   pta->guest_page_size;
-			vcpu_args->gpa = pta->gpa;
-		}
-
-		pr_debug("Added VCPU %d with test mem gpa [%lx, %lx)\n",
-			 vcpu_id, vcpu_args->gpa, vcpu_args->gpa +
-			 (vcpu_args->pages * pta->guest_page_size));
-	}
-}
diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index b3b8f08e91ad..949822833b6b 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -98,16 +98,14 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	int vcpu_id;
 
 	vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
-				 VM_MEM_SRC_ANONYMOUS);
+				 VM_MEM_SRC_ANONYMOUS,
+				 p->partition_vcpu_memory_access);
 
 	perf_test_args.wr_fract = 1;
 
 	vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
 	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
 
-	perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size,
-			      p->partition_vcpu_memory_access);
-
 	/* Export the shared variables to the guest */
 	sync_global_to_guest(vm, perf_test_args);
 
-- 
2.30.0.478.g8a0d178c01-goog

