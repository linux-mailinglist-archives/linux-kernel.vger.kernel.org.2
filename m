Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37E35F87B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352538AbhDNPyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:54:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:37711 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350935AbhDNPxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:53:13 -0400
IronPort-SDR: exIqsgTeLUJrbtK/MAX3IOxwrC88OPT/B4DSCmK881cfQb/Iy1wG2QfEyLmPPhKA0F2yzukTza
 nAyWrIr2hXPA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="279979844"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="279979844"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 08:51:32 -0700
IronPort-SDR: XIVu+S/eRyaGWRdU1FaHTPNytGmcRAh9mWp1bQiFCttzqGk7tZPEjSWJk03ABIP8GUytCn+UCh
 KdnCJKtrT0cQ==
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="424790149"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 08:51:31 -0700
Date:   Wed, 14 Apr 2021 08:51:30 -0700
From:   Andi Kleen <ak@linux.intel.com>
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
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
Message-ID: <20210414155130.GU3762101@tassilo.jf.intel.com>
References: <20210413075155.32652-1-sjpark@amazon.de>
 <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area>
 <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>    2) It will not scan PTE tables under non-leaf PMD entries that do not
>       have the accessed bit set, when
>       CONFIG_HAVE_ARCH_PARENT_PMD_YOUNG=y.

This assumes  that workloads have reasonable locality. Could there
be a worst case where only one or two pages in each PTE are used,
so this PTE skipping trick doesn't work?

-Andi
