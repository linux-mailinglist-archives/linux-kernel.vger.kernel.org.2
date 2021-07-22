Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760A73D1C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 05:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhGVDTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 23:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhGVDTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 23:19:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8344C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 20:59:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q16so6430329lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 20:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wlgo+HDD4XVGLL4+0YFLCCYhPxqOV8dpTaeF7KubZV8=;
        b=JQ/huajMzCvVKfzB6aXogb7L836C3TbNsinJ3VRro9HWNGJASIrofApytSysWx4L99
         SN/GyG1XubEsMr0nMeDuu5DDdYmp88OHzfyCvx0gJx3GTlNqBZLKp3E63TK9hkX29xId
         ZXCj6I2h60ZWd4i/7Cy4wIoYBZDUWCA1jqe32KiLFIRFL8hpkHW3k+Q2icTUSuzmuh8G
         24irTrEULS/CB+qFB5HJaBGHDP0TaISr7GRev9KR5LwZ4ZrgB2/9gu57Hoq2aSgKtqFP
         NlGa/7TjcyUpdzWubtvAzQeobWJeePGtUSmA5OSXA8YzMzkOcEdn2xSU2NmPF8PYWNw1
         IWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wlgo+HDD4XVGLL4+0YFLCCYhPxqOV8dpTaeF7KubZV8=;
        b=DDL8sZN3UPoHfC5mKHA9RkVyBb7fCw6ikiGz3YRpoIjdVTjMRzaAjHW0Q0pi6Mq8Z0
         JvCuPcLZAXDyxKggbKf75/YjdtK7ovSRUQ8oWkzTYxsOKWdS+VnPQIG+OI8OjdnFsfh/
         hQKYnN1RFQpxBG/XRNuxMZLPh9V9d/GrVPfv2JKyoEmcVBf2slWtQHd7Q1Vfeki3ec1x
         4rpBtx4CLPe+OIT0W8v+ZQilFCgYAjjpybCCBbuwS4a7ecCB4GxpAE95GGOOf/nVOQP1
         /qEnUa5U64UqHicBmRip/03V4acBogNOCSUwuUHRrQcIYsCf0jGeYtOuJW6hIzD9z9aN
         lWDA==
X-Gm-Message-State: AOAM531Q4SCh5PGza2dtFbJQpN2hCT0tADdvwpkQib/L52vse9Fn9ino
        xIV/aectppDZsfRLuKSBm4WixdO7yAlXHynEYio=
X-Google-Smtp-Source: ABdhPJzwt1i4+o2Og+EX183RIj/YK2dms/vY1DosY/yvxfL/bZmEjt4dhaQvoUjKjaWSgGXYwUkpPS1OBZvGCD6M81A=
X-Received: by 2002:a19:7512:: with SMTP id y18mr28071154lfe.533.1626926379270;
 Wed, 21 Jul 2021 20:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210721072048.3035928-1-daeho43@gmail.com> <YPiTLwB3d8BWSKje@gmail.com>
 <CACOAw_xq3_ccqzh8dnomFXBOK_iN9LOTsOBYSBzDJHSSDrRxVw@mail.gmail.com>
 <YPi4rRg2ZPFBWaTZ@sol.localdomain> <CACOAw_xeTSa8J_9=+6thXvFT75u734D5asNRogUxt+DC-tPhxg@mail.gmail.com>
 <YPjGsSEdsoSsCJlB@sol.localdomain> <CACOAw_yWAUNiziiQuZgRDaVrOxceuEpO8QtoYGmhxxJV2s7wWQ@mail.gmail.com>
 <YPjQQTjJ6rO2sx/o@sol.localdomain>
In-Reply-To: <YPjQQTjJ6rO2sx/o@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 21 Jul 2021 20:59:28 -0700
Message-ID: <CACOAw_w_5YD3GZGrrdMK_hK6KWbyQOfEMo-JwT2CgWLHAMCBrg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change fiemap way in printing
 compression chunk
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 6:56 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jul 21, 2021 at 06:40:00PM -0700, Daeho Jeong wrote:
> > On Wed, Jul 21, 2021 at 6:15 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Wed, Jul 21, 2021 at 06:04:22PM -0700, Daeho Jeong wrote:
> > > > >
> > > > > How f2fs stores the mapping information doesn't matter.  That's an
> > > > > implementation detail that shouldn't be exposed to userspace.  The only thing
> > > > > that should be exposed is the actual mapping, and for that it seems natural to
> > > > > report the physical blocks first.
> > > > >
> > > > > There is no perfect solution for how to handle the remaining logical blocks,
> > > > > given that the fiemap API was not designed for compressed files, but I think we
> > > > > should just go with extending the length of the last compressed extent in the
> > > > > cluster to cover the remaining logical blocks, i.e.:
> > > > >
> > > > >   [0..31]: 2683128..2683159 flag(0x1009) -> merged, encoded, last_extent
> > > > >
> > > > > That's what btrfs does on compressed files.
> > > > >
> > > > > - Eric
> > > >
> > > > I also agree that that's an implementation detail that shouldn't be
> > > > exposed to userspace.
> > > >
> > > > I want to make it more clear for better appearance.
> > > >
> > > > Do you think we have to remove "unwritten" information below? I also
> > > > think it might be unnecessary information for the user.
> > > > [0..31]: 2683128..2683159 flag(0x1009) -> merged, encoded, last_extent
> > > > (unwritten?)
> > >
> > > FIEMAP_EXTENT_UNWRITTEN already has a specific meaning; see
> > > Documentation/filesystems/fiemap.rst.  It means that the data is all zeroes, and
> > > the disk space is preallocated but the data hasn't been written to disk yet.
> > >
> > > In this case, the data is *not* necessarily all zeroes.  So I think
> > > FIEMAP_EXTENT_UNWRITTEN shouldn't be used here.
> > >
> > > > Do you want f2fs to print out the info on a cluster basis, even when
> > > > the user asks for one block information?
> > > > Like
> > > > If the user asks for the info of [8..15], f2fs will return the info of [0..31]?
> > >
> > > Yes, since that's how FS_IOC_FIEMAP is supposed to work; see
> > > Documentation/filesystems/fiemap.rst:
> > >
> > >         All offsets and lengths are in bytes and mirror those on disk.  It is
> > >         valid for an extents logical offset to start before the request or its
> > >         logical length to extend past the request.
> > >
> > > (That being said, the f2fs compression+encryption tests I've written don't
> > > exercise this case; they only map the whole file at once.)
> > >
> > > - Eric
> >
> > My last question is.
> > How about a discontinuous cluster like [0..31] maps to discontinuous
> > three blocks like physical address 0x4, 0x14 and 0x24.
> > I think we have to return three extents for the one logical region
> > like the below. What do you think?
> > [0..31] -> 0x4 (merged, encoded)
> > [0..31] -> 0x14 (merged, encoded)
> > [0..31] -> 0x24 (merged, encoded, last_extent)
>
> No, please don't do that.  struct fiemap_extent only has a single length field,
> not separate lengths for fe_logical and fe_physical, so with your proposal there
> would be no way to know how many physical blocks to take from each extent.  It
> would be reporting the same part of the file in contradictory ways.
>
> Like I suggested originally, I think this case should be reported like:
>
>        fe_logical=0    fe_physical=16384  length=4096
>        fe_logical=4096 fe_physical=81920  length=4096
>        fe_logical=8192 fe_physical=147456 length=8192
>
> It's not perfect, but I think it's the least bad option, for the reasons I've
> explained previously...
>
> - Eric

Ok, I got your point. Let me try it again.

Thank you,
