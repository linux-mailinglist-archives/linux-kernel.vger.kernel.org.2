Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F195A358BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhDHSQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231676AbhDHSQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617905789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+ZAM3G9QEbZhESupLgtt9XPr4Jta/bTYgM9EuA2Thw=;
        b=F0c5YJiKvEgKZZoboH/bZx9WwMN/8NUIaGx3Lhxnq1D9qK+FdiHHLz2DPhzUThgiqrfjCq
        63CchNhZZH/OpPhXK1tiGkOFfOiz5+gDaQY7XUUUoO7CwO+8lFoXib+ZS7WfE0lD7EH4z0
        BtKlG/senbKLpz5cBOZS8tnyRB4d2qg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-v5LP_p_OOEqJQ2MwT-ujmw-1; Thu, 08 Apr 2021 14:16:27 -0400
X-MC-Unique: v5LP_p_OOEqJQ2MwT-ujmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA6E384B9A0;
        Thu,  8 Apr 2021 18:16:25 +0000 (UTC)
Received: from [10.36.113.26] (ovpn-113-26.ams2.redhat.com [10.36.113.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 542815C1C4;
        Thu,  8 Apr 2021 18:16:18 +0000 (UTC)
Subject: Re: [PATCH v10 2/6] arm64: kvm: Introduce MTE VM feature
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>, Haibo Xu <Haibo.Xu@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        qemu-devel@nongnu.org, Marc Zyngier <maz@kernel.org>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <e0b88560-34e1-dcc4-aaa7-9a7a5b771824@arm.com>
 <20210330103013.GD18075@arm.com>
 <8977120b-841d-4882-2472-6e403bc9c797@redhat.com>
 <20210331092109.GA21921@arm.com>
 <d545a051-a02a-4c3a-0afe-66612839ba32@redhat.com>
 <86a968c8-7a0e-44a4-28c3-bac62c2b7d65@arm.com>
 <20210331184311.GA10737@arm.com>
 <e2612bd8-b356-a9cd-cfdf-26f4aa813578@arm.com>
 <20210407151458.GC21451@arm.com>
 <5e5bf772-1e4d-ca59-a9d8-058a72dfad4f@arm.com>
 <20210408141853.GA7676@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <bfcd1c41-92fb-d4ee-34b1-7beb6b6c9fd8@redhat.com>
Date:   Thu, 8 Apr 2021 20:16:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210408141853.GA7676@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.21 16:18, Catalin Marinas wrote:
> On Wed, Apr 07, 2021 at 04:52:54PM +0100, Steven Price wrote:
>> On 07/04/2021 16:14, Catalin Marinas wrote:
>>> On Wed, Apr 07, 2021 at 11:20:18AM +0100, Steven Price wrote:
>>>> On 31/03/2021 19:43, Catalin Marinas wrote:
>>>>> When a slot is added by the VMM, if it asked for MTE in guest (I guess
>>>>> that's an opt-in by the VMM, haven't checked the other patches), can we
>>>>> reject it if it's is going to be mapped as Normal Cacheable but it is a
>>>>> ZONE_DEVICE (i.e. !kvm_is_device_pfn() + one of David's suggestions to
>>>>> check for ZONE_DEVICE)? This way we don't need to do more expensive
>>>>> checks in set_pte_at().
>>>>
>>>> The problem is that KVM allows the VMM to change the memory backing a slot
>>>> while the guest is running. This is obviously useful for the likes of
>>>> migration, but ultimately means that even if you were to do checks at the
>>>> time of slot creation, you would need to repeat the checks at set_pte_at()
>>>> time to ensure a mischievous VMM didn't swap the page for a problematic one.
>>>
>>> Does changing the slot require some KVM API call? Can we intercept it
>>> and do the checks there?
>>
>> As David has already replied - KVM uses MMU notifiers, so there's not really
>> a good place to intercept this before the fault.
>>
>>> Maybe a better alternative for the time being is to add a new
>>> kvm_is_zone_device_pfn() and force KVM_PGTABLE_PROT_DEVICE if it returns
>>> true _and_ the VMM asked for MTE in guest. We can then only set
>>> PG_mte_tagged if !device.
>>
>> KVM already has a kvm_is_device_pfn(), and yes I agree restricting the MTE
>> checks to only !kvm_is_device_pfn() makes sense (I have the fix in my branch
>> locally).
> 
> Indeed, you can skip it if kvm_is_device_pfn(). In addition, with MTE,
> I'd also mark a pfn as 'device' in user_mem_abort() if
> pfn_to_online_page() is NULL as we don't want to map it as Cacheable in
> Stage 2. It's unlikely that we'll trip over this path but just in case.
> 
> (can we have a ZONE_DEVICE _online_ pfn or by definition they are
> considered offline?)

By definition (and implementation) offline. When you get a page = 
pfn_to_online_page() with page != NULL, that one should never be 
ZONE_DEVICE (otherwise it would be a BUG).

As I said, things are different when exposing dax memory via dax/kmem to 
the buddy. But then, we are no longer talking about ZONE_DEVICE.

-- 
Thanks,

David / dhildenb

