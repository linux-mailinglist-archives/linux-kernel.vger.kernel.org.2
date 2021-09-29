Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739CB41D01E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 01:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347656AbhI2Xnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 19:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347524AbhI2Xnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 19:43:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1C676126A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 23:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632958921;
        bh=otV9VV/sFcF022eYj5odI220EtLVp8iNHKDlnTKMYts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MABys8Z/Y8aBZd0ydLplveETTesiDBeKHDu/pTycjplmN3OTjdf5osT6dFwgfjE9w
         1WD/AJIsr+eO9oidOxUCby37TKrvZxRNssqyfuOBMe24rwl/4H9mjfe5MwX+0iwn8h
         h8nGjt8UTvIJbeDF+Dqx0o1+Pi51ejS5s2BPEghw9h2J+SvQy2/Lm755RIkCNBcWmk
         Q2rZroP9Rxrlp82/jswReK/kTomgAifBS4xkfyStPAwcPTnGwVdl6+8Hs6W5k/YrAZ
         cWveMGgB50sEnWsZTOygQnAdXcmEna94kFfRFPzkoY/9R620kbQgxEOGllODea3sgD
         qCX68asy4QjXw==
Received: by mail-lf1-f47.google.com with SMTP id y26so17556058lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:42:01 -0700 (PDT)
X-Gm-Message-State: AOAM5318sK3n6YHiP/Y/w0PDfa0T19pR3ZqkQ/elEpMcj/F1LH9NJQnN
        BGSIgYd3Wuf7eA6jhC3iNCi3qCgUSCr+Hpm8cEI=
X-Google-Smtp-Source: ABdhPJxHqAjSpOeee9Gqzi1rY9sY5DM00t+Nr1XmoZToxp1W8xpUS2LPcFfuGRc/ndeFpb0W/nBQOoEpcB3X7s5V7cE=
X-Received: by 2002:a2e:5442:: with SMTP id y2mr2794204ljd.436.1632958920169;
 Wed, 29 Sep 2021 16:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
 <YUsVcEDcQ2vEzjGg@casper.infradead.org> <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
 <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com> <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com> <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com> <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org>
In-Reply-To: <YVSopxYWegtQJ3iD@casper.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 29 Sep 2021 16:41:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
Message-ID: <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page cache
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:56 AM Matthew Wilcox <willy@infradead.org> wrote:
>
[...]
> > Now, I am able to crash the system on
> >     find_lock_entries () {
> >      ...
> >        VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
> >     }
> > I guess it is related. I will test more.
>
> That's a bogus VM_BUG_ON.  I have a patch in my tree to delete it.
> Andrew has it too, but for some reason, he hasn't sent it on to Linus.
>
> +++ b/mm/filemap.c
> @@ -2093,7 +2093,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
>                 if (!xa_is_value(page)) {
>                         if (page->index < start)
>                                 goto put;
> -                       VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
>                         if (page->index + thp_nr_pages(page) - 1 > end)
>                                 goto put;
>                         if (!trylock_page(page))

Yes, after removing this line, I am able to see the same bug.

Here is my finding so far:

The issue is NOT caused by concurrent khugepaged:collapse_file() and
truncate_pagecache(inode, 0). With some printks, we can see a clear
time gap (>2 second )  between collapse_file() finishes, and
truncate_pagecache() (which crashes soon). Therefore, my earlier
suggestion that adds deny_write_access() to collapse_file() does NOT
work.

The crash is actually caused by concurrent truncate_pagecache(inode, 0).
If I change the number of write thread in stress_madvise_dso.c to one,
(IOW, one thread_read and one thread_write), I cannot reproduce the
crash anymore.

I think this means we cannot fix this issue in collapse_file(), because it
finishes long before the crash.

Thanks,
Song
