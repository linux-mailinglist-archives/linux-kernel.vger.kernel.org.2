Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1807F307BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhA1RMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbhA1RKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:10:05 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2774DC061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:25 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i7so4676052pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PJ8vhRlRVNsnNigVA3H+x3MLmJHygV2g8jXvg7Vnj4Y=;
        b=kLroCc1xOeYMVKQR0s/ZTRX42tJ/fVbTONzC/+Y7nlPAB9ANbAatBAgie7gpPCjzXW
         Y2BvBl2+i9f+Ziz4nBFIcLoBoBAlJm1hWLFTbiJ1Si2k7PwvQNhflJGVbZio6DiwXiDX
         3QhggykFuj+J36w0q3sqHyHPH4DPP4/wsxBOmWqTCSBkL88ESZibZQoOLkGkjS861gGd
         OTEXpz4vrcYffjOCI01VN1Ovv6MbJOUfP/ZESb2JAqLw78rNUD2nvDogSsN8Cg95Hhg5
         4rrL0x9ERcull8gxyr/f4Z27WaXxnxeeoSDGXcdv5W0J+IfUFOVsEFNFEzdIsbQEk7I7
         CK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJ8vhRlRVNsnNigVA3H+x3MLmJHygV2g8jXvg7Vnj4Y=;
        b=V+UwuB0Df75eiMzbv3HUQPmw1E2ooHT5zPIZabd+GG1oCGYQdpNTPhQPqlsO2NA/Jz
         XGobx7gycHJfaHK8KqtmNRz9MxtZA72cx1B5jhd54lJr8R6xFUO+h3YBXvDTCn59njgM
         u2+FlPc3yQrXBlPlFw9LaCMJ7Ct9SfmwqOE0jXcbM6T8LMZJnj5m4H0OMvRpu4B0ecHA
         FPurZBL9nLnOzQaHBEPwSwasLrv5Z/tFPDE/LYDlF5GmiAuM8j9uHJ/uNgIabnbJuNoV
         W5RU0ZtH17BhZklymWgzoya7WCtvQYaEW48fM8+pOEM1Q+z/q+LGZTfqxVwGb2SEHYDk
         MNSg==
X-Gm-Message-State: AOAM533d14RG7LlxfBbpq06WFbRnSMFZNPuuTLTBQ34R9u6gdvriuUX9
        5JuAmTwgNoTdO7ww/temVAcKFw==
X-Google-Smtp-Source: ABdhPJxnMcoxMMfmamEou+2TlotHDWW8f0QfrKGSgKlCV6FqqyFfUIJe76KcBU9KACT92xkL360dbg==
X-Received: by 2002:a65:6453:: with SMTP id s19mr481327pgv.280.1611853764502;
        Thu, 28 Jan 2021 09:09:24 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id 5sm5389515pjz.23.2021.01.28.09.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:09:23 -0800 (PST)
Date:   Thu, 28 Jan 2021 09:09:18 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2 05/14] KVM: x86: Override reported SME/SEV feature
 flags with host mask
Message-ID: <YBLvvpeEORjVd2IP@google.com>
References: <20210114003708.3798992-1-seanjc@google.com>
 <20210114003708.3798992-6-seanjc@google.com>
 <74642db3-14dc-4e13-3130-dc8abe1a2b6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74642db3-14dc-4e13-3130-dc8abe1a2b6e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021, Paolo Bonzini wrote:
> On 14/01/21 01:36, Sean Christopherson wrote:
> > Add a reverse-CPUID entry for the memory encryption word, 0x8000001F.EAX,
> > and use it to override the supported CPUID flags reported to userspace.
> > Masking the reported CPUID flags avoids over-reporting KVM support, e.g.
> > without the mask a SEV-SNP capable CPU may incorrectly advertise SNP
> > support to userspace.
> > 
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/cpuid.c | 2 ++
> >   arch/x86/kvm/cpuid.h | 1 +
> >   2 files changed, 3 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index 13036cf0b912..b7618cdd06b5 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -855,6 +855,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
> >   	case 0x8000001F:
> >   		if (!boot_cpu_has(X86_FEATURE_SEV))
> >   			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> > +		else
> > +			cpuid_entry_override(entry, CPUID_8000_001F_EAX);
> >   		break;
> >   	/*Add support for Centaur's CPUID instruction*/
> >   	case 0xC0000000:
> > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > index dc921d76e42e..8b6fc9bde248 100644
> > --- a/arch/x86/kvm/cpuid.h
> > +++ b/arch/x86/kvm/cpuid.h
> > @@ -63,6 +63,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
> >   	[CPUID_8000_0007_EBX] = {0x80000007, 0, CPUID_EBX},
> >   	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
> >   	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
> > +	[CPUID_8000_001F_EAX] = {0x8000001f, 1, CPUID_EAX},
> >   };
> >   /*
> > 
> 
> I don't understand, wouldn't this also need a kvm_cpu_cap_mask call
> somewhere else?  As it is, it doesn't do anything.

Ugh, yes, apparently I thought the kernel would magically clear bits it doesn't
care about.

Looking at this again, I think the kvm_cpu_cap_mask() invocation should always
mask off X86_FEATURE_SME.  SME cannot be virtualized, and AFAIK it's not
emulated by KVM.  This would fix an oddity where SME would be advertised if SEV
is also supported.

Boris has queue the kernel change to tip/x86/cpu, I'll spin v4 against that.
