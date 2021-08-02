Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6033DE2A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhHBWlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhHBWlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:41:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F5FC061764
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 15:40:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t3so19292078plg.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 15:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ak5j6PtmBPoE1bF08nfp5CsK+6RSogJq3bn6zejTSpg=;
        b=h+FUvAgmxamgrp+BJEqSwqpnZJHF9D73Z52u7ojhnqm0sV35MSc2vqr9HM6X/XGkfa
         jp48DzPwy96FsWZZG6ZqyWto0McutSdG2/EUhvrbdflu6KLpaz3CPOoIiQFmx2g7wqAS
         RBcxkMpsFv5e/7Cs2i+54CyUQ3G7aGUe/sAaH7QJ4FgclkKAyllPP8qWsirLliLNbaSh
         J1z7klCgJf1lIMmCDwV23pWeP3SFFIMrz5w44ozTkmJxzqW3AGo5OEi3qi7o5k1ZM+H3
         4ShwBZqmI+CPemp8q+D30UShDFgkquN5b2y4TslWfFlUxXqgH1IeLE5jkW/cDPHMuTQ/
         +snQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ak5j6PtmBPoE1bF08nfp5CsK+6RSogJq3bn6zejTSpg=;
        b=bgP7Os4UMjtZPvzwb3X4GxS0hlcbr+f9nYD9qY3VJ1BS1AURJKrzt9wauVPXprScw8
         RDtX6zk422axjLGn9vF//BzdvXyzuMGMC20h5QFEvIx4bKIZk2iTbB/zKJfww/uVhJ7n
         2JFa1W/EPkxvc68uN0LiAARBX/TSygkE0sS5q26Wtp0a6/c9kzChXeQJwJRfJSJ94lf1
         fPgjvMx/TIlQmB+ScgTUP8Rt8R4SoxKRs02OyPMVNqPdSE+un8+s5OrthcQEUNZlTFNS
         PGF/DYwyXynzpYwvnwJKK1pWwvtJyYlLrt+5IKLLdUoS/8QlGnOd0grPInJtJ6HIO6VD
         YoJQ==
X-Gm-Message-State: AOAM532aNhA75klQv0F4rXSAV/yno4fJzYXxuOY1MIVxb4owLTBN3goE
        onwTMS/G8yBNVZ8BV6uKdVaXcw==
X-Google-Smtp-Source: ABdhPJy/Gee/LyY/H8Wbh1sViloEHwn2OFYpKQjdDDFYIxAxGcPcCM/I/zGgJDZI+aIpe7JM6Bmmuw==
X-Received: by 2002:a65:5c48:: with SMTP id v8mr234643pgr.411.1627944053598;
        Mon, 02 Aug 2021 15:40:53 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id h21sm2790921pfq.130.2021.08.02.15.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:40:52 -0700 (PDT)
Date:   Mon, 2 Aug 2021 22:40:49 +0000
From:   David Matlack <dmatlack@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH v3 2/3] KVM: x86/mmu: Avoid collision with !PRESENT SPTEs
 in TDP MMU lpage stats
Message-ID: <YQh0cdZUIkfJGpeC@google.com>
References: <20210730225939.3852712-1-mizhang@google.com>
 <20210730225939.3852712-3-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730225939.3852712-3-mizhang@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:59:38PM -0700, Mingwei Zhang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Factor in whether or not the old/new SPTEs are shadow-present when
> adjusting the large page stats in the TDP MMU.  A modified MMIO SPTE can
> toggle the page size bit, as bit 7 is used to store the MMIO generation,
> i.e. is_large_pte() can get a false positive when called on a MMIO SPTE.
> Ditto for nuking SPTEs with REMOVED_SPTE, which sets bit 7 in its magic
> value.
> 
> Opportunistically move the logic below the check to verify at least one
> of the old/new SPTEs is shadow present.
> 
> Use is/was_leaf even though is/was_present would suffice.  The code
> generation is roughly equivalent since all flags need to be computed
> prior to the code in question, and using the *_leaf flags will minimize
> the diff in a future enhancement to account all pages, i.e. will change
> the check to "is_leaf != was_leaf".
> 
> Reviewed-by: Ben Gardon <bgardon@google.com>
> 
> Fixes: 1699f65c8b65 ("kvm/x86: Fix 'lpages' kvm stat for TDM MMU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---

Reviewed-by: David Matlack <dmatlack@google.com>

>  arch/x86/kvm/mmu/tdp_mmu.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index caac4ddb46df..cba2ab5db2a0 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -413,6 +413,7 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
>  	bool was_leaf = was_present && is_last_spte(old_spte, level);
>  	bool is_leaf = is_present && is_last_spte(new_spte, level);
>  	bool pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
> +	bool was_large, is_large;
>  
>  	WARN_ON(level > PT64_ROOT_MAX_LEVEL);
>  	WARN_ON(level < PG_LEVEL_4K);
> @@ -446,13 +447,6 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
>  
>  	trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
>  
> -	if (is_large_pte(old_spte) != is_large_pte(new_spte)) {
> -		if (is_large_pte(old_spte))
> -			atomic64_sub(1, (atomic64_t*)&kvm->stat.lpages);
> -		else
> -			atomic64_add(1, (atomic64_t*)&kvm->stat.lpages);
> -	}
> -
>  	/*
>  	 * The only times a SPTE should be changed from a non-present to
>  	 * non-present state is when an MMIO entry is installed/modified/
> @@ -478,6 +472,18 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
>  		return;
>  	}
>  
> +	/*
> +	 * Update large page stats if a large page is being zapped, created, or
> +	 * is replacing an existing shadow page.
> +	 */
> +	was_large = was_leaf && is_large_pte(old_spte);
> +	is_large = is_leaf && is_large_pte(new_spte);
> +	if (was_large != is_large) {
> +		if (was_large)
> +			atomic64_sub(1, (atomic64_t *)&kvm->stat.lpages);
> +		else
> +			atomic64_add(1, (atomic64_t *)&kvm->stat.lpages);
> +	}
>  
>  	if (was_leaf && is_dirty_spte(old_spte) &&
>  	    (!is_present || !is_dirty_spte(new_spte) || pfn_changed))
> -- 
> 2.32.0.554.ge1b32706d8-goog
> 
