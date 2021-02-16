Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E645431CDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBPQWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBPQWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:22:01 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6300C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:21:19 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 75so3157768pgf.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ICaHiuq9sQswfA1xeW7s9Nu305gjOngzWGENdWHyfwo=;
        b=XjKpPVRuZw8GCEH6eA2RBf9/ASbC/dgnGma0Q+AKyXDZ0T6p9QUOzoUJsDe76h5lu7
         ya6hUdzWAgFZJuyfPfJeidvsfxG55K7F0klJbAZnYBgfp7+I45BY2eOU6sNUjjghvdPc
         go1DegO0GpfqotB05aprkPvCYnCmgX0ghkLKxOfaRtPDIfZokvGAh/dtgSxBzcCNzA9f
         XVBFGUlYcbC330zRb1hybBZK8mG0HaM95ExkvyOJlC1jTBrI0qTj9wpLJjELa1RD8T5S
         FEfy1L1Q5+oAZmBgOsQi1wOw+dl8iONd0l0x2druG9Epwbz/dgo3smcQ7cUQX4O/lziz
         CY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ICaHiuq9sQswfA1xeW7s9Nu305gjOngzWGENdWHyfwo=;
        b=hpOIqHQIO4oEROrssU2pAhhelVYgtZO3gvAtS/pDiXIhggiFnVvQWDEKwxjn0SIXG9
         mmc3r6aKEq0Gkk/QXHRurDHUndOVoxUUv9KgZSIbbvy5pKKz2JkmU+IjY4x1B3NHmlu8
         o6yq8Yjm/kx7vl2o5KOAmsiMNPs5pryPn7WhGBOXzJjLphIDOyf5jDtLSv8lWf3SEpQj
         hgjxMV/kyFoJCdyUou0Q9YpdEs6Zw0Y5Y+4IF+ipMVdEXzK54NAKOB8CgpvWRG5Ig1Oq
         ayLmHa3rXjvcSRqcchBQiilf0WEky3TZmEDE7YpUYiXqMiTLrwHMmwuqDRmYuUFvXKn4
         CzbQ==
X-Gm-Message-State: AOAM533uVaFcEaJvM2BOB0g+be1H+f9MPAkSUHtFrbhP0ZLG6P3W81y0
        67s12VcQhNYmHFMnIfEqYGjuEQ==
X-Google-Smtp-Source: ABdhPJwK6txOBGk6t8C7EsIVXZPKe4FVavK53stVIFcjWVnrQQ+pL5Jvv8qZcwz2xfxSjbaQ7sgNdg==
X-Received: by 2002:a62:187:0:b029:1da:e323:a96b with SMTP id 129-20020a6201870000b02901dae323a96bmr20916692pfb.28.1613492479131;
        Tue, 16 Feb 2021 08:21:19 -0800 (PST)
Received: from google.com ([2620:15c:f:10:d107:e68e:347d:fd04])
        by smtp.gmail.com with ESMTPSA id j4sm20756990pfa.131.2021.02.16.08.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:21:18 -0800 (PST)
Date:   Tue, 16 Feb 2021 08:21:11 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 1/2] x86/stackprotector/32: Make the canary into a
 regular percpu variable
Message-ID: <YCvw99dIJ9C90Q6R@google.com>
References: <cover.1613243844.git.luto@kernel.org>
 <c0ff7dba14041c7e5d1cae5d4df052f03759bef3.1613243844.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ff7dba14041c7e5d1cae5d4df052f03759bef3.1613243844.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021, Andy Lutomirski wrote:
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f923e14e87df..ec39073b4897 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1467,12 +1467,8 @@ static void svm_vcpu_put(struct kvm_vcpu *vcpu)
>  #ifdef CONFIG_X86_64
>  		loadsegment(fs, svm->host.fs);
>  		wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
> -		load_gs_index(svm->host.gs);
> -#else
> -#ifdef CONFIG_X86_32_LAZY_GS
> -		loadsegment(gs, svm->host.gs);
> -#endif

This manually GS crud is gone as of commit e79b91bb3c91 ("KVM: SVM: use
vmsave/vmload for saving/restoring additional host state"), which is queued for
5.12.

>  #endif
> +		load_gs_index(svm->host.gs);
>  
>  		for (i = 0; i < NR_HOST_SAVE_USER_MSRS; i++)
>  			wrmsrl(host_save_user_msrs[i].index,
> @@ -3705,13 +3701,11 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>  	} else {
>  		__svm_vcpu_run(svm->vmcb_pa, (unsigned long *)&svm->vcpu.arch.regs);
>  
> +		/* Restore the percpu segment immediately. */
>  #ifdef CONFIG_X86_64
>  		native_wrmsrl(MSR_GS_BASE, svm->host.gs_base);
>  #else
>  		loadsegment(fs, svm->host.fs);
> -#ifndef CONFIG_X86_32_LAZY_GS
> -		loadsegment(gs, svm->host.gs);
> -#endif
>  #endif
>  	}
