Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABB5351311
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhDAKM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233504AbhDAKM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617271976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xVtkud0FGFVllFbRHTCHeF0n3q4DIXws1lAIbt6JHY=;
        b=HB7UhLvKBMuybS0aiPHeHkQmKFAXvNaSQA5FycxENHGoJJiFsXPrcWfhxYjVUnjDkivEdF
        73CqbYoHYw+M/xgAe1Y4xKsWrJ8sR99hJtJSAG+rnMG3WQyixkcHWhM9JM2Yj4xi17t7Lp
        JE+1nTWpxl2g597RPDsOQsHcaKB/R9M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-MGOx6_eqMBmRIDuu4GNsww-1; Thu, 01 Apr 2021 06:12:55 -0400
X-MC-Unique: MGOx6_eqMBmRIDuu4GNsww-1
Received: by mail-ed1-f69.google.com with SMTP id v27so2606055edx.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 03:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0xVtkud0FGFVllFbRHTCHeF0n3q4DIXws1lAIbt6JHY=;
        b=m8TIN3u/hex+KU9ZFuHn8SE54tRLHlqw6ou62cPDSdLL4SleVjcuzSVPyvfYENSG9k
         dbGBSN5BMvnuMVUjD7zn7N6WfVpYrCF3amyUDHHNtAJjE2plFxxfOCio8KcJqXfp4v2E
         iqxanVZRBCSimFMfW7NTF4TXu2wnZiwx70TY/s6OwqOtEG6vgfOwuXbBTzsPJJwpQ/K9
         IvFEKN0cfCJLwVvcDtG6aPxeOimafBIx3exu29QStyyi37bFlxpu9Z9lhhdU0Orul3tv
         U5N12S2kC/v9AIawBBNCJ8G6ruAu5cIzcxnmnPYSuHTtg1/6t/6wCnomyXt/5f7BeD7b
         dopA==
X-Gm-Message-State: AOAM532DjCiD2TlScyYVWMscylQkZtPmClqXyHZuA1bbRFXCACnKSU2N
        jCrO28C+OEA3G/uVQiJiwYt72rI2FFi+NNigiJXhFwEMe+wnVDad1lDcBpv7jku2pV3M/TgZAML
        aeJFU8BheD0mY6dLNZD75G2AC
X-Received: by 2002:a05:6402:375:: with SMTP id s21mr8925789edw.287.1617271974373;
        Thu, 01 Apr 2021 03:12:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybUDAIY2pZzNujL1X/TNW7x2ha+e8W7ahPYGzrvN5rd/bAcBeSWCPMWWfNv5LJZC8H7IIMKQ==
X-Received: by 2002:a05:6402:375:: with SMTP id s21mr8925778edw.287.1617271974245;
        Thu, 01 Apr 2021 03:12:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id hy13sm2526147ejc.32.2021.04.01.03.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 03:12:53 -0700 (PDT)
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210331210841.3996155-1-bgardon@google.com>
 <20210331210841.3996155-11-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 10/13] KVM: x86/mmu: Allow zapping collapsible SPTEs to
 use MMU read lock
Message-ID: <51034a41-2d03-103e-6c11-1ed27a952de2@redhat.com>
Date:   Thu, 1 Apr 2021 12:12:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210331210841.3996155-11-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/21 23:08, Ben Gardon wrote:
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index dcbfc784cf2f..81967b4e7d76 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5610,10 +5610,13 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
>   
>   	write_lock(&kvm->mmu_lock);
>   	slot_handle_leaf(kvm, slot, kvm_mmu_zap_collapsible_spte, true);
> -
> -	if (is_tdp_mmu_enabled(kvm))
> -		kvm_tdp_mmu_zap_collapsible_sptes(kvm, slot);
>   	write_unlock(&kvm->mmu_lock);
> +
> +	if (is_tdp_mmu_enabled(kvm)) {
> +		read_lock(&kvm->mmu_lock);
> +		kvm_tdp_mmu_zap_collapsible_sptes(kvm, memslot);
> +		read_unlock(&kvm->mmu_lock);
> +	}
>   }

Same here, this will conflict with

KVM: x86/mmu: Coalesce TLB flushes when zapping collapsible SPTEs

Again, you will have to add back some "if (flush)" before the write_unlock.

Paolo

