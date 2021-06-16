Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016FA3AA0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhFPQBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbhFPQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:01:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2634C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:59:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h12so1342105plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jsKxH6Uvg5elYWvTgwin/KbQ6DsnCN7zXRgANzUnLwM=;
        b=tWo+pAnepuiklZmHLkiKrERf8oiCjr/yw/ZPqTO75EjOAxb4KYr1baeC1kx3sLhwIU
         zfmIFj6xSZ9wmKtsGjnJGcAs0wKk2ZL4xte/BsDKkYZrT56vdHPPHA/QD7vdXGVaFgQw
         XJWf0/udIC3PQOFXW0n4aSoIic13ntc81DmKsKy+HBCIDirjxtWKpJAc5+XBd5xZEpcv
         0kqeQC4TFMbR2t/XIFsvByVJvvZLNToiZoJXfH9lg8xX2LvM/bn0gV4K9D1vLufQCw2I
         lgbYrC+N/hpez9U9bmQ94L7zI3b9y5cPFLNt58T4ojg9v9SC5+VawW1lBsrW9U4jIhyG
         Mcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jsKxH6Uvg5elYWvTgwin/KbQ6DsnCN7zXRgANzUnLwM=;
        b=WGRaa+M3KskhQQyF6T75JO+s0xTZDZ/B67E/DRU2uV2MSs4fa5pfC/mWcMIg0lvrPY
         qLteA9kBDy50J48nQNBeDA/qF65iMQZeaJJtoIrssz0UVlnlb9XncDn6ZD89nZgx+B9M
         XCntGw/FpJVv8m2E56tk8EP4lIhRr7qPRAlcxrQkT4gSZhbQqWCLdNVTkUZhX76tQ5bd
         lp15EpJ4JWALe2QSct3el/nzz9mJNUvOrkHFmdHY8RGqhFGBj32f64ww6rF1qWU2CgFn
         xklr0peZYn1Mn8d/NnKXENad374ZaYzW53vyFnX8QEsjOrnNSOlX04JBLezxPBsg3dI4
         yA3w==
X-Gm-Message-State: AOAM532B4EVuTIPEX4QuvgIOV2N8hbikFoSLrgkzTHYYiTLq8sAvnKYM
        v3RuY2y5YxyVxkQwz3RXXgqCtg==
X-Google-Smtp-Source: ABdhPJxWFzNLedWCeXDMwNldQyhDcm+rIjfYVI23h8uftkCNBu339VenxWmhaHN81/JY5otI5GTwaQ==
X-Received: by 2002:a17:90a:7025:: with SMTP id f34mr10396009pjk.95.1623859167790;
        Wed, 16 Jun 2021 08:59:27 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n14sm2544584pfa.138.2021.06.16.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 08:59:27 -0700 (PDT)
Date:   Wed, 16 Jun 2021 15:59:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86: fix 32 bit build
Message-ID: <YMof22ameZYUHNdi@google.com>
References: <20210616155032.1117176-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616155032.1117176-1-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021, Maxim Levitsky wrote:
> Now that kvm->stat.nx_lpage_splits is 64 bit, use DIV_ROUND_UP_ULL
> when doing division.

I went the "cast to an unsigned long" route.  I prefer the cast approach because
to_zap is also an unsigned long, i.e. using DIV_ROUND_UP_ULL() could look like a
truncation bug.  In practice, nx_lpage_splits can't be more than an unsigned long
so it's largely a moot point, I just like the more explicit "this is doing
something odd".

https://lkml.kernel.org/r/20210615162905.2132937-1-seanjc@google.com

> Fixes: 7ee093d4f3f5 ("KVM: switch per-VM stats to u64")
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 720ceb0a1f5c..97372225f183 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6054,7 +6054,7 @@ static void kvm_recover_nx_lpages(struct kvm *kvm)
>  	write_lock(&kvm->mmu_lock);
>  
>  	ratio = READ_ONCE(nx_huge_pages_recovery_ratio);
> -	to_zap = ratio ? DIV_ROUND_UP(kvm->stat.nx_lpage_splits, ratio) : 0;
> +	to_zap = ratio ? DIV_ROUND_UP_ULL(kvm->stat.nx_lpage_splits, ratio) : 0;
>  	for ( ; to_zap; --to_zap) {
>  		if (list_empty(&kvm->arch.lpage_disallowed_mmu_pages))
>  			break;
> -- 
> 2.26.3
> 
