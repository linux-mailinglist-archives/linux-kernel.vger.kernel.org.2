Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2091C3B8D63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhGAFXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 01:23:15 -0400
Received: from foss.arm.com ([217.140.110.172]:46878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhGAFXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 01:23:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1B5E6D;
        Wed, 30 Jun 2021 22:20:43 -0700 (PDT)
Received: from [10.163.88.72] (unknown [10.163.88.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7AD63F694;
        Wed, 30 Jun 2021 22:20:41 -0700 (PDT)
Subject: Re: [PATCH V2] mm/thp: Make ALLOC_SPLIT_PTLOCKS dependent on
 USE_SPLIT_PTE_PTLOCKS
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <1621409586-5555-1-git-send-email-anshuman.khandual@arm.com>
 <YKZFRPqg4wKjOdVg@casper.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9d1ce685-e0fd-febd-5ff2-179f7fa6e3fa@arm.com>
Date:   Thu, 1 Jul 2021 10:51:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YKZFRPqg4wKjOdVg@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/21 4:47 PM, Matthew Wilcox wrote:
> On Wed, May 19, 2021 at 01:03:06PM +0530, Anshuman Khandual wrote:
>> Split ptlocks need not be defined and allocated unless they are being used.
>> ALLOC_SPLIT_PTLOCKS is inherently dependent on USE_SPLIT_PTE_PTLOCKS. This
>> just makes it explicit and clear. While here drop the spinlock_t element
>> from the struct page when USE_SPLIT_PTE_PTLOCKS is not enabled.
> 
> I didn't spot this email yesterday.  I'm not a fan.  Isn't struct page
> already complicated enough without adding another ifdef to it?  Surely
> there's a better way than this.

This discussion thread just got dropped off the radar, sorry about it.
None of the spinlock_t elements are required unless split ptlocks are
in use. I understand your concern regarding yet another #ifdef in the
struct page definition. But this change is simple and minimal. Do you
have any other particular alternative in mind which I could explore ?

> 
>> +++ b/include/linux/mm_types.h
>> @@ -152,10 +152,12 @@ struct page {
>>  				struct mm_struct *pt_mm; /* x86 pgds only */
>>  				atomic_t pt_frag_refcount; /* powerpc */
>>  			};
>> +#if USE_SPLIT_PTE_PTLOCKS
>>  #if ALLOC_SPLIT_PTLOCKS
>>  			spinlock_t *ptl;
>>  #else
>>  			spinlock_t ptl;
>> +#endif
>>  #endif
>>  		};
>>  		struct {	/* ZONE_DEVICE pages */
