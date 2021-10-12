Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B343A429F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhJLH70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:59:26 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55067 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234071AbhJLH7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:59:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UrYcJvG_1634025437;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UrYcJvG_1634025437)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Oct 2021 15:57:18 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH] mm/damon/dbgfs: add region_stat interface
To:     SeongJae Park <sj@kernel.org>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211012071119.32320-1-sj@kernel.org>
Message-ID: <7ab062d3-f087-78ef-4630-471bb6d16275@linux.alibaba.com>
Date:   Tue, 12 Oct 2021 15:57:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20211012071119.32320-1-sj@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/10/12 ÏÂÎç3:11, SeongJae Park Ð´µÀ:
> Hello Xin, thank you for this patch!
>
> On Tue, 12 Oct 2021 13:49:48 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> Using damon-dbgfs has brought great convenience to user-mode
>> operation damon, but sometimes if i want to be able to view
>> the division of task regions, nr_access values etc,but i found
>> that it is impossible to view directly through the dbgfs interface,
>> so there i add a interface "region_stat", it displays like this.
>>
>>   # cat region_stat
>>   last_aggregation=120.87s
>>   target_id=5148
>>   nr_regions=10
>>   400000-258c000(34352 KiB): 1
>>   258c000-4719000(34356 KiB): 0
>>   4719000-abbf000(103064 KiB): 0
>>   abbf000-c4d4000(25684 KiB): 11
>>   c4d4000-ff5c000(59936 KiB): 15
>>   ff5c000-152f9000(85620 KiB): 20
>>   152f9000-1599e000(6804 KiB): 10
>>   1599e000-19573000(61268 KiB): 0
>>   19573000-1f92c000(102116 KiB): 0
>>   1f92c000-22a4c000(50304 KiB): 0
> I think similar information could also be collected via the 'damon_aggregated'
> tracepoint[1], which is merged in the mainline, or 'DAMOS_STAT'[2], which is
> merged in -mm.  The recording feature[3] could also be used, though it would
> take some time before it is merged in the mainline.  Have you considered using
> those but found some problem?

Yes, i know we can use damon_aggregated tracepoint, but i think, add a 
"region_stat" will be more

convenient and intuitive, especially when we use damon-dbgfs interface.

>
> [1] https://git.kernel.org/torvalds/c/2fcb93629ad8
> [2] https://lore.kernel.org/linux-mm/20211001125604.29660-6-sj@kernel.org/
> [3] https://lore.kernel.org/linux-mm/20211008094509.16179-1-sj@kernel.org/
>
>
> Thanks,
> SJ
>
> [...]

-- 
Best Regards!
Xin Hao

