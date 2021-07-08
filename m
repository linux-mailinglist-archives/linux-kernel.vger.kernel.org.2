Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0433C16F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhGHQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229489AbhGHQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625761084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9j0fgT60+2/e0HhcHcfYjSR793UpMTP7LOw8dx+WmU=;
        b=BJYRcCPVIO+sX4d7JP+oHXbV2QHddoz4FO6pViLn35MQgunT2xfxzB+W5QanFADh4zZpvw
        XPCezolJtRADm4I1+PvF2SFehswkdhaznpd7ut/zwINEvXGZ2OK8KzyyJxtN3WosOAgAa7
        5FsXCO/OVD0j7kte0htssHjX40JCdGY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-qKEABBv-MgaoR6mcOQcOtA-1; Thu, 08 Jul 2021 12:18:03 -0400
X-MC-Unique: qKEABBv-MgaoR6mcOQcOtA-1
Received: by mail-ej1-f70.google.com with SMTP id og25-20020a1709071dd9b02904c99c7e61f1so2072811ejc.18
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 09:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m9j0fgT60+2/e0HhcHcfYjSR793UpMTP7LOw8dx+WmU=;
        b=iYoPbDf+OTjP+53mLV67KknUsQoj6Znr2J97Twsrnq2ZJ8X9GT/s+ei4K8fAJ/HIkp
         HQE0//uDjIHWHIclRV9CJSYkiHIboKWXoRA3QBOxXm2cINJgtQM9LpDmPZlcQNOWySaL
         l5Qaw/1ffq7cA0wmXe9jhgEP621Vt09TA2n0xMNVmcCNgd5B+BTdJ6YUWct6M6ogFplu
         UknYrSCuOeVAYsqGWB8NzuA37LBKq9+QcJU0XcBmzFVlLkb64gd685tg7MwR5vXnmr5A
         4ZiahxJyZR0k0Igx5XYGT+b3M4jaz5Ma7vWHFbPVfOAQ7MpsbXh2JE+rUnfZHFi5nElL
         0nmg==
X-Gm-Message-State: AOAM5336iLlKP2eXGirYU6AMVred0ThplApc4nIk1fvUWJ8jR+ThS1Yy
        DG+70XQSfVwOGhvzzQsoOc1TACqw9IFhSvF/6bGDv5D3Eeti+IPSv3/jMJUGCvkFZv5qi4flOjs
        ehl/csoG08pCwk2QDURbEu1ZE/stUL3vQmBdAYcPE0LR/+EhDvCIDzXnaS1sJqtnqlwaveJPNKi
        Fi
X-Received: by 2002:a17:906:8584:: with SMTP id v4mr31620049ejx.301.1625761081827;
        Thu, 08 Jul 2021 09:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrusHA0pBCSrA1fd/X22PtmeBy7767Uwpwxg/gdkQaycnP2jWXEycjCC8XUgx7fHyY9loSLg==
X-Received: by 2002:a17:906:8584:: with SMTP id v4mr31620017ejx.301.1625761081541;
        Thu, 08 Jul 2021 09:18:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ja11sm1182528ejc.62.2021.07.08.09.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 09:18:01 -0700 (PDT)
Subject: Re: [PATCH] Revert "KVM: x86: WARN and reject loading KVM if NX is
 supported but not enabled"
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210625001853.318148-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28ec9d07-756b-f546-dad1-0af751167838@redhat.com>
Date:   Thu, 8 Jul 2021 18:17:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625001853.318148-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/21 02:18, Sean Christopherson wrote:
> Let KVM load if EFER.NX=0 even if NX is supported, the analysis and
> testing (or lack thereof) for the non-PAE host case was garbage.
> 
> If the kernel won't be using PAE paging, .Ldefault_entry in head_32.S
> skips over the entire EFER sequence.  Hopefully that can be changed in
> the future to allow KVM to require EFER.NX, but the motivation behind
> KVM's requirement isn't yet merged.  Reverting and revisiting the mess
> at a later date is by far the safest approach.
> 
> This reverts commit 8bbed95d2cb6e5de8a342d761a89b0a04faed7be.
> 
> Fixes: 8bbed95d2cb6 ("KVM: x86: WARN and reject loading KVM if NX is supported but not enabled")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> Hopefully it's not too late to just drop the original patch...
> 
>   arch/x86/kvm/x86.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4a597aafe637..1cc02a3685d0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10981,9 +10981,6 @@ int kvm_arch_hardware_setup(void *opaque)
>   	int r;
>   
>   	rdmsrl_safe(MSR_EFER, &host_efer);
> -	if (WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_NX) &&
> -			 !(host_efer & EFER_NX)))
> -		return -EIO;
>   
>   	if (boot_cpu_has(X86_FEATURE_XSAVES))
>   		rdmsrl(MSR_IA32_XSS, host_xss);
> 

So do we want this or "depends on X86_64 || X86_PAE"?

Paolo

