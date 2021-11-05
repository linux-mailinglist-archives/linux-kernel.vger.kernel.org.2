Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0F4445D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhKEBIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhKEBIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:08:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94896C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:05:56 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g18so2662192pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G/nhaOd9Dv5dMVPfxGxOacbJh3HbdybN9D3Bt3gtDl4=;
        b=nvfkNvU5Z8xadZEfrQs+mun09ht1fvHcLrH2DxUG/3DX7gUnwMzAJkexDG2eYTXZcT
         nXC0KbqPvC1tK0JQgs5hCtnmTYToVQpMf8nCU56R48NFvVb6s3m/Ngv/UjYCmArWyqT5
         p0SUqwKjeQQxCQt0zc0As36KIH4BAIyfNYMeM36s0WzO5Q1J/xrc07u8scp9QxgFseUx
         dQ59ZAkYjl9GQ/mNW/WJt9rhnODEtXi5DZG6vgO1qHgTfVwOKU3kDPsIgbbN9rzZyOjx
         2mxK9OAGR8TorHdShQM7kemuuxLfv77EOifqsz29EGFHH4GQs7sBLdkOTDN1ZVWUEahZ
         b+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/nhaOd9Dv5dMVPfxGxOacbJh3HbdybN9D3Bt3gtDl4=;
        b=nX58PlJShjvXJAJJ1g78a7AVxhUBlZoxv/MVuHVxgtFIsvrc90z70G08BYaw/9jTxw
         0d1AGqlYCbmKvHYo7BWUe3kooq6FUZVEn+5Gu/HabfHEw1VuRRUtOCS3eAzxK5+vFlDT
         zNBgZPWAgjo8NeUJV7EdfcsvWz4oBbdXuMJCRAaU7cYgtJ9nxdK3P9SxB+gE/40r6ti2
         NXje+zvYc8k7xCK1Im43BYiB9QKTKeHjpiiIbkwGldKuthOKP25MZ3FlIVJR3USfKoE0
         qaCZsNPWUwjghKJd+YngQpcFsQpIqHF43UJM0Tx2tVmMNUvIm0B3BKOgd2QQTWepNbF/
         cIAg==
X-Gm-Message-State: AOAM532w6o4F/q8XcrMFan48SQb9RTP09Tram9FXmFjFnXppSrSUPYkB
        w8NnJjPimlBM8TnwRtZNY5e+yySHSbN//Q==
X-Google-Smtp-Source: ABdhPJxRK/fTi3PW003l6+S9tkKhBsOPyaIXk2qUrZkoR1F5QCgcD/FeTTDil/grcsUm+sPO+IkX/A==
X-Received: by 2002:a05:6a00:c94:b0:480:fcc2:bb2c with SMTP id a20-20020a056a000c9400b00480fcc2bb2cmr37089927pfv.30.1636074355284;
        Thu, 04 Nov 2021 18:05:55 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u22sm4846371pfi.78.2021.11.04.18.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:05:54 -0700 (PDT)
Date:   Fri, 5 Nov 2021 01:05:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] KVM: nVMX: Track whether changes in L0 require
 MSR bitmap for L2 to be rebuilt
Message-ID: <YYSDbljJgpEOnx+W@google.com>
References: <20211013142258.1738415-1-vkuznets@redhat.com>
 <20211013142258.1738415-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013142258.1738415-4-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021, Vitaly Kuznetsov wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 592217fd7d92..2cdf66e6d1b0 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -148,6 +148,15 @@ struct nested_vmx {
>  	bool need_vmcs12_to_shadow_sync;
>  	bool dirty_vmcs12;
>  
> +	/*
> +	 * Indicates whether MSR bitmap for L2 needs to be rebuilt due to
> +	 * changes in MSR bitmap for L1 or switching to a different L2. Note,
> +	 * this flag can only be used reliably in conjunction with a paravirt L1
> +	 * which informs L0 whether any changes to MSR bitmap for L2 were done
> +	 * on its side.
> +	 */
> +	bool msr_bitmap_force_recalc;

Belated bikeshedding...  What about need_msr_bitmap_recalc to follow the above
need_vmcs12_to_shadow_sync?

> +
>  	/*
>  	 * Indicates lazily loaded guest state has not yet been decached from
>  	 * vmcs02.
> -- 
> 2.31.1
> 
