Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F104A3C17B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhGHRG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbhGHRG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625763854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8ONPfQUSVA2YZLmXzZtd9HLMlXkG1u4LXG9yECa9hM=;
        b=T+Y1YZAwV9yh76NkN2l6X7pMM66cZK4f74L6G434JCqL0EqZcjPWVGz6m44l4JkYpE/wTS
        hq7qAPjpBTVhfASK+G/bwg+llujT1jKC/2nHx3qEFHAmpv7FhPSefsVkhwHD60w/zza/IR
        1gTd+droEGOYYjqvnGtEInD7mW7g4Yk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-maXKeD-RPmC7Vc3-mdDQBw-1; Thu, 08 Jul 2021 13:04:13 -0400
X-MC-Unique: maXKeD-RPmC7Vc3-mdDQBw-1
Received: by mail-ed1-f69.google.com with SMTP id s6-20020a0564020146b029039578926b8cso3624797edu.20
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E8ONPfQUSVA2YZLmXzZtd9HLMlXkG1u4LXG9yECa9hM=;
        b=XQYHPPls0/7ZbhyFgh0PB591cVmK6nMAIdwUIcPZbvFJTOdJk8WDPfxCb5CwdsZyHT
         uywRjTa17Lvw7f2/ZjkoqPWwAbof8C8EZZrqUWUdBFU4lJqNemP7Z4iSFB7+l0h68RDd
         GVfQhX9eL81w94pNQ88wvHpdUoumTKt1ALrEqs4oerFw4MjAgwS11bxWRDCLilzMRyll
         rZ5GC7ExZ7VUt49dJu6RUCqV1PRYvBgLvyo4w30EKJRHgEHq8OE4FzLI1bTSq8PygScD
         KPYQGt77aKHjJSFGXzNyOVAN5bHMRySDIaaCIi1hvZb3SWUMl5I127R7Sc23LJcBCjGa
         7ayQ==
X-Gm-Message-State: AOAM533KUHsME56aC/TavgKDW6FKnBmvxTBf2+bEhXdbEshcPCUGNbil
        ysg/jyrQeABQYs5BVoLe7ivwU3eSX1wvs2qI4P0wrssbO0OGFf1DvL4lmy9VPAOHrpIwoVbTv7o
        4iDk45ZhAS37/dcRtTWGymFKrlJ0FkYm7Sgs7gtpiQmqZHhYBHlxPZUQa/Z9SGA/DN4j75k5Uae
        qZ
X-Received: by 2002:aa7:dad3:: with SMTP id x19mr22354348eds.310.1625763851612;
        Thu, 08 Jul 2021 10:04:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjcSauD8vIdF5gc0z6HxXIYk+QksY8QrZj/Qmb1l6JhLIdnHokJqW/YuFdg7m1aznpGS+rag==
X-Received: by 2002:aa7:dad3:: with SMTP id x19mr22354321eds.310.1625763851459;
        Thu, 08 Jul 2021 10:04:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id eb9sm1221954ejc.32.2021.07.08.10.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 10:04:11 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Remove vmx_msr_index from vmx.h
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210707235702.31595-1-yu.c.zhang@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52d7d0f8-231a-58f0-fafc-489e3b11742e@redhat.com>
Date:   Thu, 8 Jul 2021 19:04:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707235702.31595-1-yu.c.zhang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/21 01:57, Yu Zhang wrote:
> vmx_msr_index was used to record the list of MSRs which can be lazily
> restored when kvm returns to userspace. It is now reimplemented as
> kvm_uret_msrs_list, a common x86 list which is only used inside x86.c.
> So just remove the obsolete declaration in vmx.h.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> ---
>   arch/x86/kvm/vmx/vmx.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 3979a947933a..db88ed4f2121 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -14,8 +14,6 @@
>   #include "vmx_ops.h"
>   #include "cpuid.h"
>   
> -extern const u32 vmx_msr_index[];
> -
>   #define MSR_TYPE_R	1
>   #define MSR_TYPE_W	2
>   #define MSR_TYPE_RW	3
> 

Queued, thanks.

Paolo

