Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2764599A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 02:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhKWBXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 20:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhKWBXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 20:23:33 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A1AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:20:26 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z34so86734166lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8wfXbw5bjxz9JfJOdAOa5BfAiwRfYmne+uZZ/dKp/g=;
        b=VlgBqVpm+Xam5cdvEkYMdeYYdYrjdjY76z5PLJOvzhTOi7qcGetldnK6rjO83qoiMo
         JXHLnf3L1TwFLK/FXp1Jr/dVpWI/th20qgdkYNUC4LtK+JteNgYs9PvNT8htSUUWC9ED
         0BMKty7OQ/AQPPva9pRQPdf6uagGzKw5/uQ5hGZ6oy7eF+2lQQs0hYh3ObrvDFTsMhcJ
         rKAJxXlPURvEGYTDFYp+kp6wgIl6WTQ//KkCpkQIOiDrtLI49o4egZA0hc5sUAJI5wuh
         pwyUbVvjzY6u8YsQPXexPskBaow8TLr3F7gR7l8QJfEZgogzT6DcFwYkuBV5XybUNC56
         FpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8wfXbw5bjxz9JfJOdAOa5BfAiwRfYmne+uZZ/dKp/g=;
        b=NsvC2WpLIxRzvsxTYfN2SR0XgpoR/4U9t/AK8lmebWWoQDV1mRRDBLEuJzovMcX7di
         sZm7cgBYtCbirAcgmTl9VHTK8mNNNW2/A91egFBTOal0mxdt/CaWeJo+LDuEDMbl26Hk
         i9yPdQFSXBflWa5d8dsLmfRt8S5WPsLJhg3WEIkq3urtOqionS0jnnM6JMUWUShTsbIM
         QB3dIs6BlBRQw2DW9fvUU5MyiO9b7AHbT/vz2rKfGE8fhrHoBXDdS5I+GpF6mfLyNdqa
         mcmuQK8xEEyr/upi1qxCxhMe1oQYDXpjkICu9Ec5x8uuIYzgaKKI6UFovsqBKzFdYXgN
         2TkQ==
X-Gm-Message-State: AOAM533G0OWdxQ5CPHSwYcLxWiBSG4qool/I0ERRNM34OJJ0lPE5nn9n
        bR4xe1G9lgUNjeypFbI2vRkopE/K4dLsKZT8j4biSg==
X-Google-Smtp-Source: ABdhPJxfwYlKfdZacoYT9IM3uxvudeR9PeDB67TebeAtAn1rZiAl2xnuLQGARcc2+NBdCsqxFg9SFZHiFMHbw4MmQvY=
X-Received: by 2002:a05:6512:1113:: with SMTP id l19mr854413lfg.184.1637630424415;
 Mon, 22 Nov 2021 17:20:24 -0800 (PST)
MIME-Version: 1.0
References: <20211120201230.920082-1-shakeelb@google.com> <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com> <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com>
In-Reply-To: <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Nov 2021 17:20:13 -0800
Message-ID: <CALvZod5sFQbf3t_ZDW6ob+BqVtezn-c7i1UyOeev6Lwch96=7g@mail.gmail.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 10:59 AM David Hildenbrand <david@redhat.com> wrote:
>
[...]
>
> Thanks for the details, that makes sense to me. It's essentially like
> another kernel buffer charged to the process, only reclaimed on memory
> reclaim.
>
> (can we add that to the patch description?)
>

Sure.

[...]
> >
> > I did a simple benchmark of madvise(MADV_DONTNEED) on 10000 THPs on
> > x86 for both settings you suggested. I don't see any statistically
> > significant difference with and without the patch. Let me know if you
> > want me to try something else.
>
> Awesome, thanks for benchmarking. I did not check, but I assume on
> re-access, we won't actually re-use pages from the underlying, partially
> unmapped, THP, correct?

Correct.

> So after MADV_DONTNEED, the zapped sub-pages are
> essentially lost until reclaimed by splitting the THP?

Yes.

> If they could get
> reused, there would be value in the deferred split when partially
> unmapping a THP.
>
>
> I do wonder which purpose the deferred split serves nowadays at all.
> Fortunately, there is documentation: Documentation/vm/transhuge.rst:
>
> "
> Unmapping part of THP (with munmap() or other way) is not going to free
> memory immediately. Instead, we detect that a subpage of THP is not in
> use in page_remove_rmap() and queue the THP for splitting if memory
> pressure comes. Splitting will free up unused subpages.
>
> Splitting the page right away is not an option due to locking context in
> the place where we can detect partial unmap. It also might be
> counterproductive since in many cases partial unmap happens during
> exit(2) if a THP crosses a VMA boundary.
>
> The function deferred_split_huge_page() is used to queue a page for
> splitting. The splitting itself will happen when we get memory pressure
> via shrinker interface.
> "
>
> I do wonder which these locking contexts are exactly, and if we could
> also do the same thing on ordinary munmap -- because I assume it can be
> similarly problematic for some applications.

This is a good question regarding munmap. One main difference is
munmap takes mmap_lock in write mode and usually performance critical
applications avoid such operations.

> The "exit()" case might
> indeed be interesting, but I really do wonder if this is even observable
> in actual number: I'm not so sure about the "many cases" but I might be
> wrong, of course.

I am not worried about the exit(). The whole THP will get freed and be
removed from the deferred list as well. Note that deferred list does
not hold reference to the THP and has a hook in the THP destructor.

thanks,
Shakeel
