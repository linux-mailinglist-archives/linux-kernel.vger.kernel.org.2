Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2DA36E578
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbhD2HDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237215AbhD2HDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619679766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZ2o/KezshQ3s8sCIRalLHQIdE/FL4CqZWe7FVkZ9EE=;
        b=dgm3hVWwkvxLAKS/F2Vr4zK6Bx2oJvslEhvsOrbNq0/KFLX3hwkufLfvkNXNnOVXnAvpdv
        eeqfLte4thnik8ZjkwNQgbfaJjMni/VfNbnBGpdMHbp1MTHy676iPkffTpzvrGMespt+K6
        Qe47tyVrAmQBlkCcTiK4sqkTJqKc67M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-hS6f9BI9O_GHggKr4wocFg-1; Thu, 29 Apr 2021 03:02:43 -0400
X-MC-Unique: hS6f9BI9O_GHggKr4wocFg-1
Received: by mail-ej1-f71.google.com with SMTP id bi3-20020a170906a243b02903933c4d9132so1609480ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZ2o/KezshQ3s8sCIRalLHQIdE/FL4CqZWe7FVkZ9EE=;
        b=p7gdCXZ9U1Pdi8AM4F//fwKcsC+OHp7PiNorm2tQCIyl8HIq/P0C3rFKF/NdPHGJs4
         BVZqgqBEfrr3bfUrwPfDnxT/QGEeAKQ3kdPncPbJct+s9Sv8QyJr4dg3/aw5i7HS+jBS
         wXYPvNBDuxU7VWYWPNzFdz4wHwcA5aq0OlhzEVYBnPZ5gLPtBkbcDOhc1cpam34WuKlX
         AiMx2XlCq9uEp1Ci0Ng/tyqsrBcmTNyIaw+PrCT+7SEmEpGMp5dy28gPjlPRn/13DUcQ
         32RI6YYovVUbnsO+OJ+1GS6xX9kr0IYfsowIDlYlV4irQst1TnKeXnFE0cNr79WgD92e
         OqYQ==
X-Gm-Message-State: AOAM532h9YtpUteBlPmhGQIVIaRfvK1mPaxgXMfayucf2nQHiiHQoI1N
        XQ0XXeXJI1zo3ka380bkuolSdwptdIU1sqw9amSKtw8ipKGF/DDB9bQrWm280yps2dNgQmlAID+
        JBZIu63pkEtqZierPgDp8B0lC
X-Received: by 2002:a17:906:4d8d:: with SMTP id s13mr271892eju.37.1619679762764;
        Thu, 29 Apr 2021 00:02:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQO6zVuK/9mdURJ4nRGjsTW6eznsN5Bs+Xz5YGyi2vHuoRxwoF2gSsPE1agXie+E0ub1kMKg==
X-Received: by 2002:a17:906:4d8d:: with SMTP id s13mr271861eju.37.1619679762524;
        Thu, 29 Apr 2021 00:02:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id x7sm1672865eds.11.2021.04.29.00.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 00:02:41 -0700 (PDT)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ben Gardon <bgardon@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210427223635.2711774-1-bgardon@google.com>
 <20210427223635.2711774-6-bgardon@google.com>
 <997f9fe3-847b-8216-c629-1ad5fdd2ffae@redhat.com>
 <CANgfPd8RZXQ-BamwQPS66Q5hLRZaDFhi0WaA=ZvCP4BbofiUhg@mail.gmail.com>
 <d936b13b-bb00-fc93-de3b-adc59fa32a7b@redhat.com>
 <CANgfPd9kVJOAR_uq+oh9kE2gr00EUAGSPiJ9jMR9BdG2CAC+BA@mail.gmail.com>
 <5b4a0c30-118c-da1f-281c-130438a1c833@redhat.com>
 <CANgfPd_S=LjEs+s2UzcHZKfUHf+n498eSbfidpXNFXjJT8kxzw@mail.gmail.com>
 <16b2f0f3-c9a8-c455-fff0-231c2fe04a8e@redhat.com>
 <YIoAixSoRsM/APgx@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/6] KVM: x86/mmu: Protect kvm->memslots with a mutex
Message-ID: <623c2305-91ae-4617-357e-fe7d9147b656@redhat.com>
Date:   Thu, 29 Apr 2021 09:02:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YIoAixSoRsM/APgx@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/21 02:40, Sean Christopherson wrote:
> On Thu, Apr 29, 2021, Paolo Bonzini wrote:
>> it's not ugly and it's still relatively easy to explain.
> 
> LOL, that's debatable.

 From your remark below it looks like we have different priorities on 
what to avoid modifying.

I like the locks to be either very coarse or fine-grained enough for 
them to be leaves, as I find that to be the easiest way to avoid 
deadlocks and complex hierarchies.  For this reason, I treat unlocking 
in the middle of a large critical section as "scary by default"; you 
have to worry about which invariants might be required (in the case of 
RCU, which pointers might be stored somewhere and would be invalidated), 
and which locks are taken at that point so that the subsequent relocking 
would change the lock order from AB to BA.

This applies to every path leading to the unlock/relock.  So instead 
what matters IMO is shielding architecture code from the races that Ben 
had to point out to me, _and the possibility to apply easily explained 
rules_ outside more complex core code.

So, well, "relatively easy" because it's indeed subtle.  But if you 
consider what the locking rules are, "you can choose to protect 
slots->arch data with this mutex and it will have no problematic 
interactions with the memslot copy/update code" is as simple as it can get.

>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 2799c6660cce..48929dd5fb29 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -1377,16 +1374,17 @@ static int kvm_set_memslot(struct kvm *kvm,
>>   		goto out_slots;
>>   	update_memslots(slots, new, change);
>> -	slots = install_new_memslots(kvm, as_id, slots);
>> +	install_new_memslots(kvm, as_id, slots);
>>   	kvm_arch_commit_memory_region(kvm, mem, old, new, change);
>> -
>> -	kvfree(slots);
>>   	return 0;
>>   out_slots:
>> -	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE)
>> +	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
>> +		slot = id_to_memslot(slots, old->id);
>> +		slot->flags &= ~KVM_MEMSLOT_INVALID;
> 
> Modifying flags on an SRCU-protect field outside of said protection is sketchy.
> It's probably ok to do this prior to the generation update, emphasis on
> "probably".  Of course, the VM is also likely about to be killed in this case...
> 
>>   		slots = install_new_memslots(kvm, as_id, slots);
> 
> This will explode if memory allocation for KVM_MR_MOVE fails.  In that case,
> the rmaps for "slots" will have been cleared by kvm_alloc_memslot_metadata().

I take your subsequent reply as a sort-of-review that the above approach 
works, though we may disagree on its elegance and complexity.

Paolo

> The SRCU index is already tracked in vcpu->srcu_idx, why not temporarily drop
> the SRCU lock if activate_shadow_mmu() needs to do work so that it can take
> slots_lock?  That seems simpler and I think would avoid modifying the common
> memslot code.
>
> kvm_arch_async_page_ready() is the only path for reaching kvm_mmu_reload() that
> looks scary, but that should be impossible to reach with the correct MMU context.
> We could always and an explicit sanity check on the rmaps being avaiable.

