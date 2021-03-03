Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27C32BFA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579983AbhCCScx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbhCCQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:59:27 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFE8C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 08:58:46 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id l2so16845517pgb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 08:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nPAwW58BM2Peqy3CsvFvNOceDW2A+CpWJyP28r7fYnw=;
        b=iWqMtWXZ/Coibv6e5Pne9w95gngr0vKnGRsj0vgqpYNrXUGjw5nIsskbs410PB5w1O
         0yQrF1ITxJubs9mgois+s1sCDeteC1wkZxjob3ytmoU0G2BQnaKXtxLtVfFWZ9cjDDnC
         q9sJTrnYhwJu6p1DpZmFCj+twmNrqErIeoq/XfFJN+vRyzamu1aNO0GWpz7mwoGBbQaE
         k1Ri9AQYHJrOH1VgBIKpoaRFoPEZN9SO2xBuqP0IH5TV2zRU+lk1wGLUJiR7PZjZSvBI
         ArhNrrBFQp9iA8ITybHeHWxu1eObYGLtz5uVaFmw4nJRSoOBHmFa4hCZLtl81MvtQiXR
         41ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nPAwW58BM2Peqy3CsvFvNOceDW2A+CpWJyP28r7fYnw=;
        b=pBDen73tvF5qoS/8pwHkevktaRUkJEzfD4updsLFe21ZqMpu3LSQMtU9JLKfvlzZuO
         YWy6bx3TkD6+pYzp7Poo6GooXOhyxnw1DRqZJ5D/IjvwWrVvTDQm1rNw02VU62+ADP9b
         BhUAuJKtR7XF89GBQ1CAz5FpmxAr43hujAwdjfMv30ZGqK23vOf8qH+WA0t9NQjHzZkt
         DQNgsIIxvRmMJOAE6MNDQUAaT3nMFAiQ0LiSajqTHThgtEPgNckRVxlNl1WGDTcAIXzi
         piitD1u6s9qWFNhqPO5acE9Cn2iQEzOUzToGnL+yM7aYWPNXA9gupzCCIx5SjbaNsek9
         b1Wg==
X-Gm-Message-State: AOAM532ki0XyMSnSeYAWcPbcsmqDYyVTTh7xFYacKlt4asHLb+OAGunb
        KpFwdsoAMXhILbgHUL/mqwSt0A==
X-Google-Smtp-Source: ABdhPJzLtvZpejYPU1VXFx5zXMGAMaVhEWuOyjZyPI9KLNLaKVCQwsLsaYxA2Glvxdqc737TgzgYcA==
X-Received: by 2002:a63:e108:: with SMTP id z8mr23579432pgh.363.1614790725369;
        Wed, 03 Mar 2021 08:58:45 -0800 (PST)
Received: from google.com ([2620:15c:f:10:805d:6324:3372:6183])
        by smtp.gmail.com with ESMTPSA id i20sm3982353pgg.65.2021.03.03.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 08:58:44 -0800 (PST)
Date:   Wed, 3 Mar 2021 08:58:37 -0800
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
Subject: Re: [PATCH v3 5/9] KVM: vmx/pmu: Add MSR_ARCH_LBR_DEPTH emulation
 for Arch LBR
Message-ID: <YD/APUcINwvP53VZ@google.com>
References: <20210303135756.1546253-1-like.xu@linux.intel.com>
 <20210303135756.1546253-6-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303135756.1546253-6-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021, Like Xu wrote:
> @@ -348,10 +352,26 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
>  	return true;
>  }
>  
> +/*
> + * Check if the requested depth values is supported
> + * based on the bits [0:7] of the guest cpuid.1c.eax.
> + */
> +static bool arch_lbr_depth_is_valid(struct kvm_vcpu *vcpu, u64 depth)
> +{
> +	struct kvm_cpuid_entry2 *best;
> +
> +	best = kvm_find_cpuid_entry(vcpu, 0x1c, 0);
> +	if (best && depth && !(depth % 8))

This is still wrong, it fails to weed out depth > 64.

Not that this is a hot path, but it's probably worth double checking that the
compiler generates simple code for "depth % 8", e.g. it can be "depth & 7)".

> +		return (best->eax & 0xff) & (1ULL << (depth / 8 - 1));
> +
> +	return false;
> +}
> +
