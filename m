Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3B413E44
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 02:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhIVAHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 20:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhIVAHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 20:07:22 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3427FC061764
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 17:05:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w10-20020a0cb54a000000b0037a9848b92fso8984941qvd.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 17:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=6hT+pcsgsamW9lRK8DKVDgsjod6WnUckxdik+rJgRjs=;
        b=Bj8VBEV1iZnqxOhTLHlm7aJLEpzWR4VK7K7aD+jVIOItnRKO4fixETcLObR8Fp3wpi
         qen4ySzqMv29aPJAGQYTFE7wmMMI1j5Rtph6tALMy5t0Vpqs3rbEz84bRIN0kMxKLv8c
         UqqsOh2SdMvnju4og/DFPHA2mwLIV2Kbl8jNiHyAx8ZaTn+CIt8xR9Nfe8u7VO9K9/eN
         +2x8JLd22AxcRq3kDSstvt/WqN7tY/+xYd3wvpQsDoKFQCmzoF+iYRzBtZMgOAMbDudK
         wnTLWwmn+3bAAzltBQAbNmJfxESz4LUX9Bp79xTAk2sjGVMJKof74Y995u9shdQ30fbC
         IW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=6hT+pcsgsamW9lRK8DKVDgsjod6WnUckxdik+rJgRjs=;
        b=nXF8Rj8r0bI7Q8hospIMgyw/SbW07dftnWKS3nKwBS8QK0tpoI3pa1ayGXOTLEszsl
         NnzosUJ1yBEET4kEp2z6R2YyX1CwYvErZPhlUwm5xWFKUFVBX2A25Yzvbo2YXv3cmlS8
         o3HXAlKa4dWYJ/6/UEsgwn3Lhw9IOW7m49eUQQ/IKgUcQy6m98gKZWTdyA12sehEGU3A
         L9awU8hwWB7CpeD3elveD/8gf4u7cBk6iDTVyJuTs3Yz/8gGKi6HopD2aYvR1MVvYFES
         NZf5zATFakKy6plCQCTsCSEtkVZmsbzk6k4gU47Lpnn6ssovg3anK5ZKSTREB5mBuU90
         VqBw==
X-Gm-Message-State: AOAM530jU+3bi6cxGCNQbzBDVbukXT5C0P0Aoeu96AQdnfj0Zy9CLrBJ
        rPs3I3yGOLFEdBIsVW6e7kdG1Om2xzo=
X-Google-Smtp-Source: ABdhPJw55E4dI/IAyKkR+ZKkmH8bPHTaStHFj1pC0lhS1Eeb6cv6+uuItqqgA18GAeXeV2SBtT0zyEX+kRs=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:a0c:8e83:: with SMTP id x3mr34844810qvb.40.1632269152245;
 Tue, 21 Sep 2021 17:05:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Sep 2021 17:05:21 -0700
In-Reply-To: <20210922000533.713300-1-seanjc@google.com>
Message-Id: <20210922000533.713300-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210922000533.713300-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 04/16] perf: Stop pretending that perf can handle multiple
 guest callbacks
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the 'int' return value from the perf (un)register callbacks helpers
and stop pretending perf can support multiple callbacks.  The 'int'
returns are not future proofing anything as none of the callers take
action on an error.  It's also not obvious that there will ever be
co-tenant hypervisors, and if there are, that allowing multiple callbacks
to be registered is desirable or even correct.

Opportunistically rename callbacks=>cbs in the affected declarations to
match their definitions.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  4 ++--
 arch/arm64/kvm/perf.c             |  8 ++++----
 include/linux/perf_event.h        | 12 ++++++------
 kernel/events/core.c              | 16 ++++------------
 4 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 41911585ae0c..ed940aec89e0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -670,8 +670,8 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
 int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
 int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 
-int kvm_perf_init(void);
-int kvm_perf_teardown(void);
+void kvm_perf_init(void);
+void kvm_perf_teardown(void);
 
 long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu);
 gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index 151c31fb9860..c37c0cf1bfe9 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -48,15 +48,15 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
 	.get_guest_ip	= kvm_get_guest_ip,
 };
 
-int kvm_perf_init(void)
+void kvm_perf_init(void)
 {
 	if (kvm_pmu_probe_pmuver() != 0xf && !is_protected_kvm_enabled())
 		static_branch_enable(&kvm_arm_pmu_available);
 
-	return perf_register_guest_info_callbacks(&kvm_guest_cbs);
+	perf_register_guest_info_callbacks(&kvm_guest_cbs);
 }
 
-int kvm_perf_teardown(void)
+void kvm_perf_teardown(void)
 {
-	return perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6b0405e578c1..317d4658afe9 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1245,8 +1245,8 @@ static inline struct perf_guest_info_callbacks *perf_get_guest_cbs(void)
 	/* Prevent reloading between a !NULL check and dereferences. */
 	return READ_ONCE(perf_guest_cbs);
 }
-extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
-extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
+extern void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
+extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
 
 extern void perf_event_exec(void);
 extern void perf_event_comm(struct task_struct *tsk, bool exec);
@@ -1489,10 +1489,10 @@ perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
 static inline void
 perf_bp_event(struct perf_event *event, void *data)			{ }
 
-static inline int perf_register_guest_info_callbacks
-(struct perf_guest_info_callbacks *callbacks)				{ return 0; }
-static inline int perf_unregister_guest_info_callbacks
-(struct perf_guest_info_callbacks *callbacks)				{ return 0; }
+static inline void perf_register_guest_info_callbacks
+(struct perf_guest_info_callbacks *cbs)					{ }
+static inline void perf_unregister_guest_info_callbacks
+(struct perf_guest_info_callbacks *cbs)					{ }
 
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80ff050a7b55..d90a43572400 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6482,31 +6482,23 @@ static void perf_pending_event(struct irq_work *entry)
 		perf_swevent_put_recursion_context(rctx);
 }
 
-/*
- * We assume there is only KVM supporting the callbacks.
- * Later on, we might change it to a list if there is
- * another virtualization implementation supporting the callbacks.
- */
 struct perf_guest_info_callbacks *perf_guest_cbs;
-
-int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
+void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
 	if (WARN_ON_ONCE(perf_guest_cbs))
-		return -EBUSY;
+		return;
 
 	WRITE_ONCE(perf_guest_cbs, cbs);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
 
-int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
+void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
 	if (WARN_ON_ONCE(perf_guest_cbs != cbs))
-		return -EINVAL;
+		return;
 
 	WRITE_ONCE(perf_guest_cbs, NULL);
 	synchronize_rcu();
-	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
 
-- 
2.33.0.464.g1972c5931b-goog

