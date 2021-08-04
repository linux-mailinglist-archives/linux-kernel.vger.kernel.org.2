Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842543DFD93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbhHDJB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:01:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:44644 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236801AbhHDJB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:01:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="201049700"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="201049700"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 02:01:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="667757443"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 02:01:40 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
References: <20210723080000.93953-1-ying.huang@intel.com>
        <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
        <YPs6cQo7iG1JcOn8@casper.infradead.org>
        <8735rr54i9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YQkwBdpWTPjv4xIx@casper.infradead.org>
Date:   Wed, 04 Aug 2021 17:01:39 +0800
In-Reply-To: <YQkwBdpWTPjv4xIx@casper.infradead.org> (Matthew Wilcox's message
        of "Tue, 3 Aug 2021 13:01:09 +0100")
Message-ID: <87czqt4m8c.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Aug 03, 2021 at 04:14:38PM +0800, Huang, Ying wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> > But I REALLY REALLY REALLY want a reproducer.  Right now, I have a hard
>> > time believing this, or any of the other races can really happen.
>> 
>> I think the race is only theoretical too.  Firstly, swapoff is a rare
>> operations in practice; secondly, the race window is really small.
>
> So do something to provoke it.  Widen the window.  Put an msleep(1000)
> between *pagep = NULL and the call to get_swap_device().  That's assuming
> that the swapon/swapoff loop that I proposed doesn't work.  Did you
> try it?

I haven't tried it.  Do you agree that the race is possible in theory?
But if you still really want it, I can try to do that.

Best Regards,
Huang, Ying
