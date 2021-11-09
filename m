Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711ED44A002
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 01:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhKIA4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbhKIA4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:56:20 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2501BC061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 16:53:35 -0800 (PST)
Date:   Tue, 9 Nov 2021 09:53:20 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636419212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ly//+PLTq734fEL3QzvD6IFnidowZVyd7f7YneJBS20=;
        b=lxKivXwjJZttf+pbMJfogNfjs5aOszEpK+y8WNKYHLvkaGleVM9DVBKUh6ZtPxQC4Zayw+
        0QkQaCF6kNoME6tFRTge2IK6AenITTJKIDfqRk65PZKZKV1Mpe21/rnePN6G7oaxbrQVzZ
        FpZsnkDH1jYY50Zh5ZVLq9NyF6UpmEY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] mm/hwpoison: fix unpoison_memory()
Message-ID: <20211109005320.GA3341842@u2004>
References: <20211105055058.3152564-1-naoya.horiguchi@linux.dev>
 <20211105055058.3152564-4-naoya.horiguchi@linux.dev>
 <CAHbLzkoCUs-Z9m47SnF3sR-wai3_M6R4Jkxq8bNBTdoTrkh5vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkoCUs-Z9m47SnF3sR-wai3_M6R4Jkxq8bNBTdoTrkh5vA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 03:27:55PM -0800, Yang Shi wrote:
> On Thu, Nov 4, 2021 at 10:52 PM Naoya Horiguchi
> <naoya.horiguchi@linux.dev> wrote:
...
> > @@ -1942,6 +1987,26 @@ core_initcall(memory_failure_init);
> >                 pr_info(fmt, pfn);                      \
> >  })
> >
> > +static inline int clear_page_hwpoison(struct ratelimit_state *rs, struct page *p)
> > +{
> > +       if (TestClearPageHWPoison(p)) {
> > +               unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
> > +                                page_to_pfn(p), rs);
> > +               num_poisoned_pages_dec();
> > +               return 1;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static inline int unpoison_taken_off_page(struct ratelimit_state *rs,
> > +                                         struct page *p)
> > +{
> > +       if (put_page_back_buddy(p) && clear_page_hwpoison(rs, p))
> 
> It seems there might be race condition between free and allocation to
> kick the page out of buddy before the hwpoisoned flag is cleared IIUC?
> 
>         CPU A                     CPU B
> Free:                            Allocation:
> acquire zone lock
> put back to buddy
> release zone lock
>                                      acquire zone lock
>                                      try to allocate this page
>                                      if it is hwpoisoned then reset
> PageBuddy (not buddy page anymore)
>                                      release zone lock
> 
> Did I miss something?

No, this is a nice catch. CPU B finds hwpoisoned page on free list then
calling bad_page().  So doing "put back to buddy" and clear_page_hwpoison
inside a single zone lock should prevent this race.

Thanks,
Naoya Horiguchi
