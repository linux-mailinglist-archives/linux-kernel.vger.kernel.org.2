Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E8D357056
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353604AbhDGPab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353563AbhDGPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617809418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHuby28rSVBEts9hw5b8nEC5zGAh17eoAFfYGcwxu7Q=;
        b=g2AgWffpn6TO+hohi/KwachzJcLKc8nwRf+xbuNds2r5tLGItbf5tJpit5VIF7oxb6MPR8
        X4e2gC22ibsysWraW/OYUspBU0LY4j0j48ccQOjRHX/a0/yJVz2hHn9LIockHAjuARdSKJ
        OfqWPQzcDMMzR+v4pLFwg40rNvxm2Z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-H2GLtm1WMquhgnK143jYrw-1; Wed, 07 Apr 2021 11:30:14 -0400
X-MC-Unique: H2GLtm1WMquhgnK143jYrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08789107ACF2;
        Wed,  7 Apr 2021 15:30:12 +0000 (UTC)
Received: from [10.36.114.68] (ovpn-114-68.ams2.redhat.com [10.36.114.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B45419C78;
        Wed,  7 Apr 2021 15:30:06 +0000 (UTC)
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
References: <20210327152324.GA28167@arm.com> <20210328122131.GB17535@arm.com>
 <e0b88560-34e1-dcc4-aaa7-9a7a5b771824@arm.com>
 <20210330103013.GD18075@arm.com>
 <8977120b-841d-4882-2472-6e403bc9c797@redhat.com>
 <20210331092109.GA21921@arm.com>
 <d545a051-a02a-4c3a-0afe-66612839ba32@redhat.com>
 <86a968c8-7a0e-44a4-28c3-bac62c2b7d65@arm.com>
 <20210331184311.GA10737@arm.com>
 <e2612bd8-b356-a9cd-cfdf-26f4aa813578@arm.com>
 <20210407151458.GC21451@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v10 2/6] arm64: kvm: Introduce MTE VM feature
Message-ID: <396423df-5c30-67f6-fcba-c041c08eef7e@redhat.com>
Date:   Wed, 7 Apr 2021 17:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407151458.GC21451@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.21 17:14, Catalin Marinas wrote:
> On Wed, Apr 07, 2021 at 11:20:18AM +0100, Steven Price wrote:
>> On 31/03/2021 19:43, Catalin Marinas wrote:
>>> When a slot is added by the VMM, if it asked for MTE in guest (I guess
>>> that's an opt-in by the VMM, haven't checked the other patches), can we
>>> reject it if it's is going to be mapped as Normal Cacheable but it is a
>>> ZONE_DEVICE (i.e. !kvm_is_device_pfn() + one of David's suggestions to
>>> check for ZONE_DEVICE)? This way we don't need to do more expensive
>>> checks in set_pte_at().
>>
>> The problem is that KVM allows the VMM to change the memory backing a slot
>> while the guest is running. This is obviously useful for the likes of
>> migration, but ultimately means that even if you were to do checks at the
>> time of slot creation, you would need to repeat the checks at set_pte_at()
>> time to ensure a mischievous VMM didn't swap the page for a problematic one.
> 
> Does changing the slot require some KVM API call? Can we intercept it
> and do the checks there?

User space can simply mmap(MAP_FIXED) the user space area registered in 
a KVM memory slot. You cannot really intercept that. You can only check 
in the KVM MMU code at fault time that the VMA which you hold in your 
hands is still in a proper state. The KVM MMU is synchronous, which 
means that updates to the VMA layout are reflected in the KVM MMU page 
tables -- e.g., via mmu notifier calls.

E.g., in s390x code we cannot handle VMAs with gigantic pages. We check 
that when faulting (creating the links in the page table) via __gmap_link().

You could either check the page itself (ZONE_DEVICE) or might even be 
able to check via the VMA/file.

-- 
Thanks,

David / dhildenb

