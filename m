Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1B447A86
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 07:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKHGkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 01:40:39 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38409 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236276AbhKHGkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 01:40:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UvUeztB_1636353469;
Received: from 30.21.164.45(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UvUeztB_1636353469)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Nov 2021 14:37:50 +0800
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
 <240c5997-ab7e-8045-dacc-1afdb7c49a0d@linux.alibaba.com>
 <b7062fa5-febf-24f6-b160-41359b92ff71@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <9271f9d7-e251-9ed4-2126-8debb3395891@linux.alibaba.com>
Date:   Mon, 8 Nov 2021 14:38:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b7062fa5-febf-24f6-b160-41359b92ff71@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/7 23:20, Dave Hansen wrote:
> On 11/7/21 1:33 AM, Baolin Wang wrote:
>> Thanks for your suggestion. After some thinking, can we change the
>> node_demotion[] structure like below? Which means one source node can be
>> demoted to mutiple target node, and we can set up the target node mask
>> according to the node distance. How do you think? Thanks.
>>
>> static nodemask_t node_demotion[MAX_NUMNODES] __read_mostly =
>>          {[0 ...  MAX_NUMNODES - 1] = NODE_MASK_NONE};
> 
> How large is that in the worst case?

For the worst case (MAX_NUMNODES=1024), the size of the node_demotion is 
131072 bytes, while the size of original data structure is 4096 bytes. 
Maybe we can allocate the node_demotion dynamically?
