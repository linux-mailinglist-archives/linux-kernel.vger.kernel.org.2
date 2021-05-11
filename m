Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C9B37AEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhEKSsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhEKSsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:48:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3B5C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:47:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n16so11267407plf.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PUfD2hUn3KDMj/HYtm6y3Z3XD5hUc0CS8SfLuKj/HzM=;
        b=hH8iZ5uGg4DljK1HEHhLdreVMW5K51visxVgKumGRH38RbTsi3BTytZLhStmDbQ4uF
         h53yWZqjuULTlImML+ZiT0MVhbrfviY0KnVR1MipAvU43rvHh4Y/1CpvF9jVlxa8d2hN
         6KtOwEmXbdzHxwnpQ0Z5c49tNpWvzrZ2Fpj89ALnnKjQIqQcUzC6JktdGHwnSo1n7AA3
         UHVT8j6ckH6x3ZPtj0xzBxA1kTk4wd7ASvHx8CgzuqGj9M8CjfT+cQJKfKg08r22Zs84
         wqowq7p7x6pBqe4YACHao4OBFlFrFjh/1qycJKCDQzomPgmoKBhMyjhhCTaH9q/UHq85
         Nxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PUfD2hUn3KDMj/HYtm6y3Z3XD5hUc0CS8SfLuKj/HzM=;
        b=g43Yta0VRMOPK1ERk6uNFWB2fo8Z2pbaiKSzO80uAIe75rojdRJTcfIqb/7Pyd+iBM
         vaDkVcMg5nhapFG0hu8uTmq4+iDcaHtQCpQb2mLGHYf4H6cHz1+0vjTMBOxp89A7soTt
         UC3IGUVA29ZGEyG2M40BbvyrQGX7mtb9fQj3dEgerL0Qv/zIO4VPxwt4lK+ILsnUon+k
         YN2CQcPu4ya/vxhfEZ9h31irvpYsxXb0n2nH6tMXlY1nV6ek18Ij61E5dULbpTq40M/k
         O7eWYQ5z1zhwJDZ6IQlW8eqiwtJ8Z/APozuYR8mY5CJFC1fOkWjmd5IVGAWoArnNh2y+
         cHsw==
X-Gm-Message-State: AOAM5331WWFoiRTkSPJFBgJIurGgPcatwCdoVqSkB4HbFnNhMAAJNgg8
        +nUl69o+G+F3T7nzRrxdZE+Gtg==
X-Google-Smtp-Source: ABdhPJyJXjVPc7O99wKXfMTd5Ucm7ji44HBjrPgZP13aR2e1NJRgR8Tywj+LrdHY+pCgd3ONM6a+ug==
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr9283273pjb.52.1620758843332;
        Tue, 11 May 2021 11:47:23 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id i8sm7089806pgt.58.2021.05.11.11.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:47:22 -0700 (PDT)
Date:   Tue, 11 May 2021 18:47:19 +0000
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
Subject: Re: [PATCH v4 3/7] KVM: mmu: Refactor memslot copy
Message-ID: <YJrRN2S3EJI/S01o@google.com>
References: <20210511171610.170160-1-bgardon@google.com>
 <20210511171610.170160-4-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511171610.170160-4-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021, Ben Gardon wrote:
> Factor out copying kvm_memslots from allocating the memory for new ones
> in preparation for adding a new lock to protect the arch-specific fields
> of the memslots.
> 
> No functional change intended.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  virt/kvm/kvm_main.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 6b4feb92dc79..9e106742b388 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1306,6 +1306,18 @@ static struct kvm_memslots *install_new_memslots(struct kvm *kvm,
>  	return old_memslots;
>  }
>  
> +static size_t kvm_memslots_size(int slots)

Can we call this kvm_calc_memslots_size()?  This doesn't actually return the
true size of a given memslots instance since the allocated size may be greater
than the size computed by looking at used_slots.

> +{
> +	return sizeof(struct kvm_memslots) +
> +	       (sizeof(struct kvm_memory_slot) * slots);
> +}
> +
> +static void kvm_copy_memslots(struct kvm_memslots *from,
> +			      struct kvm_memslots *to)
> +{
> +	memcpy(to, from, kvm_memslots_size(from->used_slots));
> +}
> +
>  /*
>   * Note, at a minimum, the current number of used slots must be allocated, even
>   * when deleting a memslot, as we need a complete duplicate of the memslots for
> @@ -1315,19 +1327,16 @@ static struct kvm_memslots *kvm_dup_memslots(struct kvm_memslots *old,
>  					     enum kvm_mr_change change)
>  {
>  	struct kvm_memslots *slots;
> -	size_t old_size, new_size;
> -
> -	old_size = sizeof(struct kvm_memslots) +
> -		   (sizeof(struct kvm_memory_slot) * old->used_slots);
> +	size_t new_size;
>  
>  	if (change == KVM_MR_CREATE)
> -		new_size = old_size + sizeof(struct kvm_memory_slot);
> +		new_size = kvm_memslots_size(old->used_slots + 1);
>  	else
> -		new_size = old_size;
> +		new_size = kvm_memslots_size(old->used_slots);
>  
>  	slots = kvzalloc(new_size, GFP_KERNEL_ACCOUNT);
>  	if (likely(slots))
> -		memcpy(slots, old, old_size);
> +		kvm_copy_memslots(old, slots);
>  
>  	return slots;
>  }
> -- 
> 2.31.1.607.g51e8a6a459-goog
> 
