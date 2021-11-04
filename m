Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BF5445A0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhKDS4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231700AbhKDS4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636052038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g6MP72LMJrATuHUDQvaZoSHGvaUmUM/wSjDJM9lj1bw=;
        b=I846aAqNN79qx875IlpyMff8+03+7jA9fULQc0wfdOa9N8PvXRD1AUuiR2ikjst/zLi/Yr
        m38sX+omBi0FbzJkAICqve5HKZB0nTyittQq7ExoDe71xZfq2eCKzwne5lsYypLq0Nc1lO
        ugoUkKwrLLHl7dpVmjpIRQehkA1fg90=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-vHofWDjgP_ObvNt4xkOSig-1; Thu, 04 Nov 2021 14:53:56 -0400
X-MC-Unique: vHofWDjgP_ObvNt4xkOSig-1
Received: by mail-ed1-f72.google.com with SMTP id f20-20020a0564021e9400b003e2ad3eae74so6621823edf.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 11:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g6MP72LMJrATuHUDQvaZoSHGvaUmUM/wSjDJM9lj1bw=;
        b=Cx0T3Eqb/DZ0+hCXFF9UT6HqFoXWBg9Cg8H/bd7wni1RhONxNERJIV1IjzJhDVZjYx
         yohyWuvNny42w+67s68yYiR60O4W9uc77jTsOigF2uJ3Ciq9pSAuexwNCiD+RyG6vMg8
         3/HManAvoV3Fy+55EGq47C8VtPTejBqmfB9spx5z9SGWdeJrYUmrCk9CLym2ev8Zlsx5
         GhPYCQ7npUTcs+6iz/gVEaW0J8BHx7w9WNqQuZk4U1sjV3V58nmGL4rKUwzK8/fVQhkI
         3R60iKIACI8IbWMCOlqfPoYNgjZsCtWkUNprHe6EPrOX2q8dByx1uwX4iU9eH5mrY11r
         lgkw==
X-Gm-Message-State: AOAM531OktM++ZdSeSmagOLd1WduaysIwNiMdvYlGkuOwIiuXb6kXEg6
        MboEum7b1e9GNMtOfgdK/sGBWw8/THNodL2ctNtAquSWLQ2kcgp2OKtNLc6QLk+tSrzTBOtlL9q
        nOrBWKavN4fmUmYJsXzrP5amM
X-Received: by 2002:a17:906:1558:: with SMTP id c24mr34665112ejd.553.1636052035219;
        Thu, 04 Nov 2021 11:53:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxm52vYvTdOM0fNsR04q5IL+qtJY3Ei/i3Jhda2El8RKNLcDb4SEZmxs/eODcJbbmlvFFWPvA==
X-Received: by 2002:a17:906:1558:: with SMTP id c24mr34665074ejd.553.1636052034905;
        Thu, 04 Nov 2021 11:53:54 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id j11sm2938709ejt.114.2021.11.04.11.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 11:53:54 -0700 (PDT)
Message-ID: <0154963b-6bb5-fc33-6a29-bfa57f187c38@redhat.com>
Date:   Thu, 4 Nov 2021 19:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC][PATCH 18/22] x86,kvm: Remove .fixup usage
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        mbenes@suse.cz
References: <20211104164729.226550532@infradead.org>
 <20211104165525.588957687@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211104165525.588957687@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/21 17:47, Peter Zijlstra wrote:
> KVM instruction emulation has a gnarly hack where the .fixup does a
> return, luckily exceptions can easily emulate a return so create a new
> extable type to fully do the FASTOP magic.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/include/asm/extable_fixup_types.h |    1 +
>   arch/x86/kvm/emulate.c                     |   14 +++-----------
>   arch/x86/mm/extable.c                      |   11 +++++++++++
>   3 files changed, 15 insertions(+), 11 deletions(-)
> 
> --- a/arch/x86/include/asm/extable_fixup_types.h
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -40,5 +40,6 @@
>   #define	EX_TYPE_ONE_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(1))
>   
>   #define	EX_TYPE_FAULT_SGX		18
> +#define	EX_TYPE_KVM_FASTOP		19
>   
>   #endif
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -344,7 +344,7 @@ static int fastop(struct x86_emulate_ctx
>   	__FOP_RET(#op "_" #dst)
>   
>   #define FOP1EEX(op,  dst) \
> -	FOP1E(op, dst) _ASM_EXTABLE(10b, kvm_fastop_exception)
> +	FOP1E(op, dst) _ASM_EXTABLE_TYPE(10b, 10b, EX_TYPE_KVM_FASTOP)

There's a ret right after the 10b label, so I think you can just use this:

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 493511efa3dc..f382c03c5954 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -315,7 +315,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
  	__FOP_FUNC(#name)
  
  #define __FOP_RET(name) \
-	"ret \n\t" \
+	"11: ret \n\t" \
  	".size " name ", .-" name "\n\t"
  
  #define FOP_RET(name) \
@@ -344,7 +344,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
  	__FOP_RET(#op "_" #dst)
  
  #define FOP1EEX(op,  dst) \
-	FOP1E(op, dst) _ASM_EXTABLE(10b, kvm_fastop_exception)
+	FOP1E(op, dst) _ASM_EXTABLE_TYPE_REG(10b, 11b, EX_TYPE_ZERO_REG, %esi)
  
  #define FASTOP1(op) \
  	FOP_START(op) \

Paolo

