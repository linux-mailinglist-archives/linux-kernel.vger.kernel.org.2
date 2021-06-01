Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263BC3979B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhFASGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhFASGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:06:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC5EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:04:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q15so11322432pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYSehRyYKXLtA2v4mB2RlonXm8D5VUS7x+sRHGYw9pM=;
        b=QGbVsehE8eg8hbvGRGtRk/3OPto0TVeY/NFT31XWJ7XcUNtmp/0Y1v4feiIJ9q7x5S
         0kraAeAGRzB+4hKTvihE7bbip2z6CJk+zB0AAkaM5D8FVhgmzis8bbOHsJRknth2dGXQ
         XaKQzGNDuUknd22sLQsK5kNg/YF/W3dDQh6Zn0ZyFjf4MOyTr4NNATAm6NmbdaZLIenI
         DFmhFyvQob3QdO8ik52Vd3yQ8G9YVBa31eZ0NnVTsziTcvEq/b8t5mxOTWh6GlcoXd09
         zVCu4T/zWE9hZYBd2pTtndLcZ/NkwYg7MWUkEX/OLSJV19Dqn3ipvc6490SUP8PzQdOi
         74Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYSehRyYKXLtA2v4mB2RlonXm8D5VUS7x+sRHGYw9pM=;
        b=eibMvM1eLV3kWeNhrTRZtAr0a0C/h4QF3vhnrc4FOrmsdhmeo/+K/u7IqoISiUf7+m
         0t5tt3mgMtr3i8tzgqt4g8LoVFl5ZZUmgMtkEjlqXhSc02veM/I8eL1Avt+KLKejKc5t
         t0lc4iM1dq3ZK0FvrwUZrl3ZadvS62DLjpt6K7kRU8OReNsElIsOEy148y/6VgR0tVRP
         A5U2ALvJq+n1GlKsm4k1wQlyplkVcVtxLUaqksCMGmFOnHKzq2jW7B3lO5SbHehy9NVq
         HGPKeeub9u7utO/ZdN6qmR3MUQfRKGUNif5v9krn4OCPMzTXFQblSrovSJYB0UFL2AAB
         0Sxg==
X-Gm-Message-State: AOAM533AS3H2QFexQgIM1n3N2w8GwHom63VeTKxOZaNcQ5NRd2OfT2He
        wDgqHzavzyildMqcxqReTYYcrG+2d/a871ZSCdpFlQ==
X-Google-Smtp-Source: ABdhPJwdwH/33yjBENKSlUDlb9piGqAErRe6qgaCVJFmxuOnooIbN2cAcvzyX51ziLVuTB2eWb3vzbarkMXhl4YDeJs=
X-Received: by 2002:a63:f717:: with SMTP id x23mr29541791pgh.141.1622570679445;
 Tue, 01 Jun 2021 11:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210528005029.88088-1-almasrymina@google.com>
 <20210531162527.caeae9545ea2843c5f62bc9c@linux-foundation.org>
 <CAHS8izMCb4Ws46X3xXGcmrvV6J36qsAPTVCA_gdcH65FU0OeUg@mail.gmail.com>
 <20210531173652.c21404a16a8f8542ce40afa8@linux-foundation.org>
 <CAHS8izO_3QivHuGdmY79Jb_-LqOGc5j-_-1C-tf84hXoKdBDTQ@mail.gmail.com> <83617ae4-90a1-24d0-a79c-4e259a928e04@oracle.com>
In-Reply-To: <83617ae4-90a1-24d0-a79c-4e259a928e04@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 1 Jun 2021 11:04:28 -0700
Message-ID: <CAHS8izMA-YLz_wMyP15PV45tErN+bCHJ1x_q1vfQTMbkK-=MhA@mail.gmail.com>
Subject: Re: [PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 10:09 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/31/21 7:48 PM, Mina Almasry wrote:
> > On Mon, May 31, 2021 at 5:36 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >> On Mon, 31 May 2021 17:11:52 -0700 Mina Almasry <almasrymina@google.com> wrote:
> >>> On Mon, May 31, 2021 at 4:25 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>>> On Thu, 27 May 2021 17:50:29 -0700 Mina Almasry <almasrymina@google.com> wrote:
> >>> I've sent 2 similar patches to the list:
> >>>
> >>> 1. "[PATCH v4] mm, hugetlb: Fix simple resv_huge_pages underflow on UFFDIO_COPY"
> >>>
> >>> This one is sent to -stable and linux-mm and is a fairly simple fix.
> >>>
> >>> 2. "[PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY"
> >>
> >> Ah, OK, the title of the first patch was changed, which threw me off.
> >>
> >> I'd skipped "[PATCH v4] mm, hugetlb: Fix simple resv_huge_pages
> >> underflow on UFFDIO_COPY" because Mike's comments appeared to require a
> >> v5.  I applied it and made Mike's changelog suggestions.  Queued for
> >> 5.13 and -stable.
> >>
> >> And I queued "[PATCH v4] mm, hugetlb: fix racy resv_huge_pages
> >> underflow on UFFDIO_COPY" for 5.14.
> >>
> >>
> >
> > Awesome, thanks! And sorry for the confusion!
> >
>
> Mina, does this patch depend on changes to restore_reserve_on_error()?
>

Yes, this patch (and only this patch) depends on your changes for
complete and correct functionality. I'm not sure what's the impact

> I am still working on those changes.  It may be a few days before I can
> have something finalized.
>
> If this does depend on restore_reserve_on_error as I suspect, perhaps we
> should send these together.

I was thinking it's fine to have my fix in Andrew's tree a few days
before yours, since the race is hard to reproduce and even if the race
reproduces the userfaultfd tests still pass, so I don't see any
disastrous consequences, but I'm happy to do whatever is appropriate
here.
> --
> Mike Kravetz
