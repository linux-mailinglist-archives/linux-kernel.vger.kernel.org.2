Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7189E42DD27
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhJNPEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233450AbhJNPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634223672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BV6Kd3R3Kt6LrQLx9d+NO1qhe9aTARiaeLS4GPhJYpo=;
        b=ZRA1X0JP2s4Mqz9B9V8gmq3eWE39E+3H7fKk1SxmAXID1ceUkfF0rb9kT1Y88WqbvQD1P3
        bkhNwOSyYy3Eo5sADA2KH5QPPFNbfPuzxs3HPaQW0Y28/pveeMv46Xi7Fs6nh9EwOATLMD
        R3WD+84NR2bjj8j5IQCfQDJOvGekMNE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-Fp0cxk7uPj-pmu_Nc-8NWA-1; Thu, 14 Oct 2021 11:01:10 -0400
X-MC-Unique: Fp0cxk7uPj-pmu_Nc-8NWA-1
Received: by mail-ed1-f72.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so5409975edi.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BV6Kd3R3Kt6LrQLx9d+NO1qhe9aTARiaeLS4GPhJYpo=;
        b=lJfNWqczAKel++DlE7vKZl5S39yYedzHp9zvBSWr7okoZFFxe22Euiapm3xF6+8pJl
         qeLZLLlr8XS3oniEx7HVUzzu19PFbCGzVKaYFUrdDA+vIIg+WXQj6XdC/igNsJM+T9x4
         jKL5hPp1ptGEsglvtZEmA+lWTkBDprz4y0JGNpkqSdVVHCnJLjreQoYBC3Ck3YsEL32C
         hTt+hJDa3kqYWfjACiefrHiWQ4eGoPX7cL7vder0LymyV0yY0bJx53ClzE+lXIb+EPWq
         HolGHyxM+pVX6sOEFAlJo4n3AgWgrD41xS/yjzTLf274ob/0I/pkWwd1n+Wxs/eN9K5G
         SOZQ==
X-Gm-Message-State: AOAM532a14yJLReJ7eABbbkH/92jg960JapWEJ6ElOre8Ji7I04HXEuA
        AVMHchzdVin8KGjXUD8OKpIu3tQ7u1rBEqcBJopirH7mWiKmB6WzGwz3garPqfeLqvkc9EHblGS
        P+jc0WYeRf0nTC9+Gd2d/sykW
X-Received: by 2002:a50:998c:: with SMTP id m12mr3780750edb.19.1634223669423;
        Thu, 14 Oct 2021 08:01:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/kumyD1nCd6HHxZ5qlo0XqFX2FzJz/D5ZoqyFmP6ecJh0K9W8g1aRg2kwr1pTZGSQtBhffg==
X-Received: by 2002:a50:998c:: with SMTP id m12mr3780721edb.19.1634223669117;
        Thu, 14 Oct 2021 08:01:09 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id kw10sm2221355ejc.71.2021.10.14.08.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:01:08 -0700 (PDT)
Message-ID: <3997787e-402d-4b2b-0f90-4a672c77703f@redhat.com>
Date:   Thu, 14 Oct 2021 17:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [patch 13/31] x86/fpu: Move KVMs FPU swapping to FPU core
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Jing Liu <jing2.liu@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>
References: <871r4p9fyh.ffs@tglx>
 <ec9c761d-4b5c-71e2-c1fc-d256b6b78c04@redhat.com>
 <BL0PR11MB3252511FC48E43484DE79A3CA9B89@BL0PR11MB3252.namprd11.prod.outlook.com>
 <6bbc5184-a675-1937-eb98-639906a9cf15@redhat.com> <87wnmf66m5.ffs@tglx>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87wnmf66m5.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/21 16:09, Thomas Gleixner wrote:
> On Thu, Oct 14 2021 at 11:01, Paolo Bonzini wrote:
>> On 14/10/21 10:02, Liu, Jing2 wrote:
>> Based on the input from Andy and Thomas, the new way would be like this:
>>
>> 1) host_fpu must always be checked for reallocation in
>> kvm_load_guest_fpu (or in the FPU functions that it calls, that depends
>> on the rest of Thomas's patches).  That's because arch_prctl can enable
>> AMX for QEMU at any point after KVM_CREATE_VCPU.
> 
> No.
> 
>     1) QEMU starts
>     2) QEMU requests permissions via prctl()
>     3) QEMU creates vCPU threads
> 
> Doing it the other way around makes no sense at all and wont work.

Sure, but KVM needs to do something that makes sense even for userspaces 
that are not QEMU.

For example, there could be a program that uses AMX *itself* and does 
not expose it to the guest.  In that case, the arch_prctl can come at 
the point AMX is needed, which can be after the program creates vCPU 
threads.  That's for host_fpu.

For the guest_fpu, I agree that the arch_prctl must come before creating 
vCPUs.

>> 2) every use of vcpu->arch.guest_supported_xcr0 is changed to only
>> include those dynamic-feature bits that were enabled via arch_prctl.
>> That is, something like:
>>
>> static u64 kvm_guest_supported_cr0(struct kvm_vcpu *vcpu)
>> {
>> 	return vcpu->arch.guest_supported_xcr0 &
>> 		(~xfeatures_mask_user_dynamic | \
>> 		 current->thread.fpu.dynamic_state_perm);
> 
> Bah. You can't get enough from poking in internals, right?
> 
> vcpu_create()
> 
>    fpu_init_fpstate_user(guest_fpu, supported_xcr0)
> 
> That will (it does not today) do:
> 
>       guest_fpu::__state_perm = supported_xcr0 & xstate_get_group_perm();
> 
> The you have the information you need right in the guest FPU.

Good, I wasn't aware of the APIs that will be there.

>> int kvm_alloc_fpu_dynamic_features(struct kvm_vcpu *vcpu)
>> {
>> 	u64 allowed_dynamic = current->thread.fpu.dynamic_state_perm;
> 
> That's not a valid assumption.
> 
>> 	u64 enabled_dynamic =
>> 		vcpu->arch.xcr0 & xfeatures_mask_user_dynamic;
>>
>> 	/* All dynamic features have to be arch_prctl'd first.  */
>> 	WARN_ON_ONCE(enabled_dynamic & ~allowed_dynamic);
>>
>> 	if (!vcpu->arch.xfd_passthrough) {
>> 		/* All dynamic states will #NM?  Wait and see.  */
>> 		if ((enabled_dynamic & ~vcpu->arch.xfd) == 0)
>> 			return 0;
>>
>> 		kvm_x86_ops.enable_xfd_passthrough(vcpu);
>> 	}
>>
>> 	/* current->thread.fpu was already handled by arch_prctl.  */
> 
> No. current->thread.fpu has the default buffer unless QEMU used AMX or
> something forced it to allocate a larger buffer.
> 
>> 	return fpu_alloc_features(vcpu->guest_fpu,
>> 		vcpu->guest_fpu.dynamic_state_perm | enabled_dynamic);
> 
> This unconditionally calls into that allocation for every XCR0/XFD
> trap ?

Calls into the function, but doesn't necessarily allocate anything. 
What you wrote below looks correct to me, thanks.

Paolo

> Also you really should not wait until _all_ dynamic states are cleared
> in guest XFD.  Because a guest which has bit 18 and 19 available but only > uses one of them is going to trap on every other context switch due to
> XFD writes.

