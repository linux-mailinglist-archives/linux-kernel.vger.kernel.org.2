Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD13E221F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 05:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbhHFDTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 23:19:54 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55013 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhHFDTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 23:19:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ui5yKU9_1628219977;
Received: from 30.21.164.16(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ui5yKU9_1628219977)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Aug 2021 11:19:37 +0800
Subject: Re: [PATCH 5/5] mm: migrate: Remove redundant goto labels
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
 <d359dcf73a7a868f1b126cb73368fea64aec1f25.1628174413.git.baolin.wang@linux.alibaba.com>
 <CAHbLzkrqwOp0a_6Vzn29h9qwCiwVSLL6QzsMLfOYTWj7mtkNZg@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <98937827-89ec-2a3b-b389-da28f8493cb1@linux.alibaba.com>
Date:   Fri, 6 Aug 2021 11:20:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkrqwOp0a_6Vzn29h9qwCiwVSLL6QzsMLfOYTWj7mtkNZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

> On Thu, Aug 5, 2021 at 8:06 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Remove redundant goto labels to simplify the code.
> 
> TBH I don't see too much benefit. The "goto" makes the functions have
> a single exit point.

Yes, I agree that the 'goto' statement can make things easier when a 
function exits from multiple locations and some common work such as 
cleanup has to be done, as well as introducing complexity to reading the 
code. So per the coding style documentation, "If there is no cleanup 
needed then just return directly", which can make code more readable I 
think :)

But I have no strong opinion on this, I can drop this patch if you still 
think this is unnecessary. Thanks for your review and comments.

>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/migrate.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 0ab364f..ed74fda 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -911,9 +911,8 @@ static int move_to_new_page(struct page *newpage, struct page *page,
>>                   */
>>                  VM_BUG_ON_PAGE(!PageIsolated(page), page);
>>                  if (!PageMovable(page)) {
>> -                       rc = MIGRATEPAGE_SUCCESS;
>>                          __ClearPageIsolated(page);
>> -                       goto out;
>> +                       return MIGRATEPAGE_SUCCESS;
>>                  }
>>
>>                  rc = mapping->a_ops->migratepage(mapping, newpage,
>> @@ -949,7 +948,7 @@ static int move_to_new_page(struct page *newpage, struct page *page,
>>                          flush_dcache_page(newpage);
>>
>>          }
>> -out:
>> +
>>          return rc;
>>   }
>>
>> @@ -2095,11 +2094,10 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
>>          newpage = alloc_pages_node(nid, (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
>>                                     HPAGE_PMD_ORDER);
>>          if (!newpage)
>> -               goto out;
>> +               return NULL;
>>
>>          prep_transhuge_page(newpage);
>>
>> -out:
>>          return newpage;
>>   }
>>
>> --
>> 1.8.3.1
>>
>>
