Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0593E220F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 05:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbhHFDHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 23:07:06 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50697 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhHFDHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 23:07:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ui5guSV_1628219206;
Received: from 30.21.164.16(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ui5guSV_1628219206)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Aug 2021 11:06:47 +0800
Subject: Re: [PATCH 1/5] mm: migrate: Move the page count validation to the
 proper place
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
 <1f7e1d083864fbb17a20a9c8349d2e8b427e20a3.1628174413.git.baolin.wang@linux.alibaba.com>
 <YQwBD55FZyoY+C5D@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <a02346d7-1a79-eb92-cb1f-033e6b58fa3f@linux.alibaba.com>
Date:   Fri, 6 Aug 2021 11:07:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQwBD55FZyoY+C5D@casper.infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

> On Thu, Aug 05, 2021 at 11:05:56PM +0800, Baolin Wang wrote:
>> We've got the expected count for anonymous page or file page by
>> expected_page_refs() at the beginning of migrate_page_move_mapping(),
>> thus we should move the page count validation a little forward to
>> reduce duplicated code.
> 
> Please add an explanation to the changelog for why it's safe to pull
> this out from under the i_pages lock.

Sure. In folio_migrate_mapping(), we are sure that the migration page 
was isolated from lru list and locked, so I think there are no race to 
get the page count without i_pages lock. Please correct me if I missed 
something else. Thanks.

> 
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/migrate.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 239b238..5559571 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -386,11 +386,10 @@ int folio_migrate_mapping(struct address_space *mapping,
>>   	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
>>   	long nr = folio_nr_pages(folio);
>>   
>> -	if (!mapping) {
>> -		/* Anonymous page without mapping */
>> -		if (folio_ref_count(folio) != expected_count)
>> -			return -EAGAIN;
>> +	if (folio_ref_count(folio) != expected_count)
>> +		return -EAGAIN;
>>   
>> +	if (!mapping) {
>>   		/* No turning back from here */
>>   		newfolio->index = folio->index;
>>   		newfolio->mapping = folio->mapping;
>> @@ -404,8 +403,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>>   	newzone = folio_zone(newfolio);
>>   
>>   	xas_lock_irq(&xas);
>> -	if (folio_ref_count(folio) != expected_count ||
>> -	    xas_load(&xas) != folio) {
>> +	if (xas_load(&xas) != folio) {
>>   		xas_unlock_irq(&xas);
>>   		return -EAGAIN;
>>   	}
>> -- 
>> 1.8.3.1
>>
>>
