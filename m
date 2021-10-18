Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44304324E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhJRRYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233600AbhJRRYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:24:15 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC2060F9D;
        Mon, 18 Oct 2021 17:12:24 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mcWBS-0001xi-5Z; Mon, 18 Oct 2021 18:12:22 +0100
MIME-Version: 1.0
Date:   Mon, 18 Oct 2021 18:12:22 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Quentin Perret <qperret@google.com>
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
In-Reply-To: <YW1+mQ6Bn2HXwl34@google.com>
References: <20211013155831.943476-1-qperret@google.com>
 <20211013155831.943476-17-qperret@google.com> <87h7dhupfa.wl-maz@kernel.org>
 <YW1NLb9Pn9NyEYZF@google.com> <YW1+mQ6Bn2HXwl34@google.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <3ec8ab06f9950a13818109051835fdb9@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qperret@google.com, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, tabba@google.com, dbrazdil@google.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-18 15:03, Quentin Perret wrote:
> On Monday 18 Oct 2021 at 11:32:13 (+0100), Quentin Perret wrote:
>> Another option is to take a refcount on 'current' from
>> kvm_arch_vcpu_run_map_fp() before sharing thread-specific structs with
>> the hyp and release the refcount of the previous task after unsharing.
>> But that means we'll have to also drop the refcount when the vcpu
>> gets destroyed, as well as explicitly unshare at that point. Shouldn't
>> be too bad I think. Thoughts?
> 
> Something like the below seems to work OK on my setup, including
> SIGKILL'ing the guest and such. How much do you hate it?

It is annoyingly elegant! Small nitpick below.

> 
> diff --git a/arch/arm64/include/asm/kvm_host.h
> b/arch/arm64/include/asm/kvm_host.h
> index f8be56d5342b..50598d704c71 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -322,6 +322,7 @@ struct kvm_vcpu_arch {
> 
>  	struct thread_info *host_thread_info;	/* hyp VA */
>  	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
> +	struct task_struct *parent_task;
> 
>  	struct {
>  		/* {Break,watch}point registers */
> @@ -738,6 +739,7 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu 
> *vcpu);
>  void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
>  void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
>  void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
> +void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu);
> 
>  static inline bool kvm_pmu_counter_deferred(struct perf_event_attr 
> *attr)
>  {
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 2fe1128d9f3d..27afeebbe1cb 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -15,6 +15,22 @@
>  #include <asm/kvm_mmu.h>
>  #include <asm/sysreg.h>
> 
> +void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu)
> +{
> +	struct task_struct *p = vcpu->arch.parent_task;
> +	struct user_fpsimd_state *fpsimd;
> +	struct thread_info *ti;
> +
> +	if (!static_branch_likely(&kvm_protected_mode_initialized) || !p)

Shouldn't this be a check on is_protected_kvm_enabled() instead?
The two should be equivalent outside of the initialisation code...

Otherwise, ship it.

         M.
-- 
Jazz is not dead. It just smells funny...
