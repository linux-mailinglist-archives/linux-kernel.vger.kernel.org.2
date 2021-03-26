Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251B034ADAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCZRg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230254AbhCZRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616780183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SiWoaGpTsKxnpfH36CVPc9yu7W5RPrt7W/LPaBOJkxE=;
        b=XnYYdSG5RGUBxJE7TuUKFfEgTrwyKvdzwR5mEiPGakBRepAwZOHcL+gWWm1yqoMiGowwUQ
        xD3DuFkbkNJkJ73MesPk9XUjVuMylYcyBRPifCt9C4gCcopgwTftY5uZV8syCC9d66Cj4v
        gMfUC9zno86Cf/ppIwIdwMppoLraTIY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-eobImU2sMquKLMyIqXz_kg-1; Fri, 26 Mar 2021 13:36:21 -0400
X-MC-Unique: eobImU2sMquKLMyIqXz_kg-1
Received: by mail-ej1-f72.google.com with SMTP id gv58so4382561ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SiWoaGpTsKxnpfH36CVPc9yu7W5RPrt7W/LPaBOJkxE=;
        b=f9/zO4XNT/9eUWgT9K0bY8Bysy9LZ8eaxNxhXUgy9CKe6aHCoZpkNizDh9E2T3l7+s
         SgCN3V9QL6c3SaZYdXPHrENtu6IMyvf/EoJOnA7vur+HiEzRVIKg/V8rb+0wNZR/bZUf
         89WWvA/XVhnzwpP/i0dhkAHBKPXOyFUq5vJ95aWCAcWY7OgEI8852RdxJF8M5qvEB/zx
         T9nrHumO2ycumwatnyMMc3lgEJaToYN0jGGMjqNGaNIwzlnCUwByU07U+0o9bj+3HGQD
         xsJKrR6ErEIdsrMlYPkbGHd3oqVKEuAdrDXBTRy2yO7r4ldRXuYOGtdA5riazM49n0Jk
         TtPw==
X-Gm-Message-State: AOAM532Jiultfx8s+uK8QS1HjFR0LXHYdUCr0Gbmlv6DlanYvz5EGd1L
        aR1v5mJ0m78CTAIQ+tIGW0f4N1HIB1Iydb8BgYZVQKxkZVYlBeyi/Ah2qPO/V16LNj335HKQQPA
        M3L/4aHXdqPU8BuhKomNSERf7zf/mqqi+fUtOoGAmZZZgV5aK71xdmmeMLz8qr7BuMqUhS3YKpI
        /C
X-Received: by 2002:a17:906:fc1c:: with SMTP id ov28mr16619562ejb.342.1616780179391;
        Fri, 26 Mar 2021 10:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywy9F+bHrM6Wo1A9BQMrDcnwQV/JRcPdm9zC2239ivfsh4NlsKnAFvT9M3QNEYIiq1nD6MxQ==
X-Received: by 2002:a17:906:fc1c:: with SMTP id ov28mr16619538ejb.342.1616780179162;
        Fri, 26 Mar 2021 10:36:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d1sm4130294eje.26.2021.03.26.10.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 10:36:18 -0700 (PDT)
Subject: Re: [PATCH] KVM: make: Fix out-of-source module builds
To:     Siddharth Chandrasekaran <sidcha@amazon.de>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210324124347.18336-1-sidcha@amazon.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0391f264-ff1a-5ab6-c989-96a9f28a9457@redhat.com>
Date:   Fri, 26 Mar 2021 18:36:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210324124347.18336-1-sidcha@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/21 13:43, Siddharth Chandrasekaran wrote:
> Building kvm module out-of-source with,
> 
>      make -C $SRC O=$BIN M=arch/x86/kvm
> 
> fails to find "irq.h" as the include dir passed to cflags-y does not
> prefix the source dir. Fix this by prefixing $(srctree) to the include
> dir path.
> 
> Signed-off-by: Siddharth Chandrasekaran <sidcha@amazon.de>
> ---
>   arch/x86/kvm/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 1b4766fe1de2..eafc4d601f25 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -ccflags-y += -Iarch/x86/kvm
> +ccflags-y += -I $(srctree)/arch/x86/kvm
>   ccflags-$(CONFIG_KVM_WERROR) += -Werror
>   
>   ifeq ($(CONFIG_FRAME_POINTER),y)
> 

Queued, thanks.

Paolo

