Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5C44C278
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhKJNvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232265AbhKJNvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636552097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Og55LDFYJ7kO+kgyTSozRobvntp0cnmzWCkIuzU05sg=;
        b=PfW2nfBv6QdjhIkCW2OJaVP3bONcOUEKUt1WEOMmlctEt8qKYRssHP5Wk3Aujv1C261BAU
        303XhkWIo/gzm9SqhU9fXKadyvfGZi2uBi5ZW1vy3hUSqWJs4kYbbpE5rLMmYbBzN1fQko
        bQjVmUUB1TGmugj87aQLkTCLL47GsUQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-WHDIPG-KNoaAsNcY1x7EUQ-1; Wed, 10 Nov 2021 08:48:16 -0500
X-MC-Unique: WHDIPG-KNoaAsNcY1x7EUQ-1
Received: by mail-wm1-f72.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso3114754wme.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Og55LDFYJ7kO+kgyTSozRobvntp0cnmzWCkIuzU05sg=;
        b=jIFEL4PuqpYNnP1M9AoS92b9IeEfnCogzeb7lgSVPm9lntsRu4nyvjQjIJp3plpMdG
         9nxfAD6T/fc9rYCcRl22T6/uF+no5qviBcu6dkwWp0edtC3ciurwFN2d7LEszLNzF7p9
         8lYXCTWQD0H+N6L/98juqQtFcycoGBbfZPhb7tzCjpWqb1Nsy9zHa9ACzS07+3hwzyHd
         TbHzq81JUq8flq0GYFW3Mj199eiR79YZiUPlinVydJ9rO4/D/Dps8Kgo6cz4/X5i3r/M
         laUSuAFPJGuhLN3rn677XtRwevX7cBZ2RPH5BGTK0V8qYiNKOdPPgw7o+b3YdFDfS6/I
         5xgg==
X-Gm-Message-State: AOAM531nzUaWFMIlF9t4j+T1JK50DbhugVGNgtV5jC6of/qRWkrZKKYV
        zTxJ1Sfbog4qdYbwv4feebGeg+8YFklH0L1iEWz46hXuzcLxHKXfoxImtgLpIpeYnHmH2I1gcqo
        F4med+cy457Vp7lOnAwdMf4cu
X-Received: by 2002:a05:600c:4f87:: with SMTP id n7mr16258194wmq.168.1636552093640;
        Wed, 10 Nov 2021 05:48:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyp8PU3xnrReXZdEzOGfjYjxfYWwQf7uiEdn+JdUIQ7LP/uVRbGaV+xWQAd7nFWI/TOLRNBUQ==
X-Received: by 2002:a05:600c:4f87:: with SMTP id n7mr16258153wmq.168.1636552093377;
        Wed, 10 Nov 2021 05:48:13 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id i17sm6086348wmq.48.2021.11.10.05.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 05:48:12 -0800 (PST)
Subject: Re: [PATCH v4 16/21] KVM: arm64: Support SDEI ioctl commands on VM
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-17-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <6a4f1736-3af0-ccaa-e8a0-242759610430@redhat.com>
Date:   Wed, 10 Nov 2021 14:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-17-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/21 2:13 AM, Gavin Shan wrote:
> This supports ioctl commands on VM to manage the various objects.
> It's primarily used by VMM to accomplish live migration. The ioctl
> commands introduced by this are highlighted as blow:
below
> 
>    * KVM_SDEI_CMD_GET_VERSION
>      Retrieve the version of current implementation
which implementation, SDEI?
>    * KVM_SDEI_CMD_SET_EVENT
>      Add event to be exported from KVM so that guest can register
>      against it afterwards
>    * KVM_SDEI_CMD_GET_KEVENT_COUNT
>      Retrieve number of registered SDEI events
>    * KVM_SDEI_CMD_GET_KEVENT
>      Retrieve the state of the registered SDEI event
>    * KVM_SDEI_CMD_SET_KEVENT
>      Populate the registered SDEI event
I think we really miss the full picture of what you want to achieve with
those IOCTLs or at least I fail to get it. Please document the UAPI
separately including the structs and IOCTLs.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_sdei.h      |   1 +
>  arch/arm64/include/uapi/asm/kvm_sdei.h |  17 +++
>  arch/arm64/kvm/arm.c                   |   3 +
>  arch/arm64/kvm/sdei.c                  | 171 +++++++++++++++++++++++++
>  include/uapi/linux/kvm.h               |   3 +
>  5 files changed, 195 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
> index 19f2d9b91f85..8f5ea947ed0e 100644
> --- a/arch/arm64/include/asm/kvm_sdei.h
> +++ b/arch/arm64/include/asm/kvm_sdei.h
> @@ -125,6 +125,7 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
>  int kvm_sdei_register_notifier(struct kvm *kvm, unsigned long num,
>  			       kvm_sdei_notifier notifier);
>  void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
> +long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg);
>  void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
>  void kvm_sdei_destroy_vm(struct kvm *kvm);
>  
> diff --git a/arch/arm64/include/uapi/asm/kvm_sdei.h b/arch/arm64/include/uapi/asm/kvm_sdei.h
> index 4ef661d106fe..35ff05be3c28 100644
> --- a/arch/arm64/include/uapi/asm/kvm_sdei.h
> +++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
> @@ -57,5 +57,22 @@ struct kvm_sdei_vcpu_state {
>  	struct kvm_sdei_vcpu_regs	normal_regs;
>  };
>  
> +#define KVM_SDEI_CMD_GET_VERSION		0
> +#define KVM_SDEI_CMD_SET_EVENT			1
> +#define KVM_SDEI_CMD_GET_KEVENT_COUNT		2
> +#define KVM_SDEI_CMD_GET_KEVENT			3
> +#define KVM_SDEI_CMD_SET_KEVENT			4
> +
> +struct kvm_sdei_cmd {
> +	__u32						cmd;
> +	union {
> +		__u32					version;
> +		__u32					count;
> +		__u64					num;
> +		struct kvm_sdei_event_state		kse_state;
> +		struct kvm_sdei_kvm_event_state		kske_state;
> +	};
> +};
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _UAPI__ASM_KVM_SDEI_H */
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 0c3db1ef1ba9..8d61585124b2 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1389,6 +1389,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  			return -EFAULT;
>  		return kvm_vm_ioctl_mte_copy_tags(kvm, &copy_tags);
>  	}
> +	case KVM_ARM_SDEI_COMMAND: {
> +		return kvm_sdei_vm_ioctl(kvm, arg);
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index 5f7a37dcaa77..bdd76c3e5153 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -931,6 +931,177 @@ void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu)
>  	vcpu->arch.sdei = vsdei;
>  }
>  
> +static long kvm_sdei_set_event(struct kvm *kvm,
> +			       struct kvm_sdei_event_state *kse_state)
> +{
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_event *kse = NULL;
> +
> +	if (!kvm_sdei_is_valid_event_num(kse_state->num))
> +		return -EINVAL;
> +
> +	if (!(kse_state->type == SDEI_EVENT_TYPE_SHARED ||
> +	      kse_state->type == SDEI_EVENT_TYPE_PRIVATE))
> +		return -EINVAL;
> +
> +	if (!(kse_state->priority == SDEI_EVENT_PRIORITY_NORMAL ||
> +	      kse_state->priority == SDEI_EVENT_PRIORITY_CRITICAL))
> +		return -EINVAL;
> +
> +	kse = kvm_sdei_find_event(kvm, kse_state->num);
> +	if (kse)
> +		return -EEXIST;
> +
> +	kse = kzalloc(sizeof(*kse), GFP_KERNEL);
> +	if (!kse)
> +		return -ENOMEM;
userspace can exhaust the mem since there is no limit. There must be a max.

> +
> +	kse->state = *kse_state;
> +	kse->kvm = kvm;
> +	list_add_tail(&kse->link, &ksdei->events);
> +
> +	return 0;
> +}
> +
> +static long kvm_sdei_get_kevent_count(struct kvm *kvm, int *count)
> +{
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_kvm_event *kske = NULL;
> +	int total = 0;
> +
> +	list_for_each_entry(kske, &ksdei->kvm_events, link) {
> +		total++;
> +	}
> +
> +	*count = total;
> +	return 0;
> +}
> +
> +static long kvm_sdei_get_kevent(struct kvm *kvm,
> +				struct kvm_sdei_kvm_event_state *kske_state)
> +{
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_kvm_event *kske = NULL;
> +
> +	/*
> +	 * The first entry is fetched if the event number is invalid.
> +	 * Otherwise, the next entry is fetched.
why don't we return an error? What is the point returning the next entry?
> +	 */
> +	if (!kvm_sdei_is_valid_event_num(kske_state->num)) {
> +		kske = list_first_entry_or_null(&ksdei->kvm_events,
> +				struct kvm_sdei_kvm_event, link);
> +	} else {
> +		kske = kvm_sdei_find_kvm_event(kvm, kske_state->num);
> +		if (kske && !list_is_last(&kske->link, &ksdei->kvm_events))
> +			kske = list_next_entry(kske, link);
Sorry I don't get why we return the next one?
> +		else
> +			kske = NULL;
> +	}
> +
> +	if (!kske)
> +		return -ENOENT;
> +
> +	*kske_state = kske->state;
> +
> +	return 0;
> +}
> +
> +static long kvm_sdei_set_kevent(struct kvm *kvm,
> +				struct kvm_sdei_kvm_event_state *kske_state)
> +{
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_event *kse = NULL;
> +	struct kvm_sdei_kvm_event *kske = NULL;
> +
> +	/* Sanity check */
> +	if (!kvm_sdei_is_valid_event_num(kske_state->num))
> +		return -EINVAL;
> +
> +	if (!(kske_state->route_mode == SDEI_EVENT_REGISTER_RM_ANY ||
> +	      kske_state->route_mode == SDEI_EVENT_REGISTER_RM_PE))
> +		return -EINVAL;
> +
> +	/* Check if the event number is valid */
> +	kse = kvm_sdei_find_event(kvm, kske_state->num);
> +	if (!kse)
> +		return -ENOENT;
> +
> +	/* Check if the event has been populated */
> +	kske = kvm_sdei_find_kvm_event(kvm, kske_state->num);
> +	if (kske)
> +		return -EEXIST;
> +
> +	kske = kzalloc(sizeof(*kske), GFP_KERNEL);
userspace can exhaust the mem since there is no limit
> +	if (!kske)
> +		return -ENOMEM;
> +
> +	kske->state = *kske_state;
> +	kske->kse   = kse;
> +	kske->kvm   = kvm;
> +	list_add_tail(&kske->link, &ksdei->kvm_events);
> +
> +	return 0;
> +}
> +
> +long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg)
> +{
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_cmd *cmd = NULL;
> +	void __user *argp = (void __user *)arg;
> +	bool copy = false;
> +	long ret = 0;
> +
> +	/* Sanity check */
> +	if (!ksdei) {
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
> +	if (!cmd) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (copy_from_user(cmd, argp, sizeof(*cmd))) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	spin_lock(&ksdei->lock);
> +
> +	switch (cmd->cmd) {
> +	case KVM_SDEI_CMD_GET_VERSION:
> +		copy = true;
> +		cmd->version = (1 << 16);       /* v1.0.0 */
> +		break;
> +	case KVM_SDEI_CMD_SET_EVENT:
> +		ret = kvm_sdei_set_event(kvm, &cmd->kse_state);
> +		break;
> +	case KVM_SDEI_CMD_GET_KEVENT_COUNT:
> +		copy = true;
> +		ret = kvm_sdei_get_kevent_count(kvm, &cmd->count);
> +		break;
> +	case KVM_SDEI_CMD_GET_KEVENT:
> +		copy = true;
> +		ret = kvm_sdei_get_kevent(kvm, &cmd->kske_state);
> +		break;
> +	case KVM_SDEI_CMD_SET_KEVENT:
> +		ret = kvm_sdei_set_kevent(kvm, &cmd->kske_state);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	spin_unlock(&ksdei->lock);
> +out:
> +	if (!ret && copy && copy_to_user(argp, cmd, sizeof(*cmd)))
> +		ret = -EFAULT;
> +
> +	kfree(cmd);
> +	return ret;
> +}
> +
>  void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index d9e4aabcb31a..8cf41fd4bf86 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1679,6 +1679,9 @@ struct kvm_xen_vcpu_attr {
>  #define KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_DATA	0x4
>  #define KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST	0x5
>  
> +/* Available with KVM_CAP_ARM_SDEI */
> +#define KVM_ARM_SDEI_COMMAND	_IOWR(KVMIO, 0xce, struct kvm_sdei_cmd)
> +
>  /* Secure Encrypted Virtualization command */
>  enum sev_cmd_id {
>  	/* Guest initialization commands */
> 
Eric

