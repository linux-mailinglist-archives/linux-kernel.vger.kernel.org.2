Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337AD44D836
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 15:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhKKO1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 09:27:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232699AbhKKO1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636640704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TZ85R17ksHNNki9ytrUAcivCTUFGWKfCZEjAM+vq04=;
        b=fc7c/zbdBgA0vsB4iWprcmBXmIZkPwoFZIvYrCZeH6fPfQIB3xGCgjRjkmlGsSv7PUG89p
        x62WTfOgf5slnIenbSW4l35TKq8eVy3z50QI143VtiFAS9lfWqyrxHjk4oA6QZ/mHLxNET
        ajK9aA2VCKIqAedCdLUUf8rvlJPC5jM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-0dgXKhn1NYmBvbV0ZX4rJg-1; Thu, 11 Nov 2021 09:25:03 -0500
X-MC-Unique: 0dgXKhn1NYmBvbV0ZX4rJg-1
Received: by mail-ed1-f70.google.com with SMTP id t20-20020a056402525400b003e2ad6b5ee7so5538784edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 06:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8TZ85R17ksHNNki9ytrUAcivCTUFGWKfCZEjAM+vq04=;
        b=s19oZly9Ancaj5NK7leBys+eBlnUk5tcKPhBmHDhT7MoFTBEn7XdSnAcuya5ccUtpW
         j1zOM3iKys+1KaZK4TYhvBZ2iDF2tT/fPP3bvzHT7OKMjBoJl7M/X/ghTyw9MJeU6aej
         VMwVvNNLDdYsY8/1Kvzaf+f2/B5kwZWxGtPjl8zQA5R2x5dqGJ3HwcSerUOu4jJgfzvO
         s77hxatgz0Xhw8QcUNUKh8BPprgn2VIhUw/55v+ltH/V51eFRQcV/BCyFB/zcn9C+9qF
         jjvhBUzRHK2gw4xStyc7HrABvgxzds7+fy/wotTx6bWfvn06xGd4/daMfVQvMN8Iy0nB
         gj0A==
X-Gm-Message-State: AOAM531HyTwg86F5mtjZ9XgeJni0N6A7IRmfpEA/ZAh9SmikOL+x6iS4
        IeONOeAbbvGDXU7/BVtI5dqZVlRhWvqe2zsIUyWGzpDP564LAtgAkiiHn1Dv6tQ3Ml0t3oLv89C
        47bkCQn4zEAzRxLDdoiECiVff
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr9902163ejc.263.1636640701776;
        Thu, 11 Nov 2021 06:25:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5mlEO9ECKaC/uGnjkikEPFowycPQFS1eUhmAjLflS+IuFdyoJZ0gmnDT/yy/6DvwVIa++rw==
X-Received: by 2002:a17:907:94ca:: with SMTP id dn10mr9902125ejc.263.1636640701520;
        Thu, 11 Nov 2021 06:25:01 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id hb36sm1402996ejc.73.2021.11.11.06.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 06:25:00 -0800 (PST)
Message-ID: <5cdb6982-d4ec-118e-2534-9498196d11b8@redhat.com>
Date:   Thu, 11 Nov 2021 15:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RFC] KVM: x86: Drop arbitraty KVM_SOFT_MAX_VCPUS
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20211111134733.86601-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211111134733.86601-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/21 14:47, Vitaly Kuznetsov wrote:
> KVM_CAP_NR_VCPUS is used to get the "recommended" maximum number of
> VCPUs and arm64/mips/riscv report num_online_cpus(). Powerpc reports
> either num_online_cpus() or num_present_cpus(), s390 has multiple
> constants depending on hardware features. On x86, KVM reports an
> arbitrary value of '710' which is supposed to be the maximum tested
> value but it's possible to test all KVM_MAX_VCPUS even when there are
> less physical CPUs available.
> 
> Drop the arbitrary '710' value and return num_online_cpus() on x86 as
> well. The recommendation will match other architectures and will mean
> 'no CPU overcommit'.
> 
> For reference, QEMU only queries KVM_CAP_NR_VCPUS to print a warning
> when the requested vCPU number exceeds it. The static limit of '710'
> is quite weird as smaller systems with just a few physical CPUs should
> certainly "recommend" less.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Yes, this is a good idea.  We cannot move it entirely to common code due 
to POWER's handling of secondary threads in hypervisors; still, this is 
as close as we can get to a common idea of what KVM_CAP_NR_VCPUS means.

Queued, thanks.

Paolo

> ---
>   arch/x86/include/asm/kvm_host.h | 1 -
>   arch/x86/kvm/x86.c              | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 88fce6ab4bbd..0232a00598f2 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -38,7 +38,6 @@
>   #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
>   
>   #define KVM_MAX_VCPUS 1024
> -#define KVM_SOFT_MAX_VCPUS 710
>   
>   /*
>    * In x86, the VCPU ID corresponds to the APIC ID, and APIC IDs
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ac83d873d65b..91ef1b872b90 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4137,7 +4137,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   		r = !static_call(kvm_x86_cpu_has_accelerated_tpr)();
>   		break;
>   	case KVM_CAP_NR_VCPUS:
> -		r = KVM_SOFT_MAX_VCPUS;
> +		r = num_online_cpus();
>   		break;
>   	case KVM_CAP_MAX_VCPUS:
>   		r = KVM_MAX_VCPUS;
> 

