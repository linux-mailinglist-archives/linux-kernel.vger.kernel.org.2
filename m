Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC433BB5A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 05:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhGEDlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 23:41:14 -0400
Received: from foss.arm.com ([217.140.110.172]:36290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhGEDlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:41:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BE94D6E;
        Sun,  4 Jul 2021 20:38:36 -0700 (PDT)
Received: from [10.163.88.246] (unknown [10.163.88.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78E7D3F5A1;
        Sun,  4 Jul 2021 20:38:34 -0700 (PDT)
Subject: Re: [PATCH V2] mm/thp: Make ALLOC_SPLIT_PTLOCKS dependent on
 USE_SPLIT_PTE_PTLOCKS
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <1621409586-5555-1-git-send-email-anshuman.khandual@arm.com>
 <YKZFRPqg4wKjOdVg@casper.infradead.org>
 <9d1ce685-e0fd-febd-5ff2-179f7fa6e3fa@arm.com>
 <YN27uc64s/yllfQR@casper.infradead.org>
 <45c1feaa-4bab-91d1-6962-81549d2b6d00@arm.com>
 <YOJ8YR8wWkiHsRTp@casper.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <67a7c36d-a040-b58a-ab8b-d67ba4341369@arm.com>
Date:   Mon, 5 Jul 2021 09:09:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YOJ8YR8wWkiHsRTp@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/21 8:58 AM, Matthew Wilcox wrote:
> On Mon, Jul 05, 2021 at 08:57:54AM +0530, Anshuman Khandual wrote:
>>
>> On 7/1/21 6:27 PM, Matthew Wilcox wrote:
>>> On Thu, Jul 01, 2021 at 10:51:27AM +0530, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 5/20/21 4:47 PM, Matthew Wilcox wrote:
>>>>> On Wed, May 19, 2021 at 01:03:06PM +0530, Anshuman Khandual wrote:
>>>>>> Split ptlocks need not be defined and allocated unless they are being used.
>>>>>> ALLOC_SPLIT_PTLOCKS is inherently dependent on USE_SPLIT_PTE_PTLOCKS. This
>>>>>> just makes it explicit and clear. While here drop the spinlock_t element
>>>>>> from the struct page when USE_SPLIT_PTE_PTLOCKS is not enabled.
>>>>>
>>>>> I didn't spot this email yesterday.  I'm not a fan.  Isn't struct page
>>>>> already complicated enough without adding another ifdef to it?  Surely
>>>>> there's a better way than this.
>>>>
>>>> This discussion thread just got dropped off the radar, sorry about it.
>>>> None of the spinlock_t elements are required unless split ptlocks are
>>>> in use. I understand your concern regarding yet another #ifdef in the
>>>> struct page definition. But this change is simple and minimal. Do you
>>>> have any other particular alternative in mind which I could explore ?
>>>
>>> Do nothing?  I don't understand what problem you're trying to solve.
>>
>> Currently there is an element (spinlock_t ptl) in the struct page for page
>> table lock. Although a struct page based spinlock is not even required in
>> case USE_SPLIT_PTE_PTLOCKS evaluates to be false. Is not that something to
>> be fixed here i.e drop the splinlock_t element if not required ?
> 
> No?  It doesn't actually cause any problems, does it?
> 

No but should an unnecessary element in a struct is dropped only if there
is a reported problem ?
