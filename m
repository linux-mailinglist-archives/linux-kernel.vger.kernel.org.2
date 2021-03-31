Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C12D350A2B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhCaWWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhCaWV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:21:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B6CC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:21:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w8so17851pjf.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TNLJMnrWivn3GFXa2+TzAqtoU0ub+N8TkRxfn0l4Flg=;
        b=gQ9/NBVl4giS83ythLJ0Bf81bKdwuuKhPnKsxUuqiWwWf/EMxGPzvbYRbSyqotN4vm
         22EKYNZKYhFvYdFjNrdwZD1oXdiJNoVE5omarseI/GrnGjOB5BDydz49ERLb9MK7dKlQ
         By0u36NM/69ysYdyMdruTfzpIIE7UpbEMJtt7lzi+QwhAFRgyRU9s9CkGN8ph6GDFzx3
         SlTfRLDjSw0ce8sRcyWWtdKK5kWDL1z4pIK78F5XOkVRJHNHGWulas6YmOsXa4jh+JLQ
         0/sZic99pWXb3wv/EXvA27ef5u8Dt+Ye2h2mcpxzWjrzfI9/X2Tu6eccjmANnNLF/94e
         kEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TNLJMnrWivn3GFXa2+TzAqtoU0ub+N8TkRxfn0l4Flg=;
        b=jFCcyGLWpCKifYywyUK1gUzzBquVso9MQdQLD3JJWpI55qdCmCLBo7QM8VEbULdR+W
         eUHWgC9zMGlDbMZSRlDARUpxklq2xrNijWtWFupKjXRGM2NesNvrJAq/+Z1ArjMDyM0D
         MbBsK78O0Ys/b4t3TYfYGEBjGZI+U9emNlwhCgQx/Mqm7b0OJrmp8IyZVaeQZCRpxqeI
         Boc/RgzdJZWDKF/l9odLN1eByXmbFwZhr6CqWB3tqMabyPl2dqcoP9cnRSXmzOUKk9jB
         jWErCTiNgigKjw4c8pIop4yajQOewDP5iUS6KH7Nbwin9PoSpPOY/MGs5Ytpsa187fOL
         9IaQ==
X-Gm-Message-State: AOAM5300ssGB48RkPR6qoTmf3gfR4rgj1hmGeM+uTCt57OkQdc+1xts+
        4cEJ3L9pr8ajYnTq21oLYTlXG3VdXfiHNw==
X-Google-Smtp-Source: ABdhPJw11PZCJPfSeDHa53TUna9HFcJfFsVjGOJ7EGP/H4fwhQeTvZqLMv5AwD/nK53ex5x3+kL+Yw==
X-Received: by 2002:a17:90b:3553:: with SMTP id lt19mr5528995pjb.222.1617229317806;
        Wed, 31 Mar 2021 15:21:57 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id 138sm3260059pfv.192.2021.03.31.15.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:21:57 -0700 (PDT)
Date:   Wed, 31 Mar 2021 22:21:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH 07/13] KVM: x86/mmu: Make TDP MMU root refcount atomic
Message-ID: <YGT2AV6lhDG5yLkW@google.com>
References: <20210331210841.3996155-1-bgardon@google.com>
 <20210331210841.3996155-8-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331210841.3996155-8-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021, Ben Gardon wrote:
> In order to parallelize more operations for the TDP MMU, make the
> refcount on TDP MMU roots atomic, so that a future patch can allow
> multiple threads to take a reference on the root concurrently, while
> holding the MMU lock in read mode.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---

...

> @@ -88,10 +88,12 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
>  		next_root = list_first_entry(&kvm->arch.tdp_mmu_roots,
>  					     typeof(*next_root), link);
>  
> +	while (!list_entry_is_head(next_root, &kvm->arch.tdp_mmu_roots, link) &&
> +	       !kvm_tdp_mmu_get_root(kvm, next_root))
> +		next_root = list_next_entry(next_root, link);
> +
>  	if (list_entry_is_head(next_root, &kvm->arch.tdp_mmu_roots, link))
>  		next_root = NULL;
> -	else
> -		kvm_tdp_mmu_get_root(kvm, next_root);
>  
>  	if (prev_root)
>  		kvm_tdp_mmu_put_root(kvm, prev_root);
> @@ -158,14 +160,13 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
>  
>  	/* Check for an existing root before allocating a new one. */
>  	for_each_tdp_mmu_root(kvm, root) {
> -		if (root->role.word == role.word) {
> -			kvm_tdp_mmu_get_root(kvm, root);
> +		if (root->role.word == role.word &&
> +		    kvm_tdp_mmu_get_root(kvm, root))

I'm not opposed to changing this logic while making the refcount atomic, but it
needs to be explained in the changelog.  As is, the changelog makes it sound
like the patch is a pure refactoring of the type.
