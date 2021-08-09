Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD33E5015
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 01:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhHIXoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 19:44:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:31239 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232717AbhHIXoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 19:44:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="300392518"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="300392518"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 16:43:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="525563317"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 16:43:47 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
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
        <CAHbLzkrShKORwU-Zrf5_5c6_o_iVwoXRTT+7ABZALLj7p0w-Ug@mail.gmail.com>
        <d1c768c-8b6-6a9d-ddde-39ac51286927@google.com>
        <CAHbLzkrqY=L2bEeEfAkApkoz=sRUk-Nk_KBDWGAbsqapY+xG1Q@mail.gmail.com>
        <CAHbLzko7LJmxkVuZTX35Aj65V29ukXmioJtrkiTtGrTyK9q7Sw@mail.gmail.com>
Date:   Tue, 10 Aug 2021 07:43:46 +0800
In-Reply-To: <CAHbLzko7LJmxkVuZTX35Aj65V29ukXmioJtrkiTtGrTyK9q7Sw@mail.gmail.com>
        (Yang Shi's message of "Mon, 9 Aug 2021 14:26:49 -0700")
Message-ID: <87k0ku89ql.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> On Fri, Aug 6, 2021 at 1:37 PM Yang Shi <shy828301@gmail.com> wrote:
>>
>> On Thu, Aug 5, 2021 at 11:01 PM Hugh Dickins <hughd@google.com> wrote:
>> >
>> > On Thu, 5 Aug 2021, Yang Shi wrote:
>> > > On Tue, Aug 3, 2021 at 10:34 PM Hugh Dickins <hughd@google.com> wrote:
>> > > >
>> > > > I've never seen the swapoff race claimed by Miaohe, and don't expect to;
>> > > > but he's probably right, given the current code.  I just dislike adding
>> > > > unnecessary complexity, and siting it in the wrong place (mm/shmem.c).
>> > > >
>> > > > Yang, is it possible that 5.1 commit 8fd2e0b505d1 ("mm: swap: check if
>> > > > swap backing device is congested or not") was actually developed and
>> > > > measured on 4.1 or earlier, which still had blk_set_queue_congested()?
>> > >
>> > > I forgot the exact version, but definitely not 4.1 or earlier. Maybe
>> > > 4.19 or earlier. I'm not familiar with how block layer detect
>> > > congestion, if the logic was changed, hence the optimization doesn't
>> > > stand anymore nowadays, I'm totally fine to remove it.
>> >
>> > You drove me back to look more closely.  blk_set_queue_congested()
>> > vanished from include/linux/blkdev.h in 4.2, but blk_set_congested()
>> > appeared then in block/blk-core.c to replace it.  blk_set_congested()
>> > vanished (along with all references to "congested" in blk-core.c) in
>> > 5.0, then your commit (most probably tested on 4.19) went into 5.1 -
>> > just after it had become redundant!
>> >
>> > Thanks, yes, let's revert that and Miaohe's and Huang's, later on.
>>
>> It should be easier to revert Huang Ying's , then Miaohe's, then mine.
>
> Hi Ying,
>
> I just prepared the reverts since I need to revert yours and Miaohe's
> in order to revert my problematic commit.

If your original commit will be reverted, then mine and Miaohe's can be
reverted from the race condition point of view.

Although I still think it's better to call get/put_swap_device() in
shmem_swapin_page(), that can be discussed with another patch.

Best Regards,
Huang, Ying
