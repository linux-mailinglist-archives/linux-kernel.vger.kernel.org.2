Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A32447AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbhKHHJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:09:20 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33022 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236168AbhKHHJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:09:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UvXJHyi_1636355192;
Received: from 30.21.164.45(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UvXJHyi_1636355192)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Nov 2021 15:06:32 +0800
Subject: Re: [RFC PATCH] mm: migrate: Add new node demotion strategy
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, ziy@nvidia.com, osalvador@suse.de,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <c02bcbc04faa7a2c852534e9cd58a91c44494657.1636016609.git.baolin.wang@linux.alibaba.com>
 <665cb882-6dbc-335f-1435-e52659d7ee58@intel.com>
 <87tugrxqks.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <c0023ae8-0aff-0890-00fb-310d72130f8a@intel.com>
 <240c5997-ab7e-8045-dacc-1afdb7c49a0d@linux.alibaba.com>
 <b7062fa5-febf-24f6-b160-41359b92ff71@intel.com>
 <9271f9d7-e251-9ed4-2126-8debb3395891@linux.alibaba.com>
 <87fss7w3b7.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <a26234d8-4113-9f22-cb04-efe1956db8e7@linux.alibaba.com>
Date:   Mon, 8 Nov 2021 15:07:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87fss7w3b7.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/8 14:48, Huang, Ying writes:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 2021/11/7 23:20, Dave Hansen wrote:
>>> On 11/7/21 1:33 AM, Baolin Wang wrote:
>>>> Thanks for your suggestion. After some thinking, can we change the
>>>> node_demotion[] structure like below? Which means one source node can be
>>>> demoted to mutiple target node, and we can set up the target node mask
>>>> according to the node distance. How do you think? Thanks.
>>>>
>>>> static nodemask_t node_demotion[MAX_NUMNODES] __read_mostly =
>>>>           {[0 ...  MAX_NUMNODES - 1] = NODE_MASK_NONE};
>>> How large is that in the worst case?
>>
>> For the worst case (MAX_NUMNODES=1024), the size of the node_demotion
>> is 131072 bytes, while the size of original data structure is 4096
>> bytes. Maybe we can allocate the node_demotion dynamically?
> 
> Per my understanding, in most cases, the number of demotion target nodes
> should be quite small.  So why not restrict the number of demotion
> target nodes to make it some kind of simple array?

Yes, agree. Something like below is reasonable for you?

#define DEMOTION_TARGET_NODES 16
typedef struct { DECLARE_BITMAP(bits, DEMOTION_TARGET_NODES); } 
demotemask_t;

static demotemask_t node_demotion[MAX_NUMNODES];
