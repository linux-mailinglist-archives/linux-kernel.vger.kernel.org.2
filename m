Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC8327867
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 08:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhCAHmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 02:42:35 -0500
Received: from foss.arm.com ([217.140.110.172]:52148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232509AbhCAHma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 02:42:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EFE71FB;
        Sun, 28 Feb 2021 23:43:10 -0800 (PST)
Received: from [10.163.67.14] (unknown [10.163.67.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BD253F70D;
        Sun, 28 Feb 2021 23:43:07 -0800 (PST)
Subject: Re: [PATCH] mm: Generalize HUGETLB_PAGE_SIZE_VARIABLE
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-mm@kvack.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1614577853-7452-1-git-send-email-anshuman.khandual@arm.com>
 <20210301062358.GA25761@lst.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <89f2d77c-f4bc-8f7b-a6b0-1c04e422fb77@arm.com>
Date:   Mon, 1 Mar 2021 13:13:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210301062358.GA25761@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/21 11:53 AM, Christoph Hellwig wrote:
> On Mon, Mar 01, 2021 at 11:20:53AM +0530, Anshuman Khandual wrote:
>> HUGETLB_PAGE_SIZE_VARIABLE need not be defined for each individual
>> platform subscribing it. Instead just make it generic.
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: linux-ia64@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This change was originally suggested in an earilier discussion. This
>> applies on v5.12-rc1 and has been build tested on all applicable
>> platforms i.e ia64 and powerpc.
>>
>> https://patchwork.kernel.org/project/linux-mm/patch/1613024531-19040-3-git-send-email-anshuman.khandual@arm.com/
>>
>>  arch/ia64/Kconfig    | 6 +-----
>>  arch/powerpc/Kconfig | 6 +-----
>>  mm/Kconfig           | 8 ++++++++
>>  3 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
>> index 2ad7a8d29fcc..6b3e3f6c29ae 100644
>> --- a/arch/ia64/Kconfig
>> +++ b/arch/ia64/Kconfig
>> @@ -32,6 +32,7 @@ config IA64
>>  	select TTY
>>  	select HAVE_ARCH_TRACEHOOK
>>  	select HAVE_VIRT_CPU_ACCOUNTING
>> +	select HUGETLB_PAGE_SIZE_VARIABLE
> 
> doesn't this need a 'if HUGETLB_PAGE'

While making HUGETLB_PAGE_SIZE_VARIABLE a generic option, also made it
dependent on HUGETLB_PAGE. Should not that gate HUGETLB_PAGE_SIZE_VARIABLE
when HUGETLB_PAGE is not available irrespective of the select statement on
the platforms ?

> 
> or did you verify that HUGETLB_PAGE_SIZE_VARIABLE checks are always
> nested inside of HUGETLB_PAGE ones?
>
