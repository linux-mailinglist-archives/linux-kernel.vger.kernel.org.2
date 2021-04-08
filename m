Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DF2358299
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhDHMAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230434AbhDHMAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617883222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4jNA22ts4sXV+GUF1Wj8QCzAfhn+4bY8EmKVJ9s6OPc=;
        b=V4c+W//WzCryb56+roQbsVfEpi5UmTVo+3Ihbc/cN8lPT3xmOa3iOQNZbLsQOC9hVZe01b
        JoBOmtpcC2MGNrXB6GsHcyqkaq+N9fiOq+c2CP0hir39FoPueTIfS03r7Ny94Nm22epFiS
        6RuuLmdwQASEa15E1lHJRjkXW0VqNdE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-o9EpDbClNLmR9QdZHXCmFQ-1; Thu, 08 Apr 2021 08:00:20 -0400
X-MC-Unique: o9EpDbClNLmR9QdZHXCmFQ-1
Received: by mail-ej1-f70.google.com with SMTP id jt26so739030ejc.18
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 05:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4jNA22ts4sXV+GUF1Wj8QCzAfhn+4bY8EmKVJ9s6OPc=;
        b=iCvrLPAZbb27JnMEqtK4GMhwY5wATHdU+PzFjvnscU3CyF2NYAX02McGgwGzQC78kL
         EZAiOSrZv3IF5W/bBaK9aiIj+ClyQmFsEGm794MeP4XimDEAdkh7h/gr38ASVB7Y+ayk
         i+rF6GrrAsUzm3swQ02rk3QFk4iyBrkd1wrrSojRCmav1VRSA4vpzgjgSyMPPuRNFDvI
         TPRxAVr3xrK2sxmv/c7aXaWcJywZpDnjsQ/yQbd8vTwyOadK97PyOTir8NAJn5O4FMaK
         LUNNiV9DrQ2OtTFAUql8FjRK8wa5IvNJOdhzynKuEsIbTMpGjbca+jw5BwrUtY6ythIy
         gJtQ==
X-Gm-Message-State: AOAM532vPoGtOFYB97/mizB0RcFQVGlIaBPiYrK4ZRhpkcN859vup0o6
        5ATgWVMUVbZfSiRex8TDnnL6fSCfat0yw+4h/5+VPvIEEiWDVqAFZdrtWCmH0r6EOG1XGfqI40r
        U/DQCjIB5Gx0SQTXUE43SAWQQ
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr9661936ejb.124.1617883216660;
        Thu, 08 Apr 2021 05:00:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCaXWiCiY1qRqSDTSV8wOLTIbsQEr6KIundxcbgi9SLmCTjbsZRz+/AN4KDzZ5Shtv+a3bng==
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr9661393ejb.124.1617883213903;
        Thu, 08 Apr 2021 05:00:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a9sm4209509eda.13.2021.04.08.05.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 05:00:13 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: Explicitly use GFP_KERNEL_ACCOUNT for 'struct
 kvm_vcpu' allocations
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wanpeng Li <kernellwp@gmail.com>
References: <20210406190740.4055679-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf29a3f3-cb55-dbfd-36da-708cc67d1d1a@redhat.com>
Date:   Thu, 8 Apr 2021 14:00:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210406190740.4055679-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/21 21:07, Sean Christopherson wrote:
> Use GFP_KERNEL_ACCOUNT when allocating vCPUs to make it more obvious that
> that the allocations are accounted, to make it easier to audit KVM's
> allocations in the future, and to be consistent with other cache usage in
> KVM.
> 
> When using SLAB/SLUB, this is a nop as the cache itself is created with
> SLAB_ACCOUNT.
> 
> When using SLOB, there are caveats within caveats.  SLOB doesn't honor
> SLAB_ACCOUNT, so passing GFP_KERNEL_ACCOUNT will result in vCPU
> allocations now being accounted.   But, even that depends on internal
> SLOB details as SLOB will only go to the page allocator when its cache is
> depleted.  That just happens to be extremely likely for vCPUs because the
> size of kvm_vcpu is larger than the a page for almost all combinations of
> architecture and page size.  Whether or not the SLOB behavior is by
> design is unknown; it's just as likely that no SLOB users care about
> accounding and so no one has bothered to implemented support in SLOB.
> Regardless, accounting vCPU allocations will not break SLOB+KVM+cgroup
> users, if any exist.
> 
> Cc: Wanpeng Li <kernellwp@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> v2: Drop the Fixes tag and rewrite the changelog since this is a nop when
>      using SLUB or SLAB. [Wanpeng]
> 
>   virt/kvm/kvm_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 0a481e7780f0..580f98386b42 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3192,7 +3192,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
>   	if (r)
>   		goto vcpu_decrement;
>   
> -	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
> +	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
>   	if (!vcpu) {
>   		r = -ENOMEM;
>   		goto vcpu_decrement;
> 

Queued, thanks.

Paolo

