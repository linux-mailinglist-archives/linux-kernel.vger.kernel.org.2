Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85B73E5BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbhHJNaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239763AbhHJN2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:28:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A9D361008;
        Tue, 10 Aug 2021 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628602108;
        bh=e0EorNutTQj/n4ko+JR91efDJm3tMXggkYYS1yjdf0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6WB1QQ7XiHvWBiNtDH6+7DcZgoNBxNsm6lrgGZ/aLMRXYuRGbJYkidf9j1k9Ho3I
         mpBFx1HGFMHmO3la9vyyPST7cXNeaObCjivL+gznRERT387++Y2bbjSiqtSvHtJ6ye
         ydccEBAUkzBOvX8ovvS1488xK7xQFzAA4096btKPCUCzGzw77OkmgrFDuxmFH8U7AI
         zs2utfs2nRra4mfky6HDQKrHGMF9ZCWhv4827ypiNTxa7s91lg2nCCtOT6DRLJHTVd
         bo+y2JhhKHrAXxP8OWKFajdyXoG2Zg7T9eXFXPGpNd5juKEJcPIjIqeeckXvYHpN3N
         ILOxjZEU++M/w==
Date:   Tue, 10 Aug 2021 14:28:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] KVM: arm64: Drop check_kvm_target_cpu() based percpu
 probe
Message-ID: <20210810132822.GC2946@willie-the-truck>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
 <1628578961-29097-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628578961-29097-4-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 12:32:39PM +0530, Anshuman Khandual wrote:
> kvm_target_cpu() never returns a negative error code, so check_kvm_target()
> would never have 'ret' filled with a negative error code. Hence the percpu
> probe via check_kvm_target_cpu() does not make sense as its never going to
> find an unsupported CPU, forcing kvm_arch_init() to exit early. Hence lets
> just drop this percpu probe (and also check_kvm_target_cpu()) altogether.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Alexandru Elisei <alexandru.elisei@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/kvm/arm.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 19560e457c11..16f93678c17e 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -2010,11 +2010,6 @@ static int finalize_hyp_mode(void)
>  	return 0;
>  }
>  
> -static void check_kvm_target_cpu(void *ret)
> -{
> -	*(int *)ret = kvm_target_cpu();
> -}
> -
>  struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
>  {
>  	struct kvm_vcpu *vcpu;
> @@ -2074,7 +2069,6 @@ void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *cons)
>  int kvm_arch_init(void *opaque)
>  {
>  	int err;
> -	int ret, cpu;
>  	bool in_hyp_mode;
>  
>  	if (!is_hyp_mode_available()) {
> @@ -2089,14 +2083,6 @@ int kvm_arch_init(void *opaque)
>  		kvm_info("Guests without required CPU erratum workarounds can deadlock system!\n" \
>  			 "Only trusted guests should be used on this system.\n");
>  
> -	for_each_online_cpu(cpu) {
> -		smp_call_function_single(cpu, check_kvm_target_cpu, &ret, 1);
> -		if (ret < 0) {
> -			kvm_err("Error, CPU %d not supported!\n", cpu);
> -			return -ENODEV;
> -		}
> -	}

Looks like kvm_target_cpu() *could* return an error at one time of day (at
least on 32-bit), but agreed that this checking is no longer needed:

Acked-by: Will Deacon <will@kernel.org>

Perhaps it's worth making the return type of kvm_target_cpu() a u32 to
make it a bit more explicit that you shouldn't be returning an error code
there?

Will
