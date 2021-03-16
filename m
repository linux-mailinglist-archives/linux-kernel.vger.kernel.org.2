Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5988A33CB45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhCPCHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:07:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:13311 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234123AbhCPCHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:07:45 -0400
IronPort-SDR: O4d0QDeO/9Mjyf8u+Vs8EUlynSGik+3/RrqEUG5dU+bvC8MnlKQd7QWXusbmoi2tE6YoseCksV
 QJrExgSTPYGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="274227362"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="274227362"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 19:07:45 -0700
IronPort-SDR: d2eDvlHl+dgThSXmfUvknY+TyZ1uWkRIbfoaWox9BycBJ4AK71ppXLeGh+u5OdGz3hVAMoHuJ7
 IZatz0beOQ6A==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="412045481"
Received: from unknown (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 19:07:40 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Yu Zhao <yuzhao@google.com>, <linux-mm@kvack.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>, <linux-kernel@vger.kernel.org>,
        <page-reclaim@google.com>
Subject: Re: [PATCH v1 09/14] mm: multigenerational lru: mm_struct list
References: <20210313075747.3781593-1-yuzhao@google.com>
        <20210313075747.3781593-10-yuzhao@google.com>
        <048e5e1e977e720c3f9fc536ac54beebcc8319f5.camel@surriel.com>
Date:   Tue, 16 Mar 2021 10:07:36 +0800
In-Reply-To: <048e5e1e977e720c3f9fc536ac54beebcc8319f5.camel@surriel.com> (Rik
        van Riel's message of "Mon, 15 Mar 2021 15:40:10 -0400")
Message-ID: <87pmzzsvfb.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@surriel.com> writes:

> On Sat, 2021-03-13 at 00:57 -0700, Yu Zhao wrote:
>
>> +/*
>> + * After pages are faulted in, they become the youngest generation.
>> They must
>> + * go through aging process twice before they can be evicted. After
>> first scan,
>> + * their accessed bit set during initial faults are cleared and they
>> become the
>> + * second youngest generation. And second scan makes sure they
>> haven't been used
>> + * since the first.
>> + */
>
> I have to wonder if the reductions in OOM kills and 
> low-memory tab discards is due to this aging policy
> change, rather than from the switch to virtual scanning.

If my understanding were correct, the temperature of the processes is
considered in addition to that of the individual pages.  That is, the
pages of the processes that haven't been scheduled after the previous
scanning will not be scanned.  I guess that this helps OOM kills?

If so, how about just take advantage of that information for OOM killing
and page reclaiming?  For example, if a process hasn't been scheduled
for long time, just reclaim its private pages.

Best Regards,
Huang, Ying
