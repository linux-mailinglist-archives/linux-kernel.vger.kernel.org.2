Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23173DBD67
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhG3Q5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 12:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhG3Q5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:57:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC855C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 09:56:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso21713682pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NHmczmIzJufSB3Li/LucyxkDOJfl+luasFO2GMfh3i8=;
        b=EwcggOYo/KbZsqbv7CnLQji1AaGLnOh5sUY2NEpMi13aXZro2JK54VQT6EA0LGqEhp
         1dUrc+sHK5QUBLJMqWCOkVhRORDMasbGc+TOD24B7tNkfpzuGSMo8PWaKmEy1U7xtHUx
         q2Tra7+g6UGs9nC/2zTwsRW3ZjjJMQUqLUuu86eJdfpsqEdwAhNF1wbUviE7h7v3e4No
         ZhEeZbFW48Wecy/exed5zVehY2v7yXNhQFiz7UAWuLehu8RXOsgutb5gJvvx4xh51f0m
         ch4nma24ljAdFeNIidkVIV4YCjh9zTv7Sz9NEIs3gib/XxkJ9DakVPEgZNpUgkRMS3f3
         pmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NHmczmIzJufSB3Li/LucyxkDOJfl+luasFO2GMfh3i8=;
        b=R1IEbU2xepsuM6JzdIS4K0p9zAGAIqsJnnq+bi25XVJ8NcssPqg6qLEdk8Vkya1/CP
         XDvwSCAVqJxNYyFkxtU4xrVW2QiptXkgPzeN+GUcteCBnIofKGTcYOszOO3a9felKTdY
         IK2Vx6fWarCdRC2w6Hof6+dq5egb66A1AfGD8DpnfJrx50NelCc8hiyBnVtWWLEEXIQz
         Xb3YnQqCn2xFcepndo8ArRePqly3N2+voSIF+ifBQXCtS6CLepbcJ2GHAeSQg5onisT5
         nRS4NASlNWdDZhdW7RZWko533w0c0Ym7ZE7ajMjsA+Fmd5nJhe8BY+5xIPhgxVYbz5o8
         ryMA==
X-Gm-Message-State: AOAM530QpHrLDL+GrAWCIPMsM5zH2ATXXqNEivlAi5lBhr9SABUoYPfM
        fdcN30jWEjKdbTGYKig6Ub/eog==
X-Google-Smtp-Source: ABdhPJzWI6FoTcaZNj62M9u9nn73qB7KjElQlQVRB3Sn9a2CCf11QZlLRjOgsi/YapsBA2ELYgUCvw==
X-Received: by 2002:a63:4e11:: with SMTP id c17mr3123982pgb.54.1627664212050;
        Fri, 30 Jul 2021 09:56:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f3sm2904882pfe.123.2021.07.30.09.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 09:56:51 -0700 (PDT)
Date:   Fri, 30 Jul 2021 16:56:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Oliver Upton <oupton@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Shier <pshier@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Guangyu Shi <guangyus@google.com>
Subject: Re: [PATCH v2 3/3] KVM: arm64: Use generic KVM xfer to guest work
 function
Message-ID: <YQQvT7vAnRrcAcx/@google.com>
References: <20210729220916.1672875-1-oupton@google.com>
 <20210729220916.1672875-4-oupton@google.com>
 <878s1o2l6j.wl-maz@kernel.org>
 <CAOQ_QsjFzdjYgYSxNLH=8O84FJB+O8KtH0VnzdQ9HnLZwxwpNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ_QsjFzdjYgYSxNLH=8O84FJB+O8KtH0VnzdQ9HnLZwxwpNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021, Oliver Upton wrote:
> 
> On Fri, Jul 30, 2021 at 2:41 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Thu, 29 Jul 2021 23:09:16 +0100, Oliver Upton <oupton@google.com> wrote:
> > > @@ -714,6 +715,13 @@ static bool vcpu_mode_is_bad_32bit(struct kvm_vcpu *vcpu)
> > >               static_branch_unlikely(&arm64_mismatched_32bit_el0);
> > >  }
> > >
> > > +static bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
> > > +{
> > > +     return kvm_request_pending(vcpu) ||
> > > +                     need_new_vmid_gen(&vcpu->arch.hw_mmu->vmid) ||
> > > +                     xfer_to_guest_mode_work_pending();
> >
> > Here's what xfer_to_guest_mode_work_pending() says:
> >
> > <quote>
> >  * Has to be invoked with interrupts disabled before the transition to
> >  * guest mode.
> > </quote>
> >
> > At the point where you call this, we already are in guest mode, at
> > least in the KVM sense.
> 
> I believe the comment is suggestive of guest mode in the hardware
> sense, not KVM's vcpu->mode designation. I got this from
> arch/x86/kvm/x86.c:vcpu_enter_guest() to infer the author's
> intentions.

Yeah, the comment is referring to hardware guest mode.  The intent is to verify
there is no work to be done before making the expensive world switch.  There's
no meaningful interaction with vcpu->mode, on x86 it's simply more convenient
from a code perspective to throw it into kvm_vcpu_exit_request().
