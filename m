Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F32388637
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbhESE5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:57:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:31958 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233899AbhESE5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:57:33 -0400
IronPort-SDR: l3PdbIXMTLTTAHloFoMWMg6CBasRB9wASDF/ShK3O6vCzi9PYAT3plwyAZwDLgJtngfJF9BGMd
 +LtV/SUSEWHw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="188018222"
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="188018222"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 21:56:14 -0700
IronPort-SDR: MWjdBhhnnYyx3rnpRhA4yOtG/fNc/QcDIkcHqNrgPJvBNOQtuzATJHHPYhC2/GcEYWWCg4b7mz
 zkCOsQz4jczQ==
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="473305424"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 21:56:10 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Xu" <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: move idle swap cache pages to the tail of LRU after
 COW
References: <20210519013313.1274454-1-ying.huang@intel.com>
        <7b2525ba7871e6b8ce3f48cfd2375804a6791a94.camel@surriel.com>
Date:   Wed, 19 May 2021 12:56:08 +0800
In-Reply-To: <7b2525ba7871e6b8ce3f48cfd2375804a6791a94.camel@surriel.com> (Rik
        van Riel's message of "Tue, 18 May 2021 22:12:42 -0400")
Message-ID: <874kez9v9z.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@surriel.com> writes:

> On Wed, 2021-05-19 at 09:33 +0800, Huang Ying wrote:
>
>> To test the patch, we used pmbench memory accessing benchmark with
>> working-set larger than available memory on a 2-socket Intel server
>> with a NVMe SSD as swap device.  Test results shows that the pmbench
>> score increases up to 21.8% with the decreased size of swap cache and
>> swapin throughput.
>
> Nice!
>
>> +++ b/mm/memory.c
>> @@ -3012,6 +3012,11 @@ static vm_fault_t wp_page_copy(struct vm_fault
>> *vmf)
>>  				munlock_vma_page(old_page);
>>  			unlock_page(old_page);
>>  		}
>> +		if (page_copied && PageSwapCache(old_page) &&
>> +		    !page_mapped(old_page) && trylock_page(old_page)) {
>> +			try_to_free_idle_swapcache(old_page);
>> +			unlock_page(old_page);
>> +		}
>
> That's quite the if condition!
>
> Would it make sense to move some of the tests, as well
> as the trylock and unlock into try_to_free_idle_swapcache()
> itself?

Sure.  Will put trylock/unlock into try_to_free_idle_swapcache() as
suggested by Linus.

> Especially considering that page_mapped is already tested
> in that function, too...

The two page_mapped() tests are intended.  The first one is a quick
check with the page unlocked, the second one is to confirm with the page
locked.  Because if the page is unlocked, the swap count may be
transited to map count or vice versa.

Best Regards,
Huang, Ying

