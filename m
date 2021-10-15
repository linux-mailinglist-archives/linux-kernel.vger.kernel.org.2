Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5580042F7E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbhJOQRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237297AbhJOQRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:17:48 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E086C061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:15:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so7611304pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/yO2HrsaIO4jpccfAAiSxchb2+pTUm4acP48FhP+BCA=;
        b=bUBg8DXOOANy6KqSvBqBwr4pmyBcze1Of2z9SGdN5dWXFYYcJCS3vbytUgV0rOMiXo
         GWyiRqa92v7zE6Wie+Z5fZSeJJwNmg6uI83gYFm7yoJh3zOGrbqaqKa4kWr/QJX/JzAy
         Wjh2ICUvay/45VlCQ+O4NREOW3J8aYh44wTEnIam8IrkM13thHKeaa1u3IkbqXFngGsN
         2TE/Qcq9m0sDKU8HbgukX7FK7ddZSNkCl9F/C+pVe1AihjHOcswuFhxTuqTzXb5Tty4N
         HXka1s1G5TpdFKO/1FPAPld9HHa4ihY+PcFZzbG+9BKR9734/e2DJMFK1gsG+zFlPWrI
         m8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/yO2HrsaIO4jpccfAAiSxchb2+pTUm4acP48FhP+BCA=;
        b=oKxHzdXTNtJk70n1i/C4VPzU4Mz9Tj+256PP13tYFzNXVkEsP3iGergGe6UBx7OdpL
         djy39RrcYJP0qQN7+dJ+lP5G7BGjpqx26kNqVrz7bRrHE9owwpeeKstA0whgrr9m7rk6
         1GGcQU3WtfONAgk7gtVns7CcwjAMHsB8O5TvM8kPyenG3tgilgbjYbfmhM9XjIzMHjDK
         knwY4TyS5o4vi8nPzCyCanvwgclls+B+zaVYhRwDQakmyqUcawxO8/WN2vrZWJHMxXCG
         s38hWh0CMy6+CHQQxofLsurHLH6FyABWS6z9ONDyH+uvTmP/8vGNnpM0ftLHdKeYHvz5
         ihNw==
X-Gm-Message-State: AOAM5330AvI0x7qsAGyEdSutoXfHT68ORohNQR83LYF2jXwoueFP3PFq
        EXuqlMcKVWxB9lz5GLEBS0kaxg==
X-Google-Smtp-Source: ABdhPJxZHQrhEOGz7VbH6I1+z+OM+fUVzje7Ks0ZhZ0Abhzq5LbftH60+HZoOCIbUBbOEvaq9B5Cyw==
X-Received: by 2002:a17:90b:4c11:: with SMTP id na17mr14895117pjb.105.1634314541686;
        Fri, 15 Oct 2021 09:15:41 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z11sm11914561pjl.45.2021.10.15.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:15:41 -0700 (PDT)
Date:   Fri, 15 Oct 2021 16:15:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: x86: Fix and cleanup for recent AVIC changes
Message-ID: <YWmpKTk/7MOCzm15@google.com>
References: <20211009010135.4031460-1-seanjc@google.com>
 <9e9e91149ab4fa114543b69eaf493f84d2f33ce2.camel@redhat.com>
 <YWRJwZF1toUuyBdC@google.com>
 <YWRtHmAUaKcbWEzH@google.com>
 <ebf038b7b242dd19aba1e4adb6f4ef2701c53748.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf038b7b242dd19aba1e4adb6f4ef2701c53748.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021, Maxim Levitsky wrote:
> On Mon, 2021-10-11 at 16:58 +0000, Sean Christopherson wrote:
> > Argh, I forgot the memslot is still there, so the access won't be treated as MMIO
> > and thus won't end up in the MMIO cache.
> > 
> > So I agree that the code is functionally ok, but I'd still prefer to switch to
> > kvm_vcpu_apicv_active() so that this code is coherent with respect to the APICv
> > status at the time the fault occurred.
> > 
> > My objection to using kvm_apicv_activated() is that the result is completely
> > non-deterministic with respect to the vCPU's APICv status at the time of the
> > fault.  It works because all of the other mechanisms that are in place, e.g.
> > elevating the MMU notifier count, but the fact that the result is non-deterministic
> > means that using the per-vCPU status is also functionally ok.
> 
> The problem is that it is just not correct to use local AVIC enable state 
> to determine if we want to populate the SPTE or or just jump to the emulation.
> 
> 
> For example, assuming that the AVIC is now enabled on all vCPUs,
> we can have this scenario:
> 
>     vCPU0                                   vCPU1
>     =====                                   =====
> 
> - disable AVIC
> - VMRUN
>                                         - #NPT on AVIC MMIO access
>                                         - *stuck on something prior to the page fault code*
> - enable AVIC
> - VMRUN
>                                         - *still stuck on something prior to the page fault code*
> 
> - disable AVIC:
> 
>   - raise KVM_REQ_APICV_UPDATE request
> 					
>   - set global avic state to disable
> 
>   - zap the SPTE (does nothing, doesn't race
> 	with anything either)
> 
>   - handle KVM_REQ_APICV_UPDATE -
>     - disable vCPU0 AVIC
> 
> - VMRUN
> 					- *still stuck on something prior to the page fault code*
> 
>                                                             ...
>                                                             ...
>                                                             ...
> 
>                                         - now vCPU1 finally starts running the page fault code.
> 
>                                         - vCPU1 AVIC is still enabled 
>                                           (because vCPU1 never handled KVM_REQ_APICV_UPDATE),
>                                           so the page fault code will populate the SPTE.

But vCPU1 won't install the SPTE if it loses the race to acquire mmu_lock, because
kvm_zap_gfn_range() bumps the notifier sequence and so vCPU1 will retry the fault.
If vCPU1 wins the race, i.e. sees the same sequence number, then the zap is
guaranteed to find the newly-installed SPTE.

And IMO, retrying is the desired behavior.  Installing a SPTE based on the global
state works, but it's all kinds of weird to knowingly take an action the directly
contradicts the current vCPU state.

FWIW, I had gone so far as to type this up to handle the situation you described
before remembering the sequence interaction.

		/*
		 * If the APIC access page exists but is disabled, go directly
		 * to emulation without caching the MMIO access or creating a
		 * MMIO SPTE.  That way the cache doesn't need to be purged
		 * when the AVIC is re-enabled.
		 */
		if (slot && slot->id == APIC_ACCESS_PAGE_PRIVATE_MEMSLOT) {
			/*
			 * Retry the fault if an APICv update is pending, as
			 * the kvm_zap_gfn_range() when APICv becomes inhibited
			 * may have already occurred, in which case installing
			 * a SPTE would be incorrect.
			 */
			if (!kvm_vcpu_apicv_active(vcpu)) {
				*r = RET_PF_EMULATE;
				return true;
			} else if (kvm_test_request(KVM_REQ_APICV_UPDATE, vcpu)) {
				*r = RET_PF_RETRY;
				return true;
			}
		}

>                                         - handle KVM_REQ_APICV_UPDATE
>                                            - finally disable vCPU1 AVIC
> 
>                                         - VMRUN (vCPU1 AVIC disabled, SPTE populated)
> 
> 					                 ***boom***
