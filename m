Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEFF40031B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhICQTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhICQTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:19:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A431FC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 09:18:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c5so2697035plz.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChP8PdB41PutFMixaLE0rfk4/4aZZSOhPrBvvsCLFqQ=;
        b=VjqgsLShKAkbLM1azNDdvG159OgASrl2YVgwYaz0szQJKqQAFCGLeOe8dcWPTJ2/oy
         jP1ouhXTEqLn8Xe6GlRk9hxDUTyjjbyffo/rqu/CALrMYRXqgOvsOm2n3xfLl4WG7FWg
         HQgDFy8Q3DLumE0V8k2t0qZqM594E2Wo2Nio49bQoZGW5HUiogsuBUF6SSepT5JDDGv1
         gOzhiTsOmCXbGYQZ9TCvkZLKepdfuFNsNC0pG6GlkzLfBUmJqeOoWnsC+FUbSmDc7ekd
         o8ePqcs0Wj2xbzKm5OWs7fzATZS3cCW3qmtphye8CJteohWK7SdZmsHWND2A8xM7et+O
         cnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChP8PdB41PutFMixaLE0rfk4/4aZZSOhPrBvvsCLFqQ=;
        b=l1ophHwZk0i3FRoP2cdlgbMfY+EM0L5eCMO54qTgSu6IUznDbK//Vx0JnwLav1wkoH
         /kHlNEkRicGGoZQJvWcc2Esmn2lUUPUWlCVZaC6/g6hygqYvrrcDuM8wmN7XqHzTS+m2
         7R6U1Ipwh0ea9Jx+FLW6nbIBcT06uUaJgjwFqlrLgFWq/NSDDdWYwSf0uekmcVoV8D/Y
         UZfDm3HtYhphQYGqEbxbdEWV7ikM+k2ed3vZPntlikbiffEQXFN228vw94hkhlPnvomm
         AG9j6csQ0jaffK43gPo17jrirPXfMuWZ7sc1faJQHenIMKrXkWAJMbIM2rCaKUmEPj3V
         JEfg==
X-Gm-Message-State: AOAM530mCoZIiiVkATDtonZAxmwHC5naklRTDajndUIfShL6MzUXjt9+
        p8JHx9rStYOMJVcpcyKuPK4u7Q==
X-Google-Smtp-Source: ABdhPJwPKKNN2JHWTX6NfgVtmjv48+HxSSSPZqaFb05JK6slg3WWjPU4OHqX25/0G7E5mIu2mBm/wg==
X-Received: by 2002:a17:90a:8b08:: with SMTP id y8mr1566065pjn.173.1630685925975;
        Fri, 03 Sep 2021 09:18:45 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a20sm5606772pjh.46.2021.09.03.09.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:18:45 -0700 (PDT)
Date:   Fri, 3 Sep 2021 16:18:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     tcs.kernel@gmail.com
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>
Subject: Re: [PATCH v2] KVM: x86: Handle SRCU initialization failure during
 page track init
Message-ID: <YTJK4aACtboaPAF8@google.com>
References: <1630636626-12262-1-git-send-email-tcs_kernel@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630636626-12262-1-git-send-email-tcs_kernel@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021, tcs.kernel@gmail.com wrote:
> From: Haimin Zhang <tcs_kernel@tencent.com>
> 
> Check the return of init_srcu_struct(), which can fail due to OOM, when
> initializing the page track mechanism.  Lack of checking leads to a NULL
> pointer deref found by a modified syzkaller.
> 
> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Neither myself nor Vitaly provided an SOB, nor is one needed.  Review feedback
can be attributed/noted in the part that git ignores (below the three dashes).

> Reported-by: TCS Robot <tcs_robot@tencent.com>
> 
> ---

Notes about version changes, e.g. to document/attribute review feedback, go here.

  v2: 
    - Blah blah blah [Vitaly, Sean]

>  arch/x86/include/asm/kvm_page_track.h | 2 +-
>  arch/x86/kvm/mmu/page_track.c         | 4 ++--
>  arch/x86/kvm/x86.c                    | 6 +++++-
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 

...

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 86539c1..9a122af 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11143,6 +11143,8 @@ void kvm_arch_free_vm(struct kvm *kvm)
>  
>  int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  {
> +	int ret;
> +
>  	if (type)
>  		return -EINVAL;
>  
> @@ -11178,7 +11180,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  
>  	kvm_apicv_init(kvm);
>  	kvm_hv_init_vm(kvm);
> -	kvm_page_track_init(kvm);
> +	ret = kvm_page_track_init(kvm);
> +	if (ret)
> +		return ret;

Before moving forward with a fix, I'd like to get Paolo's input on dropping
track_srcu in favor of kvm->srcu and avoiding this altogheter.  Note, Paolo is on
vacation at the moment, so this won't get attention for a week or more.

[*] https://lkml.kernel.org/r/YS5Bn6I6wVEL8wKS@google.com

>  	kvm_mmu_init_vm(kvm);
>  	kvm_xen_init_vm(kvm);
>  
> -- 
> 1.8.3.1
> 
