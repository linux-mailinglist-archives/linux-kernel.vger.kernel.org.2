Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB89389AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhETBYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:24:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:64728 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhETBYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:24:12 -0400
IronPort-SDR: dpDEAwo4cosxh7djoclagD3YJO9nrb0cDd/CyRKx7tsdRMijD5cpUt2WxqMY+DOx5KqSjDSgKZ
 mtruFU8Hf+ZQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="188246568"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188246568"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 18:22:51 -0700
IronPort-SDR: PWfdGOb06qVDM6X27/4KBStD4pv/kuC00A1YSX6+Oy8t8xQP6JPZsr49wEn13KAimSly57HxQM
 je1fZtKIKKVg==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440222333"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 18:22:47 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: move idle swap cache pages to the tail of LRU after
 COW
References: <20210519013313.1274454-1-ying.huang@intel.com>
        <YKUlfeAiq/vv+dHl@cmpxchg.org>
Date:   Thu, 20 May 2021 09:22:45 +0800
In-Reply-To: <YKUlfeAiq/vv+dHl@cmpxchg.org> (Johannes Weiner's message of
        "Wed, 19 May 2021 10:49:33 -0400")
Message-ID: <87r1i28ahm.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Wed, May 19, 2021 at 09:33:13AM +0800, Huang Ying wrote:
>> diff --git a/mm/memory.c b/mm/memory.c
>> index b83f734c4e1d..2b6847f4c03e 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3012,6 +3012,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>>  				munlock_vma_page(old_page);
>>  			unlock_page(old_page);
>>  		}
>> +		if (page_copied && PageSwapCache(old_page) &&
>> +		    !page_mapped(old_page) && trylock_page(old_page)) {
>> +			try_to_free_idle_swapcache(old_page);
>> +			unlock_page(old_page);
>
> If there are no more swap or pte references, can we just attempt to
> free the page right away, like we do during regular unmap?
>
> 		if (page_copied)
> 			free_swap_cache(old_page);
> 		put_page(old_page);

A previous version of the patch does roughly this.

https://lore.kernel.org/lkml/20210113024241.179113-1-ying.huang@intel.com/

But Linus has concerns with the overhead introduced in the hot COW path.

Another possibility is to move the idle swap cache page to the tail of
the file LRU list.  But the question is how to identify the page.

Best Regards,
Huang, Ying
