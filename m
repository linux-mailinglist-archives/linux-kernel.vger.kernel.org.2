Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DDF44DB39
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 18:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhKKRrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 12:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKRrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:47:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F8AC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:44:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x7so4641721pjn.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7MaSOuEOp+CoiKDEE7sxnGw6C1tJ0+8FkGqNIXlaeOA=;
        b=FnGpm3IF6H65QzbG3rCh8MmyvtNek0vSeOME3psBrfAVG3939I40wIxO2yosG1b+8B
         Sad+hM2t4c7Fq3IyDGA/ZDs33DIANmy1v1UZ54FX49PnBvzAxDKGDiXxnKre5ZnZ2EHx
         GBikptqHMGmMR1fbZe0CQDEHVxRj3jTEf6WAKF3OPOsO+6gGWOD8DLUg/cPexe3hcdQK
         sokXOYi8CE4wwfpRZoSyOcV66zPu/K1RiporWSt6FZl3UrIwnHSqlY/o76+s1n7s/sHP
         oRoqRk9VS3n4HdrD3JnlDvI76ep9sqJu43l+5FKoM2fsaI3n4pbsO9lB+R2XzlXMGlRO
         oDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7MaSOuEOp+CoiKDEE7sxnGw6C1tJ0+8FkGqNIXlaeOA=;
        b=286D1SCm3zcGfEX1ZitWPyXQZewMdQ84vDqU0tTV0gC1IomTbz+DQq3X/xWcNKPrhS
         Z+3ChtJawGDmqlFysN4HxdrvoujUkpVTU6BAdXT7WyScV3bVfRhW2eMNP8Ec5IGmpi9Q
         wC+m5eHNFRPIz0//l+OaW+GRbdFRpJhCEGYo1zV4fNa+xD70Az1fMwpOek75kYXVpLRM
         fn9wGk3goLREXuivfGrFPhFmn2Xc3PBdqvHPTrt47AnORVmyxh5aozr1bkYcHvxKEk4I
         NPPxsQ0lIG6NEYMIv/XAMbgcQYzVFjuM4hD9/OYAfz8O+oYy8IvzUsAZiRAu+g1z4ZRy
         lVqQ==
X-Gm-Message-State: AOAM533rdUW5qVhIc70cIn4+tTt8lgxXNXbPwC4va507N9Hg0Ng3Cc0w
        rmDtBo1nISPWIgXFUExosM+RQpimL1Zujw==
X-Google-Smtp-Source: ABdhPJwsH3mjR1to/+eMgCPxKJRq74DHSnHEnWS89IVB3LZ0yYHt/FcM8e3ZoCMzCoQVNiPxhxvi5Q==
X-Received: by 2002:a17:90a:6e41:: with SMTP id s1mr28492721pjm.166.1636652689846;
        Thu, 11 Nov 2021 09:44:49 -0800 (PST)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id f21sm4393355pfc.85.2021.11.11.09.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 09:44:49 -0800 (PST)
Date:   Thu, 11 Nov 2021 17:44:45 +0000
From:   David Matlack <dmatlack@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>, stable@vger.kernel.org
Subject: Re: [RFC 01/19] KVM: x86/mmu: Fix TLB flush range when handling
 disconnected pt
Message-ID: <YY1Wje9zNEch6XvG@google.com>
References: <20211110223010.1392399-1-bgardon@google.com>
 <20211110223010.1392399-2-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110223010.1392399-2-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 02:29:52PM -0800, Ben Gardon wrote:
> When recursively clearing out disconnected pts, the range based TLB
> flush in handle_removed_tdp_mmu_page uses the wrong starting GFN,
> resulting in the flush mostly missing the affected range. Fix this by
> using base_gfn for the flush.
> 
> Fixes: a066e61f13cf ("KVM: x86/mmu: Factor out handling of removed page tables")
> CC: stable@vger.kernel.org
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 7c5dd83e52de..866c2b191e1e 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -374,7 +374,7 @@ static void handle_removed_tdp_mmu_page(struct kvm *kvm, tdp_ptep_t pt,
>  				    shared);
>  	}
>  
> -	kvm_flush_remote_tlbs_with_address(kvm, gfn,
> +	kvm_flush_remote_tlbs_with_address(kvm, base_gfn,

Suggest pulling the definition of gfn into the for loop as well (along
with sptep and old_child_spte for that matter) so that referencing it
here isn't even possible.

>  					   KVM_PAGES_PER_HPAGE(level + 1));
>  
>  	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog
> 
