Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14F0363036
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhDQNSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 09:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230442AbhDQNSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 09:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618665472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ciCV1LTqKSA6yKmOaXOhxINSuLAEFyVRLAAxoRtJwoM=;
        b=Ft7ncJoAdjylzpOXFsh2UOb8iE8kQGvE8nn0P9uOpBU6+/fjwz3rrXt/ubJnw1khY/GK/F
        u6ORCvgalg+z/Va+O4nd1nZraR10yyv5Er8Am2IYEbZeGwls5HZRX+g6r7xZB8oR36gIoY
        jZLlxggVVpYM+jpgqdd/k5rMpqFdbeI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-5IgaT4dvPiadOzB2t8UaLg-1; Sat, 17 Apr 2021 09:17:50 -0400
X-MC-Unique: 5IgaT4dvPiadOzB2t8UaLg-1
Received: by mail-ed1-f70.google.com with SMTP id ay2-20020a0564022022b02903824b52f2d8so8648761edb.22
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 06:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ciCV1LTqKSA6yKmOaXOhxINSuLAEFyVRLAAxoRtJwoM=;
        b=paIRjQv2W/O64Eixko+c+GAyw3Qr+v7CCsbhimDGb1AZI4qMFHYSot9S+hx0xw8DOh
         iqm69j5DbHbgEbCnoUbai5PkOtRF9jXayxl3qeYPUT5cXOVDOTT/I6gZVf/PbR8Pb9tZ
         NJxawzrI34je8+v4P+/r6byoVOhtPJyr9ThCaLs8LibVW38bB5vy8eQdwehJf7B+jnWu
         TUrhq77XyTy3VeTObKrvRLoc99kulJ+rimEyTsTmbsy8w/2LEHSwOjldkc4fbSWbk2ed
         1NU6AO1RjzYv/Hejqjd+vm/Lj1d2FzgfSOATM80Cndr1lgk7XXarIkB/yES/G11azDJX
         0BEA==
X-Gm-Message-State: AOAM533o2QAzRQ8zReYtiWRI0oaMQiF0ho5RUlo86RyDRav7IJhHIYdY
        NX9MRNQvRc6hylf+8lXzznCNDe9fsw1i4b1fwN9hFNUHQFB9nu08qbfyfLclBw50kYb6+hHHxZX
        nojIW3CdZR+UQ0OfVcklIW/TM
X-Received: by 2002:a50:9feb:: with SMTP id c98mr7521049edf.104.1618665469402;
        Sat, 17 Apr 2021 06:17:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypcobCsRzpU30ZOTnDw84A6BtQgyuc+LOn+rxCJXVvab3FP2M7bWGGF0+hx9a2WLJH3chjIA==
X-Received: by 2002:a50:9feb:: with SMTP id c98mr7521019edf.104.1618665469222;
        Sat, 17 Apr 2021 06:17:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s9sm7789724edd.16.2021.04.17.06.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 06:17:48 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: vmx: add mismatched size assertions in
 vmcs_check32()
To:     lihaiwei.kernel@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org,
        Haiwei Li <lihaiwei@tencent.com>
References: <20210409022456.23528-1-lihaiwei.kernel@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3532509-c484-c980-cbef-847053050384@redhat.com>
Date:   Sat, 17 Apr 2021 15:17:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210409022456.23528-1-lihaiwei.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/21 04:24, lihaiwei.kernel@gmail.com wrote:
> From: Haiwei Li <lihaiwei@tencent.com>
> 
> Add compile-time assertions in vmcs_check32() to disallow accesses to
> 64-bit and 64-bit high fields via vmcs_{read,write}32().  Upper level KVM
> code should never do partial accesses to VMCS fields.  KVM handles the
> split accesses automatically in vmcs_{read,write}64() when running as a
> 32-bit kernel.
> 
> Reviewed-and-tested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
> v1 -> v2:
> * Improve the changelog
> 
>   arch/x86/kvm/vmx/vmx_ops.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
> index 692b0c3..164b64f 100644
> --- a/arch/x86/kvm/vmx/vmx_ops.h
> +++ b/arch/x86/kvm/vmx/vmx_ops.h
> @@ -37,6 +37,10 @@ static __always_inline void vmcs_check32(unsigned long field)
>   {
>   	BUILD_BUG_ON_MSG(__builtin_constant_p(field) && ((field) & 0x6000) == 0,
>   			 "32-bit accessor invalid for 16-bit field");
> +	BUILD_BUG_ON_MSG(__builtin_constant_p(field) && ((field) & 0x6001) == 0x2000,
> +			 "32-bit accessor invalid for 64-bit field");
> +	BUILD_BUG_ON_MSG(__builtin_constant_p(field) && ((field) & 0x6001) == 0x2001,
> +			 "32-bit accessor invalid for 64-bit high field");
>   	BUILD_BUG_ON_MSG(__builtin_constant_p(field) && ((field) & 0x6000) == 0x6000,
>   			 "32-bit accessor invalid for natural width field");
>   }
> 

Queued, thanks.

paolo

