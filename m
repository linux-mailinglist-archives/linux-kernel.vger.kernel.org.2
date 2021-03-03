Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2488B32C0C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386727AbhCCSqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbhCCR1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:27:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7EBC061763
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 09:26:13 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e9so4774863pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EK8LKNqmhy5x5LGHLejHKmLyx1MsPWviMZPTqKPSEvc=;
        b=JAljs/qnOK5jykvYwB6CxVcKXYmcriiOHnXg+2p/0p+pr1G9jTezxPcXNnfUkuF0u6
         K/gVGL85aHy4UOB9QVbFAJgBq9wGhyEJjMXDjn1Df1LlYWauOVLOuKG6nuERLGdqtrv2
         2VBT4jEcYz4L1TaZTN0gkWkq9IXNMUX83aTipLspLO2xUxVy6SdyO2uxyzAIpx1W+Gjy
         hmoD8h3c8uNaGjUMGQPyqOxkravbrA43rCMhX8jabm4CDuqT6Pxa3Y2c9CEAONqGI8fz
         A0hibh7eoiujKp4rxdjoJ61sXj9OfgRvu0qgsZe2FwMJSkSBDC4DyZAVPen/txEjeohY
         FE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EK8LKNqmhy5x5LGHLejHKmLyx1MsPWviMZPTqKPSEvc=;
        b=j9j/ztbBS6+mhjNYeou5EfMzHUK/+L+GcblcaqQzntfTQKPoFvuKCapg0I3E0Rv4jE
         +bcq3ljfoy8awArUw7WjvtCwtKo3CiFYTI5Qa7pVM//Bufg5RW6G0Lc4wlxa10Wz8Wdt
         wuBNvLcF9zmOokiZd+UCr1exsMYlcUaFFijNdOOfBZp6K3V8/PFzsLOXPTxRf+njOjb+
         rQY7ot0CQKKTuDjBJse+UD6UVVSrdsIr3VAySAZXtwIVeh4ZvV1InPN3YOLlZAXaiQLg
         vptTf7js/BLt2CpaiIcjxH3z20npEnHDHvhMQ7wcMuOZQ//UNNgLbvXUTjp/CLV/DN5N
         HinQ==
X-Gm-Message-State: AOAM531+OsRa6OWyTmNrO5H37ksaBjSqkxWXWo1YqcTSqRwK2tO2+lN5
        /7sG9JO2iQjRLNRtA7+hcrzswg==
X-Google-Smtp-Source: ABdhPJzelju/P4Sadau5toHeUSN3iJ90+g+CrjUu7odQYNHUelH7VSCksC5Fy/t8qpf0EFPUkGkJWg==
X-Received: by 2002:a17:902:f68c:b029:e5:ca30:8657 with SMTP id l12-20020a170902f68cb02900e5ca308657mr251635plg.78.1614792372514;
        Wed, 03 Mar 2021 09:26:12 -0800 (PST)
Received: from google.com ([2620:15c:f:10:805d:6324:3372:6183])
        by smtp.gmail.com with ESMTPSA id v26sm24500719pff.195.2021.03.03.09.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:26:11 -0800 (PST)
Date:   Wed, 3 Mar 2021 09:26:05 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, wei.w.wang@intel.com,
        Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] KVM: vmx/pmu: Add Arch LBR emulation and its VMCS
 field
Message-ID: <YD/GrQAl1NMPHXFj@google.com>
References: <20210303135756.1546253-1-like.xu@linux.intel.com>
 <20210303135756.1546253-8-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303135756.1546253-8-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021, Like Xu wrote:
> New VMX controls bits for Arch LBR are added. When bit 21 in vmentry_ctrl
> is set, VM entry will write the value from the "Guest IA32_LBR_CTL" guest
> state field to IA32_LBR_CTL. When bit 26 in vmexit_ctrl is set, VM exit
> will clear IA32_LBR_CTL after the value has been saved to the "Guest
> IA32_LBR_CTL" guest state field.

...

> @@ -2529,7 +2532,8 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  	      VM_EXIT_LOAD_IA32_EFER |
>  	      VM_EXIT_CLEAR_BNDCFGS |
>  	      VM_EXIT_PT_CONCEAL_PIP |
> -	      VM_EXIT_CLEAR_IA32_RTIT_CTL;
> +	      VM_EXIT_CLEAR_IA32_RTIT_CTL |
> +	      VM_EXIT_CLEAR_IA32_LBR_CTL;

So, how does MSR_ARCH_LBR_CTL get restored on the host?  What if the host wants
to keep _its_ LBR recording active while the guest is running?

>  	if (adjust_vmx_controls(min, opt, MSR_IA32_VMX_EXIT_CTLS,
>  				&_vmexit_control) < 0)
>  		return -EIO;
> @@ -2553,7 +2557,8 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  	      VM_ENTRY_LOAD_IA32_EFER |
>  	      VM_ENTRY_LOAD_BNDCFGS |
>  	      VM_ENTRY_PT_CONCEAL_PIP |
> -	      VM_ENTRY_LOAD_IA32_RTIT_CTL;
> +	      VM_ENTRY_LOAD_IA32_RTIT_CTL |
> +	      VM_ENTRY_LOAD_IA32_LBR_CTL;
>  	if (adjust_vmx_controls(min, opt, MSR_IA32_VMX_ENTRY_CTLS,
>  				&_vmentry_control) < 0)
>  		return -EIO;
> -- 
> 2.29.2
> 
