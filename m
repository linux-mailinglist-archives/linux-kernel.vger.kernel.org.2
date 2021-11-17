Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910D1455140
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241683AbhKQXrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbhKQXro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:47:44 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9752C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 15:44:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so3956152pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 15:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i7xdcRno9lDJq2FbKrL24KjJKjCIV0UBKAHoRv3oYcY=;
        b=Ro1E93iJGGaTrfqODGtsjHtNUXl97SPsedcZlIzJwwLzv/OGKhGC90jBr8CuIMJCHb
         yCmvMfcFTOqLSclWg/i3V1jMhh/fDsD7jtCOmE/6RjDeYxUugPttuXNGpy8uQ+9OleU1
         lid416M7EdRoj5/AtYPF7iNCOIPfWQSl4n2udMBTWi+C1qIoKn8aTgOHo0t/fVBjZjfW
         D6HXGYRzcWvdcjWzINfOMFAPo+Nc55WjyPrY28U9kSY+DekAB8XZU7c/N2cx5b8t1HDi
         efN51Znoz07u0FW6V2KXJiwXrPG82Gjmx83zMNmD7p9fTrQTjkQGaek8dVnt3XFNfGzQ
         dv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7xdcRno9lDJq2FbKrL24KjJKjCIV0UBKAHoRv3oYcY=;
        b=661fmgUz9jE7WsSccOOqhZRQ/IVyaCYmcnE+LLDUXrocxlU6ZGzjWz1F7iwh4HY33C
         zNNkze1+4EmTKOgJtIuggrpGOwwI/MkSEejbo1BO1XyMB+3YskJClQ34OC/3iC8M34ae
         n35qP1LWmDfqTjjnSRdIX5Wrlp5HKX+Bk2DDkpIM1SYJF31mujbMfmi+lCK1CMpLik56
         Nllo0VBDvgQLDYC7tyVdaFCmNLQuKwTWcMMGrlz6l4a1XWnn67pmUyud0PEi15BmsRPI
         eVUVpqUB0jkAl7pAcaQtssF5YyaAo0eTDoRXYQlEAyv5OHNhVsr9/hd893TRsTZc1yCY
         dw0w==
X-Gm-Message-State: AOAM532qYY1W2ks+6PV+6etKZ880pppN0A/98DBO5cu3A1H7cxqteX6M
        Ai6D/NcZLnP2Rc7eePhFj8R/NQ==
X-Google-Smtp-Source: ABdhPJz5Wl2LlXg5RksONm6f0Fp1E2rz/GXf5uQKCy9QVm18k+NlOYToW639G7zwFaer2wUkuKwXQg==
X-Received: by 2002:a17:902:748c:b0:141:c45e:c612 with SMTP id h12-20020a170902748c00b00141c45ec612mr60682754pll.73.1637192684255;
        Wed, 17 Nov 2021 15:44:44 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h18sm733576pfh.172.2021.11.17.15.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 15:44:43 -0800 (PST)
Date:   Wed, 17 Nov 2021 23:44:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 1/4] x86/kvm: add boot parameter for adding vcpu-id
 bits
Message-ID: <YZWT6GP/Jfy27r8e@google.com>
References: <20211116141054.17800-1-jgross@suse.com>
 <20211116141054.17800-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116141054.17800-2-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021, Juergen Gross wrote:
> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index 816a82515dcd..64ba9b1c8b3d 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -685,11 +685,21 @@ static const struct kvm_io_device_ops ioapic_mmio_ops = {
>  int kvm_ioapic_init(struct kvm *kvm)
>  {
>  	struct kvm_ioapic *ioapic;
> +	size_t sz;
>  	int ret;
>  
> -	ioapic = kzalloc(sizeof(struct kvm_ioapic), GFP_KERNEL_ACCOUNT);
> +	sz = sizeof(struct kvm_ioapic) +
> +	     sizeof(*ioapic->rtc_status.dest_map.map) *
> +		    BITS_TO_LONGS(KVM_MAX_VCPU_IDS) +
> +	     sizeof(*ioapic->rtc_status.dest_map.vectors) *
> +		    (KVM_MAX_VCPU_IDS);
> +	ioapic = kzalloc(sz, GFP_KERNEL_ACCOUNT);
>  	if (!ioapic)
>  		return -ENOMEM;
> +	ioapic->rtc_status.dest_map.map = (void *)(ioapic + 1);

Oof.  Just do separate allocations.  I highly doubt the performance of the
emulated RTC hinges on the spatial locality of the bitmap and array.  The array
is going to end up in a second page for most configuration anyways.

> +	ioapic->rtc_status.dest_map.vectors =
> +		(void *)(ioapic->rtc_status.dest_map.map +
> +			 BITS_TO_LONGS(KVM_MAX_VCPU_IDS));
>  	spin_lock_init(&ioapic->lock);
>  	INIT_DELAYED_WORK(&ioapic->eoi_inject, kvm_ioapic_eoi_inject_work);
>  	kvm->arch.vioapic = ioapic;
