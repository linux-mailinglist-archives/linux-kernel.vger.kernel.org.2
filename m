Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229EF3AFA59
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 02:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFVA4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 20:56:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:15928 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhFVA4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 20:56:54 -0400
IronPort-SDR: VFAY2GOxrxxU5KGUJllSoy/Clf4jhLFpfla+duGHRLMwLSCGqczBF7KOlJfcCd1sz9c/ca0zQb
 6Thr0xVXbW9g==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="194271685"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="194271685"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 17:54:39 -0700
IronPort-SDR: bylm2WP4+0gdOJ5pDwrKkr0wmM4h8aMa4HvR8Qy0HkfoFJJCv4aIkVMdEvkdFLEQKOq1VtsfMN
 SkxY4Pzxeuog==
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="486705746"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 17:54:36 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: Re: [PATCH -V8 02/10] mm/numa: automatically generate node
 migration order
References: <20210618061537.434999-1-ying.huang@intel.com>
        <20210618061537.434999-3-ying.huang@intel.com>
        <79397FE3-4B08-4DE5-8468-C5CAE36A3E39@nvidia.com>
        <87v96anu6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <36307d7a-6e39-b1dd-64e8-95ec59f16867@intel.com>
Date:   Tue, 22 Jun 2021 08:54:34 +0800
In-Reply-To: <36307d7a-6e39-b1dd-64e8-95ec59f16867@intel.com> (Dave Hansen's
        message of "Mon, 21 Jun 2021 12:53:04 -0700")
Message-ID: <871r8uoh11.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 6/19/21 1:18 AM, Huang, Ying wrote:
>>>>  int next_demotion_node(int node)
>>>>  {
>>>> -	return node_demotion[node];
>>>> +	/*
>>>> +	 * node_demotion[] is updated without excluding
>>>> +	 * this function from running.  READ_ONCE() avoids
>>>> +	 * reading multiple, inconsistent 'node' values
>>>> +	 * during an update.
>>>> +	 */
>>>> +	return READ_ONCE(node_demotion[node]);
>>>>  }
>>> Is it necessary to have two separate patches to add node_demotion and
>>> next_demotion_node() then modify it immediately? Maybe merge Patch 1 into 2?
>>>
>>> Hmm, I just checked Patch 3 and it changes node_demotion again and uses RCU.
>>> I guess it might be much simpler to just introduce node_demotion with RCU
>>> in this patch and Patch 3 only takes care of hotplug events.
>> Hi, Dave,
>> 
>> What do you think about this?
>> 
>
> Squashing them seems like a good idea to me.

Sure.  Will do that.  How about move RCU from 3/10 to the squashed one?

Best Regards,
Huang, Ying
