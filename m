Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3F38F534
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 23:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhEXVzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 17:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhEXVzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 17:55:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1062DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 14:54:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x18so17652758pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y7H6pCP7/yViKEmHdKMC147HRDRySUoBtMkLMOdzOEY=;
        b=QkDsj98CjSxsb0UVBSUKnaRnpNYKcn+hGZ9oD5zxCYio1dHxtpr/gk8UTTwhWYwyYP
         h1RBH+oRPt5vanKSGKlCbL7DCgH3Jqo+i4kcIxadUbNjV1jMH7fIu8gc8hgo8aBLGeAG
         D40biFug8QAimDQ3VPX5TDjLk/0ySZebc4j5D5kFYrX0ODB1XVMF6ogSm6ahTsyxrnK1
         j2Otr8+l2q9GHCs1T4MA1zQYvTYOdTcfawV+5vjb2a9otNsa0QUxd0DDrddKHf5AlqKF
         UfuBH8aQvpsvk97CFt4byKXdErvqzoDGe/EDQmJGTI5Jp8TVmeyycw/XBOcz4ahUf7+a
         VI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y7H6pCP7/yViKEmHdKMC147HRDRySUoBtMkLMOdzOEY=;
        b=FJCCiaZU/SkWBQAxhYCwfUVbnH6ZrcmP4iDDCz4HyhrrUv0kMFeR2uaXic2NfzIgxo
         eRTjoKkUE+SLTLJJZSipJh1NiIkH/frBBBi6NGHZpzD6G5gPMgAsJ2JewVgIUV+3RmFr
         ByWGXekAbdXjZ3fHUqHSnI20+J2Cof+y8f8QLXkaqai+KofDyw0GqBNankhOYbJr6GxG
         HCF46cg7gX4PHhP6vZ3W01a3BAvA74s9vEr+PHrOi03RXCVUfgHM/Hjq5VSe8i3n/cOH
         0/oKPXpBVzcpqbiwmcJnCZJMvP/Q2S5EpnhtKP1nZLL6y09/Rez2K6jgvBt2ywIWbeiS
         FOEg==
X-Gm-Message-State: AOAM530MsRCLTZuvmp7qoxb5ImirzlNwuyVMbZMZmVvZ+zI4uojWrDvd
        mVx4lnbzo6Rixl0OZFOfWcepzg==
X-Google-Smtp-Source: ABdhPJwOHx8ecBfE8DDXSATrpxTZSwQywYuF9nhhh9re21Qri4jNYnxAiTEG7CWkP8IKSrkddgSz8g==
X-Received: by 2002:a05:6a00:882:b029:2de:b01d:755a with SMTP id q2-20020a056a000882b02902deb01d755amr26872259pfj.43.1621893240451;
        Mon, 24 May 2021 14:54:00 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id q24sm12235699pgk.32.2021.05.24.14.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 14:53:59 -0700 (PDT)
Date:   Mon, 24 May 2021 21:53:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jing Liu <jing2.liu@linux.intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jing2.liu@intel.com
Subject: Re: [PATCH RFC 7/7] kvm: x86: AMX XCR0 support for guest
Message-ID: <YKwgdBTqiyuItL6b@google.com>
References: <20210207154256.52850-1-jing2.liu@linux.intel.com>
 <20210207154256.52850-8-jing2.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207154256.52850-8-jing2.liu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021, Jing Liu wrote:
> Two XCR0 bits are defined for AMX to support XSAVE mechanism.
> Bit 17 is for tilecfg and bit 18 is for tiledata.

This fails to explain why they must be set in tandem.  Out of curisoity, assuming
they do indeed need to be set/cleared as a pair, what's the point of having two
separate bits?

> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---
>  arch/x86/kvm/x86.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index bfbde877221e..f1c5893dee18 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -189,7 +189,7 @@ static struct kvm_user_return_msrs __percpu *user_return_msrs;
>  #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
>  				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
>  				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
> -				| XFEATURE_MASK_PKRU)
> +				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
>  
>  u64 __read_mostly host_efer;
>  EXPORT_SYMBOL_GPL(host_efer);
> @@ -946,6 +946,12 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
>  		if ((xcr0 & XFEATURE_MASK_AVX512) != XFEATURE_MASK_AVX512)
>  			return 1;
>  	}
> +
> +	if (xcr0 & XFEATURE_MASK_XTILE) {
> +		if ((xcr0 & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE)
> +			return 1;
> +	}
> +
>  	vcpu->arch.xcr0 = xcr0;
>  
>  	if ((xcr0 ^ old_xcr0) & XFEATURE_MASK_EXTEND)
> -- 
> 2.18.4
> 
