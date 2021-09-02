Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A783FF2D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346701AbhIBRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346645AbhIBRxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:53:15 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FFBC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:52:16 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r4so5465215ybp.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xAUZw7IrrctnJdeQBEtbAhv9xiy70VOpKzIZyk6KqAA=;
        b=iyKqthjIRwPONyCS4/FKOde7Qj8MPxzxsMuN8Ti/E5d4o95dMRFhXGD0ZN2pu7RPVp
         JwWUX/2NUc7y4oxHWdsjIHW4i99GjxckLQGR8lyOsGYMBoUAf4tdI8Tc2b2WN05V78s1
         1ci/XTZoMbCx+VULa5z5tq7lKuPFjEOFL2ewyVdnHWMbRBr8zMXxtFQ47bECS/S778Vd
         uWYSbkDI5Q7wCUKjWhT936QxX63P6W5fUF+RE1aax17r7lqa+ihcXphy+D1BQzgYmBOh
         74HWpCi3vjxnYhTz4SIltFZH+bMTbuiVxuEulZmZgyDq40oAz76TRf9JSIgTAEM3wNC2
         3lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xAUZw7IrrctnJdeQBEtbAhv9xiy70VOpKzIZyk6KqAA=;
        b=NLFxZbeu49GPh2DHAIwdOAaC7GZ18QC7PwSCpqcG5JFI5qlw3WLqSWz0MZTweHOcsz
         Kflbki9g5iSBLoZKYjgf4l4rFFVZc6Ze+1ORTuORBIbUiRrH1sn1LEBbZQJjgrTx4uHn
         3SptagXnctS0AjdzLCOQ3WLkdjLuoTck1fK1NBN3kLIwUiyRw7jajXB8TUZLPtca30to
         ZZSHWpB378Wr6vo4GfezI8NHI/nuET6C08bNTbxUpi8WjwPTbpHy6pFpyI33jW35JbOs
         /QygH33zY3R3FU9JM+PYkgM4nkrZNsbm9/a1WiwyTzCjuetgj4e+dpcSFnCk66ih3gy+
         iTRQ==
X-Gm-Message-State: AOAM532/y1hpCUpRs2X1gBkLL7W5mQsxyGIqHrWKm+uGthjXeQ+4AiSL
        MgPa+7aSSWbTgIekwHd6oH0nsqWF4V7SwHr48oL2Ig==
X-Google-Smtp-Source: ABdhPJwQXtJzqbxl4gNeMNvhKYFqgI/uCi3/Up5vD6artyFiw1jvBI/+9aQ5dnuQX2F2LGGKUfF/T1/Eh5NonYuxIbU=
X-Received: by 2002:a25:4f87:: with SMTP id d129mr5967977ybb.359.1630605135660;
 Thu, 02 Sep 2021 10:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210901211412.4171835-1-rananta@google.com> <20210901211412.4171835-8-rananta@google.com>
 <YTARPBhMHXjgcPlg@google.com> <20210902123656.lfzwqrlw5kbvckah@gator>
In-Reply-To: <20210902123656.lfzwqrlw5kbvckah@gator>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Thu, 2 Sep 2021 10:52:05 -0700
Message-ID: <CAJHc60xQYiOsQcZ64SVsVRarnb2b+fefRYq+xQ8FeqGxH0fY2w@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] KVM: arm64: selftests: Add support to get the
 vcpuid from MPIDR_EL1
To:     Andrew Jones <drjones@redhat.com>
Cc:     Oliver Upton <oupton@google.com>, kvm@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 5:37 AM Andrew Jones <drjones@redhat.com> wrote:
>
> On Wed, Sep 01, 2021 at 11:48:12PM +0000, Oliver Upton wrote:
> > On Wed, Sep 01, 2021 at 09:14:07PM +0000, Raghavendra Rao Ananta wrote:
> > > At times, such as when in the interrupt handler, the guest wants to
> > > get the vCPU-id that it's running on. As a result, introduce
> > > get_vcpuid() that parses the MPIDR_EL1 and returns the vcpuid to the
> > > requested caller.
> > >
> > > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > > ---
> > >  .../selftests/kvm/include/aarch64/processor.h | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> > > index c35bb7b8e870..8b372cd427da 100644
> > > --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> > > +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> > > @@ -251,4 +251,23 @@ static inline void local_irq_disable(void)
> > >     asm volatile("msr daifset, #3" : : : "memory");
> > >  }
> > >
> > > +#define MPIDR_LEVEL_BITS 8
> > > +#define MPIDR_LEVEL_SHIFT(level) (MPIDR_LEVEL_BITS * level)
> > > +#define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
> > > +#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
> > > +   ((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
> > > +
> > > +static inline uint32_t get_vcpuid(void)
> > > +{
> > > +   uint32_t vcpuid = 0;
> > > +   uint64_t mpidr = read_sysreg(mpidr_el1);
> > > +
> > > +   /* KVM limits only 16 vCPUs at level 0 */
> > > +   vcpuid = mpidr & 0x0f;
> > > +   vcpuid |= MPIDR_AFFINITY_LEVEL(mpidr, 1) << 4;
> > > +   vcpuid |= MPIDR_AFFINITY_LEVEL(mpidr, 2) << 12;
> > > +
> > > +   return vcpuid;
> > > +}
> >
> > Are we guaranteed that KVM will always compose vCPU IDs the same way? I
> > do not believe this is guaranteed ABI.
>
> I don't believe we are. At least in QEMU we take pains to avoid that
> assumption.
>
> >
> > For the base case, you could pass the vCPU ID as an arg to the guest
> > function.
> >
> > I do agree that finding the vCPU ID is a bit more challenging in an
> > interrupt context. Maybe use a ucall to ask userspace? But of course,
> > every test implements its own run loop, so its yet another case that
> > tests need to handle.
> >
> > Or, you could allocate an array at runtime of length KVM_CAP_MAX_VCPUS
> > (use the KVM_CHECK_EXTENSION ioctl to get the value). Once all vCPUs are
> > instantiated, iterate over them from userspace to populate the {MPIDR,
> > VCPU_ID} map. You'd need to guarantee that callers initialize the vGIC
> > *after* adding vCPUs to the guest.
>
> I agree with this approach. It may even make sense to create a common
> function that returns a {cpu_id,vcpu_index} map for other tests to use.
>
Interesting idea. I'll look into this.

Regards,
Raghavendra

> Thanks,
> drew
>
> >
> > --
> > Thanks,
> > Oliver
> >
> > >  #endif /* SELFTEST_KVM_PROCESSOR_H */
> > > --
> > > 2.33.0.153.gba50c8fa24-goog
> > >
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm@lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> >
>
