Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A243D1B79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 03:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhGVA7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 20:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhGVA7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 20:59:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D41C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 18:40:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y42so6072358lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 18:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWU7SdOsmeYo0TWfgP+Sn4a+QG5zD3wUdqHKbsK9/EA=;
        b=EXRjUOr5oYArS2i3JP8TKaeSGun+zuOG+vnC5qIBfhOHtXBLHXzAswrWUEuMiGlgy3
         YsbvNpd0JTQpS+LR1YDhkTkeRFKTAG9ynEWYpShn9t2sqnYJ/+Fa/E8vP63MzwCaHLbU
         h1IwJWZ1z+ZqKlLA6XKCSCFN52VgBHyqeEgZw667z2dO9Qcu+ML7YZAu2HYqxOke7Sy9
         GpX6tk6KWsjwxfm/ot6MeCrmpmvHZc+CSxYn6IdzPthQ73VmlySuRurkNP4xTSs/ukvw
         IrviTWTdxc/VK94UsWEM1GSr6Xh84S3d4qi8Fnl+bR3QY3+MeDgqlD3FUuXwtF9Kp43r
         xZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWU7SdOsmeYo0TWfgP+Sn4a+QG5zD3wUdqHKbsK9/EA=;
        b=dJmBqZsqazVmKYfdpjXC3Od0/NE8Mnp7UZKMO+iuEmVooyL3bCTBRRy1K6AjO1bEEs
         FGSFO+xC6UK4q5TghTcnqbwjczVOKoQZmHh+3XfFlAat/xneLpkbC/0g/WaMUWw7Xv6v
         z5WGQ3TZE26WokXXJ2y5KWPlumnSRVB86zENfY3tsVhnh3qlqF6tIhfWNmqN4W4ibEgM
         U3EfupOerXW/AHdXaBlvqERaTW65Hbczy+wl7ELA0bHTsghkMvdI51GiNBuqej8AKP/3
         Pf5oBau5WKx9WSnJoP0vxIsbN5T3boB58ZmUFlNI9TnhL4CTwlzi8dSs+9BScq7/syFn
         e0lQ==
X-Gm-Message-State: AOAM533cdJrCqoZFwfts9gtVDpscuuoJlO355PmG1tR2DH6ZxzbSqhhq
        eqacsgVcylBhQBXFMx24+7t6anyb56rtTcXyfcw=
X-Google-Smtp-Source: ABdhPJwUzHIuTlfj2HDSYaARWRI3kfa5pWpLCqC6mCujsgqa7zMaj2h1/zJ+KCVpfcd+a4yjurQws0KNmHaQ+/aS10Y=
X-Received: by 2002:a19:c3d6:: with SMTP id t205mr27042837lff.622.1626918011651;
 Wed, 21 Jul 2021 18:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210721072048.3035928-1-daeho43@gmail.com> <YPiTLwB3d8BWSKje@gmail.com>
 <CACOAw_xq3_ccqzh8dnomFXBOK_iN9LOTsOBYSBzDJHSSDrRxVw@mail.gmail.com>
 <YPi4rRg2ZPFBWaTZ@sol.localdomain> <CACOAw_xeTSa8J_9=+6thXvFT75u734D5asNRogUxt+DC-tPhxg@mail.gmail.com>
 <YPjGsSEdsoSsCJlB@sol.localdomain>
In-Reply-To: <YPjGsSEdsoSsCJlB@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 21 Jul 2021 18:40:00 -0700
Message-ID: <CACOAw_yWAUNiziiQuZgRDaVrOxceuEpO8QtoYGmhxxJV2s7wWQ@mail.gmail.com>
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

On Wed, Jul 21, 2021 at 6:15 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jul 21, 2021 at 06:04:22PM -0700, Daeho Jeong wrote:
> > >
> > > How f2fs stores the mapping information doesn't matter.  That's an
> > > implementation detail that shouldn't be exposed to userspace.  The only thing
> > > that should be exposed is the actual mapping, and for that it seems natural to
> > > report the physical blocks first.
> > >
> > > There is no perfect solution for how to handle the remaining logical blocks,
> > > given that the fiemap API was not designed for compressed files, but I think we
> > > should just go with extending the length of the last compressed extent in the
> > > cluster to cover the remaining logical blocks, i.e.:
> > >
> > >   [0..31]: 2683128..2683159 flag(0x1009) -> merged, encoded, last_extent
> > >
> > > That's what btrfs does on compressed files.
> > >
> > > - Eric
> >
> > I also agree that that's an implementation detail that shouldn't be
> > exposed to userspace.
> >
> > I want to make it more clear for better appearance.
> >
> > Do you think we have to remove "unwritten" information below? I also
> > think it might be unnecessary information for the user.
> > [0..31]: 2683128..2683159 flag(0x1009) -> merged, encoded, last_extent
> > (unwritten?)
>
> FIEMAP_EXTENT_UNWRITTEN already has a specific meaning; see
> Documentation/filesystems/fiemap.rst.  It means that the data is all zeroes, and
> the disk space is preallocated but the data hasn't been written to disk yet.
>
> In this case, the data is *not* necessarily all zeroes.  So I think
> FIEMAP_EXTENT_UNWRITTEN shouldn't be used here.
>
> > Do you want f2fs to print out the info on a cluster basis, even when
> > the user asks for one block information?
> > Like
> > If the user asks for the info of [8..15], f2fs will return the info of [0..31]?
>
> Yes, since that's how FS_IOC_FIEMAP is supposed to work; see
> Documentation/filesystems/fiemap.rst:
>
>         All offsets and lengths are in bytes and mirror those on disk.  It is
>         valid for an extents logical offset to start before the request or its
>         logical length to extend past the request.
>
> (That being said, the f2fs compression+encryption tests I've written don't
> exercise this case; they only map the whole file at once.)
>
> - Eric

My last question is.
How about a discontinuous cluster like [0..31] maps to discontinuous
three blocks like physical address 0x4, 0x14 and 0x24.
I think we have to return three extents for the one logical region
like the below. What do you think?
[0..31] -> 0x4 (merged, encoded)
[0..31] -> 0x14 (merged, encoded)
[0..31] -> 0x24 (merged, encoded, last_extent)
