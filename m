Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C519431F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhJROTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhJROS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:18:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A3C06ED2E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:03:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p21so8845296wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ilVE4xJNEWJqyraR6L3VDA//LfSc9977wvuETuVPB8A=;
        b=iJIXL5k7UKvSaiTpCZ/NRbW8UXBAsbUL5bOR63EhPqb2ttLq0MzQ+FfWR28Ughkcbs
         7oxUvk5dyNKyRQ9FcyE+4POjljVn8AUTg0UxQ/joj1V2cjBe6Mb/J+3yp9DUeTOChEzF
         hCbP6MccBTheeW2X1EAx4b6raO1wC/cuiHTbGljgxKMNmXFiLAeD0yLXrzZ+XBD5/Ssz
         9Dg0rxygs5gZ7Hr/mxbdvF1cw40+Mdx6SSDe5DsAEeUGW+2gJ0hE6ZWPxLFMwf/XaGZJ
         6dX+v1hEfS5yqCz0z84JwbkyGe05YN4VVNU5P88OPbnwPQx308pK5syC8OBhnhe9bTQy
         o9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ilVE4xJNEWJqyraR6L3VDA//LfSc9977wvuETuVPB8A=;
        b=1n9MDh1oj/Q8E9UjAjB3MddkswamGgVbkjMZtiG+f9JipYbaI+hUlEsOANzQi9hc9D
         D1eoJZ7TQwXQ3WjCK2JoLBOjas8rToKwQ2JoIf9Lg9Lew5QiFIPkks7cFwCIe00GtVbE
         yR+Q+2JQLd5WjD/nkUttIlQHGAHBWQ5zHJYg4jOKuurIyqN22ZudFlVPnpDePmKOCI37
         718J7Ev4uwvcjkamrOFrYcLSWqYK7f2RG8gn8a+bYSgaMtAsD8yDcBdK/ehuOmB26PDc
         d/yISpA4B51ihpST4ICAYWCg3n4pNnujXxNzeKvvp1sIQOGjLXbsXmvyXGdqMujMTnrF
         8A4w==
X-Gm-Message-State: AOAM533SsSfBL+J/lsVMVKGPzQRfaz7vGPhBJGf3pUTsc90XmF8hMJ7q
        AH67j/UkAqOKjoedSzcNmYMoQw==
X-Google-Smtp-Source: ABdhPJxJWiLYpJjB5ZQ0+cjl9xUBd/Al0nfVV9kESWuAisjQ7GXwYpBkwbby+DsCbh6H7gcw1jJXcg==
X-Received: by 2002:a05:600c:1c1b:: with SMTP id j27mr29455483wms.1.1634565788135;
        Mon, 18 Oct 2021 07:03:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:ba81:6f1b:ab2e:f120])
        by smtp.gmail.com with ESMTPSA id n9sm3982324wmq.6.2021.10.18.07.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 07:03:07 -0700 (PDT)
Date:   Mon, 18 Oct 2021 15:03:05 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 16/16] KVM: arm64: pkvm: Unshare guest structs during
 teardown
Message-ID: <YW1+mQ6Bn2HXwl34@google.com>
References: <20211013155831.943476-1-qperret@google.com>
 <20211013155831.943476-17-qperret@google.com>
 <87h7dhupfa.wl-maz@kernel.org>
 <YW1NLb9Pn9NyEYZF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW1NLb9Pn9NyEYZF@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 Oct 2021 at 11:32:13 (+0100), Quentin Perret wrote:
> Another option is to take a refcount on 'current' from
> kvm_arch_vcpu_run_map_fp() before sharing thread-specific structs with
> the hyp and release the refcount of the previous task after unsharing.
> But that means we'll have to also drop the refcount when the vcpu
> gets destroyed, as well as explicitly unshare at that point. Shouldn't
> be too bad I think. Thoughts?

Something like the below seems to work OK on my setup, including
SIGKILL'ing the guest and such. How much do you hate it?

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f8be56d5342b..50598d704c71 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -322,6 +322,7 @@ struct kvm_vcpu_arch {
 
 	struct thread_info *host_thread_info;	/* hyp VA */
 	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
+	struct task_struct *parent_task;
 
 	struct {
 		/* {Break,watch}point registers */
@@ -738,6 +739,7 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
+void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu);
 
 static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
 {
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 2fe1128d9f3d..27afeebbe1cb 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -15,6 +15,22 @@
 #include <asm/kvm_mmu.h>
 #include <asm/sysreg.h>
 
+void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu)
+{
+	struct task_struct *p = vcpu->arch.parent_task;
+	struct user_fpsimd_state *fpsimd;
+	struct thread_info *ti;
+
+	if (!static_branch_likely(&kvm_protected_mode_initialized) || !p)
+		return;
+
+	ti = &p->thread_info;
+	kvm_unshare_hyp(ti, ti + 1);
+	fpsimd = &p->thread.uw.fpsimd_state;
+	kvm_unshare_hyp(fpsimd, fpsimd + 1);
+	put_task_struct(p);
+}
+
 /*
  * Called on entry to KVM_RUN unless this vcpu previously ran at least
  * once and the most recent prior KVM_RUN for this vcpu was called from
@@ -31,6 +47,8 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 	struct thread_info *ti = &current->thread_info;
 	struct user_fpsimd_state *fpsimd = &current->thread.uw.fpsimd_state;
 
+	kvm_vcpu_unshare_task_fp(vcpu);
+
 	/*
 	 * Make sure the host task thread flags and fpsimd state are
 	 * visible to hyp:
@@ -45,6 +63,17 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.host_thread_info = kern_hyp_va(ti);
 	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
+
+	/*
+	 * We need to keep current's task_struct pinned until its data has been
+	 * unshared with the hypervisor to make sure it is not re-used by the
+	 * kernel and donated to someone else while already shared -- see
+	 * kvm_vcpu_unshare_task_fp() for the matching put_task_struct().
+	 */
+	if (static_branch_likely(&kvm_protected_mode_initialized)) {
+		get_task_struct(current);
+		vcpu->arch.parent_task = current;
+	}
 error:
 	return ret;
 }
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5ce36b0a3343..c2a2cd7d5748 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -141,7 +141,13 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 
 void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
-	kfree(vcpu->arch.sve_state);
+	void *sve_state = vcpu->arch.sve_state;
+
+	kvm_vcpu_unshare_task_fp(vcpu);
+	kvm_unshare_hyp(vcpu, vcpu + 1);
+	if (sve_state && vcpu->arch.has_run_once)
+		kvm_unshare_hyp(sve_state, sve_state + vcpu_sve_state_size(vcpu));
+	kfree(sve_state);
 }
 
 static void kvm_vcpu_reset_sve(struct kvm_vcpu *vcpu)
