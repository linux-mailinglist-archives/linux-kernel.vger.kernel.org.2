Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60587392CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhE0LqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233490AbhE0LqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622115872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5EkUl2AHkjTvyhXvN8pIvnw608I2TQwFWpE2hO80KoI=;
        b=i1pR+ag4iRdfiHRYmLGJG0H8TlB0IPAD5EoBOCeZEx7INziwR8jX6yOrUFiygTAJyHpvna
        FcTGDIl9cgPnGzh75vtuq2CoC/uRJBEAZocYep86tDgvmN4m/u2R0YSTCahVKWLMo6OBh5
        oCkWYULF45LWRNTdhw1eapaVL4GzkTs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-LomQAGj3MB2TsGLg2S9tJg-1; Thu, 27 May 2021 07:44:30 -0400
X-MC-Unique: LomQAGj3MB2TsGLg2S9tJg-1
Received: by mail-ed1-f72.google.com with SMTP id d4-20020aa7ce040000b029038d1d0524d0so185441edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 04:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5EkUl2AHkjTvyhXvN8pIvnw608I2TQwFWpE2hO80KoI=;
        b=YyP4+fvy9x9QdI8x+6JyunfIJSmsXemmCFVia3+A3/V/cKloGW/aM4+xITuWcTmvJs
         r3LlQJ4aDXpu/pbKklfq/tuvz9y7W11of2S49BVftdhrC63AdiK+emjYmSuEP2Ndn2Yb
         9qmfhkDiHMwWWmFXO3mjHq1HHrVvgRUFko6uIATtG2lQ/yj7sjoRG2Z3h8o0X3zoBZdP
         JaJ/OUTVs51dOFzJ6Fz6/BoZyMmc0ZgiStwoE+GEy/3bQJT0p3UgouWpa4voqGXFO5SM
         +ZJGc4yloepvVsD+XWX6+x2H6r6gIeJ5GwZd3il7CCQ2vMk2E4aiD18jPHJsB2FGQub0
         UWfA==
X-Gm-Message-State: AOAM531ZOPprKgDL2wDgjd8Dw5xZj+U7jmIqTYmEkvCuEFiVXVh2AsNo
        mrCdqIuVMzK4luD60HnlGI6TFog/482RKyO1Q7JcUvWHbIVgG6y4pnts7SmyoMjzbnFi32RyM6R
        uTm2I/6qC/ulBfR/JGip6L6dk
X-Received: by 2002:a05:6402:15:: with SMTP id d21mr3710264edu.66.1622115869698;
        Thu, 27 May 2021 04:44:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWXe1O4j7xdizgAqxvsjX4MSfhJlfA2EVfNnWE/rPIqY6auscC55tvpfp/RD2kuAyi6nXJag==
X-Received: by 2002:a05:6402:15:: with SMTP id d21mr3710237edu.66.1622115869444;
        Thu, 27 May 2021 04:44:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j17sm886750ejv.60.2021.05.27.04.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 04:44:28 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the kvm-fixes tree
To:     Wanpeng Li <kernellwp@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     KVM <kvm@vger.kernel.org>, Wanpeng Li <wanpengli@tencent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210527084356.12c2784f@canb.auug.org.au>
 <CANRm+CyC+=hMrVJCVWZ7cTC_F3CXYKRms2xNFQCvWa5rPS3U-w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f47859df-3c5d-f96d-523b-dbf6161b7b82@redhat.com>
Date:   Thu, 27 May 2021 13:44:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANRm+CyC+=hMrVJCVWZ7cTC_F3CXYKRms2xNFQCvWa5rPS3U-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/21 06:56, Wanpeng Li wrote:
> On Thu, 27 May 2021 at 10:50, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> After merging the kvm-fixes tree, today's linux-next build (powerpc
>> ppc64_defconfig) failed like this:
>>
>> In file included from arch/powerpc/include/asm/kvm_ppc.h:19,
>>                   from arch/powerpc/include/asm/dbell.h:17,
>>                   from arch/powerpc/kernel/asm-offsets.c:38:
>> include/linux/kvm_host.h: In function 'kvm_vcpu_can_poll':
>> include/linux/kvm_host.h:270:9: error: implicit declaration of function 'single_task_running' [-Werror=implicit-function-declaration]
>>    270 |  return single_task_running() && !need_resched() && ktime_before(cur, stop);
>>        |         ^~~~~~~~~~~~~~~~~~~
>>
>> Caused by commit
>>
>>    85d4c3baeb45 ("KVM: PPC: exit halt polling on need_resched()")
>>
>> I have used the kvm-fixes tree from next-20210524 again today.
> 
> The kvm/master is broken by several patches.

I made a mess and pushed a bunch of 5.13 patches to it.  Apologies 
everyone, I will rewind kvm/master.  If you had checked it out 
yesterday, be careful to remove anything not belonging to your tree.

Paolo

> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 0f6f394..e851671 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1659,7 +1659,7 @@ struct kvm_hv_hcall {
> 
>   static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct
> kvm_hv_hcall *hc, bool ex)
>   {
> -    int i, j;
> +    int i;
>       gpa_t gpa;
>       struct kvm *kvm = vcpu->kvm;
>       struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9d095bed..feb9611 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3604,7 +3604,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu,
> struct msr_data *msr_info)
>            * to ensure backwards-compatible behavior for migration.
>            */
>           if (msr_info->host_initiated &&
> -            kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_TSC_HOST_ACCESS))
> +            kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_TSC_HOST_ACCESS)) {
>               offset = vcpu->arch.l1_tsc_offset;
>               ratio = vcpu->arch.l1_tsc_scaling_ratio;
>           } else {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 18905c9..4273e04 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -10,6 +10,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/signal.h>
>   #include <linux/sched.h>
> +#include <linux/sched/stat.h>
>   #include <linux/bug.h>
>   #include <linux/minmax.h>
>   #include <linux/mm.h>
> 

