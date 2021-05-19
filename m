Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B885C388627
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbhESEvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:51:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:38613 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233017AbhESEvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:51:13 -0400
IronPort-SDR: t31QHTNP7mCmOvNy3s7ickG8SuO2J5WfeUd+GRNAqhOza397cnXSpS258iNirSy31wgLbRis/s
 dy2l0r2QFlgg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200938056"
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="200938056"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 21:49:53 -0700
IronPort-SDR: EjMpw5x3wLmFSP9vcT3lkkifFPgbcaKC04jAkPbcnkt93rTuIVCPjbVRe3LmHQ6dtuaQzyUNrF
 NLyuMV2HbJ1w==
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="473303825"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 21:49:49 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: move idle swap cache pages to the tail of LRU after
 COW
References: <20210519013313.1274454-1-ying.huang@intel.com>
        <CAHk-=wig4SQjBLtmFODs6oXukwrO0o5CPUVzxT2UvJM9jvwSiA@mail.gmail.com>
        <CAHk-=wgUMC03e1Ost6q4gb7+2jWO=vBHW63OYaOHOHvi39esng@mail.gmail.com>
Date:   Wed, 19 May 2021 12:49:47 +0800
In-Reply-To: <CAHk-=wgUMC03e1Ost6q4gb7+2jWO=vBHW63OYaOHOHvi39esng@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 18 May 2021 17:25:50 -1000")
Message-ID: <878s4b9vkk.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, May 18, 2021 at 5:17 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> This looks sensible to me (and numbers talk!), but as Rik says, it
>> would probably be a good idea to move the trylock_page()/unlock_page()
>> into try_to_free_idle_swapcache(), and that would make the calling
>> side a whole lot cleaner and easier to read.
>
> To keep the error handling simple, and keep that "if that didn't work,
> just return" logic in you had, doing it as two functions like:
>
>   static inline void locked_try_to_free_idle_swapcache(struct page *page)
>   { .. your current try_to_free_idle_swapcache() .. }
>
>   void try_to_free_idle_swapcache(struct page *page)
>   {
>         if (trylock_page(page)) {
>                 locked_try_to_free_idle_swapcache(page);
>                 unlock_page(page);
>         }
>   }
>
> would keep that readability and simplicity.
>
> And then the wp_page_copy() code ends up being
>
>         if (page_copied && PageSwapCache(old_page) && !page_mapped(old_page))
>                       try_to_free_idle_swapcache(old_page);
>
> which looks pretty sensible to me: if we copied the page, and the old
> page is a no longer mapped swap cache page, let's try to free it.
>
> That's still a hell of a long conditional, partly because of those
> long names. But at least it's conceptually fairly straightforward and
> easy to understand what's going on.

Thanks!  That looks much better.  I will do that in the next version.

Best Regards,
Huang, Ying
