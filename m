Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07AB30D05C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 01:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhBCAiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 19:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhBCAiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 19:38:50 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85925C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 16:38:10 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o7so16097585pgl.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 16:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Sw0Vvtzcz6Tp5ASQ/gatuKuqoHGAQQtnplIYIuWXPQ=;
        b=VV7MMgCIdgHXeVw67dyU/de0/CuHMGaEY/0AIDC8R+C8K+ThhEcNLAHzEYCzHvLMbG
         PgfDeJt1bk5k7tZx9Sz2Te+YAm7wliwXDlmlXwym97EXWelAPbnVXbESIEnOpzOTXze1
         mOfwvY6SDg2hQpGFJZqbZPo+0N1EkHMSkV6uFik/nRhcUVLBlGCLc9IgW5bLP/BzkJzU
         KD0RZqj5itNMuHlJ2MyAlAANswZBOEQjVICsjxeBn6rLlbzdNLZMI1wcdBLiUTgjmOA5
         cahRGd6RArPrAERuLxhsnhkxX8PyyUzl/W+dmOXMpAjmebfrpMKwyPv+xj48sk8r2a70
         uGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Sw0Vvtzcz6Tp5ASQ/gatuKuqoHGAQQtnplIYIuWXPQ=;
        b=tBNhHrHxVH1tGU6WP9yp2udgMF+ex06/VdQGcjHtWt2YsKe007MIpQ0zpsiKBOv2m/
         wgAb6HyGI37E46LS0GOe27jzdZLrprzGPLdoE9JIAoHVLTHsBT1K7sOBu1RpJRkQEtKf
         gujjXaXZrPv+D8Hicylf0law3wQ43IaokK+zt613904yS+rDelnfMwb5OxPdVvFdhagy
         ncDofHqcxi/RLEGGaNbvMufAmiYfLmJLVcV+FPo3Uxja8sWjt4JmGGF/4eIFjs2zr0aj
         Ki48KiPKXjz9gScVVBFhdgQaGzOPbGw+ueOAUGmrmhp9xZ9ATxqfXkmSOXURMXvhs/73
         z4vA==
X-Gm-Message-State: AOAM532xxnmaL9i+xiderZFkNojoWWWCoUT5Syf5IWQfCd0JgrFrqYqI
        9rfkYgy28INOFjkOGVjdT2JfVA==
X-Google-Smtp-Source: ABdhPJxElBeGhuLbpW5OZIWAajiwcgq4/Chf7fDUQUUmUBYq2MeDNxVh46dvwmhvJSPuwh++7AUV4w==
X-Received: by 2002:a63:f20e:: with SMTP id v14mr740665pgh.436.1612312689611;
        Tue, 02 Feb 2021 16:38:09 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e1bc:da69:2e4b:ce97])
        by smtp.gmail.com with ESMTPSA id p1sm155681pfn.21.2021.02.02.16.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 16:38:08 -0800 (PST)
Date:   Tue, 2 Feb 2021 16:38:02 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 1/3] KVM: SVM: use vmsave/vmload for saving/restoring
 additional host state
Message-ID: <YBnwaiy8L/O0PCrR@google.com>
References: <20210202190126.2185715-1-michael.roth@amd.com>
 <20210202190126.2185715-2-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202190126.2185715-2-michael.roth@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One quick comment while it's on my mind, I'll give this a proper gander tomorrow.

On Tue, Feb 02, 2021, Michael Roth wrote:
> diff --git a/arch/x86/kvm/svm/svm_ops.h b/arch/x86/kvm/svm/svm_ops.h
> index 0c8377aee52c..c2a05f56c8e4 100644
> --- a/arch/x86/kvm/svm/svm_ops.h
> +++ b/arch/x86/kvm/svm/svm_ops.h
> @@ -56,4 +56,9 @@ static inline void vmsave(hpa_t pa)
>  	svm_asm1(vmsave, "a" (pa), "memory");
>  }
>  
> +static inline void vmload(hpa_t pa)

This needs to be 'unsigned long', using 'hpa_t' in vmsave() is wrong as the
instructions consume rAX based on effective address.  I wrote the function
comment for the vmsave() fix so that it applies to both VMSAVE and VMLOAD,
so this can be a simple fixup on application (assuming v5 isn't needed for
other reasons).

https://lkml.kernel.org/r/20210202223416.2702336-1-seanjc@google.com

> +{
> +	svm_asm1(vmload, "a" (pa), "memory");
> +}
> +
>  #endif /* __KVM_X86_SVM_OPS_H */
> -- 
> 2.25.1
> 
