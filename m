Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E24378130
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhEJKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhEJKYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:24:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A34C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:23:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h7so8915483plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SC3l9ot/NnrIlFH9F+9VvlqluJ48/wZ0HvAXIkGXJZs=;
        b=KsiOvL/wV7695uCIKkpWUl37lqlAZKZaXg5HPRqOWKZ0FRbWKl6l1KVawCravOw2Eg
         U3MrCQCGB+okOqR4/Gw2dvVOcuMhuJhN+TaTyS6Ob8Ymmbtgy3wVvYTnPWWb6ZiLIa4q
         1Z/5sbtyOTAEpSKU+SSU1i8bvYU2floXeLkEekYy686XFt81uS7TMf0aoICutreut6I4
         NB9ioG7k27GBujjyngBObw/tkCfW8S1oEYyD3mI+gEf0PGT8vbE4AdB5TpxCF26QcL2A
         VX0BAIwUhbosIXaA8gWWtVJOfLzQqIkN9V8kdexodE5iZISdiczN8xC/ZmCrlhEjWWqB
         T0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SC3l9ot/NnrIlFH9F+9VvlqluJ48/wZ0HvAXIkGXJZs=;
        b=rkRXO2pp8/f28cTpmuTk95d3CLIaaS0NXoAWNP+0vgWWRJerb2vhYN+rnl8oDAbyhM
         k6DaKjiXLi7Vg4M7RrpolQGqMNv8z3aLyn8SYud4M8JVSfPlegt5Qi+LZximGaJY3WvL
         UfyuyenWYW8aWKkC00/G6eM02eHiBzb5Iqr1FOmC9tjm3uNVDiMKnnTzpL35lYxIiWfR
         M/AqV7cvnDhg7Ij0+whBlQu6fqLV7Xzi/SB/xEZ8tQkA1jvdVOmccYsWebZvQ0FmNvB2
         JzAgTDkie0HSsu6u0SaQ0g+k0r5yT4GHYD8Ui4GCoI/Oj6Mk4OsfFlNX9YuiEYl1wdme
         aUew==
X-Gm-Message-State: AOAM532o1ufjCq1XXVsEvuOAM31tFly8vDBevBYB/MFrbvqnkAvrrDwf
        mSTri0YBziHvk4hibIIy1R41u37sq4Pxlwnohds=
X-Google-Smtp-Source: ABdhPJzlCpx0aMPDG1UTtHx9ORvSAqoLR+lQwLXGS36HfGe3zsY4SMHWTdYCDU1z6eHE+BRbHFkmE7hhGlwtP40PCPw=
X-Received: by 2002:a17:90a:c297:: with SMTP id f23mr26676792pjt.197.1620642184074;
 Mon, 10 May 2021 03:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210428225046.16301-1-wuchi.zero@gmail.com> <20210509163633.ced3588cb92984c0d3835fc3@linux-foundation.org>
In-Reply-To: <20210509163633.ced3588cb92984c0d3835fc3@linux-foundation.org>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Mon, 10 May 2021 18:22:53 +0800
Message-ID: <CA+tQmHBvm41BbYJXVqAR+RDy1R9WJXP7TmkqkgpigOUh45QpXg@mail.gmail.com>
Subject: Re: [PATCH] mm/page-writeback: Fix performance when BDI's share of
 ratio is 0.
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        Howard Cochran <hcochran@kernelspring.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Jens Axboe <axboe@fb.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2021=E5=B9=B45=E6=9C=881=
0=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=887:36=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, 29 Apr 2021 06:50:46 +0800 Chi Wu <wuchi.zero@gmail.com> wrote:
>
> > Fix performance when BDI's share of ratio is 0.
> >
> > The issue is similar to commit 74d369443325 ("writeback: Fix
> > performance regression in wb_over_bg_thresh()").
> >
> > Balance_dirty_pages and the writeback worker will also disagree on
> > whether writeback when a BDI uses BDI_CAP_STRICTLIMIT and BDI's share
> > of the thresh ratio is zero.
> >
> > For example, A thread on cpu0 writes 32 pages and then
> > balance_dirty_pages, it will wake up background writeback and pauses
> > because wb_dirty > wb->wb_thresh =3D 0 (share of thresh ratio is zero).
> > A thread may runs on cpu0 again because scheduler prefers pre_cpu.
> > Then writeback worker may runs on other cpus(1,2..) which causes the
> > value of wb_stat(wb, WB_RECLAIMABLE) in wb_over_bg_thresh is 0 and does
> > not writeback and returns.
> >
> > Thus, balance_dirty_pages keeps looping, sleeping and then waking up th=
e
> > worker who will do nothing. It remains stuck in this state until the
> > writeback worker hit the right dirty cpu or the dirty pages expire.
> >
> > The fix that we should get the wb_stat_sum radically when thresh is low=
.
>
> (optimistically Cc's various people who might remember how this code work=
s)

Thanks, I'll correct it in the future.

>
> > Signed-off-by: Chi Wu <wuchi.zero@gmail.com>
>
> Thanks.  I'll add it for some testing and hopefully someone will find
> the time to review this.
>
> > ---
> >  mm/page-writeback.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index 0062d5c57d41..bd7052295246 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -1945,6 +1945,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
> >       struct dirty_throttle_control * const gdtc =3D &gdtc_stor;
> >       struct dirty_throttle_control * const mdtc =3D mdtc_valid(&mdtc_s=
tor) ?
> >                                                    &mdtc_stor : NULL;
> > +     unsigned long reclaimable;
> > +     unsigned long thresh;
> >
> >       /*
> >        * Similar to balance_dirty_pages() but ignores pages being writt=
en
> > @@ -1957,8 +1959,13 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
> >       if (gdtc->dirty > gdtc->bg_thresh)
> >               return true;
> >
> > -     if (wb_stat(wb, WB_RECLAIMABLE) >
> > -         wb_calc_thresh(gdtc->wb, gdtc->bg_thresh))
> > +     thresh =3D wb_calc_thresh(gdtc->wb, gdtc->bg_thresh);
> > +     if (thresh < 2 * wb_stat_error())
> > +             reclaimable =3D wb_stat_sum(wb, WB_RECLAIMABLE);
> > +     else
> > +             reclaimable =3D wb_stat(wb, WB_RECLAIMABLE);
> > +
> > +     if (reclaimable > thresh)
> >               return true;
> >
> >       if (mdtc) {
> > @@ -1972,8 +1979,13 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
> >               if (mdtc->dirty > mdtc->bg_thresh)
> >                       return true;
> >
> > -             if (wb_stat(wb, WB_RECLAIMABLE) >
> > -                 wb_calc_thresh(mdtc->wb, mdtc->bg_thresh))
> > +             thresh =3D wb_calc_thresh(mdtc->wb, mdtc->bg_thresh);
> > +             if (thresh < 2 * wb_stat_error())
> > +                     reclaimable =3D wb_stat_sum(wb, WB_RECLAIMABLE);
> > +             else
> > +                     reclaimable =3D wb_stat(wb, WB_RECLAIMABLE);
> > +
> > +             if (reclaimable > thresh)
> >                       return true;
> >       }
> >
> > --
> > 2.17.1
