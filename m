Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D550369E85
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 04:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbhDXCeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 22:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhDXCeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 22:34:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF8BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 19:33:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r7so38125402wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 19:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOmGJz1YMkX1d3zPs6qU93d5OQzAANLQ/MDgx0IN2Dw=;
        b=ta9rssePip7edcrE34ZasASEDthvSGLseGE9GD7p1VWVPVsb4A/J/LzedHXnEfFnO4
         4PhlFUL/muvuQLE/n0X85ELGxCdSxjS2AQwAd4NGFcstib+mYp43s1Plaien3T06MJUT
         7C0UHN9ecI8ljBFRgJnkIDow8EQ2RSlTR1s3M1YiJzBu8kDxnxAmAJkVZH84D7wJTOyi
         M6gZoMaGLsI99D7Z9uw9BfIYFew5qjMl5Es/hSuUxWjlIzPB5nBQ2wqIncv/JI0sUR95
         BalsjO0T/qLJzmm4DsFpTcdMLAgsgcRRmUPcD7G/OMkMx4apxasvglqhDvuQ2OifWSai
         D5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOmGJz1YMkX1d3zPs6qU93d5OQzAANLQ/MDgx0IN2Dw=;
        b=BaIKbRZ8UqMTHN6spT0el7EZTtmA9efw14jFAkzRIMxDgvnNomfhdcx/KCgn5v+/Yv
         x10seyBccBNwF2BJHY2YzZ3wiyxHyHttIgzPi+uGdIhKhayy4ExUJi2p92ZOX6lK4HzD
         uv1N6tF1KhlxLKY8RLVTvOUKnmxrR1jDW+D7SAm8oEu0V/g9ft1ECwlHpn3qMjL0+w4z
         J5iNuokOHBK6LuakBRdQ9yMB0ecMZaY64r3II89G3YW9qM9QWoKFCWRIGF2SrkTtFQbn
         Bhp8BwMINkyx58yiQLZIK/+x5ruPf720tDN66qu0WKbJeWVTOtLhH1TENN/DiQ/qa/jU
         9PeQ==
X-Gm-Message-State: AOAM532t9qfqNq/MvIfv5tDfkqavNlNbiDNTnSjvyYC8UQa2gtd9nAP2
        BLz+i+RBtGdHcm89R/s+Mp/N/ZYXE0AlevQVLPZyBQ==
X-Google-Smtp-Source: ABdhPJwrS12uckB2hzMR4Ggc6bBm61WaYkKatrm6wvUyapuAnzX7rVpdAlmghVDKocxd2l/58IdtI9Yj55whwGANIRg=
X-Received: by 2002:adf:e381:: with SMTP id e1mr7961383wrm.323.1619231609325;
 Fri, 23 Apr 2021 19:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210413075155.32652-1-sjpark@amazon.de> <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area> <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
 <20210414155130.GU3762101@tassilo.jf.intel.com> <CAOUHufZ4o4zmW_PyRCXWmBj4OVgVJdC6h1wZsJFMWpGxpzyGdg@mail.gmail.com>
 <20210415030002.GX3762101@tassilo.jf.intel.com> <CAOUHufaAz72+0HJu=XPv-6T8rUAdYo_mb5=H+yF3=LfwoufeYg@mail.gmail.com>
 <20210415095708.GA6874@lespinasse.org>
In-Reply-To: <20210415095708.GA6874@lespinasse.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 23 Apr 2021 20:33:17 -0600
Message-ID: <CAOUHufZY62nDZiPvFH_SuMLN-4Nxhr0HeOo06RWdTcE9QbhhXg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Michel Lespinasse <michel@lespinasse.org>
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
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 12:48 AM Michel Lespinasse
<michel@lespinasse.org> wrote:
> On Thu, Apr 15, 2021 at 01:13:13AM -0600, Yu Zhao wrote:
> > Page table scanning doesn't replace the existing rmap walk. It is
> > complementary and only happens when it is likely that most of the
> > pages on a system under pressure have been referenced, i.e., out of
> > *inactive* pages, by definition of the existing implementation. Under
> > such a condition, scanning *active* pages one by one with the rmap is
> > likely to cost more than scanning them all at once via page tables.
> > When we evict *inactive* pages, we still use the rmap and share a
> > common path with the existing code.
> >
> > Page table scanning falls back to the rmap walk if the page tables of
> > a process are apparently sparse, i.e., rss < size of the page tables.
>
> Could you expand a bit more as to how page table scanning and rmap
> scanning coexist ? Say, there is some memory pressure and you want to
> identify good candidate pages to recaim. You could scan processes with
> the page table scanning method, or you could scan the lru list through
> the rmap method. How do you mix the two - when you use the lru/rmap
> method, won't you encounter both pages that are mapped in "dense"
> processes where scanning page tables would have been better, and pages
> that are mapped in "sparse" processes where you are happy to be using
> rmap, and even pges that are mapped into both types of processes at
> once ?  Or, can you change the lru/rmap scan so that it will efficiently
> skip over all dense processes when you use it ?

Hi Michel,

Sorry for the late reply. I was out of town and am still catching up on emails.

That's a great question. Currently the page table scanning isn't smart
enough to know where dense regions are. My plan was to improve it
gradually but it seems it couldn't wait because people have major
concerns over this.

At the moment, the page table scanning decides if a process is worthy
by checking its RSS against the size of its page tables. This can only
avoid extremely sparse regions, meaning the page table scanning will
scan regions that ideally should be covered by the rmap, for some
worse case scenarios. My next step is to add a bloom filter so it can
quickly determine dense regions and target them only.

Given what I just said, the rmap is unlikely to encounter dense
regions, and that's why the perf profile shows its cpu usage drops
from ~30% to ~5%.

Now the question is how we build the bloom filter. A simple answer is
to let the rmap do the legwork, i.e., when it encounters dense
regions, add them to the filter. Of course this means we'll have to
use the rmap more than we do now, which is not ideal for some
workloads but necessary to avoid worst case scenarios.

Does it make sense?
