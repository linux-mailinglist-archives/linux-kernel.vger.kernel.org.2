Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5044C48A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhKJPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:40:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232469AbhKJPko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636558676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30tz3JHxuBBH6OKoTYVZ1/oahiy3zylMfJnsAgakHOQ=;
        b=LdgC19zYVq5EHY6Ar74Y/G+HgyGhIlJPWcGzEXez9ecqT599HwSZcnOwPfT2KBNJ7azEx6
        dIvqO17iVsJuQ/MfL4ehiVKnlX2ovCvvx3hbh0CQ70YhpFE9W/nEYZG46CzN9sMZeDP3Vt
        7GyKhXiTt6pg1xfeWsXEFrnfsO7FXeE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-K4JiiGtQPtGElC1a-c1WLQ-1; Wed, 10 Nov 2021 10:37:54 -0500
X-MC-Unique: K4JiiGtQPtGElC1a-c1WLQ-1
Received: by mail-wm1-f72.google.com with SMTP id y9-20020a1c7d09000000b003316e18949bso1286084wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=30tz3JHxuBBH6OKoTYVZ1/oahiy3zylMfJnsAgakHOQ=;
        b=Jpffs7JSNPN8v+FmO45aNiKl0aS9R+g2smfVc/sH1JsR3tBr28xngvkWe/5kBPU4Xz
         3eIetf4YqYN65nJ0GarDdQDQNqFlikKCzWSH6bpZccTU4Deth9NGrv1x+1UwT9OyjCAf
         X17JxTtmSCJECEj0/Ev/tyFJvjeYLnShP6+shhXGb4A9F2oehtliURqMS7VMQzeF7Vna
         Cf95OyMB8Sh4fzBCG8PG5Zs5zj2WBh/AV7wvX8HYNAvhl3yXS86kAkgxwhGoXTD2JWIn
         ADViFngpXacsLfZotmom8WVU+MH6D47f4j3BvXT7QExbbwLWR2nAPfs+4atrn0ijApzQ
         IVcw==
X-Gm-Message-State: AOAM533MmHOTr12jh9SqYY6jmIdumta2t1UzG4McSC19DSGWifckm6Xs
        a+/h+gQRjqsrdDghGtKE+sInJdE+Ye86DVydFAWFd8ajYPM8h6Ln3oOX/Kb9P9MPfByLIlqAkgp
        1EESjgJZRuXVZxRBu5BbodqXy
X-Received: by 2002:a05:600c:2e42:: with SMTP id q2mr15936wmf.161.1636558673479;
        Wed, 10 Nov 2021 07:37:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxW/VFDXDiiODjm7LlcaoGlETxK4RENu+QyMKWkyGXEAqSrOjFV0sT/j9ePtuz8jicQgs0upA==
X-Received: by 2002:a05:600c:2e42:: with SMTP id q2mr15911wmf.161.1636558673273;
        Wed, 10 Nov 2021 07:37:53 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id q84sm7204196wme.3.2021.11.10.07.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 07:37:52 -0800 (PST)
Subject: Re: [PATCH v4 01/15] KVM: async_pf: Move struct kvm_async_pf around
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
References: <20210815005947.83699-1-gshan@redhat.com>
 <20210815005947.83699-2-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <f05db974-1145-b83e-a8ba-e73dbf4bc880@redhat.com>
Date:   Wed, 10 Nov 2021 16:37:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815005947.83699-2-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 8/15/21 2:59 AM, Gavin Shan wrote:
> This moves the definition of "struct kvm_async_pf" and the related
> functions after "struct kvm_vcpu" so that newly added inline functions
> in the subsequent patches can dereference "struct kvm_vcpu" properly.
> Otherwise, the unexpected build error will be raised:
> 
>    error: dereferencing pointer to incomplete type ‘struct kvm_vcpu’
>    return !list_empty_careful(&vcpu->async_pf.done);
>                                    ^~
> Since we're here, the sepator between type and field in "struct kvm_vcpu"
separator
> is replaced by tab. The empty stub kvm_check_async_pf_completion() is also
> added on !CONFIG_KVM_ASYNC_PF, which is needed by subsequent patches to
> support asynchronous page fault on ARM64.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  include/linux/kvm_host.h | 44 +++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index ae7735b490b4..85b61a456f1c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -199,27 +199,6 @@ int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
>  struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,
>  					 gpa_t addr);
>  
> -#ifdef CONFIG_KVM_ASYNC_PF
> -struct kvm_async_pf {
> -	struct work_struct work;
> -	struct list_head link;
> -	struct list_head queue;
> -	struct kvm_vcpu *vcpu;
> -	struct mm_struct *mm;
> -	gpa_t cr2_or_gpa;
> -	unsigned long addr;
> -	struct kvm_arch_async_pf arch;
> -	bool   wakeup_all;
> -	bool notpresent_injected;
> -};
> -
> -void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
> -void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu);
> -bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> -			unsigned long hva, struct kvm_arch_async_pf *arch);
> -int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
> -#endif
> -
>  #ifdef KVM_ARCH_WANT_MMU_NOTIFIER
>  struct kvm_gfn_range {
>  	struct kvm_memory_slot *slot;
> @@ -346,6 +325,29 @@ struct kvm_vcpu {
>  	struct kvm_dirty_ring dirty_ring;
>  };
>  
> +#ifdef CONFIG_KVM_ASYNC_PF
> +struct kvm_async_pf {
> +	struct work_struct		work;
> +	struct list_head		link;
> +	struct list_head		queue;
> +	struct kvm_vcpu			*vcpu;
> +	struct mm_struct		*mm;
> +	gpa_t				cr2_or_gpa;
> +	unsigned long			addr;
> +	struct kvm_arch_async_pf	arch;
> +	bool				wakeup_all;
> +	bool				notpresent_injected;
> +};
> +
> +void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
> +void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu);
> +bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> +			unsigned long hva, struct kvm_arch_async_pf *arch);
> +int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
> +#else
> +static inline void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu) { }
why is that stub needed on ARM64 and not on the other archs?

Eric
> +#endif
> +
>  /* must be called with irqs disabled */
>  static __always_inline void guest_enter_irqoff(void)
>  {
> 

