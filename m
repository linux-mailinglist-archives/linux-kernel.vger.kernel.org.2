Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E53DE27A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhHBW3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhHBW3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:29:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0442C061764
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 15:29:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z3so20048598plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9qmivmphespvuvyQ3MoQcp3D+LF94WdyvdfL2S659tE=;
        b=QTS5XBU/761TpN4U96Dh5MQybzFkqH146ItHsrUeAN+GIDp5GJqcYZ0UdTUXckdlFd
         cNSiuSkRgJEEX5Cd7UjrDqOBtgocNdFU/I3PUQFcfpmoYw/KaVpLDuPdZr/VKm/OJ+pd
         ssqtwWpblWCQsqftXO6LkljYpm3Ir+w0gPQG0sPn1mwWg+hVtYa2e47I/lHmQkuAwu2G
         V7YVQSgIMfDZ+58cTIu+g8+w7bdyKjVD38Om0pgPRF5wxFKJhnEycam6tDsVGpRSZ+rN
         xq5v/xOaU8NoAjmveoqSmYC+m6VmCUZ76IQxE1CLBrKsaZYOEg5yM5aqtpRbSO1LsWc6
         Vfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qmivmphespvuvyQ3MoQcp3D+LF94WdyvdfL2S659tE=;
        b=eNKBg8FdJwZW3WP4GFIxJfFHjkgD2s0rFtg63BGPBHPkuqLFW4JgsC2ogx+haiOpig
         WTCfZWocB1Iuerot7Kk36NW7x7GZGUWrdSQfVUDp+aCHNZiHP+0YLc+Zuf8yO5g3C6nM
         flOt4YuzsGO2VRGA5NlZaK7EcKukhhM4gVBMhpZQaxlFPX675+RoLUuPs0JIF0SnnBYX
         6gqE//wx/3sL5c5A7FYKQVBCxSu6wdZ5fGLjP2UvMlfAXw9HyJpNNLFxRjBnS11Lqh8O
         wV+oZNfkNt+aLO3IUyDdUElHV9fzVNA3tgLROml/FV1wlpwL0YpybkVOuzT/Rc6JIWfu
         k1RA==
X-Gm-Message-State: AOAM5300otsRIU3vEeIU2E+Zd6uEHNGXN4ZCDnW8wV6Ry1z8qVCOZmea
        /347YqecuccJ4YEZ4yQJpYy+sA==
X-Google-Smtp-Source: ABdhPJxNTeEN+USUY59x0OHcGeOKlwn8jz4ouYtbv2FZxQLVOv04gz5fLCya8zXjx2u4CxgyIA3AcA==
X-Received: by 2002:aa7:854a:0:b029:332:330e:1387 with SMTP id y10-20020aa7854a0000b0290332330e1387mr18564513pfn.67.1627943364007;
        Mon, 02 Aug 2021 15:29:24 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id y7sm12164953pfi.204.2021.08.02.15.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:29:23 -0700 (PDT)
Date:   Mon, 2 Aug 2021 22:29:19 +0000
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
Subject: Re: [PATCH v3 1/3] KVM: x86/mmu: Remove redundant spte present check
 in mmu_set_spte
Message-ID: <YQhxv3XO931lk7ny@google.com>
References: <20210730225939.3852712-1-mizhang@google.com>
 <20210730225939.3852712-2-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730225939.3852712-2-mizhang@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:59:37PM -0700, Mingwei Zhang wrote:
> Drop an unnecessary is_shadow_present_pte() check when updating the rmaps
> after installing a non-MMIO SPTE.  set_spte() is used only to create
> shadow-present SPTEs, e.g. MMIO SPTEs are handled early on, mmu_set_spte()
> runs with mmu_lock held for write, i.e. the SPTE can't be zapped between
> writing the SPTE and updating the rmaps.
> 
> Opportunistically combine the "new SPTE" logic for large pages and rmaps.
> 
> No functional change intended.
> 
> Suggested-by: Ben Gardon <bgardon@google.com>
> 
> Reviewed-by: Ben Gardon <bgardon@google.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---

Reviewed-by: David Matlack <dmatlack@google.com>

>  arch/x86/kvm/mmu/mmu.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b888385d1933..442cc554ebd6 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2690,15 +2690,13 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
>  
>  	pgprintk("%s: setting spte %llx\n", __func__, *sptep);
>  	trace_kvm_mmu_set_spte(level, gfn, sptep);
> -	if (!was_rmapped && is_large_pte(*sptep))
> -		++vcpu->kvm->stat.lpages;
>  
> -	if (is_shadow_present_pte(*sptep)) {
> -		if (!was_rmapped) {
> -			rmap_count = rmap_add(vcpu, sptep, gfn);
> -			if (rmap_count > RMAP_RECYCLE_THRESHOLD)
> -				rmap_recycle(vcpu, sptep, gfn);
> -		}
> +	if (!was_rmapped) {
> +		if (is_large_pte(*sptep))
> +			++vcpu->kvm->stat.lpages;
> +		rmap_count = rmap_add(vcpu, sptep, gfn);
> +		if (rmap_count > RMAP_RECYCLE_THRESHOLD)
> +			rmap_recycle(vcpu, sptep, gfn);
>  	}
>  
>  	return ret;
> -- 
> 2.32.0.554.ge1b32706d8-goog
> 
