Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB133369E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 05:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbhDXDbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 23:31:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:48382 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhDXDbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 23:31:17 -0400
IronPort-SDR: C3O9MesraxACpLR34qZmPN1I/AxS8edirfalVLsPM9eyFG44E3zR42J7g4dNK3RFbigttUh97C
 xwp7koxh0a0Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="257463733"
X-IronPort-AV: E=Sophos;i="5.82,247,1613462400"; 
   d="scan'208";a="257463733"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 20:30:40 -0700
IronPort-SDR: GDpt/XE7DF3GrhacVF7Vpy23laFs/roeoUFy5BkMWagdXnUZPnMTIHXrOT2kg1nyQPmPbyfdlb
 ehwP5e+VqEkQ==
X-IronPort-AV: E=Sophos;i="5.82,247,1613462400"; 
   d="scan'208";a="535711869"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 20:30:40 -0700
Date:   Fri, 23 Apr 2021 20:30:38 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Rik van Riel <riel@surriel.com>,
        Ying Huang <ying.huang@intel.com>,
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
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
Message-ID: <20210424033038.GP1401198@tassilo.jf.intel.com>
References: <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area>
 <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
 <20210414155130.GU3762101@tassilo.jf.intel.com>
 <CAOUHufZ4o4zmW_PyRCXWmBj4OVgVJdC6h1wZsJFMWpGxpzyGdg@mail.gmail.com>
 <20210415030002.GX3762101@tassilo.jf.intel.com>
 <CAOUHufaAz72+0HJu=XPv-6T8rUAdYo_mb5=H+yF3=LfwoufeYg@mail.gmail.com>
 <20210415095708.GA6874@lespinasse.org>
 <CAOUHufZY62nDZiPvFH_SuMLN-4Nxhr0HeOo06RWdTcE9QbhhXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufZY62nDZiPvFH_SuMLN-4Nxhr0HeOo06RWdTcE9QbhhXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Now the question is how we build the bloom filter. A simple answer is
> to let the rmap do the legwork, i.e., when it encounters dense
> regions, add them to the filter. Of course this means we'll have to
> use the rmap more than we do now, which is not ideal for some
> workloads but necessary to avoid worst case scenarios.

How would you maintain the bloom filter over time? Assume a process
that always creates new mappings and unmaps old mappings. How 
do the stale old mappings get removed and avoid polluting it over time?

Or are you thinking of one of the fancier bloom filter variants
that support deletion? As I understand they're significantly less
space efficient and more complicated.

-Andi
