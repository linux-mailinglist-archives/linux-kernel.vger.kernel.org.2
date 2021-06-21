Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B117C3AE4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFUIUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:20:51 -0400
Received: from foss.arm.com ([217.140.110.172]:58222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFUIUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:20:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DA03D6E;
        Mon, 21 Jun 2021 01:18:35 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D6FA3F718;
        Mon, 21 Jun 2021 01:18:32 -0700 (PDT)
Subject: Re: [PATCH v16 7/7] KVM: arm64: Document MTE capability and ioctl
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
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
        Andrew Jones <drjones@redhat.com>
References: <20210618132826.54670-1-steven.price@arm.com>
 <20210618132826.54670-8-steven.price@arm.com>
 <20210618145241.GG16116@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1273c642-d2b0-b81d-2052-1f2f0deafdae@arm.com>
Date:   Mon, 21 Jun 2021 09:18:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618145241.GG16116@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2021 15:52, Catalin Marinas wrote:
> On Fri, Jun 18, 2021 at 02:28:26PM +0100, Steven Price wrote:
>> +When this capability is enabled all memory in (non-device) memslots must not
>> +used VM_SHARED, attempts to create a memslot with a VM_SHARED mmap will result
>> +in an -EINVAL return.
> 
> "must not used" doesn't sound right. Anyway, I'd remove VM_SHARED as
> that's a kernel internal and not something the VMM needs to be aware of.
> Just say something like "memslots must be mapped as shareable
> (MAP_SHARED)".

I think I meant "must not use" - and indeed memslots must *not* be
mapped as shareable. I'll update to this wording:

  When this capability is enabled all memory in memslots must be mapped as
  not-shareable (no MAP_SHARED), attempts to create a memslot with MAP_SHARED
  will result in an -EINVAL return.

> Otherwise:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 

Thanks,

Steve
