Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394703E2ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240928AbhHFRSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 13:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhHFRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:18:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA0C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 10:17:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f13so13969937edq.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akuG98DV2ldxk7RDY1w9lLgWyZHnVwVPQDD0gLmW4EI=;
        b=jT8ambbqt+XSdwwCcL2yCfnODT3i6eC9frjA1EAARfD9wCLS+WDDsyzA1/siLRxzQ3
         4WUyhJ7GqaG6pqFZvVrpnWILJ45wI6Ek9rRnGx8M3t7sNezAZlf7t/Y+rPOOIdf6EKn/
         qeGpIV3pejz+/sr12DQzvHrqFzL9MB2oUzYepyEf/9sFW0nKGv2+s93lozPlG9Zvw/hw
         0GBQLxrInQOaCfdoE5pT+4ilHbg5+PLbmpRDG85QOFH5YRZF+Wn6+oM7RuVHqcE41qYC
         +1Im1MZJl/QUwP/HDgMDq1SEcbTHr2K1C5uMTTfhGoOpy+MbgK/rQG99nueMo3euvgc8
         Gh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akuG98DV2ldxk7RDY1w9lLgWyZHnVwVPQDD0gLmW4EI=;
        b=g+9pT+2/qBA6o7EzPOKGZYRtXcfQh1I+HcndYiS2txk/JEPTcKOtkmj1T/QxS9KBk8
         v6OZSJYkRu+yppbI0qDOFeCT8vjcu4gOR97nFeW7iwge20FwwmmdSVd8rYRHFDPlJZfz
         /qig973YXUnb/RkLxqhUbIh0EkYOHagu2q08R8+NJ88wf5ewKCnlnoYdKlJfNO/sw+6G
         JYtfql/TNZyYNHwHnJftDnor3ybHydBiUEpP4IqM+82p4jCps34M6p/3zfejxSdpyYi+
         Oe6z6Kl2khUtFIwT2gQL1anm08xfJYxdUBfHzqKjk3rcwG1BXJsQHRCZUjFxK38o9yc4
         3rQg==
X-Gm-Message-State: AOAM531Ky/47KSJOE9smoTUz0v82z3hog4Rr61gew44LNAYXDUoq+swQ
        WuMl7Vo1E/c6AG45qBK6MmviDXMWzcgWCe56qdv5J+rUAIo=
X-Google-Smtp-Source: ABdhPJwrR1PSnrQQSoNoiQt+kbY2/PgyWalfYpMMLO7+4WMAqsmImJ0GpJm5h61wk+FRmSJsvka3Bf3Piak21gS9Bh0=
X-Received: by 2002:a05:6402:386:: with SMTP id o6mr14357685edv.294.1628270277721;
 Fri, 06 Aug 2021 10:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
 <d359dcf73a7a868f1b126cb73368fea64aec1f25.1628174413.git.baolin.wang@linux.alibaba.com>
 <CAHbLzkrqwOp0a_6Vzn29h9qwCiwVSLL6QzsMLfOYTWj7mtkNZg@mail.gmail.com> <98937827-89ec-2a3b-b389-da28f8493cb1@linux.alibaba.com>
In-Reply-To: <98937827-89ec-2a3b-b389-da28f8493cb1@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 Aug 2021 10:17:46 -0700
Message-ID: <CAHbLzko_spW=SPnP3jgQWCNzY=7xn7JDCFfFtY5_9yRfCApLTA@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm: migrate: Remove redundant goto labels
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 8:19 PM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Hi Yang,
>
> > On Thu, Aug 5, 2021 at 8:06 AM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >> Remove redundant goto labels to simplify the code.
> >
> > TBH I don't see too much benefit. The "goto" makes the functions have
> > a single exit point.
>
> Yes, I agree that the 'goto' statement can make things easier when a
> function exits from multiple locations and some common work such as
> cleanup has to be done, as well as introducing complexity to reading the
> code. So per the coding style documentation, "If there is no cleanup
> needed then just return directly", which can make code more readable I
> think :)
>
> But I have no strong opinion on this, I can drop this patch if you still
> think this is unnecessary. Thanks for your review and comments.

Thanks, IMHO I'd like to drop it for now.

>
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >>   mm/migrate.c | 8 +++-----
> >>   1 file changed, 3 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 0ab364f..ed74fda 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -911,9 +911,8 @@ static int move_to_new_page(struct page *newpage, struct page *page,
> >>                   */
> >>                  VM_BUG_ON_PAGE(!PageIsolated(page), page);
> >>                  if (!PageMovable(page)) {
> >> -                       rc = MIGRATEPAGE_SUCCESS;
> >>                          __ClearPageIsolated(page);
> >> -                       goto out;
> >> +                       return MIGRATEPAGE_SUCCESS;
> >>                  }
> >>
> >>                  rc = mapping->a_ops->migratepage(mapping, newpage,
> >> @@ -949,7 +948,7 @@ static int move_to_new_page(struct page *newpage, struct page *page,
> >>                          flush_dcache_page(newpage);
> >>
> >>          }
> >> -out:
> >> +
> >>          return rc;
> >>   }
> >>
> >> @@ -2095,11 +2094,10 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
> >>          newpage = alloc_pages_node(nid, (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
> >>                                     HPAGE_PMD_ORDER);
> >>          if (!newpage)
> >> -               goto out;
> >> +               return NULL;
> >>
> >>          prep_transhuge_page(newpage);
> >>
> >> -out:
> >>          return newpage;
> >>   }
> >>
> >> --
> >> 1.8.3.1
> >>
> >>
