Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2D331A6B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhBLVTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhBLVTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:19:31 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A817C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:18:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id nm1so321832pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=puPSa5+BGW9nqcMGlCFaJeX+UVnQ3PZGElCApLRKkWE=;
        b=cjjrhbbEDvT15A9JlprYYaO/sW6xWO1TQVlKbBCmanUhuSRPE27vC3tU9SDvVNiZ/i
         tzSooStcLMdMdFHuTShOCsS5/0UxlVC7ottdWfjRtWzbCQ09I5cuMjRZlmGveew9QCvt
         yr5xb4pFS7UtMhRJcTV6164/j4GTtxtoyOYd1POXwqeIKYCAd2/GB5ZRhn0SAlUr7S/G
         N8SLMr9nAIi2AfrTvPMMzhIBPuhvtzleCzoGT4bWHSBB3GfM4D+HlSzKb0eFAo5HnMDW
         xVOOpvzW7PgFgvP85nvDgv+keoPZefK8xFdx3D9h0aiXsTQAu3bfV/FPxKRYP6Av7HGr
         aQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=puPSa5+BGW9nqcMGlCFaJeX+UVnQ3PZGElCApLRKkWE=;
        b=r+JaGLnwp7fLKTagPpzKilD+AAdbLQIbCz9710fsvceWVY8kPzeO2AZzKGBkCzCyAs
         k3lULlA3SpFJfXSzjsYiXAgU848PvRTTXcx8zw1L/JsEv9fcmY4M+8B+tKZgO1rXBlTl
         wQrijOMu3tkf/crQlmIhItZ3GO1QgPwf+L3FZZCc+SrdH2l5FF+/e5PXOn9y25B6eVlV
         vqJ9EEVQvME4pjVl+2Zr4yoEu1rVdmjIjqTVtglnRqonZ2+L8Qh4Qh3VrDf9AmreeT6A
         lNB+T3vQGTzzaCSeub2rwJun3DhumSjbrwWtLbOuDzPMszhWMkhepWW6e9BiCspdtfsk
         80kQ==
X-Gm-Message-State: AOAM5336ng+RpdL9aRgVZIqYJWoHBSDOdH7/OeLehv5xbC3VDe/c0AV9
        p0kRFueOhgzXrU9lIrahkMtGnQ==
X-Google-Smtp-Source: ABdhPJwTld5G0Tr9luoSjSkXtGGY5seN8PDa1AJIuTfjAPcGArAGwmZBe/iSZCc2nVlfk9KUR0JDBg==
X-Received: by 2002:a17:90a:46cc:: with SMTP id x12mr4397347pjg.114.1613164730728;
        Fri, 12 Feb 2021 13:18:50 -0800 (PST)
Received: from google.com ([2620:15c:f:10:b407:1780:13d2:b27])
        by smtp.gmail.com with ESMTPSA id m4sm9609229pfd.130.2021.02.12.13.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 13:18:49 -0800 (PST)
Date:   Fri, 12 Feb 2021 13:18:43 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Makarand Sonare <makarandsonare@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, pshier@google.com, jmattson@google.com,
        Ben Gardon <bgardon@google.com>
Subject: Re: [RESEND PATCH ] KVM: VMX: Enable/disable PML when dirty logging
 gets enabled/disabled
Message-ID: <YCbws4v7Up2daHyQ@google.com>
References: <20210210212308.2219465-1-makarandsonare@google.com>
 <YCbE+hJC8xeWnKRg@google.com>
 <CA+qz5sqFYrFj=0+kq9m4huwkpC6V8MV_vy5c05VNqMgCPw+fDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+qz5sqFYrFj=0+kq9m4huwkpC6V8MV_vy5c05VNqMgCPw+fDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021, Makarand Sonare wrote:
> >> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> >> index 777177ea9a35e..eb6639f0ee7eb 100644
> >> --- a/arch/x86/kvm/vmx/vmx.c
> >> +++ b/arch/x86/kvm/vmx/vmx.c
> >> @@ -4276,7 +4276,7 @@ static void
> >> vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
> >>  	*/
> >>  	exec_control &= ~SECONDARY_EXEC_SHADOW_VMCS;
> >>
> >> -	if (!enable_pml)
> >> +	if (!enable_pml || !vcpu->kvm->arch.pml_enabled)
> >>  		exec_control &= ~SECONDARY_EXEC_ENABLE_PML;
> >
> > The checks are unnecessary if PML is dynamically toggled, i.e. this snippet
> > can
> > unconditionally clear PML.  When setting SECONDARY_EXEC (below snippet),
> > PML
> > will be preserved in the current controls, which is what we want.
> 
> Assuming a new VCPU can be added at a later time after PML is already
> enabled, should we clear
> PML in VMCS for the new VCPU. If yes what will be the trigger for
> setting PML for the new VCPU?

Ah, didn't consider that.  Phooey.

> >>  	if (cpu_has_vmx_xsaves()) {
> >> @@ -7133,7 +7133,8 @@ static void vmcs_set_secondary_exec_control(struct
> >> vcpu_vmx *vmx)
> >>  		SECONDARY_EXEC_SHADOW_VMCS |
> >>  		SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> >>  		SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> >> -		SECONDARY_EXEC_DESC;
> >> +		SECONDARY_EXEC_DESC |
> >> +		SECONDARY_EXEC_ENABLE_PML;
> >>
> >>  	u32 new_ctl = vmx->secondary_exec_control;
> >>  	u32 cur_ctl = secondary_exec_controls_get(vmx);
> >> @@ -7509,6 +7510,19 @@ static void vmx_sched_in(struct kvm_vcpu *vcpu, int
> >> cpu)
> >>  static void vmx_slot_enable_log_dirty(struct kvm *kvm,
> >>  				     struct kvm_memory_slot *slot)
> >>  {
> >> +	/*
> >> +	 * Check all slots and enable PML if dirty logging
> >> +	 * is being enabled for the 1st slot
> >> +	 *
> >> +	 */
> >> +	if (enable_pml &&
> >> +	    kvm->dirty_logging_enable_count == 1 &&
> >> +	    !kvm->arch.pml_enabled) {
> >> +		kvm->arch.pml_enabled = true;
> >> +		kvm_make_all_cpus_request(kvm,
> >> +			KVM_REQ_UPDATE_VCPU_DIRTY_LOGGING_STATE);
> >> +	}

...

> >> @@ -1366,15 +1367,24 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >>  	}
> >>
> >>  	/* Allocate/free page dirty bitmap as needed */
> >> -	if (!(new.flags & KVM_MEM_LOG_DIRTY_PAGES))
> >> +	if (!(new.flags & KVM_MEM_LOG_DIRTY_PAGES)) {
> >>  		new.dirty_bitmap = NULL;
> >> -	else if (!new.dirty_bitmap && !kvm->dirty_ring_size) {
> >> +
> >> +		if (old.flags & KVM_MEM_LOG_DIRTY_PAGES) {
> >> +			WARN_ON(kvm->dirty_logging_enable_count == 0);
> >> +			--kvm->dirty_logging_enable_count;
> >
> > The count will be corrupted if kvm_set_memslot() fails.
> >
> > The easiest/cleanest way to fix both this and the refcounting bug is to
> > handle the count in kvm_mmu_slot_apply_flags().  That will also allow
> > making the dirty log count x86-only, and it can then be renamed to
> > cpu_dirty_log_count to align with the
> >
> > We can always move/rename the count variable if additional motivation for
> > tracking dirty logging comes along.
> 
> Thanks for pointing out. Will this solution take care of the scenario
> where a memslot is created/deleted with LOG_DIRTY_PAGE?

Yes?  At least, that's the plan. :-)  I'll post my whole series as an RFC later
today so you and Ben can poke holes in my changes.  There are some TDP MMU fixes
that I've accumulated and would like to get posted before the 5.12 merge window
opens, if only so that Paolo can make an informed decision on whether or not to
enable TDP MMU by default.
