Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD90444C6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 19:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhKJSJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 13:09:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232516AbhKJSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 13:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636567590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cqzkKKVU1TFefm2txuHW5tA1oBvnHRU7MmXEb01dQtg=;
        b=eb8/yY8Qrat3GpF2HRQ0JwZ32/mQXy19R/dZRo1iP+0iGPOfZk+Ysq46/VTR4KpdtMdawL
        E4wmlpCA8Y0Wx6h2ZcH5p6VWkpBMIbuPVdo+NVZgcaoUmvB3iqzwkED8tUfTNDT96hqxIt
        VCG6no8G2Egkq6FmWQGj3FY9c7qtIDk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-5Zf20JidNVib__DhEhKDJQ-1; Wed, 10 Nov 2021 13:06:28 -0500
X-MC-Unique: 5Zf20JidNVib__DhEhKDJQ-1
Received: by mail-wm1-f71.google.com with SMTP id m1-20020a1ca301000000b003231d5b3c4cso3462238wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 10:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cqzkKKVU1TFefm2txuHW5tA1oBvnHRU7MmXEb01dQtg=;
        b=NqTTdeZrYGVtP6bQ0xx3d7JCrznogEXgeRRmK3ErskT8tlBQzV4no19Id4GHQ5u4oi
         MnxcAC2xqPOF70AZ1lOkBUUytadkN7QlAnRqc1aiG9l924Y1bIKQM1oTaFeY0gnthgaR
         uoSCQcM9zIa3A0NpmzzSoauY6CG7jRjp6knM0S+AY7vEAU9eHb4zywHFZGA5wb5SG7p4
         z6K+BHxPwn7etyIYXoZJtE3dbCu06jYoQqmnjcHi7fvlW3FMaMeofMxwo9iPlttDW03c
         Y3WlIVKh6k7TsLC1HQ4Cy+TlLflMYbT7NUJ6wvbvoCPnizVf2grbsHgYb73vHmXLtH8C
         S4fw==
X-Gm-Message-State: AOAM530/YKayXGiFa+yCWEPjWgQgRIRuSuKkndWHMuz/+h1vX9uAVRo2
        4LKHyDa8ivEMbjx1sEEXU7awqIe/r5pgWs4uXjhi2sl2rgNbQ6Mmwt2R0jUgakRQMVgXxHRU3H8
        1mtYhJfGKGzEAdc2uzjdO8/CG
X-Received: by 2002:a05:600c:510d:: with SMTP id o13mr18448378wms.104.1636567584355;
        Wed, 10 Nov 2021 10:06:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxU9y/NX64qlc3vXZ1ejqNHzYKNDlRCKkpWhRwE8xA5Lk7aS9uc4qTP3ah1NLedT0vvveXpAw==
X-Received: by 2002:a05:600c:510d:: with SMTP id o13mr18448327wms.104.1636567584080;
        Wed, 10 Nov 2021 10:06:24 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id y6sm621380wrh.18.2021.11.10.10.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 10:06:23 -0800 (PST)
Subject: Re: [PATCH v4 06/15] KVM: arm64: Add paravirtualization header files
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
References: <20210815005947.83699-1-gshan@redhat.com>
 <20210815005947.83699-7-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <82506a31-7b32-f8e2-c0cb-0f39d204ef3a@redhat.com>
Date:   Wed, 10 Nov 2021 19:06:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815005947.83699-7-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 8/15/21 2:59 AM, Gavin Shan wrote:
> We need put more stuff in the paravirtualization header files when
> the asynchronous page fault is supported. The generic header files
> can't meet the goal.
you need to explain why
 This duplicate the generic header files to be
s/This duplicate/Duplicate
> our platform specific header files. It's the preparatory work to
> support the asynchronous page fault in the subsequent patches:
why duplication and not move. Shouldn't it be squashed with another
subsequent patch?

Eric
> 
>    include/uapi/asm-generic/kvm_para.h
>    include/asm-generic/kvm_para.h
> 
>    arch/arm64/include/uapi/asm/kvm_para.h
>    arch/arm64/include/asm/kvm_para.h
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_para.h      | 27 ++++++++++++++++++++++++++
>  arch/arm64/include/uapi/asm/Kbuild     |  2 --
>  arch/arm64/include/uapi/asm/kvm_para.h |  5 +++++
>  3 files changed, 32 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/kvm_para.h
>  create mode 100644 arch/arm64/include/uapi/asm/kvm_para.h
> 
> diff --git a/arch/arm64/include/asm/kvm_para.h b/arch/arm64/include/asm/kvm_para.h
> new file mode 100644
> index 000000000000..0ea481dd1c7a
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_para.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM_KVM_PARA_H
> +#define _ASM_ARM_KVM_PARA_H
> +
> +#include <uapi/asm/kvm_para.h>
> +
> +static inline bool kvm_check_and_clear_guest_paused(void)
> +{
> +	return false;
> +}
> +
> +static inline unsigned int kvm_arch_para_features(void)
> +{
> +	return 0;
> +}
> +
> +static inline unsigned int kvm_arch_para_hints(void)
> +{
> +	return 0;
> +}
> +
> +static inline bool kvm_para_available(void)
> +{
> +	return false;
> +}
> +
> +#endif /* _ASM_ARM_KVM_PARA_H */
> diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
> index 602d137932dc..f66554cd5c45 100644
> --- a/arch/arm64/include/uapi/asm/Kbuild
> +++ b/arch/arm64/include/uapi/asm/Kbuild
> @@ -1,3 +1 @@
>  # SPDX-License-Identifier: GPL-2.0
> -
> -generic-y += kvm_para.h
> diff --git a/arch/arm64/include/uapi/asm/kvm_para.h b/arch/arm64/include/uapi/asm/kvm_para.h
> new file mode 100644
> index 000000000000..cd212282b90c
> --- /dev/null
> +++ b/arch/arm64/include/uapi/asm/kvm_para.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_ASM_ARM_KVM_PARA_H
> +#define _UAPI_ASM_ARM_KVM_PARA_H
> +
> +#endif /* _UAPI_ASM_ARM_KVM_PARA_H */
> 

