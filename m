Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A3B30618C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhA0RFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbhA0RDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:03:10 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74053C061788
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:02:24 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u4so1410003ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cH2HNFoWtmWpnWYeEkgVq7KIaf7LBJ3O9RpwqmgIKSA=;
        b=mz5PDFTJyoJh/pyXtv5YLKAkeJPvhgWZ4xIUUoAvtBLEVzYk9nyIDv+wGNoXKh4Img
         t1mLGgGAMfiUZCeoJZIn1ohcgMrhO48vDuCErg8HEJOmehktLiU8sO8YS/5TiTspPc5j
         m+OCKAXkv8bjFaBRU5MNZsxu92R/U3xIeHD0zZioRKHMCtAmcJESSKr3tMoDI25xKIoM
         BdRXLVPeg06O4uYFFcoyMy6vIL+8dAN8sN0Y40ZvFObmvDVtKIYbG4ja6GiWua+GHCZL
         7/NrVww2ym7LOXu0cuFEjW5WMrjDmlnUms8KKHsWYmVG9r2arbXQgVW6MqEbiHoad6DW
         tKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cH2HNFoWtmWpnWYeEkgVq7KIaf7LBJ3O9RpwqmgIKSA=;
        b=JnPHQZkhb0njWaSEkjhMnDSmIUjBHsFfnwPDQl6z3vQu8OLbQ8osi9UdoMcaatktrg
         1VXPccUe+CKtvfm6OAGjDKMU0k0YWqaew2FDbbqr2HkhwjQ8MCyFrLw4mZbn4LFGUkje
         iWHef1mjclCv58w5rxHz29HmeZnUBvzgQzGcHvVzfyjRWHagynV0VFRqWEg/Jmv0glzs
         dthAznw5MiajNA1sWDTXUzUa/FBv4WpTUD1V7OfEJLAXw5SueMsXlBjvz07dC6mOlkBl
         vqkEAVgZMh7ezO5pBzoPWzShZ8EcnRTua1FYNWv+8bojWSclLd7v1IyJTwQpShcWNmOb
         tVvw==
X-Gm-Message-State: AOAM532MJqf7VDe35rP+qlJmhvhimnCA6szKRPYbB2I7G5rgP5M6c9HB
        v3remeU/67otzE0NakxBqUt63bP+RuJBqTgm6AGAZw==
X-Google-Smtp-Source: ABdhPJzn3+brB6ijk7rnoncHsjbUhtCxiDrzyrub1UFfa0DwbZ0yKW/AEqV+N1JM57R5nuh2wtjRmyWYVYp2tkZOOho=
X-Received: by 2002:a2e:9090:: with SMTP id l16mr6467976ljg.122.1611766942605;
 Wed, 27 Jan 2021 09:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20201224071111.11551-1-sjpark@amazon.com> <20210127165630.29904-1-sjpark@amazon.com>
In-Reply-To: <20210127165630.29904-1-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 27 Jan 2021 09:02:11 -0800
Message-ID: <CALvZod61Dx4emiV5H73mQcFN6WvmD4A2Z=sRfmN2qpBh3R-_kQ@mail.gmail.com>
Subject: Re: [PATCH v23 05/15] mm/damon: Implement primitives for the virtual
 memory address spaces
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, jolsa@redhat.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, sblbir@amazon.com,
        Shuah Khan <shuah@kernel.org>, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, zgf574564920@gmail.com,
        linux-damon@amazon.com, Linux MM <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 8:57 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> On Thu, 24 Dec 2020 08:11:11 +0100 SeongJae Park <sjpark@amazon.com> wrote:
>
> > On Wed, 23 Dec 2020 14:54:02 -0800 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > On Wed, Dec 23, 2020 at 8:47 AM SeongJae Park <sjpark@amazon.com> wrote:
> > > >
> > > [snip]
> > > > > [snip]
> > > > > > +
> > > > > > +static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> > > > > > +                       unsigned long *page_sz)
> > > > > > +{
> > > > > > +       pte_t *pte = NULL;
> > > > > > +       pmd_t *pmd = NULL;
> > > > > > +       spinlock_t *ptl;
> > > > > > +       bool young = false;
> > > > > > +
> > > > > > +       if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
> > > > > > +               return false;
> > > > > > +
> > > > > > +       *page_sz = PAGE_SIZE;
> > > > > > +       if (pte) {
> > > > > > +               young = pte_young(*pte);
> > > > > > +               if (!young)
> > > > > > +                       young = !page_is_idle(pte_page(*pte));
> > > > > > +               pte_unmap_unlock(pte, ptl);
> > > > > > +               return young;
> > > > > > +       }
> > > > > > +
> > > > > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > > > +       young = pmd_young(*pmd);
> > > > > > +       if (!young)
> > > > > > +               young = !page_is_idle(pmd_page(*pmd));
> > > > > > +       spin_unlock(ptl);
> > > > > > +       *page_sz = ((1UL) << HPAGE_PMD_SHIFT);
> > > > > > +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > > > > > +
> > > > > > +       return young;
> > > > >
> > > > > You need mmu_notifier_test_young() here. Hmm I remember mentioning
> > > > > this in some previous version as well.
> > > >
> > > > Your question and my answer was as below:
> > > >
> > > >     > Don't you need mmu_notifier_clear_young() here?
> > > >
> > > >     I think we don't need it here because we only read the Accessed bit and PG_Idle
> > > >     if Accessed bit was not set.
> > > >
> > > > I should notice that you mean 'test_young()' but didn't, sorry.  I will add it
> > > > in the next version.
> > > >
> > >
> > > I should have said mmu_notifier_test_young() instead of
> > > mmu_notifier_clear_young().
> > >
> > > > >
> > > > > BTW have you tested this on a VM?
> > > >
> > > > Yes.  Indeed, I'm testing this on a QEMU/KVM environment.  You can get more
> > > > detail at: https://damonitor.github.io/doc/html/latest/vm/damon/eval.html#setup
> > > >
> > >
> > > Hmm without mmu_notifier_test_young() you should be missing the kvm
> > > mmu access updates. Can you please recheck if your eval is correctly
> > > seeing the memory accesses from the VM?
> >
> > Seems I didn't clearly answered, sorry.  My test setup installs the
> > DAMON-enabled kernel in a guest VM and run it for workloads in the guest,
> > rather than running DAMON in host to monitor accesses of VMs.  The MMU notifier
> > is for latter case, AFAIU, so my test setup didn't see the problem.
>
> Just FYI.  I confirmed the mmu_notifier_test_young() added version works for
> the use case.  I tested it by running a program accessing 200MB memory in a
> QEMU/KVM guest having 120GB memory and monitoring the qemu process' virtual
> address space from the host using DAMON.  The 200MB memory region was clearly
> identifiable.
>

Thanks for confirming. I am still going over the whole series and will
send out the emails in a couple of days.

Shakeel
