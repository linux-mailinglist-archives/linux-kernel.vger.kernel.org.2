Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FB14426FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 07:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhKBGKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 02:10:31 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44200 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhKBGKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 02:10:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UuhLMoK_1635833272;
Received: from 30.21.164.46(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UuhLMoK_1635833272)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Nov 2021 14:07:53 +0800
Subject: Re: [PATCH] mm: migrate: Correct the hugetlb migration stats
To:     Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <b35e54802a9a82d03d24845b463e9d9a68f7fd6b.1635491660.git.baolin.wang@linux.alibaba.com>
 <677EF981-F33E-4002-AA38-DD669C319284@nvidia.com>
 <29aa9c6e-7191-71bb-d8a3-e2695b18fa3e@linux.alibaba.com>
 <D32BF8D1-E6E0-4535-B8C6-1F05842DB672@nvidia.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <7f45b2c8-fd2c-345a-ec6c-43b8b1c06de1@linux.alibaba.com>
Date:   Tue, 2 Nov 2021 14:08:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <D32BF8D1-E6E0-4535-B8C6-1F05842DB672@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/1 23:12, Zi Yan wrote:
> On 1 Nov 2021, at 2:54, Baolin Wang wrote:
> 
>> On 2021/10/29 23:43, Zi Yan wrote:
>>> On 29 Oct 2021, at 3:42, Baolin Wang wrote:
>>>
>>>> Now hugetlb migration is also available for some scenarios, such as
>>>> soft offling or memory compaction. So we should correct the migration
>>>
>>> hugetlb migration is available at the time if (PageHuge(page)) branch
>>> is added. I am not sure what is new here.
>>
>> No new things actually, sorry for confusing and will update the commit message in next version.
>>
>>>
>>>> stats for hugetlb with using compound_nr() instead of thp_nr_pages()
>>>> to get the number of pages.
>>>
>>> nr_failed records the number of pages, not subpages. It is returned to
>>
>> I also think nr_failed should record the number of pages, not the number of hugetlb, if I understand you correctly.
>>
>>> user space when move_pages() syscall is used. After your change,
>>> if users try to migrate a list of pages including THPs and/or hugetlb
>>> pages and some of THPs and/or hugetlb fail to migrate, move_pages()
>>> will return a number larger than the number of pages the users tried
>>
>> OK, thanks for pointing out the issue.
>>
>> But before my patch, we've already returned the number of pages successed or failed for THP migration, instead of the number of THP. That means if we just move only 1 page by
> 
> Ah, you are right.
> 
>> move_pages() and if this page is 2M THP, so move_pages() will return 512 if failed to migrate, which is larger than the page count specified from user.
>>
>> if (err > 0)
>> 	err += nr_pages - i - 1;
> 
> I am not sure this is right for user-space.
> 
>>
>> On the other hand, the stats of PGMIGRATE_SUCCESS/PGMIGRATE_FAIL should stand for the number of pages, instead of the number of hugetlb. Also for hugetlb migration when memory compaction, we've already counted the number of pages for a hugetlb into cc->nr_migratepages, if the hugetlb migration failed, the trace stat of compaction will be confusing if we return the number of hugetlb.
>>
>> trace_mm_compaction_migratepages(cc->nr_migratepages, err,                                   &cc->migratepages);
>>
>> So I think the stats of hugetlb migration should be consistent with THP.
> 
> It makes sense to me.
> 
>>
>>> to migrate. I am not sure this is the change we want. Or at least,
>>> the comment of migrate_pages() and the manpage of move_pages() need
>>> to be changed and linux-api mailing list should be cc’d.
>>
>> I don't think we should update the comments of migrate_pages(), "Returns the number of pages that were not migrated" makes sense to me if I understand correctly.
>>
>> For the manpage of move_pages(), as you said, the the returned non-migrate page numbers can be larger than the numbers specified from user if failed to migrate a THP or a hugetlb. I am not sure if we should change the manpage, since the THP already did, but I can send a patch to update the manpage if you think this is still necessary. Thanks.
> 
> I am not sure changing manpage would help the users of move_pages() after
> think about it again, since users might not know all the THP and/or hugetlb
> information	when they call move_pages() and they just pass a list of N pages. >
> I just wonder if we could fix the rc value of migrate_pages to return
> the number of {base page, THP, hugetlb} instead, so that move_pages()
> can get its return value right.

IMO it will break the usage in other places if we change the rc value of 
migrate_pages(), for example, the page migration when doing memory 
compaction as I said before, which will expect the number of normal 
pages. Meanwhile the THP page can be split into normal pages during 
migration, so it will not be consistent if we return the number of THP.

Changing the return value of migrate_pages() will make things more 
complicated, and I am not sure whether it is worth doing. Any 
suggestion? Thanks.
