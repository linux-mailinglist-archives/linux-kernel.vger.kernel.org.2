Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0975360426
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhDOIU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:20:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:41923 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231483AbhDOIU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:20:26 -0400
IronPort-SDR: mfvJ8iApM7hmrz0CvwS/TtodCyto2EEKegfwdjmmjd1WLIwYUviQfFyFma4Q4jNRUGE0EQbhkH
 ZyY2FK2fLN4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174915921"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="174915921"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 01:20:03 -0700
IronPort-SDR: TfNJDq3moFAFzCHkvOEDK/CPLHTJL3Z1oA/NTpxQDcsf8QA3NprtYMKpTvKtuUyqYZ8Nl1NZ2x
 1tYBNB7Zgdmg==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="522284833"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 01:19:54 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        SeongJae Park <sj38.park@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
References: <20210413075155.32652-1-sjpark@amazon.de>
        <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
        <20210413231436.GF63242@dread.disaster.area>
        <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
        <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
        <20210414155130.GU3762101@tassilo.jf.intel.com>
        <CAOUHufZ4o4zmW_PyRCXWmBj4OVgVJdC6h1wZsJFMWpGxpzyGdg@mail.gmail.com>
        <20210415030002.GX3762101@tassilo.jf.intel.com>
        <CAOUHufaAz72+0HJu=XPv-6T8rUAdYo_mb5=H+yF3=LfwoufeYg@mail.gmail.com>
Date:   Thu, 15 Apr 2021 16:19:52 +0800
In-Reply-To: <CAOUHufaAz72+0HJu=XPv-6T8rUAdYo_mb5=H+yF3=LfwoufeYg@mail.gmail.com>
        (Yu Zhao's message of "Thu, 15 Apr 2021 01:13:13 -0600")
Message-ID: <87a6q0ot7b.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Wed, Apr 14, 2021 at 9:00 PM Andi Kleen <ak@linux.intel.com> wrote:
>>
>> > We fall back to the rmap when it's obviously not smart to do so. There
>> > is still a lot of room for improvement in this function though, i.e.,
>> > it should be per VMA and NUMA aware.
>>
>> Okay so it's more a question to tune the cross over heuristic. That
>> sounds much easier than replacing everything.
>>
>> Of course long term it might be a problem to maintain too many
>> different ways to do things, but I suppose short term it's a reasonable
>> strategy.
>
> Hi Rik, Ying,
>
> Sorry for being persistent. I want to make sure we are on the same page:
>
> Page table scanning doesn't replace the existing rmap walk. It is
> complementary and only happens when it is likely that most of the
> pages on a system under pressure have been referenced, i.e., out of
> *inactive* pages, by definition of the existing implementation. Under
> such a condition, scanning *active* pages one by one with the rmap is
> likely to cost more than scanning them all at once via page tables.
> When we evict *inactive* pages, we still use the rmap and share a
> common path with the existing code.
>
> Page table scanning falls back to the rmap walk if the page tables of
> a process are apparently sparse, i.e., rss < size of the page tables.
>
> I should have clarified this at the very beginning of the discussion.
> But it has become so natural to me and I assumed we'd all see it this
> way.
>
> Your concern regarding the NUMA optimization is still valid, and it's
> a high priority.

Hi, Yu,

In general, I think it's a good idea to combine the page table scanning
and rmap scanning in the page reclaiming.  For example, if the
working-set is transitioned, we can take advantage of the fast page
table scanning to identify the new working-set quickly.  While we can
fallback to the rmap scanning if the page table scanning doesn't help.

Best Regards,
Huang, Ying
