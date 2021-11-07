Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC0344725A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 10:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhKGJfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 04:35:41 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:49182 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbhKGJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 04:35:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UvOEnjO_1636277573;
Received: from 30.30.76.41(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UvOEnjO_1636277573)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Nov 2021 17:32:56 +0800
Subject: Re: [RFC PATCH] mm: migrate: Add new node demotion strategy
To:     Dave Hansen <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        ziy@nvidia.com, osalvador@suse.de, shy828301@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <c02bcbc04faa7a2c852534e9cd58a91c44494657.1636016609.git.baolin.wang@linux.alibaba.com>
 <665cb882-6dbc-335f-1435-e52659d7ee58@intel.com>
 <87tugrxqks.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <c0023ae8-0aff-0890-00fb-310d72130f8a@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <240c5997-ab7e-8045-dacc-1afdb7c49a0d@linux.alibaba.com>
Date:   Sun, 7 Nov 2021 17:33:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c0023ae8-0aff-0890-00fb-310d72130f8a@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/5 23:47, Dave Hansen wrote:
> On 11/4/21 7:51 PM, Huang, Ying wrote:
>>> Let's also try to do it with the existing node_demotion[] data
>>> structure before we go adding more.
>> To avoid cache ping-pong, I guess some kind of per-CPU data structure
>> may be more suitable for interleaving among multiple nodes.
> 
> It would probably be better to just find something that's more
> read-heavy.  Like, instead of keeping a strict round-robin, just
> randomly select one of the notes to which you can round-robin.
> 
> That will scale naturally without having to worry about caching or fancy
> per-cpu data structures.
> 

Thanks for your suggestion. After some thinking, can we change the 
node_demotion[] structure like below? Which means one source node can be 
demoted to mutiple target node, and we can set up the target node mask 
according to the node distance. How do you think? Thanks.

static nodemask_t node_demotion[MAX_NUMNODES] __read_mostly =
         {[0 ...  MAX_NUMNODES - 1] = NODE_MASK_NONE};
