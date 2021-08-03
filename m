Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1B83DEC4E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhHCLjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235656AbhHCLjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:39:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17CA360BD3;
        Tue,  3 Aug 2021 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627990742;
        bh=mME2Y3V/e+bRBo+xbl4UW9QXkdNerzgDg+UYaH+HLKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HV3jZitur7fF0Gywc+XPBQncXgR0TP63CgpxLPROPkzgdPlfCOj1xSDG1Oqy2W6en
         IaSGccub/3lkMnF1h1q2cAbKUiBJqciCauHUUxQP4RBIOPmKmSedJp1E8ftKlzqYWk
         lkot2D/XqzZUp/LVVR4MxI2rYAwbvzfSgFoX6ZDIeVIz6xK+6C2DMnFLZX6/GTrjA8
         NSjqVj8ulxUwienXToTjFjg9UZx0DRyGfAnSDQHVqV1Qk03iunM55qd1h+kG/lQmqC
         9DT0DRQa0DZcZG9pK3cFEVISG/Mbim8DNaVr6GlEufQub8K0J0nDhUNZlSswmGW+hI
         BjgwNcwiyuaTA==
Date:   Tue, 3 Aug 2021 12:38:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        jean-philippe@linaro.org, Alexandru.Elisei@arm.com,
        qperret@google.com, linuxarm@huawei.com
Subject: Re: [PATCH v3 1/4] KVM: arm64: Introduce a new VMID allocator for KVM
Message-ID: <20210803113856.GA30853@willie-the-truck>
References: <20210729104009.382-1-shameerali.kolothum.thodi@huawei.com>
 <20210729104009.382-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729104009.382-2-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 11:40:06AM +0100, Shameer Kolothum wrote:
> A new VMID allocator for arm64 KVM use. This is based on
> arm64 ASID allocator algorithm.
> 
> One major deviation from the ASID allocator is the way we
> flush the context. Unlike ASID allocator, we expect less
> frequent rollover in the case of VMIDs. Hence, instead of
> marking the CPU as flush_pending and issuing a local context
> invalidation on the next context switch, we broadcast TLB
> flush + I-cache invalidation over the inner shareable domain
> on rollover.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---

[...]

> +void kvm_arm_vmid_update(struct kvm_vmid *kvm_vmid)
> +{
> +	unsigned long flags;
> +	unsigned int cpu;
> +	u64 vmid, old_active_vmid;
> +
> +	vmid = atomic64_read(&kvm_vmid->id);
> +
> +	/*
> +	 * Please refer comments in check_and_switch_context() in
> +	 * arch/arm64/mm/context.c.
> +	 */
> +	old_active_vmid = atomic64_read(this_cpu_ptr(&active_vmids));
> +	if (old_active_vmid && vmid_gen_match(vmid) &&
> +	    atomic64_cmpxchg_relaxed(this_cpu_ptr(&active_vmids),
> +				     old_active_vmid, vmid))
> +		return;
> +
> +	raw_spin_lock_irqsave(&cpu_vmid_lock, flags);
> +
> +	/* Check that our VMID belongs to the current generation. */
> +	vmid = atomic64_read(&kvm_vmid->id);
> +	if (!vmid_gen_match(vmid)) {
> +		vmid = new_vmid(kvm_vmid);
> +		atomic64_set(&kvm_vmid->id, vmid);

new_vmid() can just set kvm_vmid->id directly

> +	}
> +
> +	cpu = smp_processor_id();

Why?

Will
