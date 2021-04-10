Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF27735AFAE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 20:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhDJSsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 14:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhDJSsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 14:48:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588CDC06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 11:48:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f6so8808686wrv.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTZ1HTtR2Igrwe/7gneJXZiuObNOiU8xF1S7Z3ECO40=;
        b=HIWPly/JV5+nWY0Os8AEZWV44yJ3K6Nm1G0xMvDRJ1ci/3HTyep8los9HCvaMr2Dzv
         VdyDRNmB2G99w22dWNuIA1Js6OeD+ZOtCDFoUIZmyYwxE3CimhxBEPnGPWiOMADdiKdR
         k+217EXnsSN2Ok/oU9NfQOjyE8nzpSlFsjihx77wTXqEf2xNYVmzJWAXwOyGdMrK79Nq
         J5W8WAWsbmwydAQxjGaip4FpnyoUwSkE2caQWyxDU6fWOvhzTvzTwoMEfXYAKQSauF+D
         AR/xmMe8hW1Pv6pbEKYfU3I50UFdqsv59Y6jrYi/zDIfUcIF4a253Y2Rvr0NSfAkUADp
         8/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTZ1HTtR2Igrwe/7gneJXZiuObNOiU8xF1S7Z3ECO40=;
        b=iKyy9EhcEghmno2XwEoOf4QXq0U/1MSrAONm+h6i8RQuQAdlRbRnauhB1k5QuGpYD3
         0WC9UDhaV+uGVNwghZ2x6FPmaOeLIAp7o552xeUYFM9H59qUwPb+/+qjvP5okPi0jQyn
         VFla7W56y1boFOGEgD0znqQ05Snz72Hc6u+SjVmTcVEwqRejskYlRWKSSa/vq6K4U2JP
         pbH6NwEgXaWjPMG8CVDOLjegYzYyDlh/+YDrrHN85t7tXYoiSPtbPtVXDgCw2lXXRcyR
         meMtvf6IQCoDB1PkzmCr75qHw9Xi3G9X5lQFi4runRui58YiBve9GCCtAz74rwCxhnHF
         q4Fw==
X-Gm-Message-State: AOAM531YboHuUjtlZZ056eR4xOfiOQfy3kIEDxgq8uZOnllOD9J6jH6S
        nrGvuynGIlVUO1Q7RqBXpJWoDmd2Ls3AJf6LYQ32rA==
X-Google-Smtp-Source: ABdhPJyWvGTK1I0jACSYksta4U4rF+tig1HsaOZiHuPae/OrQ6YDFfvcqG29dusduWlrmXXNa0WjFYCa2MWkHF4gLrc=
X-Received: by 2002:a5d:6852:: with SMTP id o18mr3515505wrw.426.1618080494800;
 Sat, 10 Apr 2021 11:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210313075747.3781593-1-yuzhao@google.com> <20210313075747.3781593-10-yuzhao@google.com>
 <048e5e1e977e720c3f9fc536ac54beebcc8319f5.camel@surriel.com>
 <87pmzzsvfb.fsf@yhuang6-desk1.ccr.corp.intel.com> <YFAsjP7NIZM5Ld+m@google.com>
 <871rcfzjg0.fsf@yhuang6-desk1.ccr.corp.intel.com> <YFBktbCH9JFcT0rL@google.com>
 <87o8fixxfh.fsf@yhuang6-desk1.ccr.corp.intel.com> <YFHeFslZ85/h3o/q@google.com>
 <87czvryj74.fsf@yhuang6-desk1.ccr.corp.intel.com> <YFhQbvSq2Px25Ub5@google.com>
 <87ft0lhwbm.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87ft0lhwbm.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 10 Apr 2021 12:48:03 -0600
Message-ID: <CAOUHufYCVDz5=6iLgWhiNSGDVxVj2gz7MqyrFVNbAXtjW8W1GQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/14] mm: multigenerational lru: mm_struct list
To:     "Huang, Ying" <ying.huang@intel.com>,
        Rong Chen <rong.a.chen@intel.com>
Cc:     Rik van Riel <riel@surriel.com>, Linux-MM <linux-mm@kvack.org>,
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
        Yang Shi <shy828301@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 12:58 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yu Zhao <yuzhao@google.com> writes:
>
> > On Mon, Mar 22, 2021 at 11:13:19AM +0800, Huang, Ying wrote:
> >> Yu Zhao <yuzhao@google.com> writes:
> >>
> >> > On Wed, Mar 17, 2021 at 11:37:38AM +0800, Huang, Ying wrote:
> >> >> Yu Zhao <yuzhao@google.com> writes:
> >> >>
> >> >> > On Tue, Mar 16, 2021 at 02:44:31PM +0800, Huang, Ying wrote:
> >> >> > The scanning overhead is only one of the two major problems of the
> >> >> > current page reclaim. The other problem is the granularity of the
> >> >> > active/inactive (sizes). We stopped using them in making job
> >> >> > scheduling decision a long time ago. I know another large internet
> >> >> > company adopted a similar approach as ours, and I'm wondering how
> >> >> > everybody else is coping with the discrepancy from those counters.
> >> >>
> >> >> From intuition, the scanning overhead of the full page table scanning
> >> >> appears higher than that of the rmap scanning for a small portion of
> >> >> system memory.  But form your words, you think the reality is the
> >> >> reverse?  If others concern about the overhead too, finally, I think you
> >> >> need to prove the overhead of the page table scanning isn't too higher,
> >> >> or even lower with more data and theory.
> >> >
> >> > There is a misunderstanding here. I never said anything about full
> >> > page table scanning. And this is not how it's done in this series
> >> > either. I guess the misunderstanding has something to do with the cold
> >> > memory tracking you are thinking about?
> >>
> >> If my understanding were correct, from the following code path in your
> >> patch 10/14,
> >>
> >> age_active_anon
> >>   age_lru_gens
> >>     try_walk_mm_list
> >>       walk_mm_list
> >>         walk_mm
> >>
> >> So, in kswapd(), the page tables of many processes may be scanned
> >> fully.  If the number of processes that are active are high, the
> >> overhead may be high too.
> >
> > That's correct. Just in case we have different definitions of what we
> > call "full":
> >
> >   I understand it as the full range of the address space of a process
> >   that was loaded by switch_mm() at least once since the last scan.
> >   This is not the case because we don't scan the full range -- we skip
> >   holes and VMAs that are unevictable, as well as PTE tables that have
> >   no accessed entries on x86_64, by should_skip_vma() and
> >   CONFIG_HAVE_ARCH_PARENT_PMD_YOUNG.
> >
> >   If you are referring to the full range of PTE tables that have at
> >   least one accessed entry, i.e., other 511 are not none  but have not
> >   been accessed either since the last scan on x86_64, then yes, you
> >   are right again :) This is the worse case scenario.
>
> OK.  So there's no fundamental difference between us on this.
>
> >> > This series uses page tables to discover page accesses when a system
> >> > has run out of inactive pages. Under such a situation, the system is
> >> > very likely to have a lot of page accesses, and using the rmap is
> >> > likely to cost a lot more because its poor memory locality compared
> >> > with page tables.
> >>
> >> This is the theory.  Can you verify this with more data?  Including the
> >> CPU cycles or time spent scanning page tables?
> >
> > Yes, I'll be happy to do so as I should, because page table scanning
> > is counterintuitive. Let me add more theory in case it's still unclear
> > to others.
> >
> > From my understanding, the two fundamental questions we need to
> > consider in terms of page reclaim are:
> >
> >   What are the sizes of hot clusters (spatial locality) should we
> >   expect under memory pressure?
> >
> >   On smaller systems with 4GB memory, our observations are that the
> >   average size of hot clusters found during each scan is 32KB. On
> >   larger systems with hundreds of gigabytes of memory, it's well
> >   above this value -- 512KB or larger. These values vary under
> >   different workloads and with different memory allocators. Unless
> >   done deliberately by memory allocators, e.g., Scudo as I've
> >   mentioned earlier, it's safe to say if a PTE entry has been
> >   accessed, its neighbors are likely to have been accessed too.
> >
> >   What's hot memory footprint (total size of hot clusters) should we
> >   expect when we have run out of inactive pages?
> >
> >   Some numbers first: on large and heavily overcommitted systems, we
> >   have observed close to 90% during a scan. Those systems have
> >   millions of pages and using the rmap to find out which pages to
> >   reclaim will just blow kswapd. On smaller systems with less memory
> >   pressure (due to their weaker CPUs), this number is more reasonable,
> >   ~50%. Here is some kswapd profiles from a smaller systems running
> >   5.11:
> >
> >    the rmap                                 page table scan
> >    ---------------------------------------------------------------------
> >    31.03%  page_vma_mapped_walk             49.36%  lzo1x_1_do_compress
> >    25.59%  lzo1x_1_do_compress               4.54%  page_vma_mapped_walk
> >     4.63%  do_raw_spin_lock                  4.45%  memset_erms
> >     3.89%  vma_interval_tree_iter_next       3.47%  walk_pte_range
> >     3.33%  vma_interval_tree_subtree_search  2.88%  zram_bvec_rw
> >
> >   The page table scan is only twice as fast. Only larger systems,
> >   it's usually more than 4 times, without THP. With THP, both are
> >   negligible (<1% CPU usage). I can grab profiles from our servers
> >   too if you are interested in seeing them on 4.15 kernel.
>
> Yes.  On a heavily overcommitted systems with high-percent hot pages,
> the page table scanning works much better.  Because almost all pages
> (and their mappings) will be scanned finally.
>
> But on a not-so-heavily overcommitted system with low-percent hot pages,
> it's possible that rmap scanning works better.  That is, only a small
> fraction of the pages need to be scanned.  I know that the page table
> scanning may still work better in many cases.
>
> And another possibility, on a system with cool instead of completely
> cold pages, that is, some pages are accessed at quite low frequency, but
> not 0, there will be always some low-bandwidth memory reclaiming.  That
> is, it's impossible to find a perfect solution with one or two full
> scanning.  But we need to reclaim some pages periodically.  And I guess
> there are no perfect (or very good) page reclaiming solutions for some
> other situations too. Where what we can do are,
>
> - Avoid OOM, that is, reclaim some pages if possible.
>
> - Control the overhead of the page reclaiming.
>
> But this is theory only.  If anyone can point out that they are not
> realistic at all, it's good too :-)
>
> >> > But, page tables can be sparse too, in terms of hot memory tracking.
> >> > Dave has asked me to test the worst case scenario, which I'll do.
> >> > And I'd be happy to share more data. Any specific workload you are
> >> > interested in?
> >>
> >> We can start with some simple workloads that are easier to be reasoned.
> >> For example,
> >>
> >> 1. Run the workload with hot and cold pages, when the free memory
> >> becomes lower than the low watermark, kswapd will be waken up to scan
> >> and reclaim some cold pages.  How long will it take to do that?  It's
> >> expected that almost all pages need to be scanned, so that page table
> >
> > A typical scenario. Otherwise why would we have run out of cold pages
> > and still be under memory? Because what's in memory is hot and
> > therefore most of the them need to be scanned :)
> >
> >> scanning is expected to have less overhead.  We can measure how well it
> >> is.
> >
> > Sounds good to me.
> >
> >> 2. Run the workload with hot and cold pages, if the whole working-set
> >> cannot fit in DRAM, that is, the cold pages will be reclaimed and
> >> swapped in regularly (for example tens MB/s).  It's expected that less
> >> pages may be scanned with rmap, but the speed of page table scanning is
> >> faster.
> >
> > So IIUC, this is a sustained memory pressure, i.e., servers constantly
> > running under memory pressure?
>
> Yes.  The system can accommodate more workloads at the cost of
> performance, as long as the end-user latency isn't unacceptable.  Or we
> need some time to schedule more computing resources, so we need to run
> in this condition for some while.
>
> But again, this is theory only.  I am glad if people can tell me that
> this is unrealistic.
>
> >> 3. Run the workload with hot and cold pages, the system is
> >> overcommitted, that is, some cold pages will be placed in swap.  But the
> >> cold pages are cold enough, so there's almost no thrashing.  Then the
> >> hot working-set of the workload changes, that is, some hot pages become
> >> cold, while some cold pages becomes hot, so page reclaiming and swapin
> >> will be triggered.
> >
> > This is usually what we see on clients, i.e., bursty workloads when
> > switching from an active app to an inactive one.
>
> Thanks for your information.  Now I know a typical realistic use case :-)
>
> >> For each cases, we can use some different parameters.  And we can
> >> measure something like the number of pages scanned, the time taken to
> >> scan them, the number of page reclaimed and swapped in, etc.
> >
> > Thanks, I appreciate these -- very well thought test cases. I'll look
> > into them and probably write some synthetic test cases. If you have
> > some already, I'd love to get my hands one them.
>
> Sorry.  I have no test cases in hand.  Maybe we can add some into
> Fengguang's vm-scalability test suite as follows.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/

Hi Ying,

I'm still investigating the test cases you suggested. I'm also
wondering if it's possible to test the next version, which I'll post
soon, with Intel's 0-Day infra.

Thanks.
