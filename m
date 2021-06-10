Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC843A2B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhFJMR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230343AbhFJMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623327358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRQIAiisGIrw+JGfT9AyG3U4rv0tgzEX+Jux94bTB+4=;
        b=eFDDPYIAdd8UNozvHX4Gg81bEUDjpGnE7IXkoArGETo22/qu6nu61fFndN4RBlZiT3GOQJ
        TIDdv1vA2cMTlT5jzjLGenM9oA5D7T91CAZg4alQz5nL2RAUFF1UwJBBG+qGL4TD6AKQbY
        MbJiiZFI2wYVjyiX5M4MdgxjzMQ5wao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-mAcYdpyjMia7pSQst82PKQ-1; Thu, 10 Jun 2021 08:15:57 -0400
X-MC-Unique: mAcYdpyjMia7pSQst82PKQ-1
Received: by mail-wr1-f69.google.com with SMTP id z4-20020adfe5440000b0290114f89c9931so800319wrm.17
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 05:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tRQIAiisGIrw+JGfT9AyG3U4rv0tgzEX+Jux94bTB+4=;
        b=rKS7JSGrIsFpAEhypMH9I1TlQ6DHrZVWZ9qprVbu3ynAOhG8pTFR3DPf1/xJuqtVtE
         +CXMY8rfZmAxfYfAY7SctLtKdeX74tQqwLXiWJiqsIgdyeoNA6JNC1KD0WN8exTDQ1mx
         QFK/OD9+U+vU0Nhrc0/I3CoNiAhmc60uyy2Oid4fVTL/idTKeGWBunBbU+gTxWLFM41z
         6tKyQkBS1l3Ok2+fLuro176E5sLHQpBOWv9Mri9LE9YmLzSkTW18vOw6KmG2HjuvU2c3
         OWyC3xNSWmKTFuKACGIGJklnrql4zD1icEvK40zRCzfyabFqp1hS3rmlKN8XJJHK1IfE
         4CEw==
X-Gm-Message-State: AOAM5338YyIG+7QXhjXF+E+h/8Hf/u+BjcJOERFrjGKNuwkVGoSN3eh0
        wSTVwVkib0K7JBoyAENDMydFEcpd/6yKBhX5urFwxT78b4ntGyy5treIY1ifN5Aff54mV+I/wAH
        6SxLXEoCt1aw+/qa4fszU2pSgsXKlgHC1g2ZKcIPPUe3NA98zkwHvqqnRJm0Ix+qaE3nqMrujnI
        ZC
X-Received: by 2002:a1c:4c04:: with SMTP id z4mr4130050wmf.47.1623327355659;
        Thu, 10 Jun 2021 05:15:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtpTmN/gbuEuGL+MyLdgwa9rsIkG/gN2oXtnPsR9mIUvPWzyeCECrc6bFL/6s21g8Ac5nCuw==
X-Received: by 2002:a1c:4c04:: with SMTP id z4mr4130021wmf.47.1623327355404;
        Thu, 10 Jun 2021 05:15:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id r4sm3668055wre.84.2021.06.10.05.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 05:15:54 -0700 (PDT)
Subject: Re: [PATCHv3 2/2] kvm: x86: implement KVM PM-notifier
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210606021045.14159-1-senozhatsky@chromium.org>
 <20210606021045.14159-2-senozhatsky@chromium.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4cb326cf-fba6-9894-980a-34c1a19183f2@redhat.com>
Date:   Thu, 10 Jun 2021 14:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210606021045.14159-2-senozhatsky@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/21 04:10, Sergey Senozhatsky wrote:
> Implement PM hibernation/suspend prepare notifiers so that KVM
> can reliably set PVCLOCK_GUEST_STOPPED on VCPUs and properly
> suspend VMs.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>   arch/x86/kvm/Kconfig |  1 +
>   arch/x86/kvm/x86.c   | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index fb8efb387aff..ac69894eab88 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -43,6 +43,7 @@ config KVM
>   	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>   	select KVM_VFIO
>   	select SRCU
> +	select HAVE_KVM_PM_NOTIFIER if PM
>   	help
>   	  Support hosting fully virtualized guest machines using hardware
>   	  virtualization extensions.  You will need a fairly recent
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b594275d49b5..af1ab527a0cb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -58,6 +58,7 @@
>   #include <linux/sched/isolation.h>
>   #include <linux/mem_encrypt.h>
>   #include <linux/entry-kvm.h>
> +#include <linux/suspend.h>
>   
>   #include <trace/events/kvm.h>
>   
> @@ -5615,6 +5616,41 @@ static int kvm_vm_ioctl_set_msr_filter(struct kvm *kvm, void __user *argp)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
> +static int kvm_arch_suspend_notifier(struct kvm *kvm)
> +{
> +	struct kvm_vcpu *vcpu;
> +	int i, ret = 0;
> +
> +	mutex_lock(&kvm->lock);
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (!vcpu->arch.pv_time_enabled)
> +			continue;
> +
> +		ret = kvm_set_guest_paused(vcpu);
> +		if (ret) {
> +			kvm_err("Failed to pause guest VCPU%d: %d\n",
> +				vcpu->vcpu_id, ret);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&kvm->lock);
> +
> +	return ret ? NOTIFY_BAD : NOTIFY_DONE;
> +}
> +
> +int kvm_arch_pm_notifier(struct kvm *kvm, unsigned long state)
> +{
> +	switch (state) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_SUSPEND_PREPARE:
> +		return kvm_arch_suspend_notifier(kvm);
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +#endif /* CONFIG_HAVE_KVM_PM_NOTIFIER */
> +
>   long kvm_arch_vm_ioctl(struct file *filp,
>   		       unsigned int ioctl, unsigned long arg)
>   {
> 

Queued, thanks.

Paolo

