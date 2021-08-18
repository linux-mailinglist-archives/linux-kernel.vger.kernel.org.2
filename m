Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1C3F06D3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbhHROgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238113AbhHROgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629297340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHSNPY/PKb5zJ0vbvuPUVun5ABAirDnCsVcNZJhehTo=;
        b=Qqsieq2OJG4sIwnFilqlLDRELxxazPOmMao57yfz33X/cdLOtPVSvLAt1vn8hALR7tdWmT
        E/BYFEyfVLTfENoSMuGfvaYrA09uYg3tZU6wLJ8ULOlvOB1BYloky64UB+mBdSiOrAN4Mw
        gx2EzL6NfFsrklM/WAG3I7kDgfmzuHE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-F_LvN2-2OfKTJrnzljoL9Q-1; Wed, 18 Aug 2021 10:35:37 -0400
X-MC-Unique: F_LvN2-2OfKTJrnzljoL9Q-1
Received: by mail-wm1-f71.google.com with SMTP id j33-20020a05600c1c21b02902e6828f7a20so781506wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XHSNPY/PKb5zJ0vbvuPUVun5ABAirDnCsVcNZJhehTo=;
        b=f73KcSpHf9D7xPWayh+PA5d6BP/X2UyOj33QH41KoCOsqojt0RNkkbkMFuGHMr3FKz
         UaFQx3cSygLQZfK/mYme+Do+L4qsRNRUMeArCt6agPlGlRPT6omaa8iu8cQJf0gTZm5S
         5KA2N80B5DmM2SjyRrun/Qtx8sIt5xo0lvmfI2cu1akHD0VdNO/DcbNXutUGBrCb9A14
         IOSubdiDQExHCbwsb+WUYHGYmE6Jneak4vDG8fNs8n5Bc2/FD60Q40s6RM3rLQoi9aCr
         ZgScy2fWu94xb8qbIsofotmworxF1XWGwue58pOCD/cuKHeQxqtGI2XvJjR671pG9dzs
         D1/g==
X-Gm-Message-State: AOAM532DFuAVrfZCaqwK2z/7LbsB9nvTAoEJQCA8MTYiZOpj8RWSBEyP
        fwQ6ymn7rl5oDPrKXZWl4qCLsp6PnujLKltBDEKZ4EKkrUpah62Q5Iq+KhdQS4Z8nOpqi70FPCA
        ULfads2wOvZhkOCnOCbgihbUI1jX4m2jn0MinPjFoHFGSTZhk9doZZ/vq/pmzRhYQF/MFPJQM
X-Received: by 2002:a1c:e919:: with SMTP id q25mr9086786wmc.28.1629297335776;
        Wed, 18 Aug 2021 07:35:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJxCK/Y1mrLV/wwaHy1YtKUXy6/HvslB5BKojfOqAhZTZbEObfAnaA0kI7sEphyd9AX7EcNg==
X-Received: by 2002:a1c:e919:: with SMTP id q25mr9086742wmc.28.1629297335389;
        Wed, 18 Aug 2021 07:35:35 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6417.dip0.t-ipconnect.de. [91.12.100.23])
        by smtp.gmail.com with ESMTPSA id e4sm6265234wrw.74.2021.08.18.07.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 07:35:34 -0700 (PDT)
Subject: Re: [PATCH v4 06/13] KVM: Move WARN on invalid memslot index to
 update_memslots()
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1628871411.git.maciej.szmigiero@oracle.com>
 <8db0f1d1901768b5de1417caa425e62d1118e5e8.1628871413.git.maciej.szmigiero@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <957c6b3d-9621-a5a5-418c-f61f87a32ee0@redhat.com>
Date:   Wed, 18 Aug 2021 16:35:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8db0f1d1901768b5de1417caa425e62d1118e5e8.1628871413.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.21 21:33, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Since kvm_memslot_move_forward() can theoretically return a negative
> memslot index even when kvm_memslot_move_backward() returned a positive one
> (and so did not WARN) let's just move the warning to the common code.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   virt/kvm/kvm_main.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 03ef42d2e421..7000efff1425 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1293,8 +1293,7 @@ static inline int kvm_memslot_move_backward(struct kvm_memslots *slots,
>   	struct kvm_memory_slot *mslots = slots->memslots;
>   	int i;
>   
> -	if (WARN_ON_ONCE(slots->id_to_index[memslot->id] == -1) ||
> -	    WARN_ON_ONCE(!slots->used_slots))
> +	if (slots->id_to_index[memslot->id] == -1 || !slots->used_slots)
>   		return -1;
>   
>   	/*
> @@ -1398,6 +1397,9 @@ static void update_memslots(struct kvm_memslots *slots,
>   			i = kvm_memslot_move_backward(slots, memslot);
>   		i = kvm_memslot_move_forward(slots, memslot, i);
>   
> +		if (WARN_ON_ONCE(i < 0))
> +			return;
> +
>   		/*
>   		 * Copy the memslot to its new position in memslots and update
>   		 * its index accordingly.
> 


Note that WARN_ON_* is frowned upon, because it can result in crashes 
with panic_on_warn enabled, which is what some distributions do enable.

We tend to work around that by using pr_warn()/pr_warn_once(), avoiding 
eventually crashing the system when there is a way to continue.

-- 
Thanks,

David / dhildenb

