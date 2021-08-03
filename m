Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95883DF17F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhHCPa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236730AbhHCPax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:30:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7489260F94;
        Tue,  3 Aug 2021 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628004642;
        bh=HTCLwdKyT6siX/NNQAkgV9S50hfCToi2PQiR46wzJOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UNa36HzG2X5o+mXj0JkamR1gwcNOzeK4UjQ7rYywhP8Aj5lkxhXxNONBj21H9y3hc
         LBDzzuDvwA6CsUouIl/cS0FGo0rVrLORLPxEucgSxg2RF2fZeLJ1oi4DzULM24kT17
         vg/lxy+sNjTy/FyuWZ+Y1N+ttGVEdMSE5BUWCCeOnNZEZh7Z8SXYJtXsVp0qBxKTRY
         w/pRHZ8m8Nf8RSBhpE8AXQR/OGyjpAGqXi42WBkAfhYj/TwmJRQiYEUfhGNBgrU2MD
         MlEGZNh6pSYXVkhHmY/v0Wfg/6c4OeyMHLI2r8d6U6PxfCE84mLxlSZUjkARU+p7+8
         cMDi/re1tKgIA==
Date:   Tue, 3 Aug 2021 16:30:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "Alexandru.Elisei@arm.com" <Alexandru.Elisei@arm.com>,
        "qperret@google.com" <qperret@google.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU schedule
 out
Message-ID: <20210803153036.GA31125@willie-the-truck>
References: <20210729104009.382-1-shameerali.kolothum.thodi@huawei.com>
 <20210729104009.382-5-shameerali.kolothum.thodi@huawei.com>
 <20210803114034.GB30853@willie-the-truck>
 <ee2863107d614ef8a36006b5aa912eca@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee2863107d614ef8a36006b5aa912eca@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 12:55:25PM +0000, Shameerali Kolothum Thodi wrote:
> > > diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
> > > index 5584e84aed95..5fd51f5445c1 100644
> > > --- a/arch/arm64/kvm/vmid.c
> > > +++ b/arch/arm64/kvm/vmid.c
> > > @@ -116,6 +116,12 @@ static u64 new_vmid(struct kvm_vmid
> > *kvm_vmid)
> > >  	return idx2vmid(vmid) | generation;
> > >  }
> > >
> > > +/* Call with preemption disabled */
> > > +void kvm_arm_vmid_clear_active(void)
> > > +{
> > > +	atomic64_set(this_cpu_ptr(&active_vmids), 0);
> > > +}
> > 
> > I think this is very broken, as it will force everybody to take the
> > slow-path when they see an active_vmid of 0.
> 
> Yes. I have seen that happening in my test setup.

Why didn't you say so?!

> > It also doesn't solve the issue I mentioned before, as an active_vmid of 0
> > means that the reserved vmid is preserved.
> > 
> > Needs more thought...
> 
> How about we clear all the active_vmids in kvm_arch_free_vm() if it
> matches the kvm_vmid->id ? But we may have to hold the lock 
> there

I think we have to be really careful not to run into the "suspended
animation" problem described in ae120d9edfe9 ("ARM: 7767/1: let the ASID
allocator handle suspended animation") if we go down this road.

Maybe something along the lines of:

ROLLOVER

  * Take lock
  * Inc generation
    => This will force everybody down the slow path
  * Record active VMIDs
  * Broadcast TLBI
    => Only active VMIDs can be dirty
    => Reserve active VMIDs and mark as allocated

VCPU SCHED IN

  * Set active VMID
  * Check generation
  * If mismatch then:
        * Take lock
        * Try to match a reserved VMID
        * If no reserved VMID, allocate new

VCPU SCHED OUT

  * Clear active VMID

but I'm not daft enough to think I got it right first time. I think it
needs both implementing *and* modelling in TLA+ before we merge it!

Will
