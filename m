Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602D73882E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352824AbhERWyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhERWyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:54:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E56C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:53:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s20so5934925plr.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dotWxrOp8K4nhTYCAIVDd9toWE3lkvpXCMU0xA+uEKo=;
        b=Vm4hjviMk1po1J7O8GIWHEKhXBGcWvWq5kXlisVEr+ff+cjoXY5DvrT19j0NZkrwcj
         WRdXPVZgN0v917mQyfqn4DmNd1d4AE6m6wPLz8LaBtcD19BkEI+fibBMuTzwSbxGjnDH
         ToeOpa2ZMwesm1R9RmpD2vRnrC4uKBTpw9vFpWFLMLjUBUq/FXQk6P7p2kMCy0ibWjxI
         8AP5/F78/x734XO538iTwEvWKAfLI0NhaUd85N4vf98z58cEQkfRcwUurM0NqjELY/i6
         pZCd0xAs2HwyU+2Hlz1+nAQ7bvj75HOBGAIwjQ88PiZi1ECkNV9r7sRPs/vszlN7eZdg
         NZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dotWxrOp8K4nhTYCAIVDd9toWE3lkvpXCMU0xA+uEKo=;
        b=EOd4Pm/JIjLesNWqkHQTrn5O5AZO97DgA9D50c0BbDoKiHA7LjaIuxy+MidkvXtLKV
         ItxiEjfCrLbbjpW+ohBUXSONDsOCyzjUl3jlR0x1VlFlhEGModiLRRFQy8re/+Eydj3G
         XMk7BW2HN4kZNMliLaP2P8Ovs/YVV+Nm4naddTy9eP7UPMugZxbi31U4K/gdRoYb5/go
         JRBpGDD0dlF1S+sA09kB8s9bz6zPxEIFVpHx1X9FeMe1Bi+6ayW+B6JB4nGGs6GqOyIL
         sJpx/yfKOoUkhUmMV6m7p2Zi7EsKK1T8YYL7AKSp9poWshmIMNt17ZYvk8/sXd1/XPkF
         mgpw==
X-Gm-Message-State: AOAM532AI+hZ05zzmAfX6mXZtYHr93Z53n+BZMNK+OQ8LAsgN8AjvlCk
        axe+RkOpYqV/yEiy8Ns5eDJ9xA==
X-Google-Smtp-Source: ABdhPJwLjao8AmZKDk6HAhx/sRqBwV7F3KweWJZpI0BPD7LL+uKMU+xDSyxXleSc8b7IkUBhycYQmQ==
X-Received: by 2002:a17:90a:df0a:: with SMTP id gp10mr7756262pjb.27.1621378381944;
        Tue, 18 May 2021 15:53:01 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id g89sm2661643pjg.30.2021.05.18.15.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 15:53:01 -0700 (PDT)
Date:   Tue, 18 May 2021 22:52:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ilias Stamatis <ilstam@amazon.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, mlevitsk@redhat.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        zamsden@gmail.com, mtosatti@redhat.com, dwmw@amazon.co.uk
Subject: Re: [PATCH v2 02/10] KVM: X86: Store L1's TSC scaling ratio in
 'struct kvm_vcpu_arch'
Message-ID: <YKRFSaktB4+tgFUH@google.com>
References: <20210512150945.4591-1-ilstam@amazon.com>
 <20210512150945.4591-3-ilstam@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512150945.4591-3-ilstam@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021, Ilias Stamatis wrote:
> Store L1's scaling ratio in that struct like we already do for L1's TSC

s/that struct/kvm_vcpu_arch.  Forcing the reader to look at the subject to
understand the changelog is annoying, especially when it saves all of a handful
of characters.  E.g. I often read patches without the subject in scope.

> offset. This allows for easy save/restore when we enter and then exit
> the nested guest.
> 
> Signed-off-by: Ilias Stamatis <ilstam@amazon.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---

...

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9b6bca616929..07cf5d7ece38 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2185,6 +2185,7 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
>  
>  	/* Guest TSC same frequency as host TSC? */
>  	if (!scale) {
> +		vcpu->arch.l1_tsc_scaling_ratio = kvm_default_tsc_scaling_ratio;
>  		vcpu->arch.tsc_scaling_ratio = kvm_default_tsc_scaling_ratio;

Looks like these are always set as a pair, maybe add a helper, e.g.

static void kvm_set_l1_tsc_scaling_ratio(u64 ratio)
{
	vcpu->arch.l1_tsc_scaling_ratio = ratio;
	vcpu->arch.tsc_scaling_ratio = ratio;
}

>  		return 0;
>  	}
> @@ -2211,7 +2212,7 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
>  		return -1;
>  	}
>  
> -	vcpu->arch.tsc_scaling_ratio = ratio;
> +	vcpu->arch.l1_tsc_scaling_ratio = vcpu->arch.tsc_scaling_ratio = ratio;
>  	return 0;
>  }
>  
> @@ -2223,6 +2224,7 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
>  	/* tsc_khz can be zero if TSC calibration fails */
>  	if (user_tsc_khz == 0) {
>  		/* set tsc_scaling_ratio to a safe value */
> +		vcpu->arch.l1_tsc_scaling_ratio = kvm_default_tsc_scaling_ratio;
>  		vcpu->arch.tsc_scaling_ratio = kvm_default_tsc_scaling_ratio;
>  		return -1;
>  	}
> @@ -2459,7 +2461,7 @@ static inline void adjust_tsc_offset_guest(struct kvm_vcpu *vcpu,
>  
>  static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adjustment)
>  {
> -	if (vcpu->arch.tsc_scaling_ratio != kvm_default_tsc_scaling_ratio)
> +	if (vcpu->arch.l1_tsc_scaling_ratio != kvm_default_tsc_scaling_ratio)
>  		WARN_ON(adjustment < 0);
>  	adjustment = kvm_scale_tsc(vcpu, (u64) adjustment);
>  	adjust_tsc_offset_guest(vcpu, adjustment);
> -- 
> 2.17.1
> 
