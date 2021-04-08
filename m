Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0214358DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhDHTsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhDHTsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:48:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050DC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 12:48:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d5-20020a17090a2a45b029014d934553c4so2800483pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=slIcnAT6MK3QWayLyTgibOhZ8J5ecsz1ts63iYPU+Ew=;
        b=ByChbfV0kxhGhFuxR5Zf9zUMxSisHCNb7EZxRu9oVkdMnRYBIDY6ddCZkdGWprWVam
         CdOVspgLsS592RuHjp9G9FJSHlZQJqmpFBlpdilPYpry66+rbGF8APvxTCpMU+LVP+HN
         QL4T1u/sGETU8c6C2GxnWJBXrBsdA+G7HGtb7fpZxm6NqxiGovNWtv82kcghKBGHgCVy
         rlcZgT8o6fD0KTBrcWn/UKmdS/qIaIcKhWjhO50sc1Mr2In9inzIkHtdnvlB9+QBgO64
         aSmKjwAp4jAQDca2HHhVdau8m0iVFZScJQf3G7K2kDjB75mqe9/sIBSUWqgmEhfsxuoE
         uIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=slIcnAT6MK3QWayLyTgibOhZ8J5ecsz1ts63iYPU+Ew=;
        b=Zcpjc4EYprDPVmsFlV7rBsOuSZGJmYhyXAT+q2VNBCdwmdjy5IGpxg1XK8S43JX7L4
         x61sA14UpX+9enfG5jqvDNDiwTnEcseWBv0NEJnutWFXzgMw0IUm325hmExna1kjeU0r
         etpW3RWysAvtRheofasgfF4F1IZNhC74m/XLtL7UiAitFjVmuJC1BebHOsOvPW7f27SB
         a1W0L5TDIq2CaqunxMlqH3Jwa2MFPMIZFRl0BW7P/pwBblOM/Fyo6saGweYcT2zqz68C
         OrtwCA87ja2uT3OVYIXH2CHJGa0FI8h1bPFKFXbHJxLMliHiaLBD5YnnFwFEoEwjJpSB
         N2sg==
X-Gm-Message-State: AOAM530qvk5LgYdlbzJ4rdfIZWMLd5B82DEF6v72mNia7XAX3CSnSHAd
        fFz7iimqrZ/bOVif3boZCl0jVNiGIRxk0w==
X-Google-Smtp-Source: ABdhPJzKuGi1quyB4B1Wtfaf3Kknfdy/GuUW+JHPGFqXjjZ9gnG75L+DXebSo7BurPh99KbkQlzK0Q==
X-Received: by 2002:a17:90b:1498:: with SMTP id js24mr652227pjb.83.1617911285864;
        Thu, 08 Apr 2021 12:48:05 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id t19sm256738pfg.38.2021.04.08.12.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:48:05 -0700 (PDT)
Date:   Thu, 8 Apr 2021 19:48:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2] KVM: SVM: Make sure GHCB is mapped before updating
Message-ID: <YG9d8aOuZKasgw2j@google.com>
References: <1ed85188bee4a602ffad9632cdf5b5b5c0f40957.1617900892.git.thomas.lendacky@amd.com>
 <YG85HxqEAVd9eEu/@google.com>
 <923548be-db20-7eea-33aa-571347a95526@amd.com>
 <YG8/WHFOPX6H1eJf@google.com>
 <3c28c9bf-d14e-3f9b-0973-ba4a438aaa33@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c28c9bf-d14e-3f9b-0973-ba4a438aaa33@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021, Tom Lendacky wrote:
> 
> 
> On 4/8/21 12:37 PM, Sean Christopherson wrote:
> > On Thu, Apr 08, 2021, Tom Lendacky wrote:
> >> On 4/8/21 12:10 PM, Sean Christopherson wrote:
> >>> On Thu, Apr 08, 2021, Tom Lendacky wrote:
> >>>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> >>>> index 83e00e524513..7ac67615c070 100644
> >>>> --- a/arch/x86/kvm/svm/sev.c
> >>>> +++ b/arch/x86/kvm/svm/sev.c
> >>>> @@ -2105,5 +2105,8 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
> >>>>  	 * the guest will set the CS and RIP. Set SW_EXIT_INFO_2 to a
> >>>>  	 * non-zero value.
> >>>>  	 */
> >>>> +	if (WARN_ON_ONCE(!svm->ghcb))
> >>>
> >>> Isn't this guest triggerable?  I.e. send a SIPI without doing the reset hold?
> >>> If so, this should not WARN.
> >>
> >> Yes, it is a guest triggerable event. But a guest shouldn't be doing that,
> >> so I thought adding the WARN_ON_ONCE() just to detect it wasn't bad.
> >> Definitely wouldn't want a WARN_ON().
> > 
> > WARNs are intended only for host issues, e.g. a malicious guest shouldn't be
> > able to crash the host when running with panic_on_warn.
> > 
> 
> Ah, yeah, forgot about panic_on_warn. I can go back to the original patch
> or do a pr_warn_once(), any pref?

No strong preference.  If you think the print would be helpful for ongoing
development, then it's probably worth adding.
