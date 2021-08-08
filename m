Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC363E3802
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 04:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhHHCzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 22:55:21 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:44603 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhHHCzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 22:55:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UiG8VD6_1628391298;
Received: from 30.39.238.167(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UiG8VD6_1628391298)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Aug 2021 10:54:59 +0800
Subject: Re: [PATCH 1/5] mm: migrate: Move the page count validation to the
 proper place
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
 <1f7e1d083864fbb17a20a9c8349d2e8b427e20a3.1628174413.git.baolin.wang@linux.alibaba.com>
 <YQwBD55FZyoY+C5D@casper.infradead.org>
 <a02346d7-1a79-eb92-cb1f-033e6b58fa3f@linux.alibaba.com>
 <YQ3puWSgUvfvIYjv@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <36956352-246a-b3c2-3ade-2a6c22e2cd5a@linux.alibaba.com>
Date:   Sun, 8 Aug 2021 10:55:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQ3puWSgUvfvIYjv@casper.infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Fri, Aug 06, 2021 at 11:07:18AM +0800, Baolin Wang wrote:
>> Hi Matthew,
>>
>>> On Thu, Aug 05, 2021 at 11:05:56PM +0800, Baolin Wang wrote:
>>>> We've got the expected count for anonymous page or file page by
>>>> expected_page_refs() at the beginning of migrate_page_move_mapping(),
>>>> thus we should move the page count validation a little forward to
>>>> reduce duplicated code.
>>>
>>> Please add an explanation to the changelog for why it's safe to pull
>>> this out from under the i_pages lock.
>>
>> Sure. In folio_migrate_mapping(), we are sure that the migration page was
>> isolated from lru list and locked, so I think there are no race to get the
>> page count without i_pages lock. Please correct me if I missed something
>> else. Thanks.
> 
> Unless the page has been removed from i_pages, this isn't a correct
> explanation.  Even if it has been removed from i_pages, unless an
> RCU grace period has passed, another CPU may still be able to inc the
> refcount on it (temporarily).  The same is true for the page tables,
> by the way; if someone is using get_user_pages_fast(), they may still
> be able to see the page.

I don't think this is an issue, cause now we've established a migration 
pte for this migration page under page lock. If the user want to get 
page by get_user_pages_fast(), it will wait for the page miggration 
finished by migration_entry_wait(). So I still think there is no need to 
check the migration page count under the i_pages lock.
