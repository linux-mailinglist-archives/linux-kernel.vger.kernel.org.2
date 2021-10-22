Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEED437C81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 20:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhJVSQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 14:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhJVSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 14:16:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA841C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 11:14:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l13so4805012edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUVy5Ei4KUMRiHJuf/GMekzWocYSeyLp9wteBIU/ENY=;
        b=B/70PtVdeJ6+wPmvf7bBT0YVw1ghfn6KBLNqkkQuC6l2NW4eKbB9vAyPnp88HJHHol
         tLumGJNSClhbqCsdFi3ToCWvFL52qJCIGjcRY/KqjIvysGlPB33pCq2nsWnORgHsr0p9
         0lVmCLTvHLv22KFp/AeZP70iupYrT16mqO7xxaYFHNIxFmD3A1+Zg4Kx6sB1CzhqYZGi
         YJcS9AXbCOj78lyXscRYMzB7OH4D1uauXHIHCU9kAOBz0f8vVjIUbl5EATc+59QOictB
         wkL/UO++/fqB89+6lgs25/lonIMGDTKlG8FVqGEp9K9BJhIuzckvRyGGlABWEtjbqURA
         SRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUVy5Ei4KUMRiHJuf/GMekzWocYSeyLp9wteBIU/ENY=;
        b=FITFecvveZHSNGmh6wn2r0Yz2UPQIZuSLjAQdtpOjblsEN/us7Cv9JJsnPLAHfNxxm
         QVLkA/VNj+WDrnoV/cI3IHVEBwOEjv8LsYLQ1GHr00Xi8PoVRLLrdM4qxmFkMPzrF07v
         OSh4G+yzVZJyckkLKMVuX//fofnM4+e1fRvae4e+RK3tNuo0Yg/iOLhSAkvM1O09UobK
         sS+YxFAnmPr8yhEOIwf30O7kPfhyTStsNUPpTZ2am+rXKVDTZfGlFESvCCUJnctIyQ/o
         CfXPFiqLw1VLKBDlO8xqwIN0b25jRWANBvxiQhiIydFEtLqx+Sba94NpNq0MbYUALsGd
         kv6A==
X-Gm-Message-State: AOAM530y5Vi+kcz3KEuZdXt+IzmKqaCMZBig7JGnG14y1AkQVUL+QZig
        UEf8YelvCrxNHy4yVttNH+NoJnpZP9WQGcOgIP8=
X-Google-Smtp-Source: ABdhPJwu4v3tFaybD5BXKvUuVzy9ahipsz/WXWVpaQOAkhbmqXaIyHcWB9ef8rv9818NiEDurbf7YkDJtcVPvMTugYs=
X-Received: by 2002:a17:907:2091:: with SMTP id pv17mr1343837ejb.311.1634926445307;
 Fri, 22 Oct 2021 11:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211022074619.57355-1-andrea.righi@canonical.com>
 <YXKdRDKp+l6lis/R@casper.infradead.org> <CAHbLzkqFpADQmrPq572M-y53ChJzFJ+uDOHUzzeRFUTv0acq9A@mail.gmail.com>
In-Reply-To: <CAHbLzkqFpADQmrPq572M-y53ChJzFJ+uDOHUzzeRFUTv0acq9A@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 22 Oct 2021 11:13:53 -0700
Message-ID: <CAHbLzkqFnQub71so5Qpi-UrNt_VVUfX82Gz2FTqx48qa-M_UKw@mail.gmail.com>
Subject: Re: [PATCH] mm: fix sleeping copy_huge_page called from atomic context
To:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:38 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Fri, Oct 22, 2021 at 4:16 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Oct 22, 2021 at 09:46:19AM +0200, Andrea Righi wrote:
> > > copy_huge_page() can be called with mapping->private_lock held from
> > > __buffer_migrate_page() -> migrate_page_copy(), so it is not safe to
> > > do a cond_resched() in this context.
> > >
> > > Introduce migrate_page_copy_nowait() and copy_huge_page_nowait()
> > > variants that can be used from an atomic context.
> >
> > I think this is a consequence of THPs being created when they should not
> > be.  This is the wrong way to fix this problem; and I suspect it may
> > already be fixed at least in -mm.  We should have taken this path:
> >
> >         if (!page_has_buffers(page))
> >                 return migrate_page(mapping, newpage, page, mode);
> >
> > but since we didn't, we can infer that there's a THP which has buffers
> > (this should never occur).  It's the same root cause as the invalidatepage
> > problem, just with a very different signature.
>
> Yeah, exactly. And I replied to that syzbot report a few days ago
> (https://lore.kernel.org/linux-mm/CAHbLzkoFaowaG8AU6tg_WMPdjcAdyE+Wafs7TJz1Z23TRg_d8A@mail.gmail.com/)
> with the same conclusion.
>
> I'm not sure why Hugh didn't submit his patch, maybe he was waiting
> for the test result from the bug reporter of that invalidatepage
> issue? It should be fine, the fix is quite straightforward IMHO.

Anyway if Hugh doesn't have time to do it, I could prepare the patch
for formal review.

>
> >
