Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B401435F88B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352560AbhDNP5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:57:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:5216 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232662AbhDNP5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:57:13 -0400
IronPort-SDR: WDd4lPt1AuUiPreH8j9oQz4plKBc1BpV+sYlUBm//YikBAKUVeap2Iu1aDf/udGQeWPdQ9yCyi
 40flsVQcscRw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="191484140"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="191484140"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 08:56:49 -0700
IronPort-SDR: 5Y/X998Ljj2Jxjpfsq/hVDjcfZCU8JZsvF2rGTzQLUNE5VeNnxg7dntcgoHjF/Yw47zakGLESf
 lI5RfYJka5kg==
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="443861179"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 08:56:48 -0700
Date:   Wed, 14 Apr 2021 08:56:47 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>,
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
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
Message-ID: <20210414155647.GV3762101@tassilo.jf.intel.com>
References: <20210413075155.32652-1-sjpark@amazon.de>
 <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area>
 <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
 <87tuo9qtmd.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <CAOUHufbk=TVOpEOvTNRBe0uoOWNZ=wf3umQ628ZFZ=QYhNqsHA@mail.gmail.com>
 <87lf9lqnit.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <93308ea276cfe7997c29ce7132516e830e8fec40.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93308ea276cfe7997c29ce7132516e830e8fec40.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Now imagine we have an 8 node system, and memory
> pressure in the DMA32 zone of node 0.

The question is how much do we still care about DMA32.
If there are problems they can probably just turn on the IOMMU for
these IO mappings.

-Andi
