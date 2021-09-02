Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098EA3FEDDD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344607AbhIBMiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344309AbhIBMiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630586223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjZNhaTHu2G7qvKup1PDbiF+IV6d0VDmwJ2nyMbiAo4=;
        b=JNOZ54lOI56MKMJxN/OYysZRoK4F01/csudNAui1AV9ZLnfO+8zwOHfw7iU9Vb2h6aa+9/
        fY0pjDcht3eF0AvzAObyNYgjj3Bml02ucg/mtipPnlk0Q/q/3USSmfsT0P5cjjUjl19VYt
        a7Om2Q9JDdMeAEYcfF61PU2jJ2ji1ls=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-xhRw5P8UOKaKjqO_OEQPFw-1; Thu, 02 Sep 2021 08:36:59 -0400
X-MC-Unique: xhRw5P8UOKaKjqO_OEQPFw-1
Received: by mail-wr1-f69.google.com with SMTP id i2-20020a05600011c200b00159467c88e9so448603wrx.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 05:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XjZNhaTHu2G7qvKup1PDbiF+IV6d0VDmwJ2nyMbiAo4=;
        b=EPZQM0pKeZBcQhL5Jlkk9kkJ18wSh4zATuC401ZCLdVNO65fxp6tbfleYKjxI5MRRr
         O8QFdnVqY9CrFo6aZDxTJQgEHQXsvsHKAsjD19nX0vRUDvuV7JgX7sHOsOu+chG8IJNq
         sn9oQIWl+e4cPI2c9nCD8g77z9y6rwByAMOLIMtiAMFhuJG+H04Slv7jav4xMPxz6tL6
         MlcO4tDwzh6wTLrS1EW4YruJdnIDo9hZ2jAwCR+Gmn4v5UkO6FQYcnA4FVWdEYWBZaMg
         7S8NUmKBvTF0yUAmuQYwFxDJA3zWDgSYt+qocH4c+8O87dLfTKYAVsXA6NCLe+f1yfbT
         AvQA==
X-Gm-Message-State: AOAM5306PvFmy7HvbCesM11GcrRoVVSE0XMQKyehCQzawqvxmRBbepxc
        63j0jmhrnQrBt9ruyAuT+lLr2xDM8T7Ezopu0OV2rfp+0gde6J+PjJztjH7TTLYkm9OXmSrYigK
        Q8WrX84IQaHQi18sTFiFRJmDu
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr3490263wrn.5.1630586218651;
        Thu, 02 Sep 2021 05:36:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyda7YkzbAIwptDdwUxeFFJ3yXbh0EqmH9ayktJ/+cOAYBlktEFMuEzHFWPK2Zg6EPNQDNukw==
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr3490239wrn.5.1630586218485;
        Thu, 02 Sep 2021 05:36:58 -0700 (PDT)
Received: from gator (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k16sm1774372wrx.87.2021.09.02.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 05:36:58 -0700 (PDT)
Date:   Thu, 2 Sep 2021 14:36:56 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Oliver Upton <oupton@google.com>
Cc:     Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 07/12] KVM: arm64: selftests: Add support to get the
 vcpuid from MPIDR_EL1
Message-ID: <20210902123656.lfzwqrlw5kbvckah@gator>
References: <20210901211412.4171835-1-rananta@google.com>
 <20210901211412.4171835-8-rananta@google.com>
 <YTARPBhMHXjgcPlg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTARPBhMHXjgcPlg@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 11:48:12PM +0000, Oliver Upton wrote:
> On Wed, Sep 01, 2021 at 09:14:07PM +0000, Raghavendra Rao Ananta wrote:
> > At times, such as when in the interrupt handler, the guest wants to
> > get the vCPU-id that it's running on. As a result, introduce
> > get_vcpuid() that parses the MPIDR_EL1 and returns the vcpuid to the
> > requested caller.
> > 
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  .../selftests/kvm/include/aarch64/processor.h | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> > index c35bb7b8e870..8b372cd427da 100644
> > --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> > +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> > @@ -251,4 +251,23 @@ static inline void local_irq_disable(void)
> >  	asm volatile("msr daifset, #3" : : : "memory");
> >  }
> >  
> > +#define MPIDR_LEVEL_BITS 8
> > +#define MPIDR_LEVEL_SHIFT(level) (MPIDR_LEVEL_BITS * level)
> > +#define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
> > +#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
> > +	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
> > +
> > +static inline uint32_t get_vcpuid(void)
> > +{
> > +	uint32_t vcpuid = 0;
> > +	uint64_t mpidr = read_sysreg(mpidr_el1);
> > +
> > +	/* KVM limits only 16 vCPUs at level 0 */
> > +	vcpuid = mpidr & 0x0f;
> > +	vcpuid |= MPIDR_AFFINITY_LEVEL(mpidr, 1) << 4;
> > +	vcpuid |= MPIDR_AFFINITY_LEVEL(mpidr, 2) << 12;
> > +
> > +	return vcpuid;
> > +}
> 
> Are we guaranteed that KVM will always compose vCPU IDs the same way? I
> do not believe this is guaranteed ABI.

I don't believe we are. At least in QEMU we take pains to avoid that
assumption.

> 
> For the base case, you could pass the vCPU ID as an arg to the guest
> function.
> 
> I do agree that finding the vCPU ID is a bit more challenging in an
> interrupt context. Maybe use a ucall to ask userspace? But of course,
> every test implements its own run loop, so its yet another case that
> tests need to handle.
> 
> Or, you could allocate an array at runtime of length KVM_CAP_MAX_VCPUS
> (use the KVM_CHECK_EXTENSION ioctl to get the value). Once all vCPUs are
> instantiated, iterate over them from userspace to populate the {MPIDR,
> VCPU_ID} map. You'd need to guarantee that callers initialize the vGIC
> *after* adding vCPUs to the guest.

I agree with this approach. It may even make sense to create a common
function that returns a {cpu_id,vcpu_index} map for other tests to use.

Thanks,
drew

> 
> --
> Thanks,
> Oliver
> 
> >  #endif /* SELFTEST_KVM_PROCESSOR_H */
> > -- 
> > 2.33.0.153.gba50c8fa24-goog
> > 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 

