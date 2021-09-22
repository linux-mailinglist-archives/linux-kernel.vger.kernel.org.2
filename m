Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBEE4140A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 06:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhIVEpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 00:45:10 -0400
Received: from foss.arm.com ([217.140.110.172]:42726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhIVEpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 00:45:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7344A11B3;
        Tue, 21 Sep 2021 21:43:39 -0700 (PDT)
Received: from [10.163.73.113] (unknown [10.163.73.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 471063F40C;
        Tue, 21 Sep 2021 21:43:36 -0700 (PDT)
Subject: Re: [PATCH V2] arm64/mm: Add pud_sect_supported()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        suzuki.poulose@arm.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1632130171-472-1-git-send-email-anshuman.khandual@arm.com>
 <YUirurhvmBPCOsS+@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <127b2334-5c40-1b71-e510-ac837c3ac614@arm.com>
Date:   Wed, 22 Sep 2021 10:14:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YUirurhvmBPCOsS+@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/21 9:11 PM, Catalin Marinas wrote:
> On Mon, Sep 20, 2021 at 02:59:31PM +0530, Anshuman Khandual wrote:
>> Section mapping at PUD level is supported only on 4K pages and currently it
>> gets verified with explicit #ifdef or IS_ENABLED() constructs. This adds a
>> new helper pud_sect_supported() for this purpose, which particularly cleans
>> up the HugeTLB code path. It updates relevant switch statements with checks
>> for __PAGETABLE_PMD_FOLDED in order to avoid build failures caused with two
>> identical switch case values in those code blocks.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Assuming that you tested the corresponding configurations,

Right, I did test this on all page size and VA bits configurations
, including the specific ones which were problematic.

> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
