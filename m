Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC3372F18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhEDRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230331AbhEDRph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:45:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9249C61166;
        Tue,  4 May 2021 17:44:39 +0000 (UTC)
Date:   Tue, 4 May 2021 18:44:37 +0100
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
Subject: Re: [PATCH v11 5/6] KVM: arm64: ioctl to fetch/store tags in a guest
Message-ID: <YJGIBTor+blelKKT@arm.com>
References: <20210416154309.22129-1-steven.price@arm.com>
 <20210416154309.22129-6-steven.price@arm.com>
 <20210427175844.GB17872@arm.com>
 <340d35c2-46ed-35ea-43fa-e5cb64c27230@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <340d35c2-46ed-35ea-43fa-e5cb64c27230@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 05:06:07PM +0100, Steven Price wrote:
> On 27/04/2021 18:58, Catalin Marinas wrote:
> > On Fri, Apr 16, 2021 at 04:43:08PM +0100, Steven Price wrote:
> > > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > > index 24223adae150..2b85a047c37d 100644
> > > --- a/arch/arm64/include/uapi/asm/kvm.h
> > > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > > @@ -184,6 +184,20 @@ struct kvm_vcpu_events {
> > >   	__u32 reserved[12];
> > >   };
> > > +struct kvm_arm_copy_mte_tags {
> > > +	__u64 guest_ipa;
> > > +	__u64 length;
> > > +	union {
> > > +		void __user *addr;
> > > +		__u64 padding;
> > > +	};
> > > +	__u64 flags;
> > > +	__u64 reserved[2];
> > > +};
[...]
> > Maybe add the two reserved
> > values to the union in case we want to store something else in the
> > future.
> 
> I'm not sure what you mean here. What would the reserved fields be unioned
> with? And surely they are no longer reserved in that case?

In case you want to keep the structure size the same for future
expansion and the expansion only happens via the union, you'd add some
padding in there just in case. We do this for struct siginfo with an
_si_pad[] array in the union.

-- 
Catalin
