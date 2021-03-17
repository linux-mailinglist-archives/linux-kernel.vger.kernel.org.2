Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E899B33F983
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhCQTnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbhCQTnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:43:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05727C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:43:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id n9so235649pgi.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k1GpdqpKu5NtNVkT+q0ivL6GW8GOK1p+zqFeQGycyQ8=;
        b=fD0RYnSPouRbKSgAnr97CYQTPiHVojvbPRTlVyAiVq7KaPH26mMq2Hlgi4TifmVzGC
         5/HeCo1cGffHYMUFwZWt+vTBb0DaDY5iSBN5ErJEeHWugdIW5WtqPY46jZTI5q0SM1b2
         8lf52WoMKjLfctGYYsWz2tUlIhbM+xOaUCYt2DhzVr5C25QAh3soyMQVp/p8VlCFlt88
         WD9UD7aUfhQ1Vsh3SPBqRsKyRkkE0TLNS8BMj7KgExtuQvuViPR/sL+quY7GC8M30jM2
         Jzk8FVx/S1IKh4Vv5kI89yEsQTr0h649Qjs9m8XfAmvmxJg6CVyPndFFnAmnRmC4Z+qi
         6w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k1GpdqpKu5NtNVkT+q0ivL6GW8GOK1p+zqFeQGycyQ8=;
        b=MDcGTMzN0PLxcrow6HEeG2UHtJenXjbD/gEz71Lq/K7nbAWQPjrZH44xKZdn4vIGOb
         qXc1LuqJUJKQ/vkRFi5RGaq0Gg7VWTTEOdf0sc7JMJNTrgkkR1+PHbpu+s841qJdH6Db
         2sy0+wa7be1fmui0WtccOvdkfM+bLib9dqUpPAwxyhE0PfF+RdQkeHVVX48Z2PUd+dAR
         2NtKa836eksxRjTVT0NANKlNeRHsAtmkLMugAPoZevFA3rMXcXmphk8I3cB9MEdlGXRU
         coOgN8zoYTQtwZ7/C8FoaDJiBFhKwSILqQtt4Zgy6FvNEDt7SQz28uzBBxwN7xckPNOK
         /SXw==
X-Gm-Message-State: AOAM5339XgvEMukTL05prrIka1EnFYKUQgVHFVYdXKk67wYv7zULWe5U
        jplVkroqg4AJmugi/iren3t74Q==
X-Google-Smtp-Source: ABdhPJw7+PrjRE9F5cfVcFws45Z2+O9IQGN6ifUw+OSxPdjZnaroSK0SBRUqVTkRN4usleTFLvwlPw==
X-Received: by 2002:a63:130f:: with SMTP id i15mr3922891pgl.287.1616010195315;
        Wed, 17 Mar 2021 12:43:15 -0700 (PDT)
Received: from google.com ([2620:15c:f:10:e113:95c2:2d1:e304])
        by smtp.gmail.com with ESMTPSA id l3sm3451314pju.44.2021.03.17.12.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:43:14 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:43:08 -0700
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Peter Gonda <pgonda@google.com>
Subject: Re: [PATCH] x86/cpu/AMD: Adjust x86_phys_bits to account for reduced
 PA in SEV-* guests
Message-ID: <YFJbzIrGLXu2UsFv@google.com>
References: <20210317183243.2904919-1-seanjc@google.com>
 <20210317191132.GD25069@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317191132.GD25069@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021, Borislav Petkov wrote:
> On Wed, Mar 17, 2021 at 11:32:43AM -0700, Sean Christopherson wrote:
> > Note, early kernel boot code for SEV-*, e.g. get_sev_encryption_bit(),
> > _requires_ the SEV feature flag to be set in CPUID in order to identify
> > SEV (this requirement comes from the SEV-ES GHCB standard).  But, that
> > requirement does not mean the kernel must also "advertise" SEV in its own
> > CPU features array.
> 
> Sure it does - /proc/cpuinfo contains feature bits of stuff which has
> been enabled in the kernel. And when it comes to SEV, yeah, that was a
> lot of enablement. :-)

Ha, all I'm saying is that /proc/cpuinfo doesn't have to match the GHCB spec.

> > Fixes: d8aa7eea78a1 ("x86/mm: Add Secure Encrypted Virtualization (SEV) support")
> > Cc: stable@vger.kernel.org
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Cc: Peter Gonda <pgonda@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> > 
> > Regarding clearing SME, SEV, SEV_ES, etc..., it's obviously not required,
> > but to avoid false postives, identifying "SEV guest" within the kernel
> > must be done with sev_active().  And if we want to display support in
> > /proc/cpuinfo, IMO it should be a separate synthetic feature so that
> > userspace sees "sev_guest" instead of "sev".
> 
> I'm on the fence here, frankly. We issue capabilities in the guest dmesg
> in print_mem_encrypt_feature_info(). However, if someone wants to query
> SEV* status in the guest, then I don't have a good suggestion where to
> put it. cpuinfo is probably ok-ish, a new /sys/devices/system/cpu/caps/
> or so, should work too, considering the vuln stuff we stuck there so we
> can extend that. We'll see.
> 
> > 
> >  arch/x86/kernel/cpu/amd.c | 32 ++++++++++++++++++++++++++++----
> >  1 file changed, 28 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> > index 2d11384dc9ab..0f7f8c905226 100644
> > --- a/arch/x86/kernel/cpu/amd.c
> > +++ b/arch/x86/kernel/cpu/amd.c
> > @@ -15,6 +15,7 @@
> >  #include <asm/cpu.h>
> >  #include <asm/spec-ctrl.h>
> >  #include <asm/smp.h>
> > +#include <asm/mem_encrypt.h>
> >  #include <asm/numa.h>
> >  #include <asm/pci-direct.h>
> >  #include <asm/delay.h>
> > @@ -575,10 +576,33 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
> >  	resctrl_cpu_detect(c);
> >  }
> >  
> > +#define SEV_CBIT_MSG "SEV: C-bit (bit %d), overlaps MAXPHYADDR (%d bits).  VMM is buggy or malicious, overriding MAXPHYADDR to %d.\n"
> 
> Not sure about that. This will make a lot of users run scared, not
> knowing what's going on and open bugzillas.

Yeah, I'm not too sure about it either.  I would not object to dropping it to
a pr_info or pr_warn, and/or removing the "VMM is buggy or malicious" snippet.

> > +
> >  static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
> >  {
> >  	u64 msr;
> >  
> > +	/*
> > +	 * When running as an SEV guest of any flavor, update the physical
> > +	 * address width to account for the C-bit and clear all of the SME/SVE
> > +	 * feature flags.  As far as the kernel is concerned, the SEV flags
> > +	 * enumerate what features can be used by the kernel/KVM, not what
> > +	 * features have been activated by the VMM.
> > +	 */
> > +	if (sev_active()) {
> > +		int c_bit = ilog2(sme_me_mask);
> > +
> > +		BUG_ON(!sme_me_mask);
> > +
> > +		c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
> 
> Well, if that leaf is intercepted, how do you wanna trust this at all?

That's a good question for the AMD folks.  CPUID.0x80000008 and thus the original
x86_phys_bits is also untrusted.

> IOW, you have c_bit so your valid address space is [0 .. c_bit-1] no?

I haven't found anything in the GHCB that dictates that MAXPHYADDR == C_BIT-1,
or more specifically that MAXPHYADDR == C_BIT - PhysAddrReduction.  E.g. AFAICT,
a VMM could do C_BIT=47, MAXPHYADDR=36, PhysAddrReduction=0, and that would be
allowed by the GHCB.

Forcing "c->x86_phys_bits = c_bit - 1" doesn't seem like it would break anything,
but it's also technically wrong.
