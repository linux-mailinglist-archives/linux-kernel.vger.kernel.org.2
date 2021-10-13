Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1D42B0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhJMAE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhJMAEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:04:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD87C061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:02:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l6so592969plh.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=usOJyi3vWJ+B8xCJglaCM/0JQ+BQoeyBpYldNBu2X7A=;
        b=D+7qhklJPAH83AmBCpAMyIvHcu0UZpGBjD3qo/SjZGhh+cbq/euskkcZ1cSTfJQBVn
         /O1iVvf5S1EpmEm3eXdD+Iy1MRk9RXAc3Vsv2OmxsOGZOSZ8rnucKpDfyFfonUYD2tXH
         yPvY1qAKvZm0T1UKwE9E+wGryzPZyFnkHWud+uqljuameF0Hjdgg7MOlmSINGw6Y4Mho
         OzpQK4SqiaZj4+y+/QKrMA8iIIwFough5NTypRJia97qJLAztZNLFYqM+oiQAvKtziEi
         dVg4rQre/vKbe/BJ7N0Yx20BzJbvvVB5pylKWHuw6JAjEndTlIULMwyNwqQ1psdhD2Iz
         KUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=usOJyi3vWJ+B8xCJglaCM/0JQ+BQoeyBpYldNBu2X7A=;
        b=lUHwCxiTUnCgmdWt1ZN93Nv0Z3xZp9+iKg344bunsfuQZj3PoKRHynZafIaNE6KQoF
         4xvit7BlmiDpQFJYjjsluO8d7Lojxcd5yEl8Stx/KrJz3HkvavC4k1G+Y/lGmrhucyJI
         vJQsTsTfsEGGDEGgagD8EdMjZsBo3aHwDi5R8vsUUyqgrdV0ZsoTtofIwCaAjLx3rLGS
         VrBmttN7Gl31HE9KC+gYC+vng0e2nNEP8nKobHjEMMjpFVzn6EXs/cZmur51TOKYHBCa
         yC0Y8besv7QwWxBxksKE2ry3oKWYWMmiidRFiR77rluRinuHnNWmyVd+loeoTnMiqeF8
         54jA==
X-Gm-Message-State: AOAM5315VVRxlhRvxntyfveRvwWKKSVctEmIFVF0pOU1wIlhxEdS1svS
        3xJ7yKnzEPb8/5NNizfV3Rg8TA==
X-Google-Smtp-Source: ABdhPJxo7HfGHeKdwK3WniLQ9W70SyBtE5TarYga88X1oCtTWRYloyybpHWXgxggwD5S0ICHu+k1DA==
X-Received: by 2002:a17:90b:17c9:: with SMTP id me9mr9626717pjb.197.1634083371829;
        Tue, 12 Oct 2021 17:02:51 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b130sm586106pfb.9.2021.10.12.17.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:02:51 -0700 (PDT)
Date:   Wed, 13 Oct 2021 00:02:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] KVM: mmu: remove over-aggressive warnings
Message-ID: <YWYiJy1Z7VZ0SxAd@google.com>
References: <20210929042908.1313874-1-stevensd@google.com>
 <20210929042908.1313874-5-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929042908.1313874-5-stevensd@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Remove two warnings that require ref counts for pages to be non-zero, as
> mapped pfns from follow_pfn may not have an initialized ref count.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  arch/x86/kvm/mmu/mmu.c | 7 -------
>  virt/kvm/kvm_main.c    | 2 +-
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 5a1adcc9cfbc..3b469df63bcf 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -617,13 +617,6 @@ static int mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
>  
>  	pfn = spte_to_pfn(old_spte);
>  
> -	/*
> -	 * KVM does not hold the refcount of the page used by
> -	 * kvm mmu, before reclaiming the page, we should
> -	 * unmap it from mmu first.
> -	 */
> -	WARN_ON(!kvm_is_reserved_pfn(pfn) && !page_count(pfn_to_page(pfn)));

Have you actually observed false positives with this WARN?  I would expect anything
without a struct page to get filtered out by !kvm_is_reserved_pfn(pfn).

If you have observed false positives, I would strongly prefer we find a way to
keep the page_count() sanity check, it has proven very helpful in the past in
finding/debugging bugs during MMU development.

> -
>  	if (is_accessed_spte(old_spte))
>  		kvm_set_pfn_accessed(pfn);
>  
