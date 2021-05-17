Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047D238344B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241522AbhEQPHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:07:02 -0400
Received: from foss.arm.com ([217.140.110.172]:54446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239476AbhEQO5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:57:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19BD2106F;
        Mon, 17 May 2021 07:56:36 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815AE3F73B;
        Mon, 17 May 2021 07:56:33 -0700 (PDT)
Subject: Re: [PATCH v12 1/8] arm64: mte: Handle race when synchronising tags
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
 <20210517123239.8025-2-steven.price@arm.com> <87cztpv4mo.wl-maz@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <37fe19b5-6494-41c5-e541-ddc873a82be0@arm.com>
Date:   Mon, 17 May 2021 15:56:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87cztpv4mo.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2021 15:03, Marc Zyngier wrote:
> Hi Steven,

Hi Marc,

> On Mon, 17 May 2021 13:32:32 +0100,
> Steven Price <steven.price@arm.com> wrote:
>>
>> mte_sync_tags() used test_and_set_bit() to set the PG_mte_tagged flag
>> before restoring/zeroing the MTE tags. However if another thread were to
>> race and attempt to sync the tags on the same page before the first
>> thread had completed restoring/zeroing then it would see the flag is
>> already set and continue without waiting. This would potentially expose
>> the previous contents of the tags to user space, and cause any updates
>> that user space makes before the restoring/zeroing has completed to
>> potentially be lost.
>>
>> Since this code is run from atomic contexts we can't just lock the page
>> during the process. Instead implement a new (global) spinlock to protect
>> the mte_sync_page_tags() function.
>>
>> Fixes: 34bfeea4a9e9 ("arm64: mte: Clear the tags when a page is mapped in user-space with PROT_MTE")
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>> ---
>>  arch/arm64/kernel/mte.c | 21 ++++++++++++++++++---
>>  1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 125a10e413e9..c88e778c2fa9 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -25,6 +25,7 @@
>>  u64 gcr_kernel_excl __ro_after_init;
>>  
>>  static bool report_fault_once = true;
>> +static spinlock_t tag_sync_lock;
> 
> What initialises this spinlock? Have you tried this with lockdep? I'd
> expect it to be defined with DEFINE_SPINLOCK(), which always does the
> right thing.

You of course are absolute right, and this will blow up with lockdep.
Sorry about that. DEFINE_SPINLOCK() solves the problem.

Thanks,

Steve
