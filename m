Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A883AE4C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFUIaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:30:11 -0400
Received: from foss.arm.com ([217.140.110.172]:58344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhFUIaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:30:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 644EDD6E;
        Mon, 21 Jun 2021 01:27:51 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B66793F718;
        Mon, 21 Jun 2021 01:27:48 -0700 (PDT)
Subject: Re: [PATCH v16 1/7] arm64: mte: Handle race when synchronising tags
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
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
 <20210618132826.54670-2-steven.price@arm.com>
 <20210618144013.GE16116@arm.com>
 <3551d8ea9c9464e982d75acdd5f855b4@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <2437e23c-2871-765e-2637-7a6823d80a52@arm.com>
Date:   Mon, 21 Jun 2021 09:27:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3551d8ea9c9464e982d75acdd5f855b4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2021 16:42, Marc Zyngier wrote:
> On 2021-06-18 15:40, Catalin Marinas wrote:
>> On Fri, Jun 18, 2021 at 02:28:20PM +0100, Steven Price wrote:
>>> mte_sync_tags() used test_and_set_bit() to set the PG_mte_tagged flag
>>> before restoring/zeroing the MTE tags. However if another thread were to
>>> race and attempt to sync the tags on the same page before the first
>>> thread had completed restoring/zeroing then it would see the flag is
>>> already set and continue without waiting. This would potentially expose
>>> the previous contents of the tags to user space, and cause any updates
>>> that user space makes before the restoring/zeroing has completed to
>>> potentially be lost.
>>>
>>> Since this code is run from atomic contexts we can't just lock the page
>>> during the process. Instead implement a new (global) spinlock to protect
>>> the mte_sync_page_tags() function.
>>>
>>> Fixes: 34bfeea4a9e9 ("arm64: mte: Clear the tags when a page is
>>> mapped in user-space with PROT_MTE")
>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>
>> Although I reviewed this patch, I think we should drop it from this
>> series and restart the discussion with the Chromium guys on what/if they
>> need PROT_MTE with MAP_SHARED. It currently breaks if you have two
>> PROT_MTE mappings but if they are ok with only one of the mappings being
>> PROT_MTE, I'm happy to just document it.
>>
>> Not sure whether subsequent patches depend on it though.
> 
> I'd certainly like it to be independent of the KVM series, specially
> as this series is pretty explicit that this MTE lock is not required
> for KVM.

Sure, since KVM no longer uses the lock we don't have the dependency -
so I'll drop the first patch.

> This will require some rework of patch #2, I believe. And while we're
> at it, a rebase on 5.13-rc4 wouldn't hurt, as both patches #3 and #5
> conflict with it...

Yeah there will be minor conflicts in patch #2 - but nothing major. I'll
rebase as requested at the same time.

Thanks,

Steve
