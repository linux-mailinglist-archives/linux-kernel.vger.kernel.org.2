Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EB4422C38
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhJEPVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJEPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:21:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8881DC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:19:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v18so236296edc.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXvbj1RYdFStR8mOgmKx85W1SzZn5CdUbt0kPqVxu7U=;
        b=GPL5pcd4au0pQkOdAj5r+sYOunLp6UQmEpcQ/49JUfIfltVmskiS2/jbeuPp0aAMnm
         x9EPY+9YI2ZdYSYqNLsd01wpWaSHSbyVleHVTGsTrzM0oaFy+ExmM4IUUSlSY1v7tXII
         B9dYh7FTmb5K14gbIy0mIdBuZspzKrQ5+8oe1F9T65PaVl1boqLAidmynvOW7Na9tlSg
         7BShU7N3lwJjXfeyV6rAt0IAEQs7MrXWmPoLeXcVOOrTMvE/+NyC2gmmjHB4OZeHcaqt
         2BQtsSMsShgsVVYxcygnepxH9ygmJsGeKJVozSBDFSaqfyvpfJvt65oz0RJUtHv3PGXI
         aCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXvbj1RYdFStR8mOgmKx85W1SzZn5CdUbt0kPqVxu7U=;
        b=3lrwTPnE733GLYwDTXVSJExV76zr0vMv9rYRmQARJcTsOEScG3ktvvXoVuk8CDazeQ
         89lm+dKF/lbxCIAwgI8oFJEUKncTFM/G8WOX7wUWve2y/wEq5fevR/DgZfsGolSoKA7H
         d1UlpLCL/djW4rzGZ29QQPtPfmsoKMy0XKcSqEahLH1lcx/RIeCPGeoEDwHpy2G05Oj0
         oIO3CtPYv6tFVmFO8UqwCdOKHUP2kjKOo5JTPLXBnwC6g78H8ZKsFBTFtvcGJMD29ejS
         8LWdcl0QiTq26ZfaxVFZcjMb0+l0IElVAhNqHmn5zTYbpbbKKtgCsJ669+in+fYph200
         bqKg==
X-Gm-Message-State: AOAM5326ni0/jrVWn8vu0z3F/dRHKZ7aO2AL5P5yk75dUYI/BcOgQXEC
        4HgyLDady86qG3u2GwJDO7w+9IErTcqVgwAQEguGBg==
X-Google-Smtp-Source: ABdhPJzEQTdR5MwSCJAa5eFfsQ2wk6xnibaZV36SS9TXJwF5RMyWkT1NJxJygIIntOrS5zPGE2vGNq9slkBa9xX4Oa8=
X-Received: by 2002:a50:cf87:: with SMTP id h7mr27483539edk.152.1633447154850;
 Tue, 05 Oct 2021 08:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211001181627.394921-1-bgeffon@google.com> <YVtH60zyzq9AhUv2@google.com>
 <CADyq12xk-2Fhnf_rJQ70oC1_98OEBJqwxOt6z=PpJa5V=X3dFQ@mail.gmail.com>
 <YVtqHv+p3uYkbu5E@google.com> <CADyq12w2sHdeBhAKVP+5GghHMqNZN+h36ydV7gi8QxOcHZ7f7A@mail.gmail.com>
In-Reply-To: <CADyq12w2sHdeBhAKVP+5GghHMqNZN+h36ydV7gi8QxOcHZ7f7A@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 5 Oct 2021 11:18:38 -0400
Message-ID: <CADyq12zNcXAS8+7GwMPsbFNgn-M-7e+mtR=_9PXBTOfX65yoew@mail.gmail.com>
Subject: Re: [PATCH] zram: Allow backing device to be assigned after init
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Oct 4, 2021 at 4:55 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Mon, Oct 04, 2021 at 02:40:52PM -0400, Brian Geffon wrote:
> > > On Mon, Oct 4, 2021 at 2:29 PM Minchan Kim <minchan@kernel.org> wrote:
> > > >
> > > > On Fri, Oct 01, 2021 at 11:16:27AM -0700, Brian Geffon wrote:
> > > > > There does not appear to be a technical reason to not
> > > > > allow the zram backing device to be assigned after the
> > > > > zram device is initialized.
> > > > >
> > > > > This change will allow for the backing device to be assigned
> > > > > as long as no backing device is already assigned. In that
> > > > > event backing_dev would return -EEXIST.
> > > > >
> > > > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > > > ---
> > > > >  drivers/block/zram/zram_drv.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > > > index fcaf2750f68f..12b4555ee079 100644
> > > > > --- a/drivers/block/zram/zram_drv.c
> > > > > +++ b/drivers/block/zram/zram_drv.c
> > > > > @@ -462,9 +462,9 @@ static ssize_t backing_dev_store(struct device *dev,
> > > > >               return -ENOMEM;
> > > > >
> > > > >       down_write(&zram->init_lock);
> > > > > -     if (init_done(zram)) {
> > > > > -             pr_info("Can't setup backing device for initialized device\n");
> > > > > -             err = -EBUSY;
> > > > > +     if (zram->backing_dev) {
> > > > > +             pr_info("Backing device is already assigned\n");
> > > > > +             err = -EEXIST;
> > > > >               goto out;
> > > >
> > > > Hi Brian,
> > > >
> > >
> > > Hi Minchan,
> > >
> > > > I am worry about the inconsistency with other interface of current zram
> > > > set up. They were supposed to set it up before zram disksize setting
> > > > because it makes code more simple/maintainalbe in that we don't need
> > > > to check some feature on the fly.
> > > >
> > > > Let's think about when zram extends the writeback of incompressible
> > > > page on demand. The write path will need the backing_dev under
> > > > down_read(&zarm->init_lock) or other conditional variable to check
> > > > whether the feature is enabled or not on the fly.
> > >
> > > I don't follow what you mean by that, writeback_store already holds
> > > down_read(&zarm->init_lock).
> >
> > I should have explained a bit more. Sorry about that.
> > I am thinking about a feature to deal with incompressible page.
> > Let's have an example to handle incompressible page for that.
> >
> > zram_bvec_rw
> >   zram_bvec_write
> >     if (comp_len >= huge_class)
> >         zs_page_writeback
> >             down_read(&zram->init_lock) or some other way
> >
> > It's just idea for incompressible page but we might intorduce
> > the way for other compresible pages, too at some condition.

(sorry for the top post before)

Hi Minchan,
I guess the point I was trying to make was that so long as we allow a
reset operation we'll need to be taking the init lock in read mode
before doing any writeback. Does that seem right?

Brian
