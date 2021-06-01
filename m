Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41914396A3E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 02:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhFAANp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 20:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhFAANo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 20:13:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347DBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 17:12:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 29so9370840pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McnlVW7m2tmbVr3AUvGvJWCMB+Kt1knxYWYaULI0/HQ=;
        b=KhY2ylKyto9r4/tMQRwmFBO2W7/XbtsevDmzDpJjYRpcYwNoP26vppfyCevbFVXlSl
         YHX0iHcBbz2yTCWXNf4SHE4c9Gi0phQDTs++ugOYgBp8CLk+Bj2ZO0lgPqoYXAy87MJe
         tsN7sEW8iJ3Mtvdr4rr9Dfycx/X1uig6DAxn1dTa8jynazagUF5GO2AjMZgY2t4crt1P
         9o0gL0Kf7ssuhRXRLdY6GVquNpQHcSqCBqQCus+pOkdvA8KeMQAe6QPypM416sBarDA8
         NNZ1+pjWrtauQmsZXOtv0PCQRKM9C+7/1/mAVbo0cu+EX1PuKtoFMxyW3u6a5wzT6csP
         z4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McnlVW7m2tmbVr3AUvGvJWCMB+Kt1knxYWYaULI0/HQ=;
        b=LPyaT7vw81cMDNEpyry1zInKAuGOGf11A3hpqSydAphnLdMTXYQUHruPG0J2bGM/3w
         VvCrNrJZwumHD6KUukC9rrEBR1ugNmaZa+XAPYnyYGpd/2VHWihZLaAFMDgm/jYM/Yrp
         xngpobUXRwRzMXbYdMKcZsoX5nT2t7twwD2bcwH4m4BaozUQ5hXqfzqFF31Z4h8ScSka
         yz4BArNuiA2KsnvfIkE3XUvQCXYI5uhGCliqmICH9vqMtuVOGLw1MAfh3DLYveRaIZta
         YheJoY4VfCLOMunGmpacE9O33WK84r64QJRbgtC0rnR0fUTkA3flNoegr9EH5JPnRU+5
         IYtA==
X-Gm-Message-State: AOAM532lU7JU5aM1jlQbu7OmB13b//sxJJSBGZdRQqtc7cvLPZWuQ5jk
        O4EyjqJf3WflQyxhukkdBarhimBrySgMtcbLP0sPxQ==
X-Google-Smtp-Source: ABdhPJzFTiOJtlNDWM8JNsJwDrcRnsvRch/y7IbVpjlDEsZVTg10xklircp6yFA+QzuAAyWgnY2hdDRiR+XbX114QMo=
X-Received: by 2002:aa7:920d:0:b029:2d9:2ead:70dd with SMTP id
 13-20020aa7920d0000b02902d92ead70ddmr18810656pfo.67.1622506323295; Mon, 31
 May 2021 17:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210528005029.88088-1-almasrymina@google.com> <20210531162527.caeae9545ea2843c5f62bc9c@linux-foundation.org>
In-Reply-To: <20210531162527.caeae9545ea2843c5f62bc9c@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 31 May 2021 17:11:52 -0700
Message-ID: <CAHS8izMCb4Ws46X3xXGcmrvV6J36qsAPTVCA_gdcH65FU0OeUg@mail.gmail.com>
Subject: Re: [PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 4:25 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 27 May 2021 17:50:29 -0700 Mina Almasry <almasrymina@google.com> wrote:
>
> > On UFFDIO_COPY, if we fail to copy the page contents while holding the
> > hugetlb_fault_mutex, we will drop the mutex and return to the caller
> > after allocating a page that consumed a reservation. In this case there
> > may be a fault that double consumes the reservation. To handle this, we
> > free the allocated page, fix the reservations, and allocate a temporary
> > hugetlb page and return that to the caller. When the caller does the
> > copy outside of the lock, we again check the cache, and allocate a page
> > consuming the reservation, and copy over the contents.
> >
> > Test:
> > Hacked the code locally such that resv_huge_pages underflows produce
> > a warning and the copy_huge_page_from_user() always fails, then:
> >
> > ./tools/testing/selftests/vm/userfaultfd hugetlb_shared 10
> >         2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> > ./tools/testing/selftests/vm/userfaultfd hugetlb 10
> >       2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> >
> > Both tests succeed and produce no warnings. After the
> > test runs number of free/resv hugepages is correct.
>
> Many conflicts here with material that is queued for 5.14-rc1.
>
> How serious is this problem?  Is a -stable backport warranted?
>

I've sent 2 similar patches to the list:

1. "[PATCH v4] mm, hugetlb: Fix simple resv_huge_pages underflow on UFFDIO_COPY"

This one is sent to -stable and linux-mm and is a fairly simple fix.

2. "[PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY"

Which is this patch. It's a more complicated and not critical fix, so
not targeted for -stable. It's only sent to linux-mm.

> If we decide to get this into 5.13 (and perhaps -stable) then I can
> take a look at reworking all the 5.14 material on top.  If not very
> serious then we could rework this on top of the already queued
> material.
>

I assume given the above we want to rework this on top of the already
queued material. I can upload a v5 that is rebased on top of your
branch. Note that you have an earlier version of this fix in your
branch, so really this patch will turn into a fix for that patch if I
rebase it (I assume that's fine).
