Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53A13B1C02
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhFWOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230061AbhFWOIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624457186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Y+gMnSaFBvm6Fhb4k8PQvOFFp5EQ+FUuVvzgThZ0xI=;
        b=JzkoHSyLMLgMTHk271uQRuY5lElIS0/hUsNr8GYB95kV6J+8pUfiVDE7rRjn7t/gD0rh7k
        zIxReAjhRfT15sUGpkDfQa3BDHv/ItyQuycioikD4Pbd/Wja14/soBeLA1MmLvKFdpd7w9
        Cq9JIoyPPfoEMMFvFYEM11njAZ+COOw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-0q8W0Cq1MXiar9ljF3fA7g-1; Wed, 23 Jun 2021 10:06:25 -0400
X-MC-Unique: 0q8W0Cq1MXiar9ljF3fA7g-1
Received: by mail-wr1-f70.google.com with SMTP id l13-20020adfe9cd0000b0290119a0645c8fso1118469wrn.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 07:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8Y+gMnSaFBvm6Fhb4k8PQvOFFp5EQ+FUuVvzgThZ0xI=;
        b=rsr5eaq5BFW7pOWFIRrF7MMo2yt21iMroL63ur5IPs3f7mDbd5SsuIF9eT7wvtR0Qi
         1Nzw4cchOMXwzOk7Puhe4Hw1Vt1BHmpjtTrB0TA7lIkRN4G4jNBMlVoX2zRJsoqskb10
         hFZmo7M3rts3caMy3+70hnBSmjlldnzlm/HRJVPfdqrRqbBllrkVBn5Wh09mh1/1kk0B
         OreLuol5DdPJomMCQHUwFb91SyG8qksyqqtE1PxfVujGcXYU5fyh+80FiP9ekVCqu6s7
         IE+k5yc4gcPNhgvIlNIJFre4CRLQWOdAKr1FLsuF2LJ06sxRzMNSHwFmITjI/ojHafCu
         RjVw==
X-Gm-Message-State: AOAM532aJimDmdPAqLcPHNU48fdMNLYQet2/MeE+U1vvsbPE6y850jbB
        iiHaQZPMgZVD08p1gv4NtkxvUeW6IKL+/Bt1ZQj6RtzPK892+RvByFg2ZgqHAVd3QssMY+bJ4LD
        YywpUgmsPCLCXq/nNRiFLHYiI
X-Received: by 2002:adf:fd12:: with SMTP id e18mr227826wrr.242.1624457184276;
        Wed, 23 Jun 2021 07:06:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGCGaIAZPfxN798nYa7lRaSSqWRq/lB0TlzsgG6OLvp8zvqc7LtxIYRstMKwbKvWHvxupn9A==
X-Received: by 2002:adf:fd12:: with SMTP id e18mr227791wrr.242.1624457184068;
        Wed, 23 Jun 2021 07:06:24 -0700 (PDT)
Received: from [172.16.0.103] ([5.28.162.59])
        by smtp.gmail.com with ESMTPSA id f19sm67972wmc.16.2021.06.23.07.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 07:06:23 -0700 (PDT)
Message-ID: <568fceb7f01d328f880af656bc79ead3eebdfc26.camel@redhat.com>
Subject: Re: [PATCH RFC] KVM: nSVM: Fix L1 state corruption upon return from
 SMM
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Cathy Avery <cavery@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 23 Jun 2021 17:06:21 +0300
In-Reply-To: <01564b34-2476-2098-7ec8-47336922afda@redhat.com>
References: <20210623074427.152266-1-vkuznets@redhat.com>
         <a3918bfa-7b4f-c31a-448a-aa22a44d4dfd@redhat.com>
         <53a9f893cb895f4b52e16c374cbe988607925cdf.camel@redhat.com>
         <01564b34-2476-2098-7ec8-47336922afda@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-23 at 15:21 +0200, Paolo Bonzini wrote:
> On 23/06/21 15:01, Maxim Levitsky wrote:
> > I did some homework on this now and I would like to share few my
> > thoughts on this:
> > 
> > First of all my attention caught the way we intercept the #SMI
> > (this isn't 100% related to the bug but still worth talking about
> > IMHO)
> > 
> > A. Bare metal: Looks like SVM allows to intercept SMI, with
> > SVM_EXIT_SMI,
> >   with an intention of then entering the BIOS SMM handler manually
> > using the SMM_CTL msr.
> 
> ... or just using STGI, which is what happens for KVM.  This is in
> the 
> manual: "The hypervisor may respond to the #VMEXIT(SMI) by executing
> the 
> STGI instruction, which causes the pending SMI to be taken
> immediately".

Right, I didn't notice that, that makes sense.
Thanks for the explanation!

> 
> It *should* work for KVM to just not intercept SMI, but it adds more 
> complexity for no particular gain.

It would be nice to do so to increase testing coverage of running
a nested KVM. I'll add a hack for that in my nested kernel.

> 
> >   On bare metal we do set the INTERCEPT_SMI but we emulate the exit
> > as a nop.
> >   I guess on bare metal there are some undocumented bits that BIOS
> > set which
> >   make the CPU to ignore that SMI intercept and still take the #SMI
> > handler,
> >   normally but I wonder if we could still break some motherboard
> >   code due to that.
> > 
> > B. Nested: If #SMI is intercepted, then it causes nested VMEXIT.
> >   Since KVM does enable SMI intercept, when it runs nested it means
> > that all SMIs
> >   that nested KVM gets are emulated as NOP, and L1's SMI handler is
> > not run.
> 
> No, this is incorrect.  Note that svm_check_nested_events does not
> clear 
> smi_pending the way vmx_check_nested_events does it for nmi_pending. 
> So 
> the interrupt is still there and will be injected on the next STGI.
I din't check the code, but just assumed that same issue should be
present. Now it makes sense. I totally forgot about STGI.


Thanks,
	Best regards,
		Maxim Levitsky

> 
> Paolo
> 
> > 
> > About the issue that was fixed in this patch. Let me try to
> > understand how
> > it would work on bare metal:
> > 
> > 1. A guest is entered. Host state is saved to VM_HSAVE_PA area (or
> > stashed somewhere
> >    in the CPU)
> > 
> > 2. #SMI (without intercept) happens
> > 
> > 3. CPU has to exit SVM, and start running the host SMI handler, it
> > loads the SMM
> >      state without touching the VM_HSAVE_PA runs the SMI handler,
> > then once it RSMs,
> >      it restores the guest state from SMM area and continues the
> > guest
> > 
> > 4. Once a normal VMexit happens, the host state is restored from
> > VM_HSAVE_PA
> > 
> > So host state indeed can't be saved to VMC01.
> > 
> > I to be honest think would prefer not to use the L1's hsave area
> > but rather add back our
> > 'hsave' in KVM and store there the L1 host state on the nested
> > entry always.
> > 
> > This way we will avoid touching the vmcb01 at all and both solve
> > the issue and
> > reduce code complexity.
> > (copying of L1 host state to what basically is L1 guest state area
> > and back
> > even has a comment to explain why it (was) possible to do so.
> > (before you discovered that this doesn't work with SMM).
> > 
> > Thanks again for fixing this bug!
> > 
> > Best regards,
> >         Maxim Levitsky
> > 
> 


