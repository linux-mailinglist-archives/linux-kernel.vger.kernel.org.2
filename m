Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E224072E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 23:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhIJV0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 17:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbhIJV0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:26:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC76C061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:25:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id dw14so1332406pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hNXoetdf0vSmo87Dxq7RWSc3TBCJiQr558RgCaM5xeo=;
        b=OhiiW7eOOxRvvFYs4RGNSH5g7H82RSOE5Y8VKniFEOTJoT4q33rcxrcsM3AIyZ5FLQ
         5tIeySGF5xaFy00wd6Dz9IBj+VgJqzVOuTZCxbizFwXCOgR4B0+XPvnUCZ4GOgY2B50q
         7gsWWujJLSs3mPJKasIFqyQGeIihUGTR8WKVaGT7ckKLpxE0csiWOkgEMqfVl/88SXbX
         i9ado6TIoRVNgQ36HVArzD4Nod+6jFXHyiarKA32em5j1lBZ+438d0C7of9CWJAiqNXB
         vzEbs6F3qMUpvgU6tz4kt1iCZ3X6lvRRAsU/O6NUGlPUxWmRU7CYrK0Zy1tvKWaWSgyp
         X/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hNXoetdf0vSmo87Dxq7RWSc3TBCJiQr558RgCaM5xeo=;
        b=tgO0cAiExjSylxZ1W/nn5HbxHiAiHEMcXmp2wg/sBbTQOmFJlqsjm4kLQPJAofdDE8
         XlPN+0LzYB2gYwXV9MaZUDqIxq+IyHM/2GVHTovkXdQtsi4OxHIMKNjq1sBcGnKPj4Yx
         l78Oz9WIkEYGDKq93VvTI6KFIMYJYKUK5XmYUjCCWXQL6wpqYCwYC8teRxTXA8BeKV7p
         a+DMD/43dNtyhROWLsqS2RaptVnQ2yB9MMZIcNPb4ohHYzUJa1/wGCZW/fhSGE5LW9W/
         w+JG3Bp6xHWvoaCXm7YwKQMZkHpD/KLqqnotJ42nF5haYTPMLuQ0fCmWT2joK7vONNYl
         nqsA==
X-Gm-Message-State: AOAM5301gRX/JrYjTlQoH/3jLX2OiIHeV98tKw8ZPcINKL+aemcnGlUM
        JVTPIHy1U/BFsujZnvVuGbvRYQ==
X-Google-Smtp-Source: ABdhPJzoWSETaKcosebsuIAvqdf7dSkGLP1mSVHX+fy+vPVXXTmCMngfOSJtCsMHJOq7JdoJgLzr9A==
X-Received: by 2002:a17:902:c944:b0:138:7cd2:dd with SMTP id i4-20020a170902c94400b001387cd200ddmr9403386pla.72.1631309105666;
        Fri, 10 Sep 2021 14:25:05 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x22sm5721767pfm.102.2021.09.10.14.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 14:25:05 -0700 (PDT)
Date:   Fri, 10 Sep 2021 21:25:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Hu <robert.hu@intel.com>,
        Gao Chao <chao.gao@intel.com>,
        Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v4 1/6] x86/feat_ctl: Add new VMX feature, Tertiary
 VM-Execution control
Message-ID: <YTvNLd0PwX+PijH7@google.com>
References: <20210809032925.3548-1-guang.zeng@intel.com>
 <20210809032925.3548-2-guang.zeng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809032925.3548-2-guang.zeng@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86/cpu: is probaby more appropriate, this touches more than just feat_ctl.

On Mon, Aug 09, 2021, Zeng Guang wrote:
> From: Robert Hoo <robert.hu@linux.intel.com>
> 
> New VMX capability MSR IA32_VMX_PROCBASED_CTLS3 conresponse to this new
> VM-Execution control field. And it is 64bit allow-1 semantics, not like
> previous capability MSRs 32bit allow-0 and 32bit allow-1. So with Tertiary
> VM-Execution control field introduced, 2 vmx_feature leaves are introduced,
> TERTIARY_CTLS_LOW and TERTIARY_CTLS_HIGH.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> ---

Nits aside,

Reviewed-by: Sean Christopherson <seanjc@google.com>

> @@ -22,7 +24,7 @@ enum vmx_feature_leafs {
>  
>  static void init_vmx_capabilities(struct cpuinfo_x86 *c)
>  {
> -	u32 supported, funcs, ept, vpid, ign;
> +	u32 supported, funcs, ept, vpid, ign, low, high;
>  
>  	BUILD_BUG_ON(NVMXINTS != NR_VMX_FEATURE_WORDS);
>  
> @@ -42,6 +44,13 @@ static void init_vmx_capabilities(struct cpuinfo_x86 *c)
>  	rdmsr_safe(MSR_IA32_VMX_PROCBASED_CTLS2, &ign, &supported);
>  	c->vmx_capability[SECONDARY_CTLS] = supported;
>  
> +	/*
> +	 * For tertiary execution controls MSR, it's actually a 64bit allowed-1.
> +	 */

Maybe something like this to better fit on one line?

	/* All 64 bits of tertiary controls MSR are allowed-1 settings. */

> +	rdmsr_safe(MSR_IA32_VMX_PROCBASED_CTLS3, &low, &high);
> +	c->vmx_capability[TERTIARY_CTLS_LOW] = low;
> +	c->vmx_capability[TERTIARY_CTLS_HIGH] = high;
> +
>  	rdmsr(MSR_IA32_VMX_PINBASED_CTLS, ign, supported);
>  	rdmsr_safe(MSR_IA32_VMX_VMFUNC, &ign, &funcs);
>  
> -- 
> 2.25.1
> 
