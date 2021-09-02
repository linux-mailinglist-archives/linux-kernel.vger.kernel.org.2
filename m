Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164633FE79D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhIBCYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:24:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:24025 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243704AbhIBCYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:24:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="206153851"
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="206153851"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 19:23:26 -0700
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="691080809"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.11.199]) ([10.209.11.199])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 19:23:25 -0700
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Michal Koutn?? <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        andi.kleen@intel.com, kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
References: <20210816032855.GB72770@shbuild999.sh.intel.com>
 <YRrbpRsvdDoom9iG@cmpxchg.org>
 <20210817024500.GC72770@shbuild999.sh.intel.com>
 <20210817164737.GA23342@blackbody.suse.cz>
 <20210818023004.GA17956@shbuild999.sh.intel.com> <YSzwWIeapkzNElwV@blackbook>
 <20210831063036.GA46357@shbuild999.sh.intel.com>
 <20210831092304.GA17119@blackbody.suse.cz>
 <20210901045032.GA21937@shbuild999.sh.intel.com>
 <877dg0wcrr.fsf@linux.intel.com>
 <20210902013558.GA97410@shbuild999.sh.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <e8d087a4-a286-3561-66ef-1e9cfb38605f@linux.intel.com>
Date:   Wed, 1 Sep 2021 19:23:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902013558.GA97410@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/1/2021 6:35 PM, Feng Tang wrote:
> On Wed, Sep 01, 2021 at 08:12:24AM -0700, Andi Kleen wrote:
>> Feng Tang <feng.tang@intel.com> writes:
>>> Yes, the tests I did is no matter where the 128B padding is added, the
>>> performance can be restored and even improved.
>> I wonder if we can find some cold, rarely accessed, data to put into the
>> padding to not waste it. Perhaps some name strings? Or the destroy
>> support, which doesn't sound like its commonly used.
> Yes, I tried to move 'destroy_work', 'destroy_rwork' and 'parent' over
> before the 'refcnt' together with some padding, it restored the performance
> to about 10~15% regression. (debug patch pasted below)
>
> But I'm not sure if we should use it, before we can fully explain the
> regression.

Narrowing it down to a single prefetcher seems good enough to me. The 
behavior of the prefetchers is fairly complicated and hard to predict, 
so I doubt you'll ever get a 100% step by step explanation.


-Andi


