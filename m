Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC8F407300
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 23:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhIJVhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 17:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhIJVhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:37:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A2AC061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:36:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id n30so339863pfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=osMYYNGSd/Wjj+GEQ9AnjZzDNQa5kCk+UK3hUXrWsLk=;
        b=IXUbRyP+p3BXmkawxfs/aq7YDdpzZnyWexYE0UEPyjiWqxO3uGv9NI9++wqMbnMmdH
         3URAQ0FTb3EoySjHEvif6yG26N0NTBuDCOa0+xUMSoL1kD8TWU+Cvqyf8ztuC8N+f2TB
         EGHCxLcoAtBYIBEsTVA6wx+OPCFIWJzjQgsQEeIAqAXb0WPjXJVNzmcFkrBbEqAQguNF
         VRrrFmw43kb02a+KMCmooXTiiOhguXeBswP4JApCFDBI1lH40MlwzKc+OGWsuMJgK+or
         jUGOgbz+BaUESiviGAL6LjfDuVwnplOX94CrlNPxus1lFxQudezL9FmIk0zlXa/v58sV
         q1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=osMYYNGSd/Wjj+GEQ9AnjZzDNQa5kCk+UK3hUXrWsLk=;
        b=tFhq3g123I/Rrp03Le+755SXVYhXF+BDnO/vy64C/PiWX9uo9C3I8RhDoeR6zJdCN6
         dlpK9VfCQJ+/Qg60UN0HSTM7foT/qveBIgErfNwr2ZRaL/aUzyC2mMwKburBggejX1wl
         t4YwyceFuxaMzhBYYBzYmdiqFkrdzdOPCggTg2jqZoi3fipZGzipObf0yqqQ7pZi2c5I
         6cS+uMPk4Z8gOX3PXRziPXltYAyFtADQjHMaUY94ZDxH5BnsKu5yYXDcw5GUA4PpfQq+
         V7TClbIfY3CopER5yVsG1ZFLij/26RWe8LarABf4kSzPYU/jrMyQFVyvXcwmVzDNv12+
         YSSg==
X-Gm-Message-State: AOAM530f7AO9Rb8gudvDcnZQJ5eMLcd8u4EYdqk9hzxxdFzrsNHhj6eD
        iaFMkfQhZR2opWR3SKUElLHpmg==
X-Google-Smtp-Source: ABdhPJyFM/PKYPzNQH2Lo5rKS4cW/OJY1IuedAKl7NpJWa9TgpNuFMv10CRgNkyrPf1xFt2BAAReVQ==
X-Received: by 2002:a05:6a00:814:b0:40d:563a:a7ce with SMTP id m20-20020a056a00081400b0040d563aa7cemr10118324pfk.60.1631309759677;
        Fri, 10 Sep 2021 14:35:59 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h16sm5826014pfn.215.2021.09.10.14.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 14:35:59 -0700 (PDT)
Date:   Fri, 10 Sep 2021 21:35:55 +0000
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
Subject: Re: [PATCH v4 3/6] KVM: VMX: Detect Tertiary VM-Execution control
 when setup VMCS config
Message-ID: <YTvPu0REr+Wg3/s3@google.com>
References: <20210809032925.3548-1-guang.zeng@intel.com>
 <20210809032925.3548-4-guang.zeng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809032925.3548-4-guang.zeng@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021, Zeng Guang wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 927a552393b9..ee8c5664dc95 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2391,6 +2391,23 @@ static __init int adjust_vmx_controls(u32 ctl_min, u32 ctl_opt,
>  	return 0;
>  }
>  
> +static __init int adjust_vmx_controls_64(u64 ctl_min, u64 ctl_opt,
> +					 u32 msr, u64 *result)
> +{
> +	u64 vmx_msr;
> +	u64 ctl = ctl_min | ctl_opt;
> +
> +	rdmsrl(msr, vmx_msr);
> +	ctl &= vmx_msr; /* bit == 1 means it can be set */
> +
> +	/* Ensure minimum (required) set of control bits are supported. */
> +	if (ctl_min & ~ctl)
> +		return -EIO;
> +
> +	*result = ctl;
> +	return 0;
> +}

More succinctly, since we don't need to force-set bits in the final value:

	u64 allowed1;

	rdmsrl(msr, allowed1);

	/* Ensure minimum (required) set of control bits are supported. */
	if (ctl_min & ~allowed1)
		return -EIO;

	*result = (ctl_min | ctl_opt) & allowed1;
	return 0;

>  static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  				    struct vmx_capability *vmx_cap)
>  {

