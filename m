Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3558329742
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245628AbhCAWgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbhCARkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:40:36 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01393C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:39:53 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id a23so2243928pga.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VIEVnYfBURNQaEk7q+gL1sk168GjsFz+wyAEY3Zaj6Y=;
        b=LzapItJfq2azam+0YDJzUf2208kzzrWmIIkwteaTmAPiBPHksFPFpeeTUDkasfW7Fp
         5g6NCG5TnFQ2USBk2DUEjDtPXjVLVGWp+V6QRzwwvgC3ScsUObjYYbd/uW0ODsOiXwou
         YQ03goXSEkW3FTfGB8SBZvjHj2fqYZ4aXWmqz1Df91bJt3qOZG1z67w/IbqQkhM6Ame6
         yPyIzm0byUxbjuPQi9Okr6PISi9IrFjzSJs3EsYj8C9AbyQrE5acErzEBs9SEw8Kz1M9
         vZ5a5sgamoGr7yNoUBibH6sPUJeY02KShPQYSvDO0Omcf+gNYgSXp4K9fucd5yP0mup/
         pfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VIEVnYfBURNQaEk7q+gL1sk168GjsFz+wyAEY3Zaj6Y=;
        b=LC8qSZ9CuJPuz6aqA9P9tPunXL2BWTqyvZoKNwxH18GkHGPRmN92Rm+rVM4EGAIWxF
         x9UAVeFW9AoWLWjPGtthcq5rLrkGxXA0tmb3Evr5Zwd83XgdT3y80ehf1go5DDjHyNVo
         2e7PXjPwkmemyOJvhTD4PJnXNciKi/gdM2bhYuBf/Wz4+w/jbC1V5duFBj4TYGT1I3yd
         C7a+7EoSY9gFKuaEJtHlDGJVTjd88t6vco5PYT6NSKMVuILVnlLThfcVbY55bZPP7s+o
         nilo4t7FWuv/nzy65MA4uji5k6a2SNhvy8awa33GEywbu1enMF/wCy8F0GqkUYTTCQyJ
         D6cw==
X-Gm-Message-State: AOAM531N/9C+41AqrI3EVja1UwhhdcGqVyaj8771pBvVuqNhkdYK6yeo
        uiwIkvhYaWj7RVTp6pd0c/bISRvWgphcjw==
X-Google-Smtp-Source: ABdhPJw47eR96CR8PofpQISJ7ZeuuR2MHmvxNh2DN/a0kX+iFy2LxhpWypfYtOqIiE84wmXqqEDwDw==
X-Received: by 2002:a63:e911:: with SMTP id i17mr4202297pgh.255.1614620392312;
        Mon, 01 Mar 2021 09:39:52 -0800 (PST)
Received: from google.com ([2620:15c:f:10:5d06:6d3c:7b9:20c9])
        by smtp.gmail.com with ESMTPSA id z16sm16503070pgj.51.2021.03.01.09.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:39:51 -0800 (PST)
Date:   Mon, 1 Mar 2021 09:39:45 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: Set X86_CR4_CET in cr4_fixed1_bits if CET IBT
 is enabled
Message-ID: <YD0m4cALoArLO4ek@google.com>
References: <20210225030951.17099-1-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225030951.17099-1-weijiang.yang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021, Yang Weijiang wrote:
> CET SHSTK and IBT are independently controlled by kernel, set X86_CR4_CET
> bit in cr4_fixed1_bits if either of them is enabled so that nested guest
> can enjoy the feature.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 5856c5b81084..e92134ee081c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7258,6 +7258,7 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
>  	cr4_fixed1_update(X86_CR4_UMIP,       ecx, feature_bit(UMIP));
>  	cr4_fixed1_update(X86_CR4_LA57,       ecx, feature_bit(LA57));
>  	cr4_fixed1_update(X86_CR4_CET,	      ecx, feature_bit(SHSTK));
> +	cr4_fixed1_update(X86_CR4_CET,	      edx, feature_bit(IBT));

Ugh, what sadist put SHSTK and IBT in separate output registers.

Reviewed-by: Sean Christopherson <seanjc@google.com>

>  
>  #undef cr4_fixed1_update
>  }
> -- 
> 2.26.2
> 
