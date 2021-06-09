Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DD53A0F22
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhFII6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:58:48 -0400
Received: from foss.arm.com ([217.140.110.172]:53490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233846AbhFII6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:58:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DAD811FB;
        Wed,  9 Jun 2021 01:56:51 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AA293F719;
        Wed,  9 Jun 2021 01:56:48 -0700 (PDT)
Subject: Re: [PATCH v14 2/8] arm64: Handle MTE tags zeroing in
 __alloc_zeroed_user_highpage()
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
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
References: <20210607110816.25762-1-steven.price@arm.com>
 <20210607110816.25762-3-steven.price@arm.com>
 <20210607170714.GA17957@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <7a3f14de-211b-94f9-6886-393d233193d5@arm.com>
Date:   Wed, 9 Jun 2021 09:56:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210607170714.GA17957@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2021 18:07, Catalin Marinas wrote:
> On Mon, Jun 07, 2021 at 12:08:10PM +0100, Steven Price wrote:
>> From: Catalin Marinas <catalin.marinas@arm.com>
>>
>> Currently, on an anonymous page fault, the kernel allocates a zeroed
>> page and maps it in user space. If the mapping is tagged (PROT_MTE),
>> set_pte_at() additionally clears the tags under a spinlock to avoid a
>> race on the page->flags. In order to optimise the lock, clear the page
>> tags on allocation in __alloc_zeroed_user_highpage() if the vma flags
>> have VM_MTE set.
>>
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> I think you can drop this patch now that Peter's series has been queued
> via the arm64 tree:
> 
> https://lore.kernel.org/r/20210602235230.3928842-4-pcc@google.com
> 

Thanks for the heads up - I hadn't seen that land. I'll drop this patch
from the next posting.

Steve
