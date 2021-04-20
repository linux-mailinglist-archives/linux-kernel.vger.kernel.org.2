Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB058365C55
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhDTPkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232940AbhDTPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618933176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VQROlc+OeyGZWexjfeI5DkN1h4it7ZtOPD/Y6S64EkE=;
        b=K65YuAQX6rsvnOFclzNMGVDuvnwiCQXSNeuB01lRRiO3GhospKZXHj4bgq6Xh1NE33njHN
        Fo3Cp8KU+uSiyuy7W0f/MdYNV8hL8yaBV9DEmZ1Pb9D6o2mI3Mf7J1DSsoYifwKSdBm3N8
        /D92VxCvOLRlEhJq+qijdELQcl4r9r8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-Us60NfmTNmabhgK-MAkmOA-1; Tue, 20 Apr 2021 11:39:34 -0400
X-MC-Unique: Us60NfmTNmabhgK-MAkmOA-1
Received: by mail-qk1-f199.google.com with SMTP id l19-20020a37f5130000b02902e3dc23dc92so3559127qkk.15
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQROlc+OeyGZWexjfeI5DkN1h4it7ZtOPD/Y6S64EkE=;
        b=AgVg34HIjlJ80rZC3Z1qDT4/FV5Pd0GEInj017681lCUdB/TIyQox8ATUAb4Kgbmex
         T9rxgVahVf9LCXxI1NeNrTdgaXqZ82cu2qgJs8S54M2duqmg/KN/m3aYLyRX/ltzCNoO
         SuTF+K9el4Xm62C7W93vxTEYEWes35zR+41mB/u7SY3QWe5/u0i8iXcph7D14UbotIdH
         fw24B9JsH7JtEf/Gvbh8b/MiIqIyXTKfdUyIh8alV1oKjC50a1dp8Pjser7+S/Gj+ipt
         z1jQR9MNL5YYNrZt3TvI9qofQUuXb1IzmFRsM4exXf724jvOavWRhNjOGPos6AunEsCi
         08gw==
X-Gm-Message-State: AOAM532xJgcSf0T+olPud9Ja2aenrgiNFyqy5RbsY/4p0ck6pO/gmN3N
        2UP3i/RWdrOXjHDTzxQago3WSGB8vx4ATy8AEB0CqVCtk+LEp6G7sZ8XKxzL3OtVrTp9YunJEo+
        yRjKkaIEUyluV4FhjgjNhxhFx
X-Received: by 2002:ac8:5211:: with SMTP id r17mr13144761qtn.179.1618933173558;
        Tue, 20 Apr 2021 08:39:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx788RWtu3yNEcSOoXG9InX91GFPv3sAMNKtitjKsZi6xwq4T0JutImzI2/i7wU4um1ng7PA==
X-Received: by 2002:ac8:5211:: with SMTP id r17mr13144748qtn.179.1618933173297;
        Tue, 20 Apr 2021 08:39:33 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id f12sm11633325qtq.84.2021.04.20.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 08:39:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Sean Christopherson <seanjc@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v4 1/2] KVM: selftests: Sync data verify of dirty logging with guest sync
Date:   Tue, 20 Apr 2021 11:39:28 -0400
Message-Id: <20210420153929.482810-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210420153929.482810-1-peterx@redhat.com>
References: <20210420153929.482810-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a bug that can trigger with e.g. "taskset -c 0 ./dirty_log_test" or
when the testing host is very busy.

A similar previous attempt is done [1] but that is not enough, the reason is
stated in the reply [2].

As a summary (partly quotting from [2]):

The problem is I think one guest memory write operation (of this specific test)
contains a few micro-steps when page is during kvm dirty tracking (here I'm
only considering write-protect rather than pml but pml should be similar at
least when the log buffer is full):

  (1) Guest read 'iteration' number into register, prepare to write, page fault
  (2) Set dirty bit in either dirty bitmap or dirty ring
  (3) Return to guest, data written

When we verify the data, we assumed that all these steps are "atomic", say,
when (1) happened for this page, we assume (2) & (3) must have happened.  We
had some trick to workaround "un-atomicity" of above three steps, as previous
version of this patch wanted to fix atomicity of step (2)+(3) by explicitly
letting the main thread wait for at least one vmenter of vcpu thread, which
should work.  However what I overlooked is probably that we still have race
when (1) and (2) can be interrupted.

One example calltrace when it could happen that we read an old interation, got
interrupted before even setting the dirty bit and flushing data:

    __schedule+1742
    __cond_resched+52
    __get_user_pages+530
    get_user_pages_unlocked+197
    hva_to_pfn+206
    try_async_pf+132
    direct_page_fault+320
    kvm_mmu_page_fault+103
    vmx_handle_exit+288
    vcpu_enter_guest+2460
    kvm_arch_vcpu_ioctl_run+325
    kvm_vcpu_ioctl+526
    __x64_sys_ioctl+131
    do_syscall_64+51
    entry_SYSCALL_64_after_hwframe+68

It means iteration number cached in vcpu register can be very old when dirty
bit set and data flushed.

So far I don't see an easy way to guarantee all steps 1-3 atomicity but to sync
at the GUEST_SYNC() point of guest code when we do verification of the dirty
bits as what this patch does.

[1] https://lore.kernel.org/lkml/20210413213641.23742-1-peterx@redhat.com/
[2] https://lore.kernel.org/lkml/20210417140956.GV4440@xz-x1/

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 62 ++++++++++++++++----
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index bb2752d78fe3..fc87e2f11d3d 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -17,6 +17,7 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <asm/barrier.h>
+#include <linux/atomic.h>
 
 #include "kvm_util.h"
 #include "test_util.h"
@@ -137,12 +138,20 @@ static uint64_t host_clear_count;
 static uint64_t host_track_next_count;
 
 /* Whether dirty ring reset is requested, or finished */
-static sem_t dirty_ring_vcpu_stop;
-static sem_t dirty_ring_vcpu_cont;
+static sem_t sem_vcpu_stop;
+static sem_t sem_vcpu_cont;
+/*
+ * This is only set by main thread, and only cleared by vcpu thread.  It is
+ * used to request vcpu thread to stop at the next GUEST_SYNC, since GUEST_SYNC
+ * is the only place that we'll guarantee both "dirty bit" and "dirty data"
+ * will match.  E.g., SIG_IPI won't guarantee that (e.g., when vcpu interrupted
+ * after setting dirty bit but before data flushed).
+ */
+static atomic_t vcpu_sync_stop_requested;
 /*
  * This is updated by the vcpu thread to tell the host whether it's a
  * ring-full event.  It should only be read until a sem_wait() of
- * dirty_ring_vcpu_stop and before vcpu continues to run.
+ * sem_vcpu_stop and before vcpu continues to run.
  */
 static bool dirty_ring_vcpu_ring_full;
 /*
@@ -234,6 +243,17 @@ static void clear_log_collect_dirty_pages(struct kvm_vm *vm, int slot,
 	kvm_vm_clear_dirty_log(vm, slot, bitmap, 0, num_pages);
 }
 
+/* Should only be called after a GUEST_SYNC */
+static void vcpu_handle_sync_stop(void)
+{
+	if (atomic_read(&vcpu_sync_stop_requested)) {
+		/* It means main thread is sleeping waiting */
+		atomic_set(&vcpu_sync_stop_requested, false);
+		sem_post(&sem_vcpu_stop);
+		sem_wait_until(&sem_vcpu_cont);
+	}
+}
+
 static void default_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
 {
 	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
@@ -244,6 +264,8 @@ static void default_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
 	TEST_ASSERT(get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC,
 		    "Invalid guest sync status: exit_reason=%s\n",
 		    exit_reason_str(run->exit_reason));
+
+	vcpu_handle_sync_stop();
 }
 
 static bool dirty_ring_supported(void)
@@ -301,13 +323,13 @@ static void dirty_ring_wait_vcpu(void)
 {
 	/* This makes sure that hardware PML cache flushed */
 	vcpu_kick();
-	sem_wait_until(&dirty_ring_vcpu_stop);
+	sem_wait_until(&sem_vcpu_stop);
 }
 
 static void dirty_ring_continue_vcpu(void)
 {
 	pr_info("Notifying vcpu to continue\n");
-	sem_post(&dirty_ring_vcpu_cont);
+	sem_post(&sem_vcpu_cont);
 }
 
 static void dirty_ring_collect_dirty_pages(struct kvm_vm *vm, int slot,
@@ -355,17 +377,17 @@ static void dirty_ring_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
 	/* A ucall-sync or ring-full event is allowed */
 	if (get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC) {
 		/* We should allow this to continue */
-		;
+		vcpu_handle_sync_stop();
 	} else if (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL ||
 		   (ret == -1 && err == EINTR)) {
 		/* Update the flag first before pause */
 		WRITE_ONCE(dirty_ring_vcpu_ring_full,
 			   run->exit_reason == KVM_EXIT_DIRTY_RING_FULL);
-		sem_post(&dirty_ring_vcpu_stop);
+		sem_post(&sem_vcpu_stop);
 		pr_info("vcpu stops because %s...\n",
 			dirty_ring_vcpu_ring_full ?
 			"dirty ring is full" : "vcpu is kicked out");
-		sem_wait_until(&dirty_ring_vcpu_cont);
+		sem_wait_until(&sem_vcpu_cont);
 		pr_info("vcpu continues now.\n");
 	} else {
 		TEST_ASSERT(false, "Invalid guest sync status: "
@@ -377,7 +399,7 @@ static void dirty_ring_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
 static void dirty_ring_before_vcpu_join(void)
 {
 	/* Kick another round of vcpu just to make sure it will quit */
-	sem_post(&dirty_ring_vcpu_cont);
+	sem_post(&sem_vcpu_cont);
 }
 
 struct log_mode {
@@ -768,7 +790,25 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		usleep(p->interval * 1000);
 		log_mode_collect_dirty_pages(vm, TEST_MEM_SLOT_INDEX,
 					     bmap, host_num_pages);
+
+		/*
+		 * See vcpu_sync_stop_requested definition for details on why
+		 * we need to stop vcpu when verify data.
+		 */
+		atomic_set(&vcpu_sync_stop_requested, true);
+		sem_wait_until(&sem_vcpu_stop);
+		/*
+		 * NOTE: for dirty ring, it's possible that we didn't stop at
+		 * GUEST_SYNC but instead we stopped because ring is full;
+		 * that's okay too because ring full means we're only missing
+		 * the flush of the last page, and since we handle dirty ring
+		 * last page specifically, so verify will still pass.
+		 */
+		assert(host_log_mode == LOG_MODE_DIRTY_RING ||
+		       atomic_read(&vcpu_sync_stop_requested) == false);
 		vm_dirty_log_verify(mode, bmap);
+		sem_post(&sem_vcpu_cont);
+
 		iteration++;
 		sync_global_to_guest(vm, iteration);
 	}
@@ -819,8 +859,8 @@ int main(int argc, char *argv[])
 	};
 	int opt, i;
 
-	sem_init(&dirty_ring_vcpu_stop, 0, 0);
-	sem_init(&dirty_ring_vcpu_cont, 0, 0);
+	sem_init(&sem_vcpu_stop, 0, 0);
+	sem_init(&sem_vcpu_cont, 0, 0);
 
 	guest_modes_append_default();
 
-- 
2.26.2

