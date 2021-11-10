Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A549644CCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhKJWrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:47:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233583AbhKJWrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636584299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSmqrlgPiKChWo5c33MTnXOthA4T/vd9DTc7OgLD2e4=;
        b=ZZRMne158GhvkdSE5lhBQuAf1QkhI+SJbA1dSD7lU3qZSxNbxOoNMiSBmUfN76k5qReL/A
        yinDdQeoAZKvuDLyqPkguXmxdZwPULAdvwjSHK9AiszdM+PPTS5wj977lqnyLl2HsZPZDw
        oi99N+kFHx/jt90JAHLIxa+3QxGzTSU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-uxxCQDg8MDOSTEZaB_KW8A-1; Wed, 10 Nov 2021 17:44:57 -0500
X-MC-Unique: uxxCQDg8MDOSTEZaB_KW8A-1
Received: by mail-ed1-f71.google.com with SMTP id h13-20020a05640250cd00b003e35ea5357fso3689286edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uSmqrlgPiKChWo5c33MTnXOthA4T/vd9DTc7OgLD2e4=;
        b=egQfpwnvnnIs/jJr6EWUxW50umRkghStvWhSxWgqP2d+C91NLnueQAeTFGPTjsQ0U1
         edtL5cYSXgB+wP73Pgh3oFxzVyEDS+dYCPW77XjD+5OqUzwhkQGxvE8BL7UmWsfvxzIk
         kpTEcE9/Gik7EQnASf8FEjwNgXtTRiOCI00nAxGz+eQFk9VydFIRHUNfEc4pHNvatHRy
         LBUy0x7VhTlmuTjuqxU2DCW9k9F2UocO2SpLhn+B7L06jzvP2+og56jKSzudwtwDwSZq
         k415E8Xwi5NdPE34jrwLfL/+8alfvoXhHa4BnZRB6RAq+UTYw1usBd38nOXxQ7AmzP4n
         yViA==
X-Gm-Message-State: AOAM531MFE122sqfYWW+Ep6VL5r/ksI6xOnx0V69NfYMaxxRquHTS2T1
        TiFc2tIO8OnDFx/2XthTwmmjS48ByaNTwQidmgps8kBED/5me5OMXOFMloC/16pf/h/0GI8Ur5R
        7CMf60iJdW7l8BIsh1wY90TAB
X-Received: by 2002:a17:907:3ea7:: with SMTP id hs39mr3581485ejc.164.1636584296670;
        Wed, 10 Nov 2021 14:44:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzqO8sPtFDtNmiynR1h4PWHzluTQnK55FNEyoRgrmsJDHLh7W+j4c0z6fxQPp/wGsRhNBveQ==
X-Received: by 2002:a17:907:3ea7:: with SMTP id hs39mr3581448ejc.164.1636584296430;
        Wed, 10 Nov 2021 14:44:56 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id go10sm452325ejc.115.2021.11.10.14.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 14:44:55 -0800 (PST)
Message-ID: <80407e4a-36e1-e606-ed9f-74429f850e77@redhat.com>
Date:   Wed, 10 Nov 2021 23:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 11/19] KVM: x86/mmu: Factor shadow_zero_check out of
 make_spte
Content-Language: en-US
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>
References: <20211110223010.1392399-1-bgardon@google.com>
 <20211110223010.1392399-12-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211110223010.1392399-12-bgardon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 23:30, Ben Gardon wrote:
> -	WARN_ONCE(is_rsvd_spte(&vcpu->arch.mmu->shadow_zero_check, spte, level),
> +	WARN_ONCE(is_rsvd_spte(shadow_zero_check, spte, level),
>   		  "spte = 0x%llx, level = %d, rsvd bits = 0x%llx", spte, level,
> -		  get_rsvd_bits(&vcpu->arch.mmu->shadow_zero_check, spte, level));
> +		  get_rsvd_bits(shadow_zero_check, spte, level));

Hmm, there is a deeper issue here, in that when using EPT/NPT (on either 
the legacy aka shadow or the TDP MMU) large parts of vcpu->arch.mmu are 
really the same for all vCPUs.  The only thing that varies is those 
parts that actually depend on the guest's paging mode---the extended 
role, the reserved bits, etc.  Those are needed by the emulator, but 
don't really belong in vcpu->arch.mmu when EPT/NPT is in use.

I wonder if there's room for splitting kvm_mmu in two parts, such as 
kvm_mmu and kvm_guest_paging_context, and possibly change the walk_mmu 
pointer into a pointer to kvm_guest_paging_context.  This way the 
EPT/NPT MMU (again either shadow or TDP) can be moved to kvm->arch.  It 
should simplify this series and also David's work on eager page splitting.

I'm not asking you to do this, of course, but perhaps I can trigger 
Sean's itch to refactor stuff. :)

Paolo

