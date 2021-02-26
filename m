Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF844326A32
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 23:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBZWrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 17:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBZWrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:47:45 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FA8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:47:05 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id h4so7053713pgf.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FWfKwt6kX8wvyCzXU6S1wzKG11gxPLhSQUXPm/zfyRo=;
        b=BFoe7wL57k1glMCiP+TaTWRj6VJ5zCjEDlz8+lad9Fzz+M+mlAFI6XqQD6dF1v9HlB
         ZOfON2h9r/7U4alRF/PMshKlZ+ONIj+3+l9DUuT2dl/2+r+owhnr00JhXlqTR7q2mKeu
         ixt7ZQ50544Lgn3fQfJJsekG3jMOhzTHEAKPCN0L0iyDauUgjvQDcn+8/TKnXJtK1rkt
         iHs9d8cDsU3YyRxnJVhEFn2qFjsOVO0813bQXS2YeUDtPGT7Je6Quz8ZBee4nbdyIjDF
         A5Gsq92iZpx4cAspVOBYQKN4x1glYF9VrpoLum8/VKGhsW+5kzXLK9Sa6Zzihj9c6ine
         6mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FWfKwt6kX8wvyCzXU6S1wzKG11gxPLhSQUXPm/zfyRo=;
        b=LcPgYAmos0F0i/F2CCYEPv1/ZOW94fdh5KMiasRdzNL+igyZMAFcJlbt/VTQ7++p74
         rAYaUdgrorERCRoDdcVozhIiT2ACmEdjy0Mm1RYO8hIo8mAOwDiziilAXogHDJPyU9iu
         jSi6p0gM5+ouw1pm++B6zUs686tWtXS7BC1iAB5upbnHWnOOKoFz+8BTo1l4+dQqhJOw
         OhtIcqYV1xk8K+Ivj3nDawKp+F1hK7qOHIAag6UPf/wH/w3AgxckV2HLZRtyqR/Z2w9h
         2EeYz0dH3+H5NKnEjsW5s4xKdDc2b65ddG1ULtzhPh4dzV+CNcuqh3Vwcr4XMuNX0d4G
         oq2w==
X-Gm-Message-State: AOAM531bq+Y2mcTj1ZAp+i27qH83UKjbTYua3Gu2GjdKSgdABAIdmNVu
        1595+NmXUibR78PED2p8El1A5A==
X-Google-Smtp-Source: ABdhPJysX1Gy5qQjxhZxEfRalgZ8Np1GGaCY1UR8vYL+V5Gxo7+xl49YaHAqcCOn+yAnbwJnn5Jp0Q==
X-Received: by 2002:a65:62c7:: with SMTP id m7mr4776831pgv.50.1614379624821;
        Fri, 26 Feb 2021 14:47:04 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e190:bf4c:e355:6c55])
        by smtp.gmail.com with ESMTPSA id y72sm10658312pfg.126.2021.02.26.14.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 14:47:04 -0800 (PST)
Date:   Fri, 26 Feb 2021 14:46:57 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     "Xu, Like" <like.xu@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: vmx/pmu: Fix dummy check if lbr_desc->event is
 created
Message-ID: <YDl6YaJJqaApUALx@google.com>
References: <20210223013958.1280444-1-like.xu@linux.intel.com>
 <YDU4II6Jt+E5nFmG@google.com>
 <ca26c4e9-207a-2882-649d-fe82604f68f9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca26c4e9-207a-2882-649d-fe82604f68f9@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021, Xu, Like wrote:
> On 2021/2/24 1:15, Sean Christopherson wrote:
> > On Tue, Feb 23, 2021, Like Xu wrote:
> > > If lbr_desc->event is successfully created, the intel_pmu_create_
> > > guest_lbr_event() will return 0, otherwise it will return -ENOENT,
> > > and then jump to LBR msrs dummy handling.
> > > 
> > > Fixes: 1b5ac3226a1a ("KVM: vmx/pmu: Pass-through LBR msrs when the guest LBR event is ACTIVE")
> > > Signed-off-by: Like Xu <like.xu@linux.intel.com>
> > > ---
> > >   arch/x86/kvm/vmx/pmu_intel.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> > > index d1df618cb7de..d6a5fe19ff09 100644
> > > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > > @@ -320,7 +320,7 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
> > >   	if (!intel_pmu_is_valid_lbr_msr(vcpu, index))
> > >   		return false;
> > > -	if (!lbr_desc->event && !intel_pmu_create_guest_lbr_event(vcpu))
> > > +	if (!lbr_desc->event && intel_pmu_create_guest_lbr_event(vcpu))
> > >   		goto dummy;

...
 
> > AFAICT, event contention would lead to a #GP crash in the host due to
> > lbr_desc->event being dereferenced, no?
> 
> a #GP crash in the host ？Can you share more understanding about it ?

The original code is will dereference a null lbr_desc->event if
intel_pmu_create_guest_lbr_event() fails.

	if (!lbr_desc->event && intel_pmu_create_guest_lbr_event(vcpu))  <- falls through
		goto dummy;

	/*
	 * Disable irq to ensure the LBR feature doesn't get reclaimed by the
	 * host at the time the value is read from the msr, and this avoids the
	 * host LBR value to be leaked to the guest. If LBR has been reclaimed,
	 * return 0 on guest reads.
	 */
	local_irq_disable();
	if (lbr_desc->event->state == PERF_EVENT_STATE_ACTIVE) { <--------- kaboom
		if (read)
			rdmsrl(index, msr_info->data);
		else
			wrmsrl(index, msr_info->data);
		__set_bit(INTEL_PMC_IDX_FIXED_VLBR, vcpu_to_pmu(vcpu)->pmc_in_use);
		local_irq_enable();
		return true;
	}
