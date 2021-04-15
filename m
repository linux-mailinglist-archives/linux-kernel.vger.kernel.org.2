Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BA136342D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 08:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhDRGtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 02:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhDRGtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 02:49:12 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E6AC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 23:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-12-ed;
 t=1618480628; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=32BZ+U1/+vujlcDitqQfqCs8E48UwSHYgwSNpIYuZYg=;
 b=0OnnkKxJXqb8GR8MZAGnbjDPtjW/EABxAT7cd8D7DqI8nAXFazIpQcTTVoJG4kDl08jy6
 wfmILx3TmwfVfZVAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-12-rsa; t=1618480628; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=32BZ+U1/+vujlcDitqQfqCs8E48UwSHYgwSNpIYuZYg=;
 b=A5uiV4M0DOAsXYAeYPSUqTa2XZg2g7gantNn74Umk8eJraWtYeLlQ/p7YneMchGDax0aW
 pkHJP650JjBuCwsginSUcqHkVFkoSk+m0FqJPHVN9hiCWP7s8THvy+ElRPlKNLX9oqg0DRn
 OQVzD4mae1b0HmtZ6eK/XroQcCYBbv/MMGk6iNKTWcy4Yw0krhCjExRDIYWbnWZdUHkwF5o
 InSRwYB64Fhm/QLkRIaNkqHP6lr2wS0SwMhFUIoCLxG7p3lMWhgsJ8hv5oG8ha1s5dyMT95
 8db5YQhZ9cwZb3PVx4M+IKyY+MkHW28nSwZpCscT8zb04bwPbx7X+BWJVy8w==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 2EB59160527; Thu, 15 Apr 2021 02:57:08 -0700 (PDT)
Date:   Thu, 15 Apr 2021 02:57:08 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Rik van Riel <riel@surriel.com>, Ying Huang <ying.huang@intel.com>,
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
Message-ID: <20210415095708.GA6874@lespinasse.org>
References: <20210413075155.32652-1-sjpark@amazon.de>
 <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area>
 <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
 <20210414155130.GU3762101@tassilo.jf.intel.com>
 <CAOUHufZ4o4zmW_PyRCXWmBj4OVgVJdC6h1wZsJFMWpGxpzyGdg@mail.gmail.com>
 <20210415030002.GX3762101@tassilo.jf.intel.com>
 <CAOUHufaAz72+0HJu=XPv-6T8rUAdYo_mb5=H+yF3=LfwoufeYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufaAz72+0HJu=XPv-6T8rUAdYo_mb5=H+yF3=LfwoufeYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 01:13:13AM -0600, Yu Zhao wrote:
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

Could you expand a bit more as to how page table scanning and rmap
scanning coexist ? Say, there is some memory pressure and you want to
identify good candidate pages to recaim. You could scan processes with
the page table scanning method, or you could scan the lru list through
the rmap method. How do you mix the two - when you use the lru/rmap
method, won't you encounter both pages that are mapped in "dense"
processes where scanning page tables would have been better, and pages
that are mapped in "sparse" processes where you are happy to be using
rmap, and even pges that are mapped into both types of processes at
once ?  Or, can you change the lru/rmap scan so that it will efficiently
skip over all dense processes when you use it ?

Thanks,

--
Michel "walken" Lespinasse
