Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8077C37220F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhECUyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhECUyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:54:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A396C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 13:53:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v191so5184737pfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HG2iNPS4vD6GrbqrBfY2VORMzd+kD2GBhkRPz7mriA8=;
        b=n2ftQwm8noxgljSPL4wW5Y3SCTg7vd3R4Vy7KhuNmyKgm3rffGmKYAZHVOqlUp/Ary
         STPerdv+arJoa+ql79CrWotvXvy2wY/r7yQdYW7+b+WAFHe621SSDOFwnXBPx0HIO6bU
         D5/8di/nCu32y9NFL/tasW5xRLrMDw5tLP81BEwLjInJ2sD+BAKP17UeOpg0pih1j8gU
         ybsslREp0Fqrxstt2SIxjvo2nXSD26MW2fFH3XWNqmmAJhjrXUi4QVICj8l3sOdi3UIb
         waJPUX2VhYTdTxppxyToFNeo4cXrfxoAYvgNCDK3ItobxIl62P/fGelG2hGY8fWdYsFM
         x2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HG2iNPS4vD6GrbqrBfY2VORMzd+kD2GBhkRPz7mriA8=;
        b=om+84tmDDh7IcS6c7y4aiizm5hrhpBPfARYsD/gDHjTS80ois4/Ykfty34HDDP1iWh
         A0S6xsfoED1nbgygRKQbADsbuXqxwwHKoLSdg0AFR7vVAJD/xWs+V2hk4GGtBsSTkL0r
         cTdZAoJTjFm3WZSPpbmfO7jptacJ3g4qZ5uG9nWpP6XQ5nsN0Kj+2xFdZUSzMU72kbCY
         jwjAs2ekzeBMSZQaZLoPo/HzQZoJZMB61pGODJo9FXZT/4tLj1HtdjFTTBoAm+g8Zww7
         yp5lrePU2eQc7BSofdVGSpTGjuIACc0w0cgM5p3xnDJ0zeqv+PRZ2JU+WUqMwkLs7Fm1
         YJqA==
X-Gm-Message-State: AOAM533gEdj0EobL+123Ha8x0xRfME7qE42YVnVw72QrWKfsduVqSvGb
        xCD8MSnA3SZtrSzU1NlaJqXrIA==
X-Google-Smtp-Source: ABdhPJyAEygoMk7Ly1OgLpfsjKRWjlj1zjMSVtHgt83+UZ1qGH/TogN/idt2I2LqqUGNhSNwwo7AuQ==
X-Received: by 2002:a05:6a00:c8:b029:260:f25a:f2ef with SMTP id e8-20020a056a0000c8b0290260f25af2efmr20322820pfj.78.1620075193504;
        Mon, 03 May 2021 13:53:13 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id g8sm9749944pfo.85.2021.05.03.13.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 13:53:12 -0700 (PDT)
Date:   Mon, 3 May 2021 20:53:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Hoist input checks in kvm_add_msr_filter()
Message-ID: <YJBitcip8/WIsaB9@google.com>
References: <20210503122111.13775-1-sidcha@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503122111.13775-1-sidcha@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021, Siddharth Chandrasekaran wrote:
> In ioctl KVM_X86_SET_MSR_FILTER, input from user space is validated
> after a memdup_user(). For invalid inputs we'd memdup and then call
> kfree unnecessarily. Hoist input validation to avoid kfree altogether.
> 
> Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
> ---
>  arch/x86/kvm/x86.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ee0dc58ac3a5..15c20b31cc91 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5393,11 +5393,16 @@ static int kvm_add_msr_filter(struct kvm_x86_msr_filter *msr_filter,
>  	struct msr_bitmap_range range;
>  	unsigned long *bitmap = NULL;
>  	size_t bitmap_size;
> -	int r;
>  
>  	if (!user_range->nmsrs)
>  		return 0;
>  
> +	if (user_range->flags & ~(KVM_MSR_FILTER_READ | KVM_MSR_FILTER_WRITE))
> +		return -EINVAL;
> +
> +	if (!user_range->flags)
> +		return -EINVAL;
> +
>  	bitmap_size = BITS_TO_LONGS(user_range->nmsrs) * sizeof(long);
>  	if (!bitmap_size || bitmap_size > KVM_MSR_FILTER_MAX_BITMAP_SIZE)
>  		return -EINVAL;
> @@ -5413,24 +5418,10 @@ static int kvm_add_msr_filter(struct kvm_x86_msr_filter *msr_filter,
>  		.bitmap = bitmap,
>  	};
>  
> -	if (range.flags & ~(KVM_MSR_FILTER_READ | KVM_MSR_FILTER_WRITE)) {
> -		r = -EINVAL;
> -		goto err;
> -	}
> -
> -	if (!range.flags) {
> -		r = -EINVAL;
> -		goto err;
> -	}
> -
> -	/* Everything ok, add this range identifier. */
>  	msr_filter->ranges[msr_filter->count] = range;

Might be worth elminating the intermediate "range", too.  Doesn't affect output,
but it would make it a little more obvious that the new range is mostly coming
straight from userspace input.  E.g.

	msr_filter->ranges[msr_filter->count] = (struct msr_bitmap_range) {
		.flags = user_range->flags,
		.base = user_range->base,
		.nmsrs = user_range->nmsrs,
		.bitmap = bitmap,
	};

Either way:

Reviewed-by: Sean Christopherson <seanjc@google.com>

>  	msr_filter->count++;
>  
>  	return 0;
> -err:
> -	kfree(bitmap);
> -	return r;
>  }
>  
>  static int kvm_vm_ioctl_set_msr_filter(struct kvm *kvm, void __user *argp)
> -- 
