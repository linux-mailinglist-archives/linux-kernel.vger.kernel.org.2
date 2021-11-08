Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4586447BA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhKHIRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:17:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:5473 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234561AbhKHIRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:17:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="255853402"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="255853402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 00:15:08 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="502915910"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 00:15:04 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, <akpm@linux-foundation.org>,
        <dave.hansen@linux.intel.com>, <ziy@nvidia.com>,
        <osalvador@suse.de>, <shy828301@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: migrate: Add new node demotion strategy
References: <c02bcbc04faa7a2c852534e9cd58a91c44494657.1636016609.git.baolin.wang@linux.alibaba.com>
        <665cb882-6dbc-335f-1435-e52659d7ee58@intel.com>
        <87tugrxqks.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <c0023ae8-0aff-0890-00fb-310d72130f8a@intel.com>
        <240c5997-ab7e-8045-dacc-1afdb7c49a0d@linux.alibaba.com>
        <b7062fa5-febf-24f6-b160-41359b92ff71@intel.com>
        <9271f9d7-e251-9ed4-2126-8debb3395891@linux.alibaba.com>
        <87fss7w3b7.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <a26234d8-4113-9f22-cb04-efe1956db8e7@linux.alibaba.com>
Date:   Mon, 08 Nov 2021 16:12:10 +0800
In-Reply-To: <a26234d8-4113-9f22-cb04-efe1956db8e7@linux.alibaba.com> (Baolin
        Wang's message of "Mon, 8 Nov 2021 15:07:18 +0800")
Message-ID: <87sfw7ukv9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 2021/11/8 14:48, Huang, Ying writes:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>> 
>>> On 2021/11/7 23:20, Dave Hansen wrote:
>>>> On 11/7/21 1:33 AM, Baolin Wang wrote:
>>>>> Thanks for your suggestion. After some thinking, can we change the
>>>>> node_demotion[] structure like below? Which means one source node can be
>>>>> demoted to mutiple target node, and we can set up the target node mask
>>>>> according to the node distance. How do you think? Thanks.
>>>>>
>>>>> static nodemask_t node_demotion[MAX_NUMNODES] __read_mostly =
>>>>>       {[0 ... MAX_NUMNODES - 1] = NODE_MASK_NONE};
>>>> How large is that in the worst case?
>>>
>>> For the worst case (MAX_NUMNODES=1024), the size of the node_demotion
>>> is 131072 bytes, while the size of original data structure is 4096
>>> bytes. Maybe we can allocate the node_demotion dynamically?
>> Per my understanding, in most cases, the number of demotion target
>> nodes
>> should be quite small.  So why not restrict the number of demotion
>> target nodes to make it some kind of simple array?
>
> Yes, agree. Something like below is reasonable for you?
>
> #define DEMOTION_TARGET_NODES 16
> typedef struct { DECLARE_BITMAP(bits, DEMOTION_TARGET_NODES); }
> demotemask_t;
>
> static demotemask_t node_demotion[MAX_NUMNODES];

I don't think we need a bitmap.  May be something as following,

#define DEMOTION_TARGET_NODES 15
struct demotion_nodes {
  unsigned short nr;
  unsigned short nodes[DEMOTION_TARGET_NODES];
};

Best Regards,
Huang, Ying
