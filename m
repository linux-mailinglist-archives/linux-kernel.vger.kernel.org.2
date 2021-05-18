Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6887388182
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352204AbhERUlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhERUlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:41:18 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FD7C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:39:59 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j12so7848843pgh.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8MubtEG9hK/q62MrmOSyAzp2k5GJqxjxUkR+amxPdgc=;
        b=PcrjhRa4xcHp7ujVxO0lmMGqSmgSR4otIGIf/+coy/SW7sRDxwEKyrm9o9dl/3bOcy
         iXOMGxh6b7kzfKskp6FH5dTZi4V6bEU4ejXmpqmdsTX8aZnVb6FPHPhGMuV0m/IZh1qE
         hcFvrYqCn4F4Z96r3DXpmh8OXCSWs8YRTAoZA48fMAEi9+d4lPN3wFQUQ2+lDiWPk553
         8POSF+ud5ujlr1oUuvRuUvbkJeGfw//Qw2wjS5ihoCwhkPyi8Uf/w6hwlISU0O14cClm
         dQ+ZCohdyBi9yCBcRSETSb2qZnkAOgkm57WlBfAl9sSxHJYOc5Jkcoy1Q+muDRbuUwGJ
         NU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8MubtEG9hK/q62MrmOSyAzp2k5GJqxjxUkR+amxPdgc=;
        b=jaWQUsOPl8DHqiZs9eKR9XuH5Rb0DqEWOUBLKhMdTisAedCTLZvrx0XE6+h5qsUvXm
         BhQN5h3zFLELQaerMkFBqkn0s31elhnGPdiE2tpJ18dc0xAx2VY/BpMvySfiLVfZAuxO
         Eizc+M9MbxfD6FTcoXXqcTpwvEAg+20+Fc2Yde2FcmllvjJH3jjqUPU3fDDuyVbSv8fw
         RFqOrW6DlGcSuljrR5tsfzDLGIbnOsob98cJ+FV1X5RudVzm/eTewaziUCep98AYHCdk
         ftuPX9i9h7H757DLhtc8nocT4/Bp1qb3xEAf81J5r5rswESIVnOAa5r5SFfmC88yZVjv
         MWyA==
X-Gm-Message-State: AOAM533owwDo1MZkSPvmkH/q+ZbQWRRy+t1Ai6FFImrf3pdpVVHmqYB+
        8VHEYl44v+mrfwcVOBQmXfZYcw==
X-Google-Smtp-Source: ABdhPJyJTdNS2lrAnYR/uikbhBl5SfQpQwYVsIIIOsAoPSHilYioRlMVXx4wLfM/LO4yNcXFcKdhnA==
X-Received: by 2002:a63:4083:: with SMTP id n125mr6960937pga.398.1621370399328;
        Tue, 18 May 2021 13:39:59 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id r13sm7745401pfl.191.2021.05.18.13.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:39:58 -0700 (PDT)
Date:   Tue, 18 May 2021 20:39:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Kechen Lu <kechenl@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] KVM: x86: Use common 'enable_apicv' variable for
 both APICv and AVIC
Message-ID: <YKQmG3rMpwSI3WrV@google.com>
References: <20210518144339.1987982-1-vkuznets@redhat.com>
 <20210518144339.1987982-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518144339.1987982-4-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021, Vitaly Kuznetsov wrote:
> Unify VMX and SVM code by moving APICv/AVIC enablement tracking to common
> 'enable_apicv' variable. Note: unlike APICv, AVIC is disabled by default.
> 
> No functional change intended.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

...

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 8c3918a11826..0d6ec34d1e4b 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -185,6 +185,10 @@ module_param(vls, int, 0444);
>  static int vgif = true;
>  module_param(vgif, int, 0444);
>  
> +/* enable / disable AVIC */
> +static int avic;
> +module_param(avic, int, 0444);

We should opportunistically make avic a "bool".

> +
>  bool __read_mostly dump_invalid_vmcb;
>  module_param(dump_invalid_vmcb, bool, 0644);
>  
> @@ -1009,14 +1013,15 @@ static __init int svm_hardware_setup(void)
>  			nrips = false;
>  	}
>  
> -	if (avic) {
> -		if (!npt_enabled || !boot_cpu_has(X86_FEATURE_AVIC)) {
> -			avic = false;
> -		} else {
> -			pr_info("AVIC enabled\n");
> +	if (!npt_enabled || !boot_cpu_has(X86_FEATURE_AVIC))
> +		avic = false;
>  
> -			amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
> -		}
> +	/* 'enable_apicv' is common between VMX/SVM but the defaults differ */

-1 for not throwing Jim under the bus :-)

Nits aside,

Reviewed-by: Sean Christopherson <seanjc@google.com>
