Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA17D35FC51
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhDNUI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhDNUIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:08:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:08:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so1201147wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCkJ3L6wxS3AzadSsXtpvo5PeGe9Mmz+fl2xNX9Gte0=;
        b=VRFDLYUYYllSp7YVuiG8fJNtTM9SQhAmDOG4yLYbySp9D+R+snCUOxK/6p35n59Szz
         kcmbos1L8lzvhNgy3qiX9OOjlCRl5E8Bbqd5bxq7+GhTrGUEv4PoSMB3kioHkimQob7u
         /b24BCi6bR+B3SEM2MrtkYHnar2UeMNwEgRy+PZro8xiRzuAjlsdABqUM10ditulXlDa
         JyQFQlWGeEWimfMKn/uFhkxg8Sq6h9xm9BFaoRvXxyMTod/99Bf7JrEr6RS/XD/zFqsZ
         O5kWEiS9kLT+a4lJBiquMp/+MjlBn381TGPCAxGtpxKj9KX+Zj3U7hTLjh8Ep89PMlgk
         +sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCkJ3L6wxS3AzadSsXtpvo5PeGe9Mmz+fl2xNX9Gte0=;
        b=fyOWVQQJIbUKnRGy2da4yIGnpLWtaHT8oAwAUOgEFTLx7Lc5RXYrA3dfd6SH1Ek91u
         vj6X5C4rLDpIwgg6QnnmHyRE8umd1m0Nm7PPIeL0zhgCX2b/XG8tVcUCK29mK90fSCPr
         JMlsy+ABGsAW22zWDwaf7+rkPWfwAhH7BZXAwtfyqwIpjyl0OTAcvQWNgDCIjtPC82N6
         5RBPLTAuTxf/iwYUiodNmAs8d6a1lgoKxUSUeY2jMY7jYRzDS+tmC/KcRxN1Ox775Gx+
         0iL4+mMAgBZJHL54gVuIJrxFznQOzXYkR84oUTj2ZonYmT0Z6fehDdS9Js2171vyyOUw
         67rA==
X-Gm-Message-State: AOAM530iXrabLOoKcvj7o2QIgpPHkyQKXWcAiDwrgUELPXbp71B/Sf0n
        DVA4Kktcp/03fxyVqOXcU3NAYmF/GKvemDt+rj9FBg==
X-Google-Smtp-Source: ABdhPJyY2SsCoD/iPtzHo1ege18rCyoKZd1+jp9ZVgvOEQJvYhkgHuRWHI30WtYRv1mN7MwYW2ls5eWLmcMlzyFWf58=
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr4554076wmg.37.1618430912201;
 Wed, 14 Apr 2021 13:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210413075155.32652-1-sjpark@amazon.de> <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area> <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
 <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
 <20210414155130.GU3762101@tassilo.jf.intel.com> <e0ad1b48a1ad0b6d3a1e79129f397ddb6c32fe35.camel@surriel.com>
 <CAOUHufaRXbDHbEro1uE1CHvpWB4U67iroj0hT8CkUEOSAddzYQ@mail.gmail.com> <db2f6f81d30945eb296c4dcc9824b1ad353cc777.camel@surriel.com>
In-Reply-To: <db2f6f81d30945eb296c4dcc9824b1ad353cc777.camel@surriel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 14 Apr 2021 14:08:20 -0600
Message-ID: <CAOUHufY_hHs_dW-5PCGgw5-vnx4jERAmMF7_EoGYFTH-gthy2g@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Rik van Riel <riel@surriel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 1:42 PM Rik van Riel <riel@surriel.com> wrote:
>
> On Wed, 2021-04-14 at 13:14 -0600, Yu Zhao wrote:
> > On Wed, Apr 14, 2021 at 9:59 AM Rik van Riel <riel@surriel.com>
> > wrote:
> > > On Wed, 2021-04-14 at 08:51 -0700, Andi Kleen wrote:
> > > > >    2) It will not scan PTE tables under non-leaf PMD entries
> > > > > that
> > > > > do not
> > > > >       have the accessed bit set, when
> > > > >       CONFIG_HAVE_ARCH_PARENT_PMD_YOUNG=y.
> > > >
> > > > This assumes  that workloads have reasonable locality. Could
> > > > there
> > > > be a worst case where only one or two pages in each PTE are used,
> > > > so this PTE skipping trick doesn't work?
> > >
> > > Databases with large shared memory segments shared between
> > > many processes come to mind as a real-world example of a
> > > worst case scenario.
> >
> > Well, I don't think you two are talking about the same thing. Andi
> > was
> > focusing on sparsity. Your example seems to be about sharing, i.e.,
> > ihgh mapcount. Of course both can happen at the same time, as I
> > tested
> > here:
> > https://lore.kernel.org/linux-mm/YHFuL%2FDdtiml4biw@google.com/#t
> >
> > I'm skeptical that shared memory used by databases is that sparse,
> > i.e., one page per PTE table, because the extremely low locality
> > would
> > heavily penalize their performance. But my knowledge in databases is
> > close to zero. So feel free to enlighten me or just ignore what I
> > said.
>
> A database may have a 200GB shared memory segment,
> and a worker task that gets spun up to handle a
> query might access only 1MB of memory to answer
> that query.
>
> That memory could be from anywhere inside the
> shared memory segment. Maybe some of the accesses
> are more dense, and others more sparse, who knows?
>
> A lot of the locality
> will depend on how memory
> space inside the shared memory segment is reclaimed
> and recycled inside the database.

Thanks. Yeah, I guess we'll just need to see more benchmarks from the
database realm. Stay tuned :)
