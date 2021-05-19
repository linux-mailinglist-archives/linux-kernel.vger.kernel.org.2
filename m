Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40D3898EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhESVyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhESVyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:54:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6FEC061763
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:53:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gf3so1047393pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BYWFPE3EvGCH/ZPfc06CHtNLRxwGbiv54fFKJQnGuw4=;
        b=BHQwOQFWvbtK+TB5YY4ZlJSKIje37HMl0Z6UDPjZuIHzUW3n4oc2vp9yxky00w6Xn6
         2vsJWFvArMvcFbo98bhWiAqUlq8NNriEm3i0i3rqnZpam7DkMsJ1RcSCikN4l0h86bFe
         EpKgJ9H1at2kpOO+80JnWmmvXZMce2w+KAdGqLSZJ8IpyMq+eZCVfLUwwRMJb4V/Q2Qu
         8Vh8CTDD9a2k1Pr9uL+bkGeJhI2f8dGnJ96GP6YHoP3WDfwNenl1XOTq9zn9jHjKvY6T
         Bh351uolKTZZMNQX5mToVhKOcT219NKH2QQB6E76ETHgUcYWIiub6aB6s6TD2uMYxpVS
         647w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BYWFPE3EvGCH/ZPfc06CHtNLRxwGbiv54fFKJQnGuw4=;
        b=Xwq3I2U2L+r0c7DpPaI3eeMZTU//2e1gWi5MkKoya2YKyoCi18N0TfFDUyQKMDMkru
         uWOs9vTW7UMg+5yg2lPVvCogoaffV3NqRnwH5DIsnlOqzUXTt2Yp5+Dezp9QD3r2NZqS
         Ocn0yRSEkd2bU7wJdinhBvd5FqNYAuftNzq7hcUkL4RCwDyfzjyNP15z3r1Mk5bXONBJ
         VIfU2g0AspHyyXNtWXzeIoH+MgW6qx5N2yPKq2yEbJtt5rQ8ju64ulGLtCRuBeVnSDj6
         z/4FWvrc5S2p48PB/eLB/4QX0dsf4cZQIvW1OguCXmzgHXjBASNjYU7TFybtHGv4soGD
         UYhA==
X-Gm-Message-State: AOAM5307NoPq26HBIUJXCSUcrNUBKjZ+NMxhlD/WNUateVBbwChwh29E
        PNvfKPOcro7RRl89XIGafhnfig==
X-Google-Smtp-Source: ABdhPJw2fOae5m7SrQ14ODV1hBE1kvqVBWsGXHx3rc4csV/j/rZ9+16Pddzyqa1pUD2tssQLv6GaDw==
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr1515286pjh.170.1621461209060;
        Wed, 19 May 2021 14:53:29 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id s6sm348456pjr.29.2021.05.19.14.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 14:53:28 -0700 (PDT)
Date:   Wed, 19 May 2021 21:53:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jon Kohler <jon@nutanix.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Bijan Mottahedeh <bijan.mottahedeh@nutanix.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Junaid Shahid <junaids@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm: x86: move srcu lock out of kvm_vcpu_check_block
Message-ID: <YKWI1GPdNc4shaCt@google.com>
References: <20210428173820.13051-1-jon@nutanix.com>
 <YIxsV6VgSDEdngKA@google.com>
 <9040b3d8-f83f-beb5-a703-42202d78fabb@redhat.com>
 <70B34A15-C4A1-4227-B037-7B26B40EDBFE@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70B34A15-C4A1-4227-B037-7B26B40EDBFE@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021, Jon Kohler wrote:
> 
> > On May 1, 2021, at 9:05 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> > On 30/04/21 22:45, Sean Christopherson wrote:
> >> On Wed, Apr 28, 2021, Jon Kohler wrote:
> >>> To improve performance, this moves kvm->srcu lock logic from
> >>> kvm_vcpu_check_block to kvm_vcpu_running and wraps directly around
> >>> check_events. Also adds a hint for callers to tell
> >>> kvm_vcpu_running whether or not to acquire srcu, which is useful in
> >>> situations where the lock may already be held. With this in place, we
> >>> see roughly 5% improvement in an internal benchmark [3] and no more
> >>> impact from this lock on non-nested workloads.
> >> ...
> >>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> >>> index efc7a82ab140..354f690cc982 100644
> >>> --- a/arch/x86/kvm/x86.c
> >>> +++ b/arch/x86/kvm/x86.c
> >>> @@ -9273,10 +9273,24 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
> >>>  	return 1;
> >>>  }
> >>> 
> >>> -static inline bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
> >>> +static inline bool kvm_vcpu_running(struct kvm_vcpu *vcpu, bool acquire_srcu)
> >>>  {
> >>> -	if (is_guest_mode(vcpu))
> >>> -		kvm_x86_ops.nested_ops->check_events(vcpu);
> >>> +	if (is_guest_mode(vcpu)) {
> >>> +		if (acquire_srcu) {
> >>> +			/*
> >>> +			 * We need to lock because check_events could call
> >>> +			 * nested_vmx_vmexit() which might need to resolve a
> >>> +			 * valid memslot. We will have this lock only when
> >>> +			 * called from vcpu_run but not when called from
> >>> +			 * kvm_vcpu_check_block > kvm_arch_vcpu_runnable.
> >>> +			 */
> >>> +			int idx = srcu_read_lock(&vcpu->kvm->srcu);
> >>> +			kvm_x86_ops.nested_ops->check_events(vcpu);
> >>> +			srcu_read_unlock(&vcpu->kvm->srcu, idx);
> >>> +		} else {
> >>> +			kvm_x86_ops.nested_ops->check_events(vcpu);
> >>> +		}
> >>> +	}
> >> Obviously not your fault, but I absolutely detest calling check_events() from
> >> kvm_vcpu_running.  I would much prefer to make baby steps toward cleaning up the
> >> existing mess instead of piling more weirdness on top.
> >>
> >> Ideally, APICv support would be fixed to not require a deep probe into nested
> >> events just to see if a vCPU can run.  But, that's probably more than we want to
> >> bite off at this time.
> >>
> >> What if we add another nested_ops API to check if the vCPU has an event, but not
> >> actually process the event?  I think that would allow eliminating the SRCU lock,
> >> and would get rid of the most egregious behavior of triggering a nested VM-Exit
> >> in a seemingly innocuous helper.
> >>
> >> If this works, we could even explore moving the call to nested_ops->has_events()
> >> out of kvm_vcpu_running() and into kvm_vcpu_has_events(); I can't tell if the
> >> side effects in vcpu_block() would get messed up with that change :-/
> >> Incomplete patch...
> > 
> > I think it doesn't even have to be *nested* events.  Most events are the
> > same inside or outside guest mode, as they already special case guest mode
> > inside the kvm_x86_ops callbacks (e.g. kvm_arch_interrupt_allowed is
> > already called by kvm_vcpu_has_events).
> > 
> > I think we only need to extend kvm_x86_ops.nested_ops->hv_timer_pending to
> > cover MTF, plus double check that INIT and SIPI are handled correctly, and
> > then the call to check_nested_events can go away.
> 
> Thanks, Paolo, Sean. I appreciate the prompt response, Sorry for the slow
> reply, I was out with a hand injury for a few days and am caught up now. 
> 
> Just to confirm - In the spirit of baby steps as Sean mentioned, I’m happy to
> take up the idea that Sean mentioned, that makes sense to me. Perhaps we can
> do that small patch and leave a TODO do a tuneup for hv_timer_pending and the
> other double checks Paolo mentioned.

Paolo was pointing out that kvm_vcpu_has_events() already checks hv_timer_pending,
and that we could add the few missing nested event cases to kvm_vcpu_has_events()
instead of wholesale checking everything that's in check_nested_events().

I believe that would work, as I suspect the underlying bug that was alluded to
by commit 0ad3bed6c5ec ("kvm: nVMX: move nested events check to kvm_vcpu_running")
has since been fixed.  But, I'm not sure it makes much difference in practice
since we'll likely end up with nested_ops->has_events() either way.

Staring a bit more, I'm pretty sure hv_timer_pending() can be made obsolete and
dropped.  Unless Paolo objects, I still like my original proposal.

I think the safest approach from a bisection standpoint would be to do this in
3-4 stages:

  1. Refactor check_nested_events() to split out a has_events() helper.
  2. Move the has_events() call from kvm_vcpu_running() into kvm_vcpu_has_events()
  3. Drop the explicit hv_timer_pending() in inject_pending_event().  It should
     be dead code since it's just a pointer to nested_vmx_preemption_timer_pending(),
     which is handled by vmx_check_nested_events() and called earlier.
  4. Drop the explicit hv_timer_pending() in kvm_vcpu_has_events() for the same
     reasons as (3).  This can also drop hv_timer_pending() entirely.

> Or would you rather skip that approach and go right to making
> check_nested_events go-away first? Guessing that might be a larger effort
> with more nuances though?
