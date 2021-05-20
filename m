Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9921B38AA84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbhETLOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:14:18 -0400
Received: from foss.arm.com ([217.140.110.172]:46368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237414AbhETKxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:53:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EDCD150C;
        Thu, 20 May 2021 03:52:16 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C18FE3F719;
        Thu, 20 May 2021 03:52:12 -0700 (PDT)
Subject: Re: [PATCH v12 8/8] KVM: arm64: Document MTE capability and ioctl
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-9-steven.price@arm.com> <87r1i5teou.wl-maz@kernel.org>
 <3b4cca00-e81d-322e-6f65-4d0850aac5a5@arm.com> <871ra1vh2s.wl-maz@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <3e9f2388-89fe-f762-8e59-03f4d70320fc@arm.com>
Date:   Thu, 20 May 2021 11:52:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <871ra1vh2s.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2021 11:24, Marc Zyngier wrote:
> On Wed, 19 May 2021 15:09:23 +0100,
> Steven Price <steven.price@arm.com> wrote:
>>
>> On 17/05/2021 19:09, Marc Zyngier wrote:
>>> On Mon, 17 May 2021 13:32:39 +0100,
>>> Steven Price <steven.price@arm.com> wrote:
[...]>>>> +bytes (i.e. 1/16th of the corresponding size). Each byte
contains a single tag
>>>> +value. This matches the format of ``PTRACE_PEEKMTETAGS`` and
>>>> +``PTRACE_POKEMTETAGS``.
>>>> +
>>>>  5. The kvm_run structure
>>>>  ========================
>>>>  
>>>> @@ -6362,6 +6396,25 @@ default.
>>>>  
>>>>  See Documentation/x86/sgx/2.Kernel-internals.rst for more details.
>>>>  
>>>> +7.26 KVM_CAP_ARM_MTE
>>>> +--------------------
>>>> +
>>>> +:Architectures: arm64
>>>> +:Parameters: none
>>>> +
>>>> +This capability indicates that KVM (and the hardware) supports exposing the
>>>> +Memory Tagging Extensions (MTE) to the guest. It must also be enabled by the
>>>> +VMM before the guest will be granted access.
>>>> +
>>>> +When enabled the guest is able to access tags associated with any memory given
>>>> +to the guest. KVM will ensure that the pages are flagged ``PG_mte_tagged`` so
>>>> +that the tags are maintained during swap or hibernation of the host; however
>>>> +the VMM needs to manually save/restore the tags as appropriate if the VM is
>>>> +migrated.
>>>> +
>>>> +When enabled the VMM may make use of the ``KVM_ARM_MTE_COPY_TAGS`` ioctl to
>>>> +perform a bulk copy of tags to/from the guest.
>>>> +
>>>
>>> Missing limitation to AArch64 guests.
>>
>> As mentioned previously it's not technically limited to AArch64, but
>> I'll expand this to make it clear that MTE isn't usable from a AArch32 VCPU.
> 
> I believe the architecture is quite clear that it *is* limited to
> AArch64. The clarification is welcome though.

I explained that badly. A system supporting MTE doesn't have to have all
CPUs running AArch64 - fairly obviously you can boot a 32 bit OS on a
system supporting AArch64.

Since the KVM capability is a VM capability it's not architecturally
inconsistent to enable it even if all your CPUs are running AArch32 (at
EL1 and lower) - just a bit pointless.

However, given your comment that a mixture of AArch32/AArch64 VCPUs is a
bug - we can fail creation of AArch32 VCPUs and I'll explicitly document
this is a AArch64 only feature.

Thanks,

Steve
