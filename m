Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B703335FBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353477AbhDNTnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353460AbhDNTnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:43:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C05C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:42:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x7so20964165wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3yUW62E14xkCs8N3EwC4nKiJhQZReyXLBADYqgmxt6k=;
        b=QQQYwsTNhGpJVYQVOFKaeAgGiONW1SBnx2nIL0vCpCezxdRLF9QdytREmTA3tCeo8h
         73mh6m8gQxZttrDMvPd14wJQlP+oL6JLwZogH0Nk4sttcqy7E1z4+XMNP1arayYYLeXB
         g8V+zqfwUQF5jRsU3fPVpU5aM4zDOTi89aSLib3vyaIXuSGDnZv7iI/Wnp2t0UCkqrap
         IkQZ9s3oXKRs4QMCzPMFamC4cD3ihPDk8TK641yGBAvloYh2SB/LwnqhpSMfVO2xHP2g
         JdJUugDucFUdqLb5oZ7RMTyTnhzxjPcIuB753paBLk0meGp293sujBR6NlCBQfmYrUnL
         yMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3yUW62E14xkCs8N3EwC4nKiJhQZReyXLBADYqgmxt6k=;
        b=DImWDWNsqWog7115RWbpVUJKI6fKHi1YINJGy/Cnx/zhfvQew1t1k73CxqHFvs8L8q
         jC01rJv+7IUE8XSQcWJMNdkfUQHf+vdmyMMXvIzRtJO8El/huXXmbYz6JBXGLD6MnqYy
         ZH+3O3n/AI9plmaPf/5lGDU3BMU9CRv3mxRc956js1OBwutsGS7RfFlXn8jjYWY79LMG
         suUVVWi1Gb5mTF4330gILjLwDDeBClYATutCh8lwdiYudAjUjpWOdYKW6ZF0XIQFmS8P
         WccRF3zkHBd9TqeYtOcR11qEEXkXTI1nfA1kEUQAzSViB1W1qXphFzskpzk9iwK1jprl
         4GPg==
X-Gm-Message-State: AOAM531Wi+CkvLLQIUtkp9H+0x44l9cuwIqYyWQIzOOqgPjWJSzuGEdp
        qR79QJ0XYNmiuyhMl0+ZYxjXsHEJF2FKzQRBcocAng==
X-Google-Smtp-Source: ABdhPJwAJmWOYnyVoNvS/S04ShTxn9pdqq/vJK9wuyHhSFh3P6FidBeqq/PXHh0+wYqqqzhAdoBbFr7zOPYdI3Tl0U0=
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr36033477wru.92.1618429361699;
 Wed, 14 Apr 2021 12:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210413075155.32652-1-sjpark@amazon.de> <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area> <91146ee7-3054-a81a-296e-e75c24f4e290@kernel.dk>
In-Reply-To: <91146ee7-3054-a81a-296e-e75c24f4e290@kernel.dk>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 14 Apr 2021 13:42:30 -0600
Message-ID: <CAOUHufZxz9ucfLexutAKi8EjHKrT4NfMhsvbk+3DDymaEhp-Rg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dave Chinner <david@fromorbit.com>,
        SeongJae Park <sj38.park@gmail.com>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
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
        Rik van Riel <riel@surriel.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 8:43 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/13/21 5:14 PM, Dave Chinner wrote:
> > On Tue, Apr 13, 2021 at 10:13:24AM -0600, Jens Axboe wrote:
> >> On 4/13/21 1:51 AM, SeongJae Park wrote:
> >>> From: SeongJae Park <sjpark@amazon.de>
> >>>
> >>> Hello,
> >>>
> >>>
> >>> Very interesting work, thank you for sharing this :)
> >>>
> >>> On Tue, 13 Apr 2021 00:56:17 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >>>
> >>>> What's new in v2
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> Special thanks to Jens Axboe for reporting a regression in buffered
> >>>> I/O and helping test the fix.
> >>>
> >>> Is the discussion open?  If so, could you please give me a link?
> >>
> >> I wasn't on the initial post (or any of the lists it was posted to), b=
ut
> >> it's on the google page reclaim list. Not sure if that is public or no=
t.
> >>
> >> tldr is that I was pretty excited about this work, as buffered IO tend=
s
> >> to suck (a lot) for high throughput applications. My test case was
> >> pretty simple:
> >>
> >> Randomly read a fast device, using 4k buffered IO, and watch what
> >> happens when the page cache gets filled up. For this particular test,
> >> we'll initially be doing 2.1GB/sec of IO, and then drop to 1.5-1.6GB/s=
ec
> >> with kswapd using a lot of CPU trying to keep up. That's mainline
> >> behavior.
> >
> > I see this exact same behaviour here, too, but I RCA'd it to
> > contention between the inode and memory reclaim for the mapping
> > structure that indexes the page cache. Basically the mapping tree
> > lock is the contention point here - you can either be adding pages
> > to the mapping during IO, or memory reclaim can be removing pages
> > from the mapping, but we can't do both at once.
> >
> > So we end up with kswapd spinning on the mapping tree lock like so
> > when doing 1.6GB/s in 4kB buffered IO:
> >
> > -   20.06%     0.00%  [kernel]               [k] kswapd                =
                                                                           =
             =E2=96=92
> >    - 20.06% kswapd                                                     =
                                                                           =
             =E2=96=92
> >       - 20.05% balance_pgdat                                           =
                                                                           =
             =E2=96=92
> >          - 20.03% shrink_node                                          =
                                                                           =
             =E2=96=92
> >             - 19.92% shrink_lruvec                                     =
                                                                           =
             =E2=96=92
> >                - 19.91% shrink_inactive_list                           =
                                                                           =
             =E2=96=92
> >                   - 19.22% shrink_page_list                            =
                                                                           =
             =E2=96=92
> >                      - 17.51% __remove_mapping                         =
                                                                           =
             =E2=96=92
> >                         - 14.16% _raw_spin_lock_irqsave                =
                                                                           =
             =E2=96=92
> >                            - 14.14% do_raw_spin_lock                   =
                                                                           =
             =E2=96=92
> >                                 __pv_queued_spin_lock_slowpath         =
                                                                           =
             =E2=96=92
> >                         - 1.56% __delete_from_page_cache               =
                                                                           =
             =E2=96=92
> >                              0.63% xas_store                           =
                                                                           =
             =E2=96=92
> >                         - 0.78% _raw_spin_unlock_irqrestore            =
                                                                           =
             =E2=96=92
> >                            - 0.69% do_raw_spin_unlock                  =
                                                                           =
             =E2=96=92
> >                                 __raw_callee_save___pv_queued_spin_unlo=
ck                                                                         =
             =E2=96=92
> >                      - 0.82% free_unref_page_list                      =
                                                                           =
             =E2=96=92
> >                         - 0.72% free_unref_page_commit                 =
                                                                           =
             =E2=96=92
> >                              0.57% free_pcppages_bulk                  =
                                                                           =
             =E2=96=92
> >
> > And these are the processes consuming CPU:
> >
> >    5171 root      20   0 1442496   5696   1284 R  99.7   0.0   1:07.78 =
fio
> >    1150 root      20   0       0      0      0 S  47.4   0.0   0:22.70 =
kswapd1
> >    1146 root      20   0       0      0      0 S  44.0   0.0   0:21.85 =
kswapd0
> >    1152 root      20   0       0      0      0 S  39.7   0.0   0:18.28 =
kswapd3
> >    1151 root      20   0       0      0      0 S  15.2   0.0   0:12.14 =
kswapd2
>
> Here's my profile when memory reclaim is active for the above mentioned
> test case. This is a single node system, so just kswapd. It's using aroun=
d
> 40-45% CPU:
>
>     43.69%  kswapd0  [kernel.vmlinux]  [k] xas_create
>             |
>             ---ret_from_fork
>                kthread
>                kswapd
>                balance_pgdat
>                shrink_node
>                shrink_lruvec
>                shrink_inactive_list
>                shrink_page_list
>                __delete_from_page_cache
>                xas_store
>                xas_create
>
>     16.88%  kswapd0  [kernel.vmlinux]  [k] queued_spin_lock_slowpath
>             |
>             ---ret_from_fork
>                kthread
>                kswapd
>                balance_pgdat
>                shrink_node
>                shrink_lruvec
>                |
>                 --16.82%--shrink_inactive_list
>                           |
>                            --16.55%--shrink_page_list
>                                      |
>                                       --16.26%--_raw_spin_lock_irqsave
>                                                 queued_spin_lock_slowpath
>
>      9.89%  kswapd0  [kernel.vmlinux]  [k] shrink_page_list
>             |
>             ---ret_from_fork
>                kthread
>                kswapd
>                balance_pgdat
>                shrink_node
>                shrink_lruvec
>                shrink_inactive_list
>                shrink_page_list
>
>      5.46%  kswapd0  [kernel.vmlinux]  [k] xas_init_marks
>             |
>             ---ret_from_fork
>                kthread
>                kswapd
>                balance_pgdat
>                shrink_node
>                shrink_lruvec
>                shrink_inactive_list
>                shrink_page_list
>                |
>                 --5.41%--__delete_from_page_cache
>                           xas_init_marks
>
>      4.42%  kswapd0  [kernel.vmlinux]  [k] __delete_from_page_cache
>             |
>             ---ret_from_fork
>                kthread
>                kswapd
>                balance_pgdat
>                shrink_node
>                shrink_lruvec
>                shrink_inactive_list
>                |
>                 --4.40%--shrink_page_list
>                           __delete_from_page_cache
>
>      2.82%  kswapd0  [kernel.vmlinux]  [k] isolate_lru_pages
>             |
>             ---ret_from_fork
>                kthread
>                kswapd
>                balance_pgdat
>                shrink_node
>                shrink_lruvec
>                |
>                |--1.43%--shrink_active_list
>                |          isolate_lru_pages
>                |
>                 --1.39%--shrink_inactive_list
>                           isolate_lru_pages
>
>      1.99%  kswapd0  [kernel.vmlinux]  [k] free_pcppages_bulk
>             |
>             ---ret_from_fork
>                kthread
>                kswapd
>                balance_pgdat
>                shrink_node
>                shrink_lruvec
>                shrink_inactive_list
>                shrink_page_list
>                free_unref_page_list
>                free_unref_page_commit
>                free_pcppages_bulk
>
>      1.79%  kswapd0  [kernel.vmlinux]  [k] _raw_spin_lock_irqsave
>             |
>             ---ret_from_fork
>                kthread
>                kswapd
>                balance_pgdat
>                |
>                 --1.76%--shrink_node
>                           shrink_lruvec
>                           shrink_inactive_list
>                           |
>                            --1.72%--shrink_page_list
>                                      _raw_spin_lock_irqsave
>
>      1.02%  kswapd0  [kernel.vmlinux]  [k] workingset_eviction
>             |
>             ---ret_from_fork
>                kthread
>                kswapd
>                balance_pgdat
>                shrink_node
>                shrink_lruvec
>                shrink_inactive_list
>                |
>                 --1.00%--shrink_page_list
>                           workingset_eviction
>
> > i.e. when memory reclaim kicks in, the read process has 20% less
> > time with exclusive access to the mapping tree to insert new pages.
> > Hence buffered read performance goes down quite substantially when
> > memory reclaim kicks in, and this really has nothing to do with the
> > memory reclaim LRU scanning algorithm.
> >
> > I can actually get this machine to pin those 5 processes to 100% CPU
> > under certain conditions. Each process is spinning all that extra
> > time on the mapping tree lock, and performance degrades further.
> > Changing the LRU reclaim algorithm won't fix this - the workload is
> > solidly bound by the exclusive nature of the mapping tree lock and
> > the number of tasks trying to obtain it exclusively...
>
> I've seen way worse than the above as well, it's just my go-to easy test
> case for "man I wish buffered IO didn't suck so much".
>
> >> The initial posting of this patchset did no better, in fact it did a b=
it
> >> worse. Performance dropped to the same levels and kswapd was using as
> >> much CPU as before, but on top of that we also got excessive swapping.
> >> Not at a high rate, but 5-10MB/sec continually.
> >>
> >> I had some back and forths with Yu Zhao and tested a few new revisions=
,
> >> and the current series does much better in this regard. Performance
> >> still dips a bit when page cache fills, but not nearly as much, and
> >> kswapd is using less CPU than before.
> >
> > Profiles would be interesting, because it sounds to me like reclaim
> > *might* be batching page cache removal better (e.g. fewer, larger
> > batches) and so spending less time contending on the mapping tree
> > lock...
> >
> > IOWs, I suspect this result might actually be a result of less lock
> > contention due to a change in batch processing characteristics of
> > the new algorithm rather than it being a "better" algorithm...
>
> See above - let me know if you want to see more specific profiling as
> well.

Hi Jens,

Thanks for the profiles.

Does the code path I've demonstrated seem clear to you?

Recap:

When randomly accessing a (not infinitely) large file long enough,
some blocks are bound to be accessed multiple times. In the buffered
io access path, mark_page_accessed() activates them, i.e., moving them
to the active list. Once memory is filled and kswapd starts
reclaiming, shrink_active_list() deactivates them, i.e., moving them
back to the inactive list. Both take the lru lock to add/remove pages
to/from the active/inactive lists.

IOW, pages accessed multiple times bounce between the active and the
inactive lists when random accesses put a system under memory
pressure. For random accesses, pages accessed multiple times are not
different from those accessed once, in terms of page reclaim.
(Statistically speaking, they would be less unlikely to be used
again.)

I'd be happy to give it another try if there is anything unclear.

Thanks.
