Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8940B45527B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 03:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbhKRCIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 21:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242420AbhKRCIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 21:08:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7F3C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 18:05:17 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so6882020pja.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 18:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UFmDZX3iZjmhuVQR+vjc6h7KMRvGK/W6qGNnrnIksJI=;
        b=hEsvcYnEadPA6+b0djAbkweEqFuulYFEhfsUUAdZShhuJLcwjOufRelSUOU6Dwez8U
         Dqc3aQX6FahSu/C7FU5UFvh/SDrSzs2f957l7nTjJtgl+qnGNevYYJKJ7R02mitbVCO+
         QoJTdn/ILVJITrUuVeoxXjV7eYxAaf3gmKc+qFhJxcoVsufiPuHeL3L8VE3IkZ+QLSMK
         BDpEM/8JZw2RjPQ/eekKdqim5pT3k1G0l+GaGEO5KowuLdbimYgM731P1xx/DILAgzYM
         fi0lZ8iWqLGNE6UxiiXVzHm33TQ3AgaIoNvuYictx222GyKifm9HMMNBGp3tT7EeC3YG
         azRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UFmDZX3iZjmhuVQR+vjc6h7KMRvGK/W6qGNnrnIksJI=;
        b=h7rjGUjMzBpQDQ8i18/RWVe1muBowMax2YG5ramKmmnAfnGVLkIItn1HAWdwpoN9BN
         f+0gCJdRliw4EsyC6Ekxh0+AJc4XFHkW+ypiXt7QFOYdHsDRRuDLRy2w+Yqzqk3gih0I
         mQFpUiiq2Tag4zxh8s9Ad7pEvpV+EZchDFk8PWIp16xT6Yk3OJQywJBdLxQss8SybOcL
         wRSRBnNxj+Ka71EAJ1pZQIMGl1RnygQgQzCmMD8DUISFWbDZaKkqTDDKOlcm8seEbv/f
         VVgnjO8ggGS3rdCUmQQJKgowUMjvdEMours+4KXMzV1tSgMxMCdVRHfXeoUTKJU6ntjd
         eXSg==
X-Gm-Message-State: AOAM530iVjWNfNxI106nljdxdO7G4CjVt0FOtIHivbL5NL0bHAb7ym9d
        sSDCiiLAu09r5O26vGmhzqoOEg==
X-Google-Smtp-Source: ABdhPJyGYwQLyMPnIzlZjzcdU17UtKHkMGVxlOCCUMdlp8IjJ88xlZMgN5PPyznT5dNXAQrSz7G/UQ==
X-Received: by 2002:a17:902:ab8d:b0:143:8d6f:2b52 with SMTP id f13-20020a170902ab8d00b001438d6f2b52mr61118529plr.78.1637201117095;
        Wed, 17 Nov 2021 18:05:17 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id mq14sm7225211pjb.54.2021.11.17.18.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:05:16 -0800 (PST)
Date:   Thu, 18 Nov 2021 02:05:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [RFC 11/19] KVM: x86/mmu: Factor shadow_zero_check out of
 make_spte
Message-ID: <YZW02M0+YzAzBF/w@google.com>
References: <20211110223010.1392399-1-bgardon@google.com>
 <20211110223010.1392399-12-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110223010.1392399-12-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021, Ben Gardon wrote:
> In the interest of devloping a version of make_spte that can function
> without a vCPU pointer, factor out the shadow_zero_mask to be an
> additional argument to the function.
> 
> No functional change intended.
> 
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/spte.c | 11 +++++++----
>  arch/x86/kvm/mmu/spte.h |  3 ++-
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> index b7271daa06c5..d3b059e96c6e 100644
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -93,7 +93,8 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>  	       struct kvm_memory_slot *slot, unsigned int pte_access,
>  	       gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool prefetch,
>  	       bool can_unsync, bool host_writable, bool ad_need_write_protect,
> -	       u64 mt_mask, u64 *new_spte)
> +	       u64 mt_mask, struct rsvd_bits_validate *shadow_zero_check,

Ugh, so I had a big email written about how I think we should add a module param
to control 4-level vs. 5-level for all TDP pages, but then I realized it wouldn't
work for nested EPT because that follows the root level used by L1.  We could
still make a global non_nested_tdp_shadow_zero_check or whatever, but then make_spte()
would have to do some work to find the right rsvd_bits_validate, and the end result
would likely be a mess.

One idea to avoid exploding make_spte() would be to add a backpointer to the MMU
in kvm_mmu_page.  I don't love the idea, but I also don't love passing in rsvd_bits_validate.
