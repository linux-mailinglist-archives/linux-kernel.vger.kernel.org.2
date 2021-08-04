Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90E93DFD94
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbhHDJEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:04:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:13712 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235471AbhHDJEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:04:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="213912681"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="213912681"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 02:04:24 -0700
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="585373319"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 02:04:21 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
        <704d597-443b-32f-84eb-524a58dd8ef@google.com>
Date:   Wed, 04 Aug 2021 17:04:20 +0800
In-Reply-To: <704d597-443b-32f-84eb-524a58dd8ef@google.com> (Hugh Dickins's
        message of "Tue, 3 Aug 2021 22:34:52 -0700 (PDT)")
Message-ID: <875ywl4m3v.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hughd@google.com> writes:

> On Tue, 3 Aug 2021, Matthew Wilcox wrote:
>> On Tue, Aug 03, 2021 at 04:14:38PM +0800, Huang, Ying wrote:
>> > Matthew Wilcox <willy@infradead.org> writes:
>> > > But I REALLY REALLY REALLY want a reproducer.  Right now, I have a hard
>> > > time believing this, or any of the other races can really happen.
>> > 
>> > I think the race is only theoretical too.  Firstly, swapoff is a rare
>> > operations in practice; secondly, the race window is really small.
>> 
>> So do something to provoke it.  Widen the window.  Put an msleep(1000)
>> between *pagep = NULL and the call to get_swap_device().  That's assuming
>> that the swapon/swapoff loop that I proposed doesn't work.  Did you
>> try it?
>
> I've been doing that swapon/swapoff loop for years, while running kernel
> builds on tmpfs going out to swap; for better or worse on baremetal not VM.
>
> You're right that few will ever need that level of reliability; but it
> has caught problems from time to time, and I do insist on fixing them.
>
> I'm not as insistent as you on wanting a reproducer; and we all take pride
> sometimes in fixing ever more inconceivable bugs.  I'm not against that,
> but it's easy to end up with a fix more dangerous than what it claims to
> fix, rather like with random newbie cleanups.

Yes.  I totally agree, bug fixing is hard.

Best Regards,
Huang, Ying
