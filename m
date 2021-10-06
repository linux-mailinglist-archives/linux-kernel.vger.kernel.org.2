Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB15423CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbhJFLZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238661AbhJFLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633519430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFumdVHHGIZhUDKrWCxbg5hP7FLGEfxmOeJpVvQ4nrc=;
        b=ADr4sJpFc2FnKkrLd6SOf7vKJAbPUreaThfn6yg9FooL/w1rAndAxCDdh8J9rIRbmUQqq/
        ctHeEF49fdcXwJMrD/C4d/CE8zCzR4iM9ZKwDaex/lON7kvAILmVpfyCsqliTY54LTvqAH
        ZuYW9z3mxMG1edFRcD6YG3luqJpyEw8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-KNP8Tu_lM6udsyMzfDNFXg-1; Wed, 06 Oct 2021 07:23:49 -0400
X-MC-Unique: KNP8Tu_lM6udsyMzfDNFXg-1
Received: by mail-ed1-f69.google.com with SMTP id c8-20020a50d648000000b003daa53c7518so2272109edj.21
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 04:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TFumdVHHGIZhUDKrWCxbg5hP7FLGEfxmOeJpVvQ4nrc=;
        b=EmKwn+cBDrFuZ0Y/WNNLgSd7WcN3m1LNk1g7UnA2eu6kiBZQNvVm+8YuqA7yJ0XEEg
         rYtuHI2tIorh6SbbKg/nXdqVB523ldeNkkOvxxyI8VGi75T5EKGRWjrYGooq7GmC8XgH
         oCrrD+KedxLtLQE7TXlvmsrvR3eg275qjbgiycH+LXLVWK8RXm73TDxCPIGqtAEIWwzs
         ceZi1HH7JihYTRIW2HYl20PXxfYtNF/24xGa9a+bah1I3OVfK+8qG5Ny/P78Qem7UjbA
         bZEahvx91UII2fKWoJMWBwItr+1A40eesl1f22rSmc5GvUD69jNRyeUTc9w6O76i8MQX
         Tk2g==
X-Gm-Message-State: AOAM533QwaBWJgLLk4chKwnyQHJOIqWpIRvlBt39LcLAeekFK1eELhFf
        jwPRVGEDVYwe5ddLvcmzZZs2zQI2jA918pSJimo+DmmVv42WHYPjFMRt/iVZYlu+ZWR2D/MlcZU
        ErgJlTHf7odvQz9FxFeEi/e/t
X-Received: by 2002:a17:906:2f16:: with SMTP id v22mr1103856eji.126.1633519427838;
        Wed, 06 Oct 2021 04:23:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvI08FXytDHe1dzhPmA0wcl13J8YiR11SNMjS3aRzu44O8riA033gJLtAOcqAvt0XWmp1yKA==
X-Received: by 2002:a17:906:2f16:: with SMTP id v22mr1103841eji.126.1633519427622;
        Wed, 06 Oct 2021 04:23:47 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id y4sm8770176ejr.101.2021.10.06.04.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 04:23:47 -0700 (PDT)
Message-ID: <0fd9f7e5-697f-6ad0-b1e3-40bd48a8efae@redhat.com>
Date:   Wed, 6 Oct 2021 13:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 4.19 1/2] KVM: x86: Handle SRCU initialization
 failure during page track init
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, kvm@vger.kernel.org
References: <20211006111259.264427-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211006111259.264427-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/21 13:12, Sasha Levin wrote:
> From: Haimin Zhang <tcs_kernel@tencent.com>
> 
> [ Upstream commit eb7511bf9182292ef1df1082d23039e856d1ddfb ]
> 
> Check the return of init_srcu_struct(), which can fail due to OOM, when
> initializing the page track mechanism.  Lack of checking leads to a NULL
> pointer deref found by a modified syzkaller.
> 
> Reported-by: TCS Robot <tcs_robot@tencent.com>
> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> Message-Id: <1630636626-12262-1-git-send-email-tcs_kernel@tencent.com>
> [Move the call towards the beginning of kvm_arch_init_vm. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/include/asm/kvm_page_track.h | 2 +-
>   arch/x86/kvm/page_track.c             | 4 ++--
>   arch/x86/kvm/x86.c                    | 7 ++++++-
>   3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
> index 172f9749dbb2..5986bd4aacd6 100644
> --- a/arch/x86/include/asm/kvm_page_track.h
> +++ b/arch/x86/include/asm/kvm_page_track.h
> @@ -46,7 +46,7 @@ struct kvm_page_track_notifier_node {
>   			    struct kvm_page_track_notifier_node *node);
>   };
>   
> -void kvm_page_track_init(struct kvm *kvm);
> +int kvm_page_track_init(struct kvm *kvm);
>   void kvm_page_track_cleanup(struct kvm *kvm);
>   
>   void kvm_page_track_free_memslot(struct kvm_memory_slot *free,
> diff --git a/arch/x86/kvm/page_track.c b/arch/x86/kvm/page_track.c
> index 3052a59a3065..1f6b0d9b0c85 100644
> --- a/arch/x86/kvm/page_track.c
> +++ b/arch/x86/kvm/page_track.c
> @@ -169,13 +169,13 @@ void kvm_page_track_cleanup(struct kvm *kvm)
>   	cleanup_srcu_struct(&head->track_srcu);
>   }
>   
> -void kvm_page_track_init(struct kvm *kvm)
> +int kvm_page_track_init(struct kvm *kvm)
>   {
>   	struct kvm_page_track_notifier_head *head;
>   
>   	head = &kvm->arch.track_notifier_head;
> -	init_srcu_struct(&head->track_srcu);
>   	INIT_HLIST_HEAD(&head->track_notifier_list);
> +	return init_srcu_struct(&head->track_srcu);
>   }
>   
>   /*
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 417abc9ba1ad..70cb18f89029 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9039,9 +9039,15 @@ void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
>   
>   int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>   {
> +	int ret;
> +
>   	if (type)
>   		return -EINVAL;
>   
> +	ret = kvm_page_track_init(kvm);
> +	if (ret)
> +		return ret;
> +
>   	INIT_HLIST_HEAD(&kvm->arch.mask_notifier_list);
>   	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
>   	INIT_LIST_HEAD(&kvm->arch.zapped_obsolete_pages);
> @@ -9068,7 +9074,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>   	INIT_DELAYED_WORK(&kvm->arch.kvmclock_sync_work, kvmclock_sync_fn);
>   
>   	kvm_hv_init_vm(kvm);
> -	kvm_page_track_init(kvm);
>   	kvm_mmu_init_vm(kvm);
>   
>   	if (kvm_x86_ops->vm_init)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

