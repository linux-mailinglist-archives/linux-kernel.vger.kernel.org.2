Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF73E89BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhHKFbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:31:39 -0400
Received: from foss.arm.com ([217.140.110.172]:42892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhHKFbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:31:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1BE71FB;
        Tue, 10 Aug 2021 22:31:15 -0700 (PDT)
Received: from [10.163.67.241] (unknown [10.163.67.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B5F3F40C;
        Tue, 10 Aug 2021 22:31:13 -0700 (PDT)
Subject: Re: [PATCH 1/5] KVM: arm64: Drop direct PAGE_[SHIFT|SIZE] usage as
 page size
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
 <1628578961-29097-2-git-send-email-anshuman.khandual@arm.com>
 <20210810132015.GA2946@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7ac63cc6-d35a-d455-f629-abea2932d312@arm.com>
Date:   Wed, 11 Aug 2021 11:02:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210810132015.GA2946@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/21 6:50 PM, Will Deacon wrote:
> On Tue, Aug 10, 2021 at 12:32:37PM +0530, Anshuman Khandual wrote:
>> All instances here could just directly test against CONFIG_ARM64_XXK_PAGES
>> instead of evaluating via PAGE_SHIFT or PAGE_SIZE. With this change, there
>> will be no such usage left.
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Alexandru Elisei <alexandru.elisei@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/kvm/hyp/pgtable.c | 6 +++---
>>  arch/arm64/mm/mmu.c          | 2 +-
>>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> Why is this better?

There are two improvements here.

1. Avoids using hard coded numerical shift values to determine the page size

	e.g PAGE_SHIFT = 16 for 64K

2. There are already instances of IS_ENABLED() construct checking for the page
   size. After this change there will be just a single method to test page size
   , rather than checking for either config, PAGE_SHIFT or PAGE_SIZE etc through
   out arm64. This change helps in that unification around IS_ENABLED().

There is another patch which drops remaining usage for PAGE_SIZE as well.

https://patchwork.kernel.org/project/linux-arm-kernel/patch/1628569782-30213-1-git-send-email-anshuman.khandual@arm.com/ 
