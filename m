Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9850044D5B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhKKLWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:22:20 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43530 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhKKLWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:22:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Uw1sEVC_1636629565;
Received: from 30.21.164.4(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uw1sEVC_1636629565)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 19:19:26 +0800
Subject: Re: [PATCH v2 2/2] mm: migrate: Allocate the node_demotion structure
 dynamically
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        ziy@nvidia.com, osalvador@suse.de, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
 <e39502af91e12ba1a4bef3be4d05b11b2c7a7a9f.1636616548.git.baolin.wang@linux.alibaba.com>
 <87pmr7m5wo.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <c08caa62-82af-0254-1e77-aa02d1ce53e5@linux.alibaba.com>
Date:   Thu, 11 Nov 2021 19:20:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87pmr7m5wo.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/11 16:51, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> For the worst case (MAX_NUMNODES=1024), the node_demotion structure can
>> consume 32k bytes, which appears too large, so we can change to allocate
>> node_demotion dynamically at initialization time. Meanwhile allocating
>> the target demotion nodes array dynamically to select a suitable size
>> according to the MAX_NUMNODES.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/migrate.c | 38 +++++++++++++++++++++++++++++---------
>>   1 file changed, 29 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 126e9e6..0145b38 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1152,10 +1152,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>>   #define DEFAULT_DEMOTION_TARGET_NODES 15
>>   struct demotion_nodes {
>>   	unsigned short nr;
>> -	short nodes[DEFAULT_DEMOTION_TARGET_NODES];
>> +	short nodes[];
>>   };
>>   
>> -static struct demotion_nodes node_demotion[MAX_NUMNODES] __read_mostly;
>> +static struct demotion_nodes *node_demotion[MAX_NUMNODES] __read_mostly;
>> +static unsigned short target_nodes_max;
> 
> I think we can use something as below,
> 
>    #if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
>    #define DEMOTION_TARGET_NODES   (MAX_NUMNODES - 1)
>    #else
>    #define DEMOTION_TARGET_NODES   DEFAULT_DEMOTION_TARGET_NODES
>    #endif

Yes, looks better.

> 
>    static struct demotion_nodes *node_demotion;
> 
> Then we can allocate nr_node_ids * sizeof(struct demotion_nodes) for node_demotion.

Yeah, this is simple. The reason I want to declare the structure like 
"struct demotion_nodes *node_demotion[MAX_NUMNODES]" is that, we can 
validate the non-possible nodes which are invalid to demote memory, and 
in case the node_demotion[nid] is failed to be allocated which can be 
validated, though this is unlikely. However, I agree with you to keep 
things simple now and can be merged into patch 1. Will do in next 
version. Thanks.
