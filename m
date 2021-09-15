Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0F240BD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhIOByj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:54:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:44190 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhIOByi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:54:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="220307724"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="220307724"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 18:53:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="544379680"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 18:53:17 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH -V8 2/6] memory tiering: add page promotion counter
References: <20210914013701.344956-1-ying.huang@intel.com>
        <20210914013701.344956-3-ying.huang@intel.com>
        <CAHbLzkqhA0YJncxYokViaAa1Eo5RuMjiRmqGYb_=QAniYBd-bA@mail.gmail.com>
Date:   Wed, 15 Sep 2021 09:53:16 +0800
In-Reply-To: <CAHbLzkqhA0YJncxYokViaAa1Eo5RuMjiRmqGYb_=QAniYBd-bA@mail.gmail.com>
        (Yang Shi's message of "Tue, 14 Sep 2021 15:41:49 -0700")
Message-ID: <87y27y1u5v.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> On Mon, Sep 13, 2021 at 6:37 PM Huang Ying <ying.huang@intel.com> wrote:
>>
>> To distinguish the number of the memory tiering promoted pages from
>> that of the originally inter-socket NUMA balancing migrated pages.
>> The counter is per-node (count in the target node).  So this can be
>> used to identify promotion imbalance among the NUMA nodes.
>
> I'd like this patch be the very first one in the series. Since we need
> such counters regardless of all the optimizations. And actually I
> think this patch could go with the merged "migration in lieu of
> discard" patchset.

Yes.  This sounds reasonable.  I will change this in the next version.

Best Regards,
Huang, Ying
