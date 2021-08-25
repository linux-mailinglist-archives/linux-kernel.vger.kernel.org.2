Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A13F7820
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241467AbhHYPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240918AbhHYPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:19:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A80C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 08:18:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t1so51224pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XF1x8B/ZG+F34bQ5051hv3MrWVrItt8QQmW8Vc8uix8=;
        b=NzpAD+6a7NO6y8+3tcRH6gm+u56SAvRDBjAOIh8Fx6VgBbSWJRlzzIC/1CYBfRDWkz
         L0EBsf5sV+zs8RXVEZQvGjka9VIRhZZRAP31Et8lmWdV2VMawSdEl181drDeIhKMc7iG
         zeO7bhzgyzKfpTW8MO9Zwdjbd0xYvn2yI5JIwKLPyJK/pEKmZ6arbQFaHcza/3fT+YA/
         DuCMIZqRhDaU4sMLNMLg0KlMYki195HD9qtZ8F//KRB5mVNCc9MZ81wv8LriIVL0/ghT
         AozVt7i1NX2untQ1Jk8LFAkDnO3kRS3+P5Tg2habkcmyPu4tKyrxTFwJXg2ABBrA5qxk
         e5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XF1x8B/ZG+F34bQ5051hv3MrWVrItt8QQmW8Vc8uix8=;
        b=nD/SUeW7nWKNsnEBCM0i9AxyKupvuY0G9Omm6Yz6TPf7PNGaCZ/A6JkMYTc0NZJp+D
         fo8GQivoGBh/+YMyiFmkddJ4fmCoRtomcLCr5Xh4AMQdXo9S9NO3dSXMxvMJK0Wc5oDe
         siqV4zuaw9Tfj08IrA6rmtX1lkbrTfZ8TkqOKNpZzi2iiCfUFs7FHvqp0jkz4kq2REVx
         h04STN96ZXuJYxyF8wbDYZQN89RITmt6VqTVkdixkxFgo27evrHDN9l1I7h+OfsyGakR
         5tFMKlPvLETknkoPGSa0qHIFsqYGYsla8qbt7C3XF9el1nc/xJ6HlegzLvKzaHuzd7vu
         cDqQ==
X-Gm-Message-State: AOAM533AdTzZkcR33HlFdli2RiKxzExGj4bFUoFD91Wx80gVyMzjS7ow
        TYyHaH3lTqqX+d9+MyDYb/734w==
X-Google-Smtp-Source: ABdhPJwFscpynT8cC50el9VfgECR2sNqwfJbOc3s01idcQI7wYJQHzIUtihpQepaA+F7ckmzeWHfGg==
X-Received: by 2002:a63:411:: with SMTP id 17mr33488845pge.335.1629904726625;
        Wed, 25 Aug 2021 08:18:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 23sm289495pgk.89.2021.08.25.08.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 08:18:46 -0700 (PDT)
Date:   Wed, 25 Aug 2021 15:18:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH 7/7] KVM: X86: Also prefetch the last range in
 __direct_pte_prefetch().
Message-ID: <YSZfUqPuhENCDa9z@google.com>
References: <20210824075524.3354-1-jiangshanlai@gmail.com>
 <20210824075524.3354-8-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824075524.3354-8-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> __direct_pte_prefetch() skips prefetching the last range.
> 
> The last range are often the whole range after the faulted spte when
> guest is touching huge-page-mapped(in guest view) memory forwardly
> which means prefetching them can reduce pagefault.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e5932af6f11c..ac260e01e9d8 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2847,8 +2847,9 @@ static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
>  	i = (sptep - sp->spt) & ~(PTE_PREFETCH_NUM - 1);
>  	spte = sp->spt + i;
>  
> -	for (i = 0; i < PTE_PREFETCH_NUM; i++, spte++) {
> -		if (is_shadow_present_pte(*spte) || spte == sptep) {
> +	for (i = 0; i <= PTE_PREFETCH_NUM; i++, spte++) {
> +		if (i == PTE_PREFETCH_NUM ||
> +		    is_shadow_present_pte(*spte) || spte == sptep) {

Heh, I posted a fix just a few days ago.  I prefer having a separate call after
the loop.  The "<= PTE_PREFETCH_NUM" is subtle, and a check at the ends avoids
a CMP+Jcc in the loop, though I highly doubt that actually affects performance.

https://lkml.kernel.org/r/20210818235615.2047588-1-seanjc@google.com

>  			if (!start)
>  				continue;
>  			if (direct_pte_prefetch_many(vcpu, sp, start, spte) < 0)
> -- 
> 2.19.1.6.gb485710b
> 
