Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43363D931A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhG1QYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhG1QYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:24:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878EAC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:24:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a20so3376413plm.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fjhAztcxPbj6GCHCrhXV3HF94+0ZyiWrizPlj65G63M=;
        b=qiwppd0eMTb9QrwKCSnlMVBqBUBMjkk44DOkoShPQ5MmX+niLVhbP0D924t51BeEiX
         7i3RkVmGNBTFZvre/CkDvDUrbFxwF8DC1qLA4qFV0xirK0Tlnukm5FpYmvSt3Nd5AD9s
         tqD2slJO8B4KHduCH7SxiLcxZA5dm3q4UMvQj7NoZayfEGJTXnTMIF4glTocUK0EEEBN
         oyywY9Tx3N9fUmwetIk5kMnu0wq3wXoF06SJNu/7+Efvm7AAcwBM3p8nrkfKL7SeelhZ
         WE3/bgtD0nsULPRHZDrOv9HGdaxikxPhr1Jt6rJf4zn56KyRarkWvTJ5acwsaORpVyZA
         du3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fjhAztcxPbj6GCHCrhXV3HF94+0ZyiWrizPlj65G63M=;
        b=PRVgj6hCPvEU4JD6Aidf3OB6dr/q5h6HsQ7UtXZEZgdJRY+4Akb0Dxv64t5tDKqZg2
         2cY0MFrXZcbI0hl4KM4M9c0GO56T++fUn/kQgPiX7j1FA71UbIIHaJC6zDxbgpllKT7T
         rn2F3RpSxmd/KHB7Z3fNcWDVu0YI9bXIt7IqRtGIQt5RL1hdcvbgCTxAk1d1MhuMdA0t
         sEfanYbDRTVXxn7U6d4mmCQra6JfJmXF5Gnywjdds1nnhaD6yEjZNFreP4nnsERyizAN
         MQj2mO2qTyAiBHkaQYZv2PQt7025wBowyfBpq6fMg2p0HTbG+HqNveslNBtBuF54HmAx
         CPWg==
X-Gm-Message-State: AOAM5335jhnLNLYwMdUcdyjK55B9clfCt66F1bCNPrJXUZn9tbo5gKqC
        o5ry+8n1WF8mgA/s3WfuMPfDhA==
X-Google-Smtp-Source: ABdhPJyeJel6WKLgZw3plxOQ8WoG2P48c5pdbVK988dtMXMbXt5tX8N2nWrE2BZZVjb3pINGnsDbsA==
X-Received: by 2002:a65:44c3:: with SMTP id g3mr555757pgs.233.1627489445900;
        Wed, 28 Jul 2021 09:24:05 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q4sm472347pfn.23.2021.07.28.09.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:24:05 -0700 (PDT)
Date:   Wed, 28 Jul 2021 16:24:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] KVM: x86: Exit to userspace when kvm_check_nested_events
 fails
Message-ID: <YQGEoRTfGhinO41u@google.com>
References: <20210728115317.1930332-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728115317.1930332-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021, Paolo Bonzini wrote:
> From: Jim Mattson <jmattson@google.com>

I don't think this is actually from Jim.

> If kvm_check_nested_events fails due to raising an
> EXIT_REASON_INTERNAL_ERROR, propagate it to userspace
> immediately, even if the vCPU would otherwise be sleeping.
> This happens for example when the posted interrupt descriptor
> points outside guest memory.
> 
> Reported-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 348452bb16bc..916c976e99ab 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9752,10 +9752,14 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
>  	return 1;
>  }
>  
> -static inline bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
> +static inline int kvm_vcpu_running(struct kvm_vcpu *vcpu)
>  {
> -	if (is_guest_mode(vcpu))
> -		kvm_check_nested_events(vcpu);
> +	int r;

newline

> +	if (is_guest_mode(vcpu)) {
> +		r = kvm_check_nested_events(vcpu);
> +		if (r < 0 && r != -EBUSY)
> +			return r;
> +	}
>  
>  	return (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
>  		!vcpu->arch.apf.halted);
> @@ -9770,12 +9774,16 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>  	vcpu->arch.l1tf_flush_l1d = true;
>  
>  	for (;;) {
> -		if (kvm_vcpu_running(vcpu)) {
> -			r = vcpu_enter_guest(vcpu);
> -		} else {
> -			r = vcpu_block(kvm, vcpu);
> +		r = kvm_vcpu_running(vcpu);
> +		if (r < 0) {
> +			r = 0;
> +			break;
>  		}
>  
> +		if (r)
> +			r = vcpu_enter_guest(vcpu);
> +		else
> +			r = vcpu_block(kvm, vcpu);
>  		if (r <= 0)
>  			break;
>  
> -- 
> 2.27.0
> 
