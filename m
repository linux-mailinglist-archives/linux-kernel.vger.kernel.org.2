Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94CF37AFEA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 22:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEKUEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 16:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhEKUE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 16:04:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE962C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 13:03:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k5so2692923pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aFa9eJIskol9erfOZLkvXwFKtvp+EqqmqlvTxyINBHA=;
        b=HnZ/XDQ2sFxXpGSN+sual0eelIiN/Cusckbtlsbq8QA34pcnEKkLzsw+VtdPkRa9PC
         A2ZzajXyJ1p6t/u02xKjS7M6doRoGAk4n234NeAoXanOE+2B6c6Qsc5sFYUIfC5Lzfwv
         33L3vgEyoJTmTE4Y9a93OeSN/5O0IT5TMiCAfk2cshtpKVKXt/xgz16zj/OoakkFUDL1
         lwYk1VKu6sExrBA5dZZ1izSd0Wsa2KIKE4lQ1ACZub72ZwvdOux6w+vSFdK2GtfiifT3
         YbWGUgSmmB0neEsg9S29OWlQZnbapJaz0y6mHGkgQx9EVxYzkzRIxLUX67VkJ+wDKXTx
         FgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aFa9eJIskol9erfOZLkvXwFKtvp+EqqmqlvTxyINBHA=;
        b=F7QNRYJ7xJXXHUTlvpLMVWt1CmUnu7OoTn+OTskOhqGZY5wm8WFKKcQvo8jOY/huxv
         3gFqLBL2+eOwmwZ1fxj5fTk5l3wWd+Z91qGY4q1VWDHGB2EVozkv1Y/H83QqBefANXto
         +PBn6fQBRv7T/6nbCgcwWNOLIh0v6UU09sn4ddBkU/nf97NYnCU2Fv08bT7jOsxOJABk
         NewOzq0K5DYOhHig1wpgzbZN0B6zgu7FSESvNLEc/dsJxZ76KhwVME7mP+xdDsuGkk/E
         wNA4Wg6t4l5WBgVz/dRBFnvavhVJj4d/rp7piny3/mhaRDfa6nbmzy+uiicegYfrsY8G
         afqg==
X-Gm-Message-State: AOAM5312EHs3SUM3bcU3nXeNYtLC13TkYMg48Rdb+O+lI+0On3WHdF8s
        ZP18/mhUWN4fhwN4mpp44S30ww==
X-Google-Smtp-Source: ABdhPJyQ1H7KcFFHpjwDC5FXdMYIXQY1u4Bq9L6cTkHq11ClTnoNaBYw0jpserk/YfuAnBeVWwCwIA==
X-Received: by 2002:a17:902:ed95:b029:ee:aa46:547a with SMTP id e21-20020a170902ed95b02900eeaa46547amr31330084plj.27.1620763399188;
        Tue, 11 May 2021 13:03:19 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id o10sm6571132pjl.2.2021.05.11.13.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:03:18 -0700 (PDT)
Date:   Tue, 11 May 2021 20:03:14 +0000
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
Subject: Re: [PATCH v4 7/7] KVM: x86/mmu: Lazily allocate memslot rmaps
Message-ID: <YJrjAt5eyCZQNSkM@google.com>
References: <20210511171610.170160-1-bgardon@google.com>
 <20210511171610.170160-8-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511171610.170160-8-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021, Ben Gardon wrote:
> If the TDP MMU is in use, wait to allocate the rmaps until the shadow
> MMU is actually used. (i.e. a nested VM is launched.) This saves memory
> equal to 0.2% of guest memory in cases where the TDP MMU is used and
> there are no nested guests involved.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 ++
>  arch/x86/kvm/mmu/mmu.c          | 53 +++++++++++++++++++++++----------
>  arch/x86/kvm/mmu/tdp_mmu.c      |  6 ++--
>  arch/x86/kvm/mmu/tdp_mmu.h      |  4 +--
>  arch/x86/kvm/x86.c              | 45 +++++++++++++++++++++++++++-
>  5 files changed, 89 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index fc75ed49bfee..7b65f82ade1c 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1868,4 +1868,6 @@ static inline int kvm_cpu_get_apicid(int mps_cpu)
>  
>  int kvm_cpu_dirty_log_size(void);
>  
> +int alloc_all_memslots_rmaps(struct kvm *kvm);
> +
>  #endif /* _ASM_X86_KVM_HOST_H */
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b0bdb924d519..183afccd2944 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1190,7 +1190,8 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
>  		kvm_tdp_mmu_clear_dirty_pt_masked(kvm, slot,
>  				slot->base_gfn + gfn_offset, mask, true);
>  
> -	if (!kvm->arch.memslots_have_rmaps)
> +	/* Read memslots_have_rmaps before the rmaps themselves */

IIRC, you open coded reading memslots_have_rmaps because of a circular
dependency, but you can solve that simply by defining the helper in mmu.h
instead of kvm_host.h.

And I think you could even make it static in mmu.c and omit the smp_load_acuquire
from the three users in x86.c, though that's probably not worth it.

Either way, reading the same comment over and over and over, just to make
checkpatch happy, gets more than a bit tedious.

That would also allow you to elaborate on why the smp_load_acquire() is
necessary, and preferably what it pairs with.

> +	if (!smp_load_acquire(&kvm->arch.memslots_have_rmaps))
>  		return;
>  
>  	while (mask) {
