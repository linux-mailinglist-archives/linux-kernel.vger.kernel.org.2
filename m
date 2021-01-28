Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924CB307934
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 16:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhA1PKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 10:10:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232406AbhA1PJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611846458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTgUbUK04S+AE+SXl9oa06nYx0xizsEpdYjWl3KZECA=;
        b=Kw2rI8iLrbs69fcxQHECTYtrtG56dfsFNB76fnicUIIXcP4Gl/jerJpD6PDZZu8cWgZL0X
        rGqhEiQSjFQi/EvKTleZWbA/g6EWKxKxltpGFud97fC130MG5GdhfeASzrVmboh7ro8dEn
        a8sn+7tykf5jHFsoxLYd4XgSZkVgcXk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-xQQ_weEUOfiSQdVPCWk7EQ-1; Thu, 28 Jan 2021 10:07:36 -0500
X-MC-Unique: xQQ_weEUOfiSQdVPCWk7EQ-1
Received: by mail-ed1-f72.google.com with SMTP id f4so3310963eds.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 07:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BTgUbUK04S+AE+SXl9oa06nYx0xizsEpdYjWl3KZECA=;
        b=CI7VPM01JwsZUHtdxIlCIVF196eUA5pLtB/mlpnDzTjvSxQ48IuXIGbvgSLRcBa30O
         mmW5WnPNtmT7eGR2Uom+FP36IN5BY+3Wfn/BKwhvELlXuOUhB8Z8yKB2MUrrwEGfR0Wg
         rCGCCxQ+uGkJ8M/JtTKpo+71+Z5BvkMxRun9dERk+fnglN2f75rFxJoIGXIl8KQOjc/n
         5FcB8uIizRRiidoVbPNfm3pfoVleZ4WFS6+bV5psZlaPDG3Yf97So2aa+nirvbZPdG/I
         TZ/SsjTpejMxo+v0r5qyWnSojh2vxK2X8a+ADkxmGTKDA1x7GngXScXzvPRlPSwP/U04
         sLQw==
X-Gm-Message-State: AOAM532zyuyjnhLfBLkZOG8VlmdxgECjTTC43lPfU9aZ9br/IS9U6qzK
        v6G8QHChC1dTtLK0OFazhpFGEuc7RpFkrog/U5w7H77omD4HoICGAuO3gqkcL8GkvMxJWp0YsUi
        ghcEG34DaccNVmeD/Iys5CB7P
X-Received: by 2002:a17:907:104c:: with SMTP id oy12mr11492438ejb.503.1611846455478;
        Thu, 28 Jan 2021 07:07:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6MqOgCM2JylpXHGLATWOIoR2fX+kK2gf5U9sB6HR+mHn5JvfqvEVhY3xK7+22I0WlVH+R+A==
X-Received: by 2002:a17:907:104c:: with SMTP id oy12mr11492414ejb.503.1611846455254;
        Thu, 28 Jan 2021 07:07:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s12sm3218300edu.28.2021.01.28.07.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 07:07:34 -0800 (PST)
Subject: Re: [PATCH v2 05/14] KVM: x86: Override reported SME/SEV feature
 flags with host mask
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20210114003708.3798992-1-seanjc@google.com>
 <20210114003708.3798992-6-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74642db3-14dc-4e13-3130-dc8abe1a2b6e@redhat.com>
Date:   Thu, 28 Jan 2021 16:07:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114003708.3798992-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/21 01:36, Sean Christopherson wrote:
> Add a reverse-CPUID entry for the memory encryption word, 0x8000001F.EAX,
> and use it to override the supported CPUID flags reported to userspace.
> Masking the reported CPUID flags avoids over-reporting KVM support, e.g.
> without the mask a SEV-SNP capable CPU may incorrectly advertise SNP
> support to userspace.
> 
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/cpuid.c | 2 ++
>   arch/x86/kvm/cpuid.h | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 13036cf0b912..b7618cdd06b5 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -855,6 +855,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>   	case 0x8000001F:
>   		if (!boot_cpu_has(X86_FEATURE_SEV))
>   			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> +		else
> +			cpuid_entry_override(entry, CPUID_8000_001F_EAX);
>   		break;
>   	/*Add support for Centaur's CPUID instruction*/
>   	case 0xC0000000:
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index dc921d76e42e..8b6fc9bde248 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -63,6 +63,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
>   	[CPUID_8000_0007_EBX] = {0x80000007, 0, CPUID_EBX},
>   	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
>   	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
> +	[CPUID_8000_001F_EAX] = {0x8000001f, 1, CPUID_EAX},
>   };
>   
>   /*
> 

I don't understand, wouldn't this also need a kvm_cpu_cap_mask call 
somewhere else?  As it is, it doesn't do anything.

Paolo

