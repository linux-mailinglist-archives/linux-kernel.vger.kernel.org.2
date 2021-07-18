Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4713CCAFA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 23:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhGRVfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 17:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhGRVfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 17:35:13 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E68BC061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 14:32:14 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id b13so24573187ybk.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+/+LhyG5jvyV2FwgkrvUngRXo+GiZNFji+6rwemUzs=;
        b=vedZyKz3lL38LRdICKgLFxrEXvjXGc5BgkO2T78tkSNG8sI2Hlk33sbY4W5Y63syJE
         mURxKSpo24wSQ9o/ud5y4QDgt6SvMpf9VVsh6F507XJUpmQHNL0dW9oxTms5nlK0xUSc
         PuHLZCQNZUwHfduWT20rlRZOCXMBJrXKRIYo8Mb7fDiylsOGnIrE0HgtfxVul6uQd/rV
         1LG0LAQ4sJ9oJ6jQ9RuzMIK2dpGVBQhO5zFqDDnpLK9olnfgkR0dUTgG7hbqRmoeiac5
         zKoaJ6wS4qh1aAk9zJR/Tn2YTD8GhmJhjazXSfsyDxBgXeizJ4jqLkfMgQDSenGJ6lCg
         SJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+/+LhyG5jvyV2FwgkrvUngRXo+GiZNFji+6rwemUzs=;
        b=XmaTbaVNKYIktUa7FreQi+SecnlKMa89oLvDv/q1AtnHUsZBArvKVaPY+Uzp2LLobm
         D2+D9WeplvOSXqFpvCPYVvyurW8T/1ZGCVGht7Khm9XxwJ7RBUNtNZy8p8T7vRByxBJk
         GH9RhbF9aQE6ku3MMN5A46MJan2Trvo9x+wIs7QZvtnGA8ZU+6Jlt5GGQPKPKeSKnlmr
         CL0QColg/8MxRm/iDH8WK7bz2IvqxoHLP0PgQ40l4P6LCwsEveNk6H7IILLz7817a9xR
         3g0rOTh1M5w/TqNdus9QASi5Cchww4e1Vi/5gPHoLyKhgmtXooRstTYlr4BBNLMmOkhF
         5HjA==
X-Gm-Message-State: AOAM530C/gtcUYsKFzdjHhm60wHjXzVypRJpCyRrrv+rOeyOzuScf9I6
        3BkLKmb+YxU/j8vKL0ASLY1Qo23h8CQWRZQec2oYmQ==
X-Google-Smtp-Source: ABdhPJwcutQSQe7gkLcIvJWxIAQckzSBIZ4Ug/aclHp9CEPkdqSJ9KU5lsiYI1BnbeWezs1no9qujWoToRyP4xUylQw=
X-Received: by 2002:a25:71c4:: with SMTP id m187mr26883038ybc.397.1626643933133;
 Sun, 18 Jul 2021 14:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com> <20210710003626.3549282-2-surenb@google.com>
 <YPRdH56+dOFs/Ypu@casper.infradead.org> <CAJuCfpFNXmH3gQ51c-+3U_0HPG401dE9Mp9_hwMP67Tyg-zWGg@mail.gmail.com>
 <YPSdONIP8r9S31wM@casper.infradead.org>
In-Reply-To: <YPSdONIP8r9S31wM@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 18 Jul 2021 14:32:02 -0700
Message-ID: <CAJuCfpH-E9wJZysL7g8wvD1t62tkSoxjRzr0-aCYn-5XK8KUzg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>, apopple@nvidia.com,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 2:30 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Jul 18, 2021 at 02:25:50PM -0700, Suren Baghdasaryan wrote:
> > On Sun, Jul 18, 2021 at 9:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Jul 09, 2021 at 05:36:25PM -0700, Suren Baghdasaryan wrote:
> > > > @@ -6723,7 +6722,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> > > >  }
> > > >
> > > >  /**
> > > > - * mem_cgroup_charge - charge a newly allocated page to a cgroup
> > > > + * __mem_cgroup_charge - charge a newly allocated page to a cgroup
> > > >   * @page: page to charge
> > > >   * @mm: mm context of the victim
> > > >   * @gfp_mask: reclaim mode
> > >
> > > This patch conflicts with the folio work, so I'm just rebasing the
> > > folio patches on top of this, and I think this part of the patch is a
> > > mistake.  We don't want to document the __mem_cgroup_charge() function.
> > > That's an implementation detail.  This patch should instead have moved the
> > > kernel-doc to memcontrol.h and continued to document mem_cgroup_charge().
> >
> > Ack.
> > There was a v4 version of this patch:
> > https://lore.kernel.org/patchwork/patch/1458907 which was picked up by
> > Andrew already. If others agree that documentation should be moved
> > into the header file then I'll gladly post another version. Or I can
> > post a separate patch moving the documentation only. Whatever works
> > best. Andrew, Michal, Johannes, WDYT?
>
> At this point, I've moved the documentation as part of the folio patch.
> I'd rather not redo that patch again ...

Ok. If you need me to redo anything please let me know.
