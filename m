Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A634B369EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 06:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhDXERH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 00:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhDXERF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 00:17:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67ACC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 21:16:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r7so38265296wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 21:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RJFosm8FHH2Jn0KGRwZnltNO8hwDftaaApIKsuH0kI=;
        b=vPsrQY60EaNeOA7ZDGwId49uyGwdlyrnVdS69f2LawN1hbdeYe/kXepyDMtZRvUkh3
         jR4OTkDycg0YVUbpO1znyY5GBtnfDbLygtgfltvHLSC4/Ni2+XtyMzTvzhHdsDR7yIbw
         hk6EAXyUNguGK6BJv4jSdujbJxE25ixPJ1VmBJ2GIrfrGesMYZS8BbKkcRNXyfS6QWWT
         7tmxNoqhdRW8HVDBQmL6y//O2oPyLUCQwYg4GKcbLLXSQXAVVnbrypTQItZVAI72M8tj
         mxYIQDOIUPumoELPEfM2KuHmJHd6NBttuqr+UFxTHwG6wYqaNuLw0YnmTrhO6HDO/0oB
         F24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RJFosm8FHH2Jn0KGRwZnltNO8hwDftaaApIKsuH0kI=;
        b=iCR1nMKcMLvzvRh6glHxhkaxJpE5IKKRfiU9MhzEjqxxk0G8RxbI9qIT36ZqJ4oIPR
         /MJ8YZthAB+VHc4xCGfPH3rW+uv2dlvBuy3gh5jO+DzuqwVEK7DFDMo37ynb+s0DOv4U
         Bf7G+nd0iZwY7HOrO1mK1XXk5Ik3owRCqQJZEOUOZY/6fwI8SHZsgN/5UZfHfIS1/PId
         BM/xBdj8YVY2uC3k2ow1gIAS1Z3rccFpv5D2aYwK7gYPvYcwc3Q1h+Ie/VGQuWa8qQ49
         UYBv963v04o/Xpiwbndef52lJVwjBsjm0DxSVcNYXeg6KTI/w/5GQdTyv4Z4vU0LSiti
         c5lw==
X-Gm-Message-State: AOAM532O/Mcmu2Y96gG7ApI8x/WHYL5dfwqpZaLI1qamDqtbHVS6UKAK
        S+e4US3SgrCSb3sLQZDYnHDsg905gacnNGl5fBD6Zw==
X-Google-Smtp-Source: ABdhPJxDPtDbP8/O8pGTZKhqRlwXWFr15MUui2u1oNy5Gd7ROtemc4SLTheDmZuw2EaYsgkgys+dKShgTrSp7TVya1A=
X-Received: by 2002:adf:9148:: with SMTP id j66mr8701215wrj.124.1619237785037;
 Fri, 23 Apr 2021 21:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area> <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
 <20210414155130.GU3762101@tassilo.jf.intel.com> <CAOUHufZ4o4zmW_PyRCXWmBj4OVgVJdC6h1wZsJFMWpGxpzyGdg@mail.gmail.com>
 <20210415030002.GX3762101@tassilo.jf.intel.com> <CAOUHufaAz72+0HJu=XPv-6T8rUAdYo_mb5=H+yF3=LfwoufeYg@mail.gmail.com>
 <20210415095708.GA6874@lespinasse.org> <CAOUHufZY62nDZiPvFH_SuMLN-4Nxhr0HeOo06RWdTcE9QbhhXg@mail.gmail.com>
 <20210424033038.GP1401198@tassilo.jf.intel.com>
In-Reply-To: <20210424033038.GP1401198@tassilo.jf.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 23 Apr 2021 22:16:12 -0600
Message-ID: <CAOUHufb44NbJOM0UkvBE=D7z-zm8Mkdk094QHW-msEZsBS2FFw@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Andi Kleen <ak@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 9:30 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > Now the question is how we build the bloom filter. A simple answer is
> > to let the rmap do the legwork, i.e., when it encounters dense
> > regions, add them to the filter. Of course this means we'll have to
> > use the rmap more than we do now, which is not ideal for some
> > workloads but necessary to avoid worst case scenarios.
>
> How would you maintain the bloom filter over time? Assume a process
> that always creates new mappings and unmaps old mappings. How
> do the stale old mappings get removed and avoid polluting it over time?
>
> Or are you thinking of one of the fancier bloom filter variants
> that support deletion? As I understand they're significantly less
> space efficient and more complicated.

Hi Andi,

That's where the double buffering technique comes in :)

Recap: the creation of each new generation starts with scanning page
tables to clear the accessed bit of pages referenced since the last
scan.

We scan page tables according to the current bloom filter, and at the
same time, we build a new one and write it to the second buffer.
During this step, we eliminate regions that have become invalid, e.g.,
too sparse or completely unmapped. Note that the scan *will* miss
newly mapped regions, i.e., dense regions that the rmap hasn't
discovered. Once this step is done, we flip to the second buffer. And
from now on, all the new dense regions discovered by the rmap will be
recorded into this buffer.

Each element in the bloom filter is a hash value from an address of a
page table and a node id, indicating this page table has a worth
number of pages from this node.

A single counting bloom filter works too but it doesn't seem to offer
any advantage over double buffering. And we need to handle overflow
too.
