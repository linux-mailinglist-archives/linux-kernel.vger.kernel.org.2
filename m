Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DCF37EB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380309AbhELTa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbhELRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:03:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230CFC06137B
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:59:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 33so296005pgo.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1IimKhEf1GjkO4us3Bblmu7m4xRs4WJcM8SG6dGEVnU=;
        b=QJK2Pqnu2zSa2SC/LK0xVCwuyR3e+Lnssnov9f6PPsJdkEGhUDsGq0I83Okd+Hbrpp
         t52/ABLV5uiJ+D98Uuhdg44+tZLhaANO6QeXMUrZ20yQHNFs/TuE5iJr44lyzku+nNZE
         nrWuBmfRrT5i3cUYx9nRuDEnl4YZllznre45Hn5hZbS7QRlLJl9/hinS7DdrNp4jvDrA
         OXUAwojw5yraob2G7RuoAa441yd1Lq1RgC/FO9ElpE7UtkVoDPRV0pxPYs6bAS2T0iXK
         uhCrzjuUKUsDswDDqAT9kiQZf4GlwX6lqsOJVMxFV0ynV0UErH+bcsudfXfHAQWZra0D
         BKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1IimKhEf1GjkO4us3Bblmu7m4xRs4WJcM8SG6dGEVnU=;
        b=gXGAgyPHy+OFofie9FvfU0nrnI1rZbTbQaRF3ZT5UFDV5IPMGyiaNXH1Qb3aj9cnL6
         +BhTt1ENFdELPF9Fo+Q+40eiMcvKE8JmIQF6jU8oI5odixRLny3Vdv0vT+shlv2hooEq
         /UzDyujuFtXHf+VbosC4zo85KtI+Mxc+IAe1tVhqhohTxQGExPzWNCQ00eFEamhQNotS
         crvb0uSpIzlTWZAymNF1F5mUs4sI4Bq9KRO71idyKzN41JAwiKUdAQQcgO4VAt3JKjzg
         IT1/fuOMfIOsOsB6+MNe6ABaHZuCdGizqU2IeNtanubFBMQZ9t31eXmiNbdw5tKjyd+N
         lrHA==
X-Gm-Message-State: AOAM530jxkZSaUf0NwykzlLFZWWWPG0XbXJIlWSs30YiVxSclJgw0WtT
        e8UX4uq9vVYfQjhIvT2rXcXDqZdKvdgIOw==
X-Google-Smtp-Source: ABdhPJxUFI/X3MMDN3e7n8EhHUWxHfQiq/e8rBV1jxYrxKhOcDEXFOAbfwaXYNN/IR3OJx1ogBehAQ==
X-Received: by 2002:a05:6a00:1409:b029:27f:fb6a:24b5 with SMTP id l9-20020a056a001409b029027ffb6a24b5mr36305473pfu.18.1620838760501;
        Wed, 12 May 2021 09:59:20 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id c16sm315246pgl.79.2021.05.12.09.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 09:59:19 -0700 (PDT)
Date:   Wed, 12 May 2021 16:59:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/3] KVM: X86: Bail out of direct yield in case of
 undercomitted scenarios
Message-ID: <YJwJYxM3BBuQEXw8@google.com>
References: <1620466310-8428-1-git-send-email-wanpengli@tencent.com>
 <1620466310-8428-2-git-send-email-wanpengli@tencent.com>
 <YJr6v+hfMJxI2iAn@google.com>
 <CANRm+Czbc9AX3=Qj7dDCENyWj27drWniimZLnyKd9=--Ag8F+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+Czbc9AX3=Qj7dDCENyWj27drWniimZLnyKd9=--Ag8F+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021, Wanpeng Li wrote:
> On Wed, 12 May 2021 at 05:44, Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Sat, May 08, 2021, Wanpeng Li wrote:
> > > From: Wanpeng Li <wanpengli@tencent.com>
> > >
> > > In case of undercomitted scenarios, vCPU can get scheduling easily,
> > > kvm_vcpu_yield_to adds extra overhead, we can observe a lot of race
> > > between vcpu->ready is true and yield fails due to p->state is
> > > TASK_RUNNING. Let's bail out is such scenarios by checking the length
> > > of current cpu runqueue.
> > >
> > > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > > ---
> > >  arch/x86/kvm/x86.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 5bd550e..c0244a6 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -8358,6 +8358,9 @@ static void kvm_sched_yield(struct kvm_vcpu *vcpu, unsigned long dest_id)
> > >       struct kvm_vcpu *target = NULL;
> > >       struct kvm_apic_map *map;
> > >
> > > +     if (single_task_running())
> > > +             goto no_yield;
> > > +
> >
> > Hmm, could we push the result of kvm_sched_yield() down into the guest?
> > Currently the guest bails after the first attempt, which is perfect for this
> > scenario, but it seems like it would make sense to keep trying to yield if there
> > are multiple preempted vCPUs and
> 
> It can have a race in case of sustain yield if there are multiple
> preempted vCPUs , the vCPU which you intend to yield may have already
> completed to handle IPI and be preempted now when the yielded sender
> is scheduled again and checks the next preempted candidate.

Ah, right, don't want to penalize the happy case.

> > Unrelated to this patch, but it's the first time I've really looked at the guest
> > side of directed yield...
> >
> > Wouldn't it also make sense for the guest side to hook .send_call_func_single_ipi?
> 
> reschedule ipi is called by .smp_send_reschedule hook, there are a lot
> of researches intend to accelerate idle vCPU reactivation, my original
> attemption is to boost synchronization primitive, I believe we need a
> lot of benchmarkings to consider inter-VM fairness and performance
> benefit for  hooks .send_call_func_single_ipi and
> .smp_send_reschedule.

I was thinking of the 2 vCPU case.  If the VM has 2 vCPUs, then this

	/*
	 * Choose the most efficient way to send an IPI. Note that the
	 * number of CPUs might be zero due to concurrent changes to the
	 * provided mask.
	 */
	if (nr_cpus == 1)
		send_call_function_single_ipi(last_cpu);
	else if (likely(nr_cpus > 1))
		arch_send_call_function_ipi_mask(cfd->cpumask_ipi);

means .send_call_func_single_ipi() will always be used to send an IPI to the
other vCPU, and thus 2 vCPU VMs will never utilize PV yield.
