Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CBB3B3583
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhFXSVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231169AbhFXSVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624558753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mLRtPh/DGZyKVO5FTJhJkvkgkgWJ+9NI6bwQPnDpek=;
        b=IxIQHPtmIwX7KLFw8dRzmGe4vKVF/HvMpLlCGX2cvID2fJe1KgTMRkVmdC8ZI7bKJ9s546
        2cxdY5/6bKzldIwppcQn4FkjrZVYbAzTIFZnKtV+LejgsK2uqlepLpX8bk9NSDUWueekNY
        5KD4tIb72ThtqdPw3Sktqg0CzylBMLE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-CANT5Ih4PX-L2yec8_tUrw-1; Thu, 24 Jun 2021 14:19:11 -0400
X-MC-Unique: CANT5Ih4PX-L2yec8_tUrw-1
Received: by mail-ej1-f70.google.com with SMTP id lt4-20020a170906fa84b0290481535542e3so2303457ejb.18
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+mLRtPh/DGZyKVO5FTJhJkvkgkgWJ+9NI6bwQPnDpek=;
        b=YCQxM/dMYyeZK0b+H+1Ks4kaQhgvb5vTCp/9EvS5iAuv+WVWl7fivmvL2CwtBTDyoJ
         hjFXgP7E6bFNMOGU5BxE4ktBVqUJGVcgLojpotwtyVowss9wkRMTtoJuD0ZKnK6qauLs
         uoDuZUSH9fYhAQVfIqFo6ULgTdgHuFFulkJyCtyoYQKDR8haxYERgRRCuhK/4Y4x20DG
         8/8OMIXAUHdJXBeO8eZ4PAMTABoezLF6Ciqi3BSZbx+078HjNtUVpgakBO+aQu2FWiBC
         OF+rdrLaVE8Ai/dxjoASu9oJjaQTjK87tRlJ91VbrWVwwMMeHH82riycPSLR+oh+EhzZ
         MsiQ==
X-Gm-Message-State: AOAM530K+li97612yTYiIAncLAe0Es8O3O7+iroHZQ8H64JoDpC02fAC
        mSogkfK4h3KzL9OHawHf6HEl6/hRIeckk/JILZc7Jv9uki0leAvkvwiKFzDenzbRFSD0M7+t+sG
        KwM5b6F/mkwQDwR8G5LaUV0lxVCHEzw6pBh1pFfdC/zgfcA6E2frH+7WYw2u6/pHGLPD6YVS4vQ
        kK
X-Received: by 2002:a17:906:cc9b:: with SMTP id oq27mr6567078ejb.301.1624558750139;
        Thu, 24 Jun 2021 11:19:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCbhw8QtPjBb/UZrNGYrVaxOk7J0ZpenHwS8+G5Y7IxaFvlXRX8jFW7ycsNBZbS9YeaU0FSA==
X-Received: by 2002:a17:906:cc9b:: with SMTP id oq27mr6567050ejb.301.1624558749840;
        Thu, 24 Jun 2021 11:19:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s18sm1554573ejh.12.2021.06.24.11.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 11:19:09 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Fix uninitialized return value bug in
 EXIT_HYPERCALL enabling
To:     Sean Christopherson <seanjc@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
References: <20210624180625.159495-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6146d62f-3c96-1def-a537-1eace63368f3@redhat.com>
Date:   Thu, 24 Jun 2021 20:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210624180625.159495-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/21 20:06, Sean Christopherson wrote:
> Zero out 'r' on success in the KVM_CAP_EXIT_HYPERCALL case.  As noted by
> clang, the happy path will return an uninitialized value:
> 
>    arch/x86/kvm/x86.c:5649:7: error: variable 'r' is used uninitialized
>     whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>                    if (cap->args[0] & ~KVM_EXIT_HYPERCALL_VALID_MASK) {
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/kvm/x86.c:5663:9: note: uninitialized use occurs here
>            return r;
>                 ^
>    arch/x86/kvm/x86.c:5649:3: note: remove the 'if' if its condition is always true
>                    if (cap->args[0] & ~KVM_EXIT_HYPERCALL_VALID_MASK) {
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/kvm/x86.c:5540:7: note: initialize the variable 'r' to silence this warning
>            int r;
>                 ^
>                  = 0
> 
> Opportunistically move the "r = -EINVAL;" above the check to match the
> pattern used in almost all other cases.
> 
> Fixes: 0dbb11230437 ("KVM: X86: Introduce KVM_HC_MAP_GPA_RANGE hypercall")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Actually it was not that patch, but rather a botched conflict resolution 
when applying (too late at night) Aaron's emulation failure patch:

@@ -5647,6 +5648,9 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
                         break;
                 }
                 kvm->arch.hypercall_exit_enabled = cap->args[0];
+               break;
+       case KVM_CAP_EXIT_ON_EMULATION_FAILURE:
+               kvm->arch.exit_on_emulation_error = cap->args[0];
                 r = 0;
                 break;
         default:

I have already fixed this locally, though I haven't pushed it to kvm.git 
yet; my tests should finish running in about an hour, and then I'll push 
everything to kvm/next, except for the C bit fixes.

Paolo

> ---
>   arch/x86/kvm/x86.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e4cea00c49a3..647922ba97df 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5646,11 +5646,12 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>   			r = kvm_x86_ops.vm_copy_enc_context_from(kvm, cap->args[0]);
>   		return r;
>   	case KVM_CAP_EXIT_HYPERCALL:
> -		if (cap->args[0] & ~KVM_EXIT_HYPERCALL_VALID_MASK) {
> -			r = -EINVAL;
> +		r = -EINVAL;
> +		if (cap->args[0] & ~KVM_EXIT_HYPERCALL_VALID_MASK)
>   			break;
> -		}
> +
>   		kvm->arch.hypercall_exit_enabled = cap->args[0];
> +		r = 0;
>   		break;
>   	case KVM_CAP_EXIT_ON_EMULATION_FAILURE:
>   		kvm->arch.exit_on_emulation_error = cap->args[0];
> 

