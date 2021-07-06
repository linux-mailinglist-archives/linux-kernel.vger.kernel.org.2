Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE083BD863
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhGFOjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232484AbhGFOjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dw2C24IYhsTlppTrcEqtz5YCldeKMDuVEIPmvao1so=;
        b=AsHxm1d1VplMxjrOkk0ac15pL02nZ2CTpqodoVHJbG0okngO9wSJwe/vORiz9C0RFXbsps
        W9AmaUCx73QmnRuAv06n8p0DHtUgp2J/iYYXE/cTCPn0jvmOQ2cU652D4C46N/sF0bk6lS
        qulcKJtxWAb/OKPDNoISjT0zRv6U22o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-hT9jvLTGOHCg_TWPpGjg8Q-1; Tue, 06 Jul 2021 09:44:26 -0400
X-MC-Unique: hT9jvLTGOHCg_TWPpGjg8Q-1
Received: by mail-ej1-f72.google.com with SMTP id hy7-20020a1709068a67b02904cdf8737a75so5000635ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 06:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0dw2C24IYhsTlppTrcEqtz5YCldeKMDuVEIPmvao1so=;
        b=CFG3CETzEMn4CoOrZdQ5a27KTCFPQ64HeMQ8IsdDUx91HMpPHY1Zy6QfL6jvtR73cd
         8xIl7mxqlb9v5jzvxU3QnR033+1r1dCmX3z2zHR3gj+RF/XTdnuhXAzG7cgOujoGgqU9
         JT7aA+v+8rDWXITbwG169xWINW+Yhbaa2txK2L8LYTMXOqknHqXlMKl1SI/swAr8KCUZ
         REAqorq+zcdhWoDanMDrN5hOmFJCJm84TsniRTg3pDN+2L5TzhSvahQ0/fnQIN5QckmQ
         C6/1+30WM42Eb5HaV0xoEDDIHKU9uEhM0BYg7awqb5QYycrbLRfESCsD/g9StDkK3Xid
         cqpg==
X-Gm-Message-State: AOAM533laJTMBFZW6bH2/Pu2LpaLmCTESSzge4p4wUqbMhgweRyuCent
        lr7ZBwPi0giFTY2g154GRd9bKnQMeeRF893X9q7I0v0lP9Ztn71ek3mBJRKVvg3akmAJA/vbu77
        eyF8eLQE8Q+MTRlA1m34Du4pe
X-Received: by 2002:a17:907:9491:: with SMTP id dm17mr16092045ejc.520.1625579064817;
        Tue, 06 Jul 2021 06:44:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9RrhrIXK4HIIR1Pibe4/In21DTRjgbvaA8upkBqLZuBNsIBTFNx/Eyp5gadwqw3D0JpIbQA==
X-Received: by 2002:a17:907:9491:: with SMTP id dm17mr16092007ejc.520.1625579064580;
        Tue, 06 Jul 2021 06:44:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p8sm1167072eds.15.2021.07.06.06.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 06:44:24 -0700 (PDT)
Subject: Re: [RFC PATCH v2 16/69] KVM: x86/mmu: Zap only leaf SPTEs for
 deleted/moved memslot by default
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <78d02fee3a21741cc26f6b6b2fba258cd52f2c3c.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ef7f4e7-cfda-98fe-dd3e-1b084ef86bd4@redhat.com>
Date:   Tue, 6 Jul 2021 15:44:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <78d02fee3a21741cc26f6b6b2fba258cd52f2c3c.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Zap only leaf SPTEs when deleting/moving a memslot by default, and add a
> module param to allow reverting to the old behavior of zapping all SPTEs
> at all levels and memslots when any memslot is updated.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 8d5876dfc6b7..5b8a640f8042 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -85,6 +85,9 @@ __MODULE_PARM_TYPE(nx_huge_pages_recovery_ratio, "uint");
>   static bool __read_mostly force_flush_and_sync_on_reuse;
>   module_param_named(flush_on_reuse, force_flush_and_sync_on_reuse, bool, 0644);
>   
> +static bool __read_mostly memslot_update_zap_all;
> +module_param(memslot_update_zap_all, bool, 0444);
> +
>   /*
>    * When setting this variable to true it enables Two-Dimensional-Paging
>    * where the hardware walks 2 page tables:
> @@ -5480,11 +5483,27 @@ static bool kvm_has_zapped_obsolete_pages(struct kvm *kvm)
>   	return unlikely(!list_empty_careful(&kvm->arch.zapped_obsolete_pages));
>   }
>   
> +static void kvm_mmu_zap_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
> +{
> +	/*
> +	 * Zapping non-leaf SPTEs, a.k.a. not-last SPTEs, isn't required, worst
> +	 * case scenario we'll have unused shadow pages lying around until they
> +	 * are recycled due to age or when the VM is destroyed.
> +	 */
> +	write_lock(&kvm->mmu_lock);
> +	slot_handle_level(kvm, slot, kvm_zap_rmapp, PG_LEVEL_4K,
> +			  KVM_MAX_HUGEPAGE_LEVEL, true);
> +	write_unlock(&kvm->mmu_lock);
> +}
> +
>   static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
>   			struct kvm_memory_slot *slot,
>   			struct kvm_page_track_notifier_node *node)
>   {
> -	kvm_mmu_zap_all_fast(kvm);
> +	if (memslot_update_zap_all)
> +		kvm_mmu_zap_all_fast(kvm);
> +	else
> +		kvm_mmu_zap_memslot(kvm, slot);
>   }
>   
>   void kvm_mmu_init_vm(struct kvm *kvm)
> 

This is the old patch that broke VFIO for some unknown reason.  The 
commit message should at least say why memslot_update_zap_all is not 
true by default.  Also, IIUC the bug still there with NX hugepage splits 
disabled, but what if the TDP MMU is enabled?

Paolo

