Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C738BD2F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 06:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhEUES5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 00:18:57 -0400
Received: from foss.arm.com ([217.140.110.172]:37490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231337AbhEUESz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 00:18:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6828101E;
        Thu, 20 May 2021 21:17:32 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5F2E3F719;
        Thu, 20 May 2021 21:17:30 -0700 (PDT)
Subject: Re: [PATCH] mm/thp: Update mm_struct's MM_ANONPAGES stat for huge
 zero pages
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1621313300-1118-1-git-send-email-anshuman.khandual@arm.com>
 <alpine.LSU.2.11.2105201852230.5752@eggly.anvils>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8fa7fea6-4176-32fd-2c6a-abb6b73d0d13@arm.com>
Date:   Fri, 21 May 2021 09:48:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2105201852230.5752@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/21 7:47 AM, Hugh Dickins wrote:
> On Tue, 18 May 2021, Anshuman Khandual wrote:
> 
>> Although the zero huge page is being shared across various processes, each
>> mapping needs to update its mm_struct's MM_ANONPAGES stat by HPAGE_PMD_NR
>> to be consistent. This just updates the stats in set_huge_zero_page() after
>> the mapping gets created and in zap_huge_pmd() when mapping gets destroyed.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> NAK.
> 
> For consistency with what? In the all the years that the huge zero page

Huge zero page after all is an anon mapping. Hence why it must not be
counted for process rss MM_ANONPAGES accounting ? Is there a specific
reason why zero huge pages should not counted for MM_ANONPAGES ? Does
not it risk an inaccurate MM_ANONPAGES accounting for the processes
using huge zero pages ?

> has existed, it has been intentionally exempted from rss accounting:
> consistent with the small zero page, which itself has always been
> intentionally exempted from rss accounting. In fact, that's a good part

Why are small zero pages exempted from rss accounting which in turn
might have caused huge zero page to take the same approach as well ?

> of the reason the huge zero page was introduced (see 4a6c1297268c).

Huge zero page reduces memory consumption on read faults which is a
definite advantage but would there be a problem if rss stat goes up
for each huge zero page mapping instances. The commit mentioned here
talks about increase in actual memory utilization as seen from the
rss accounting stat, without huge zero page usage.

I am wondering if actual memory usage remains the same (reduced with
huge zero page usage), what could be the problem in an increased
MM_ANONPAGES accounting for a given process. Dont we update the rss
accounting for shared memory as well ?

> 
> To change that now will break any users depending on it.

Just to understand it correctly, are rss accounting procedures/methods
something which cannot be changed as users are currently dependent on
it ? OR this proposal here is not a good enough reason to change it ?

> 
> Not to mention the
> BUG: Bad rss-counter state mm:00000000aa61ef82 type:MM_ANONPAGES val:512
> I just got from mmotm.

Okay, unfortunately some how did not see this problem while testing. Is
there a specific test case which will be able to trigger this bug ?

- Anshuman
