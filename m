Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0131531DD3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhBQQWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbhBQQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:22:30 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9AFC061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:21:50 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e9so7666818plh.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bwj2VEQ4ikZLXStMngbVQVrHSRYYBYM85rwNvszv13s=;
        b=Ov16ZyHSFWepKkF6IllIRK+hBBfLe5qmWhpQflPEVUJ2N3wL9m949FdT9yZQwwiYSn
         qVVGh2QQdns8LanBABMPUIyPdVIDQ76ktuZsSCotbelbZY/nJK5Kv2CVXrmmDpNGJ9l+
         kO41IcjfFZSFpccgOVPy9EM8cVqgmt0bsVO0TeDNg6oYhP6wb0hAPJ5SO8x52KOFwNEN
         HUVQMbWsCWnHlZHh+CyeH/oJo44WJqw2jJfHaB5/y24wJNMZE1iVjrc2/UOUSymrTG3+
         zCVgokBQJMmxm3ZsKiRYSqjSPnq1aR9EARsqQb4MwPK3rLYZSkZoa/w5/zHviwZ3uzO/
         HfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bwj2VEQ4ikZLXStMngbVQVrHSRYYBYM85rwNvszv13s=;
        b=WoY64Az4ANMUXK6gylRYImoImLAKrO2gP/D+a7EawPiobIT6xMdh2lLSae2JQ2NkAQ
         zQK8a7+s4kVyURvamxO8QeTXTVk3N6zMploXIqpSY5czHyIEWNyugi9njy2Ioq1aQFhm
         LdHmVlDl/YPK5DDZhRZDYzujEsmuo3BwJEI+FG98YOwU1kEAI8PNVQ/NAMZ+Ra7ww/DS
         zN/sWYtmo+BbZBd8iXXsiUky2T3hjyALIOZayOAc4jh32Kjg2Q/GA7MBvlBeNlPqfh9J
         9M4yzXBsLmlPzQ2WLzlZ2KxGv9TpNHSWpaQwZuAre5cUJCjhxOumgkX+C9pgfFP7g4u7
         J61A==
X-Gm-Message-State: AOAM533NezjpZl0p9WVR8f1r3UZ3JlKV4Z4gRqimiltq+W/AJdr12k9q
        uQaDuwuBd5AtxNrrorJM8QdKQQ==
X-Google-Smtp-Source: ABdhPJwGGTJIBNFKGIKh95oKMrdWxG3JIp0VG9LMy9AJE6gGrhsvaQ6IcJhHmkJTQPLOEjsdYCTUqA==
X-Received: by 2002:a17:90b:358f:: with SMTP id mm15mr9947155pjb.13.1613578909662;
        Wed, 17 Feb 2021 08:21:49 -0800 (PST)
Received: from google.com ([2620:15c:f:10:6948:259b:72c6:5517])
        by smtp.gmail.com with ESMTPSA id c14sm2411286pfd.109.2021.02.17.08.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:21:49 -0800 (PST)
Date:   Wed, 17 Feb 2021 08:21:42 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/7] KVM: VMX: read idt_vectoring_info a bit earlier
Message-ID: <YC1Cljte2ozGSKV/@google.com>
References: <20210217145718.1217358-1-mlevitsk@redhat.com>
 <20210217145718.1217358-2-mlevitsk@redhat.com>
 <09de977a-0275-0f4f-cf75-f45e4b5d9ca5@redhat.com>
 <666eb754189a380899b82e0a9798eb2560ae6972.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <666eb754189a380899b82e0a9798eb2560ae6972.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021, Maxim Levitsky wrote:
> On Wed, 2021-02-17 at 17:06 +0100, Paolo Bonzini wrote:
> > On 17/02/21 15:57, Maxim Levitsky wrote:
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index b3e36dc3f164..e428d69e21c0 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -6921,13 +6921,15 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
> > >  	if (unlikely((u16)vmx->exit_reason.basic == EXIT_REASON_MCE_DURING_VMENTRY))
> > >  		kvm_machine_check();
> > >  
> > > +	if (likely(!vmx->exit_reason.failed_vmentry))
> > > +		vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
> > > +
> > 
> > Any reason for the if?
> 
> Sean Christopherson asked me to do this to avoid updating idt_vectoring_info on failed
> VM entry, to keep things as they were logically before this patch.

Ya, specifically because the field isn't valid if VM-Enter fails.  I'm also ok
with an unconditional VMREAD if we add a comment stating that it's unnecessary
if VM-Enter failed, but faster in the common case.
