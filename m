Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB53594E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhDIFn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhDIFnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:43:55 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2099EC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 22:43:43 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z9so3796620ilb.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 22:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdyZIH69QZLX+qD184zaI/95rRxErKOr+ptyeL501Dg=;
        b=IFJpyGI29VNx2ZZT/zab37cZtLh7k2KFjyFBZ5nh9pV4MAsPibOAKyTfUPEZlriKdL
         VI5krZLxUhCox6dw1qR1p5Q8QKLhl562H8UiAb05GzVeC4UwHhixz8F20z1uqTduV8W3
         +woVCatxn6E+YIhmgt1O5Jzy7b0DHlo3YDmTBRlCP5DkwDSQhZPXtHDPmQmXYjlTzyMV
         O+l0MtYLM0zbKnhGXq1NSOOUOTIbSA1kY7/UsDMNSL/hxH6bAgnsxJwmGjdmCJ+JCY5l
         C+0zRd0FCX3jRBOZDytVWzbUyqqnNEsX8f6vZr/CRP0PgXaAv2rpehSqT7hJMrhG3tNQ
         AIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdyZIH69QZLX+qD184zaI/95rRxErKOr+ptyeL501Dg=;
        b=SjnaWL94NRauByh2h7r5+1rrVi073LA4z4FyncW4etiOZDXWZkxsC41Xj1lN0B6VKc
         mGzbx7QiKY1cKStoRFaqoonH4oRxKIThwrpPUzYc6ZSpYx/cspssGeTKzY0ZoB5xqXl4
         /J8VecIrxSwjjA8wNETgj6Uq5Ox0AiAdyY7PVQ/Jisvj44PLCc4zt+QClC0+AcvYz3SK
         U3hTSPztXCuRlCEblrfovcZNfYeUovAq8PGDRjejPLyr92ag02/JttqqgdMts+mMkDHj
         PXzLRfNQvxtpKsRcZk6OLb51AKDwUo0svVMspp5ngK6ELfbHiRJnjrI2PfzlSTsHIPod
         awpw==
X-Gm-Message-State: AOAM530ZES61iK6kFTekKK7DPIeK8i5+kdDL2ooJR4PoGO11XBAXnaXA
        Amy2UurB7+SH9KMIohGyTqHyI+WS1bUFtn9QcQSmTzTG2Cv4sw==
X-Google-Smtp-Source: ABdhPJwBLNzQvO+jGFN3ALoPBxIkWt9qei6kpyabY/dUNKkbBbeBR/YLrbhcC2j5a34lmYBlAKiZE2VL3kI1LJWpJXY=
X-Received: by 2002:a05:6e02:1a43:: with SMTP id u3mr10086739ilv.292.1617947022330;
 Thu, 08 Apr 2021 22:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183223.80F1E291@viggo.jf.intel.com>
 <YG7XjTG9tiK29y1j@localhost.localdomain> <CAHbLzkqoaSnuBJMAe_heQt01FuPWODYQHJ955gaJNNojwbUjrw@mail.gmail.com>
 <YG9IthpDC/lri4Qh@localhost.localdomain> <CAHbLzkqt0_xM=rAaNiSwKn=kY=wmWiFe3N+CEuqH_ryU-o1ysQ@mail.gmail.com>
 <YG/g49rCrId0ALra@localhost.localdomain>
In-Reply-To: <YG/g49rCrId0ALra@localhost.localdomain>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 8 Apr 2021 22:43:31 -0700
Message-ID: <CAAPL-u_7UWmAPpRvZJQ=FGMU=OTV+n5evzb-kjU1uCS9OpzwRg@mail.gmail.com>
Subject: Re: [PATCH 04/10] mm/migrate: make migrate_pages() return nr_succeeded
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that it is a good further improvement to make nr_succeeded an optional
output argument of migrate_pages() given that most callers don't need it.  IMHO,
the most important thing in this matter is to ensure that nr_succeeded only
returns (when its return value is needed) the successfully migrated
pages in this
round and doesn't accumulate.  This is addressed by both proposals.

On Thu, Apr 8, 2021 at 10:06 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Apr 08, 2021 at 01:40:33PM -0700, Yang Shi wrote:
> > Thanks a lot for the example code. You didn't miss anything. At first
> > glance, I thought your suggestion seemed neater. Actually I
> > misunderstood what Dave said about "That could really have caused some
> > interesting problems." with multiple calls to migrate_pages(). I was
> > thinking about:
> >
> > unsigned long foo()
> > {
> >     unsigned long *ret_succeeded;
> >
> >     migrate_pages(..., ret_succeeded);
> >
> >     migrate_pages(..., ret_succeeded);
> >
> >     return *ret_succeeded;
> > }
>
> But that would not be a problem as well. I mean I am not sure what is
> foo() supposed to do.
> I assume is supposed to return the *total* number of pages that were
> migrated?
>
> Then could do something like:
>
>  unsigned long foo()
>  {
>      unsigned long ret_succeeded;
>      unsigned long total_succeeded = 0;
>
>      migrate_pages(..., &ret_succeeded);
>      total_succeeded += ret_succeeded;
>
>      migrate_pages(..., &ret_succeeded);
>      total_succeeded += ret_succeeded;
>
>      return *total_succeeded;
>  }
>
>  But AFAICS, you would have to do that with Wei Xu's version and with
>  mine, no difference there.
>
> IIUC, Dave's concern was that nr_succeeded was only set to 0 at the beginning
> of the function, and never reset back, which means, we would carry the
> sum of previous nr_succeeded instead of the nr_succeeded in that round.
> That would be misleading for e.g: reclaim in case we were to call
> migrate_pages() several times, as instead of a delta value, nr_succeeded
> would accumulate.
>
> But that won't happen neither with Wei Xu's version nor with mine.
>
> --
> Oscar Salvador
> SUSE L3
