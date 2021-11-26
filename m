Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2345E6C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 05:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344730AbhKZEVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358042AbhKZETb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 23:19:31 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16E5C061371
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 19:22:07 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id n12so20822091lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 19:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2riostl8I3En/NCJyGW1SsfiJ9Pn5IQIwltro7skKk=;
        b=fnFQ0+7iZs1qfcYQQKmkSaAVSG2WHNbDUv3Zxueq1xHczBw8x0ikh986DxT57SBLyl
         KhcWP+iCph0+sPCp40Fda1D0KUUJ8CqZhks5kT4gBdEFGoR4NiJ4S1FnWhEhulfQPEYP
         LRFAqg/8zNuKXRYoKHbA8qiDxnFn3O39aDGvyen1FHd32qovrEsfXx1LDEo0tGkiji9Z
         0oWMzfwRkrA+QkYYZbY+rVWgErH1a2PrD3x6qcEBI9P7MlpYvu1OhiltUgSWHnok6Lqn
         6i40UznZHnnj3vmxkxAU0Ts86RNIVaecIq/hngrER1wurWjg8iurwVko/F092HvZbfB+
         AQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2riostl8I3En/NCJyGW1SsfiJ9Pn5IQIwltro7skKk=;
        b=muexFkoEYJJ/65RolcsANX69A0xV4AxRvAxqY0k6cHA+2HX/pFmy0QYTYPkod+Be3g
         VYiPUxdHAfi7rKBymcvFwAOl27zdASs1AX0sGDlL1N8BE74TK8M1jiW9JqzsEI4N5pA/
         DEwrU1801DajzREzSCQZGxHecplE1zSOZa6ZIpVNjTxnt7200RehsYlm/G5EDCL5wXPj
         UafxVYz3kXqVTxkzARimbXVnL6eiuDnASIoXD6w69CITYmhsljJzDWw9kzDFGrsKxdgE
         dumWzKommH7j1ml8swu+VRBe5rgULJlNNHkCPiv04Em1K9AiRZLDPkiIFxhDxezDJvYt
         mc0A==
X-Gm-Message-State: AOAM533tSDuByhf+YPir7q+9pw9jZKwRIDfcKiJZCr+XgeVDc4aMV52T
        nge4/PsJhKaUEci5boLjVqW2x8gqS+pVntZ+LXDJrg==
X-Google-Smtp-Source: ABdhPJwIoaSTaZnNxPgZ0/H6M5visCL6XtgOrCuvhZfsrdDnhmoGzvIQOdxLcbYy3sLWSDHwkX0O7cIFC9u0EAGhMps=
X-Received: by 2002:ac2:4e02:: with SMTP id e2mr27902737lfr.264.1637896925610;
 Thu, 25 Nov 2021 19:22:05 -0800 (PST)
MIME-Version: 1.0
References: <20211120201230.920082-1-shakeelb@google.com> <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com> <YZ9kUD5AG6inbUEg@xz-m1.local>
In-Reply-To: <YZ9kUD5AG6inbUEg@xz-m1.local>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 25 Nov 2021 19:21:54 -0800
Message-ID: <CALvZod7L5Ga2xZOy_hgocsTxSuOYs840TiviOAhRwz59ATubWg@mail.gmail.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 2:24 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Nov 22, 2021 at 10:40:54AM -0800, Shakeel Butt wrote:
> > > Do we have a performance evaluation how much overhead is added e.g., for
> > > a single 4k MADV_DONTNEED call on a THP or on a MADV_DONTNEED call that
> > > covers the whole THP?
> >
> > I did a simple benchmark of madvise(MADV_DONTNEED) on 10000 THPs on
> > x86 for both settings you suggested. I don't see any statistically
> > significant difference with and without the patch. Let me know if you
> > want me to try something else.
>
> I'm a bit surprised that sync split thp didn't bring any extra overhead.
>
> "unmap whole thp" is understandable from that pov, because afaict that won't
> even trigger any thp split anyway even delayed, if this is the simplest case
> that only this process mapped this thp, and it mapped once.
>
> For "unmap 4k upon thp" IIUC that's the worst case and zapping 4k should be
> fast; while what I don't understand since thp split requires all hand-made work
> for copying thp flags into small pages and so on, so I thought there should at
> least be some overhead measured.  Shakeel, could there be something overlooked
> in the test, or maybe it's me that overlooked?
>

Thanks for making me rerun this and yes indeed I had a very silly bug in the
benchmark code (i.e. madvise the same page for the whole loop) and this is
indeed several times slower than without the patch (sorry David for misleading
you).

To better understand what is happening, I profiled the benchmark:

-   31.27%     0.01%  dontneed  [kernel.kallsyms]  [k] zap_page_range_sync
   - 31.27% zap_page_range_sync
      - 30.25% split_local_deferred_list
         - 30.16% split_huge_page_to_list
            - 21.05% try_to_migrate
               + rmap_walk_anon
            - 7.47% remove_migration_ptes
               + 7.34% rmap_walk_locked
      + 1.02% zap_page_range_details

The overhead is not due to copying page flags but rather due to two rmap walks.
I don't think this much overhead is justified for current users of MADV_DONTNEED
and munmap. I have to rethink the approach.

thanks,
Shakeel
