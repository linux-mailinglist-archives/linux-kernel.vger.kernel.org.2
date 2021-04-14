Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC535F64B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhDNOja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhDNOjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:39:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Sv9NEP22wjna5CIpFfxEXT3qRzPSodaVUOesDxk1QA=; b=VLkGN1vJjSHuydMty0NSFfPDnq
        avZRQ4ysQU5wSO8a8yVkJqe6H5ZsDqXUGlxnLpeH+8sLO8LBS7sdU6I64XNB8GUnn0HH3aJIQxZMd
        LvjncF+hpEmIgxElClojr6YNbkmIhgzlyUfUQ02+eOnW5G0zWLrFmmYms3I/yfVF4YsNJa8ZWcsu1
        m7xA6Sq8ZeNzmQUxfYZexyEceaK9rqjr1VWRzYgfZxcv51N8LnLrWqP+HOSf+4VvxTdjwpj5ePMOw
        kXrXk6zE9M0TqHymq07CJGeaCU67MmcmQjpIvbSKFpr2C4KzHpGfh3rlYrKKnPXr8lfs1E1Odbm8b
        YKFKDqLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWgd0-007EGl-DK; Wed, 14 Apr 2021 14:36:29 +0000
Date:   Wed, 14 Apr 2021 15:36:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Alex Shi <alexs@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        page-reclaim@google.com
Subject: Re: [PATCH v2 10/16] mm: multigenerational lru: mm_struct list
Message-ID: <20210414143626.GT2531743@casper.infradead.org>
References: <20210413065633.2782273-1-yuzhao@google.com>
 <20210413065633.2782273-11-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413065633.2782273-11-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 12:56:27AM -0600, Yu Zhao wrote:
> In order to scan page tables, we add an infrastructure to maintain
> either a system-wide mm_struct list or per-memcg mm_struct lists.
> Multiple threads can concurrently work on the same mm_struct list, and
> each of them will be given a different mm_struct.
> 
> This infrastructure also tracks whether an mm_struct is being used on
> any CPUs or has been used since the last time a worker looked at it.
> In other words, workers will not be given an mm_struct that belongs to
> a process that has been sleeping.

This seems like a great use for an allocating XArray.  You can use a
search mark to indicate whether it's been used since the last time a
worker looked at it.

