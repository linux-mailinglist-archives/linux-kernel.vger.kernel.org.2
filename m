Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7511137AFA0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhEKTwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhEKTwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:52:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A057DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 12:51:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so1991743pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7s7GYOkg/VFYZvmsIsHFtm2LtoGNaveMgAx+B13tn2o=;
        b=HEvW9E1Gt0n/y0w25cD3LS2n3wE7ttPT4BduZ//nxFWQO2EbNavLt5soWP8M3+XdS8
         jAI8p9ahLwLZ5NZRCxoUEsva8TsNDkaTS2OXzgdktu6lvnlM+uXU8lolsBPJ4e/9WEME
         MMwfw3aVvCcM0mOT4ReXDDpCyJ5nNCwT2pPIXofK5qsKAmqcz1qKIEAn7tFEbHKWIw30
         H/2YpL5T3ymwVdHPAdaudcD7Q0GzbLyIQBaJsSNSkr+TFmlIbyD9kf9nc3YDeCioEuEd
         Fp/xOmhzM8COe0Lwipy1F2RAJY2XwLVZfYNA8sysmcNUqG4739B4ZJHcV6dZGk+SOk5y
         An5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7s7GYOkg/VFYZvmsIsHFtm2LtoGNaveMgAx+B13tn2o=;
        b=Det4wIDrhbz2lnKNrwRd3cl9l7xF1LRfSFg7un1QKuDWEv7DqWV3JfnPNbPL+Kc2/i
         du+7pSD46PMJC27XBwf57zceqASrLJ/a0Eiv5PZLWgIXpGn5+6DilLZw7b/lOH9vso2J
         AX9pkGW8jKqxpdV+Fl1WK+Xo/YGBwlcxDpCKqnRICIbvkAmBsPfYS5aB/bB0PIG87R2e
         7ptxQyeTDoS0ZJYC3MxGUhDT9h4SKJG/FQTi8qMYlMkYBdaSTzMgJ7+2SzxAZprmhDtI
         +RXi8D73An8NhQYeiR70Ck8FewxmnyAUl/v5UZvMccmCVzjRbE7S6AOZzf7hQFSZrpJm
         Euqg==
X-Gm-Message-State: AOAM530r7WAnnx1nspqLwWHYHLP0jzOHwL4ONdB34VayBFmTtp9Kk926
        EbSmfs8DhKsG4+oGY2q+ocfJwg==
X-Google-Smtp-Source: ABdhPJwfpEURvcQvCfjpqTVQ+3ZSFRm8E4e2jr4zNr34TMdj0QfBI5EkeMlDAV8ZRnvuVfUQzXDmkQ==
X-Received: by 2002:a17:90a:b382:: with SMTP id e2mr4562295pjr.171.1620762690975;
        Tue, 11 May 2021 12:51:30 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id q11sm14597218pjq.6.2021.05.11.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:51:30 -0700 (PDT)
Date:   Tue, 11 May 2021 19:51:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 6/7] KVM: x86/mmu: Skip rmap operations if rmaps not
 allocated
Message-ID: <YJrgPoORnyf9VVvY@google.com>
References: <20210511171610.170160-1-bgardon@google.com>
 <20210511171610.170160-7-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511171610.170160-7-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021, Ben Gardon wrote:
> @@ -1260,9 +1268,12 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
>  	int i;
>  	bool write_protected = false;
>  
> -	for (i = PG_LEVEL_4K; i <= KVM_MAX_HUGEPAGE_LEVEL; ++i) {
> -		rmap_head = __gfn_to_rmap(gfn, i, slot);
> -		write_protected |= __rmap_write_protect(kvm, rmap_head, true);
> +	if (kvm->arch.memslots_have_rmaps) {
> +		for (i = PG_LEVEL_4K; i <= KVM_MAX_HUGEPAGE_LEVEL; ++i) {
> +			rmap_head = __gfn_to_rmap(gfn, i, slot);
> +			write_protected |= __rmap_write_protect(kvm, rmap_head,
> +								true);

I vote to let "true" poke out.

> +		}
>  	}
>  
>  	if (is_tdp_mmu_enabled(kvm))

...

> @@ -5440,7 +5455,8 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
>  	 */
>  	kvm_reload_remote_mmus(kvm);
>  
> -	kvm_zap_obsolete_pages(kvm);
> +	if (kvm->arch.memslots_have_rmaps)
> +		kvm_zap_obsolete_pages(kvm);

Hmm, for cases where we're iterating over the list of active_mmu_pages, I would
prefer to either leave the code as-is or short-circuit the helpers with a more
explicit:

	if (list_empty(&kvm->arch.active_mmu_pages))
		return ...;

I'd probably vote for leaving the code as it is; the loop iteration and list_empty
check in kvm_mmu_commit_zap_page() add a single compare-and-jump in the worst
case scenario.

In other words, restrict use of memslots_have_rmaps to flows that directly
walk the rmaps, as opposed to partially overloading memslots_have_rmaps to mean
"is using legacy MMU".

>  	write_unlock(&kvm->mmu_lock);
>  

...

> @@ -5681,6 +5702,14 @@ void kvm_mmu_zap_all(struct kvm *kvm)
>  	int ign;
>  
>  	write_lock(&kvm->mmu_lock);
> +	if (is_tdp_mmu_enabled(kvm))
> +		kvm_tdp_mmu_zap_all(kvm);
> +
> +	if (!kvm->arch.memslots_have_rmaps) {
> +		write_unlock(&kvm->mmu_lock);
> +		return;

Another case where falling through to walking active_mmu_pages is perfectly ok.

> +	}
> +
>  restart:
>  	list_for_each_entry_safe(sp, node, &kvm->arch.active_mmu_pages, link) {
>  		if (WARN_ON(sp->role.invalid))
> @@ -5693,9 +5722,6 @@ void kvm_mmu_zap_all(struct kvm *kvm)
>  
>  	kvm_mmu_commit_zap_page(kvm, &invalid_list);
>  
> -	if (is_tdp_mmu_enabled(kvm))
> -		kvm_tdp_mmu_zap_all(kvm);
> -
>  	write_unlock(&kvm->mmu_lock);
>  }
>  
> -- 
> 2.31.1.607.g51e8a6a459-goog
> 
