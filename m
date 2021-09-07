Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34065402850
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbhIGMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhIGMQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:16:57 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB2C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 05:15:51 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c19so7694648qte.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sf/naFZf6gVkPlsSX0o+6KPPqLesG/NQXjC5rLD+uwc=;
        b=amGj2iLUpj6wBywqneokmfuPuZsCPJoLX6J1u49EhdH8Vfwqf2/GstHdLGpVvkcMlu
         kwauX6WyujrlPbu3z1vNhYnbCsDSkah/9JULu80Q7ZqkzkwKcqSeJrDu/EZfHA74QhB5
         +MNrMu2rt/aKhm5i2i6SoIRxR1dmHMxmtis7Gxwzdj804U2w2++z8/fNbG00RLPKVLt4
         AQGLUgOT3b5AVkaw7gTcT5ym6ITv2o/squ6MX7p89vnaGucFcW+AZMIsFnUc8s+jwrHx
         FxaEi8qoxgss6X8CiqG6xp1TSAG0TZpB8dyarNBQY2Oz32MukVvbBfBdQIp/bCyymkwX
         Cp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sf/naFZf6gVkPlsSX0o+6KPPqLesG/NQXjC5rLD+uwc=;
        b=ZGQdH4t5g67C5fma49A0hlvA6MZWLeKEK79ZxGO0R+qKsthEPZv9pkVq4UU3Nw2RyI
         1/0hkYtZfmkHk10vSR4u+GF/AwzBmDMfbXxilgpVWtNbUVth+hJbadOQwmkqDdq+Gxxf
         V5mE/i25i779U1G5nGDXBZk6ORGdnyfoPPC6Hk7gaok2UfNvLDKpHiq25D8r9PMpRopF
         E67PzcbUZvjeycJymmt9CwjxsxxN8xv+mKbvKlzCjkGNGEi91KFD3Lr/himRtp4Vv1BG
         E2kpZNnR8PtjFMkXYvaXaPaBApYwa2oiJ5GVB3/82OHfFTAK7wewH4wF6xq59FWiWIfi
         NY6A==
X-Gm-Message-State: AOAM530t464iogzFOdWIlCowc2gTp1NuvDDy8uK1YE6jC+yZ28RjG3DS
        urPMSOoRNboG4gJqFIZavHX/ldScLaSPnR5FwihCP7m9
X-Google-Smtp-Source: ABdhPJzUpT0yC1thDFHfXq7FcaKhMPntPE8Wl2afNUgYlzyVo7jDSf2e8zOt5O6bvVtodkw1GevAyYtxlHP4BUDNbt8=
X-Received: by 2002:ac8:410f:: with SMTP id q15mr14616739qtl.299.1631016950762;
 Tue, 07 Sep 2021 05:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <1631015968-9779-1-git-send-email-huangzhaoyang@gmail.com> <79c08d1d-eef5-bc15-8186-7e3367b4ebe7@suse.cz>
In-Reply-To: <79c08d1d-eef5-bc15-8186-7e3367b4ebe7@suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 7 Sep 2021 20:15:30 +0800
Message-ID: <CAGWkznHY-iZ0ERbJdX-j4S5qOsUAzV0+x67maprz3W+xbq4hTQ@mail.gmail.com>
Subject: Re: [PATCH] mm : bail out from psi memstall after submit_bio in swap_readpage
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 8:03 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 9/7/21 13:59, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > It doesn't make sense to count IO time into psi memstall. Bail out after
> > bio submitted.
>
> Isn't that the point if psi, to observe real stalls, which include IO?
> Anyway, CCing Johannes.
IO stalls could be observed within blk_io_schedule. The time cost of
the data from block device to RAM is counted here. The original
purpose is to deal with the ZRAM alike devices which deal with the bio
locally instead of submitting it to request queue.
>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  mm/page_io.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index c493ce9..1d131fc 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -423,6 +423,7 @@ int swap_readpage(struct page *page, bool synchronous)
> >       count_vm_event(PSWPIN);
> >       bio_get(bio);
> >       qc = submit_bio(bio);
> > +     psi_memstall_leave(&pflags);
> >       while (synchronous) {
> >               set_current_state(TASK_UNINTERRUPTIBLE);
> >               if (!READ_ONCE(bio->bi_private))
> > @@ -433,7 +434,7 @@ int swap_readpage(struct page *page, bool synchronous)
> >       }
> >       __set_current_state(TASK_RUNNING);
> >       bio_put(bio);
> > -
> > +     return ret;
> >  out:
> >       psi_memstall_leave(&pflags);
> >       return ret;
> >
>
