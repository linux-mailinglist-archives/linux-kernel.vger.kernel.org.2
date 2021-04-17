Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B10836300D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhDQMvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 08:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236432AbhDQMvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 08:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618663843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaTcXtyBPdVI0SxVxqAEtYLRW7IktHO5BV2EA4cxMMo=;
        b=Bcqvam9hlgHPTppmncGY7y4QsgDV0C2LENLVdl+Guc5XAw7A2qaUg9e6TaTZk4DW31tkBR
        JEavMRFiP3lB+pPwgLJy38GDLJk4jMR9EMDtOK8pSDOsRLWmK/Rppd3fRnXEmYTRGg91R9
        BcH0AGzWc37n2CqfyoGBjIloduS/Hqk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-2wBepw0jPlS2kDFycCEwLQ-1; Sat, 17 Apr 2021 08:50:41 -0400
X-MC-Unique: 2wBepw0jPlS2kDFycCEwLQ-1
Received: by mail-ed1-f72.google.com with SMTP id c15-20020a056402100fb029038518e5afc5so1025479edu.18
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 05:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZaTcXtyBPdVI0SxVxqAEtYLRW7IktHO5BV2EA4cxMMo=;
        b=c4k9nOec3dAvtR1fEp5s3GN8O7Pz4p+m9fpaU8qN/lgZ1sBonj2wC1EqWxwTb1Q+T9
         5sCzbte+oayVkWn8uZaIvDER29u9E7R5CP5PNDz3QH2ffHYcwUKc0fOYqQ+/+7kT1J88
         IM5QoxunjF7pR2Y3pVCYqRmEgkP1EO31Fjs5c+cUcojbS0jV1Z+RcTXQu6yTiUeNNORD
         2V1i0aCo39VKE3tiX636vMHnZz2IODDpfXqEL8hKRKGS67BbEqs/JZakfy7lBAGim0pr
         WTEpAqSz4v6yMfOm9U3Q5nOqVDfckVlfiQFT070g8hqAPn08ZjRUUQdMZqJT/1XF4psO
         aWEQ==
X-Gm-Message-State: AOAM530kXjR9sRUmUVz/AH3/LxSVeBRjhQjNso9pV3+HW9uMQi/j0Kq3
        LLFJQ5cSty9/I0xZOI0Eb/HAOBUgbCedahO9gticQdhQtL7rFxLVFboBS9IHD7L/g3oVAuzfnNt
        nkpkQaWGELsAcb7e8DtDx3ieK
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr12667254ejz.259.1618663840298;
        Sat, 17 Apr 2021 05:50:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIf7mi5DtpN2IQG233RbYf3mpawFrXCI+aHZoFvdgJevu/Q4WnkMS+P//lsbO1vapOn52cTg==
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr12667244ejz.259.1618663840159;
        Sat, 17 Apr 2021 05:50:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f20sm3141726ejw.36.2021.04.17.05.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 05:50:39 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Remove unused function declaration
To:     Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     wanghaibin.wang@huawei.com, jiangkunkun@huawei.com
References: <20210406063504.17552-1-zhukeqian1@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ceed9a2-fa5a-0b47-d4c2-8b16c1ef100a@redhat.com>
Date:   Sat, 17 Apr 2021 14:50:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210406063504.17552-1-zhukeqian1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/21 08:35, Keqian Zhu wrote:
> kvm_mmu_slot_largepage_remove_write_access() is decared but not used,
> just remove it.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>   arch/x86/include/asm/kvm_host.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 3768819693e5..9c0af0971c9f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1440,8 +1440,6 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
>   				   const struct kvm_memory_slot *memslot);
>   void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
>   				   struct kvm_memory_slot *memslot);
> -void kvm_mmu_slot_largepage_remove_write_access(struct kvm *kvm,
> -					struct kvm_memory_slot *memslot);
>   void kvm_mmu_zap_all(struct kvm *kvm);
>   void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
>   unsigned long kvm_mmu_calculate_default_mmu_pages(struct kvm *kvm);
> 

Queued, thanks.

Paolo

