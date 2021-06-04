Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC939BA99
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhFDOHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhFDOHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:07:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 148D4613FF;
        Fri,  4 Jun 2021 14:05:46 +0000 (UTC)
Date:   Fri, 4 Jun 2021 15:05:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v13 4/8] KVM: arm64: Introduce MTE VM feature
Message-ID: <20210604140544.GF31173@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
 <20210524104513.13258-5-steven.price@arm.com>
 <20210603160031.GE20338@arm.com>
 <a0810f3b-4f13-e8b5-7057-a9de1201887a@arm.com>
 <20210604113658.GD31173@arm.com>
 <2265cbf6-d643-9122-79a8-90198ea16c64@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2265cbf6-d643-9122-79a8-90198ea16c64@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:51:38PM +0100, Steven Price wrote:
> On 04/06/2021 12:36, Catalin Marinas wrote:
> > On Fri, Jun 04, 2021 at 11:42:11AM +0100, Steven Price wrote:
> >> On 03/06/2021 17:00, Catalin Marinas wrote:
> >>> On Mon, May 24, 2021 at 11:45:09AM +0100, Steven Price wrote:
> >>>> @@ -971,8 +1007,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>>>  	if (writable)
> >>>>  		prot |= KVM_PGTABLE_PROT_W;
> >>>>  
> >>>> -	if (fault_status != FSC_PERM && !device)
> >>>> +	if (fault_status != FSC_PERM && !device) {
> >>>> +		ret = sanitise_mte_tags(kvm, pfn, vma_pagesize);
> >>>> +		if (ret)
> >>>> +			goto out_unlock;
> >>>
> >>> Maybe it was discussed in a previous version, why do we need this in
> >>> addition to kvm_set_spte_gfn()?
> >>
> >> kvm_set_spte_gfn() is only used for the MMU notifier path (e.g. if a
> >> memslot is changed by the VMM). For the initial access we will normally
> >> fault the page into stage 2 with user_mem_abort().
> > 
> > Right. Can we move the sanitise_mte_tags() call to
> > kvm_pgtable_stage2_map() instead or we don't have the all the
> > information needed?
> 
> I tried that before: kvm_pgtable_stage2_map() is shared with the
> hypervisor so sadly we can't go poking around in the host as this breaks
> on nVHE. I mentioned it in the v12 cover letter but it was in a wall of
> text:

Ah, I missed this in the cover letter (haven't read it).

So, apart from the nitpick with the early return for less indentation,
feel free to add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
