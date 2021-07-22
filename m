Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C63D1B27
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 03:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhGVAYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 20:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhGVAYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 20:24:00 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74110C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 18:04:35 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b29so5272505ljf.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 18:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdVcgyFrt783lScdfhCI3lPMqTnUeK9ABSA/mH1ibjA=;
        b=sDr7Rqiv2gHMiCoRQZiZO9pNAnwQF16sUvpKjdVJH0Bs24fQr9AU2Mv3v0hhZAlY6Z
         8GTMv3YdfjExVAEMDk8Zm9SCBDeFJM5oVhyfr4Iqrf0J/9mRQH7aHRJq3qEWgUf2SgVn
         jPy+0bTF5vfNU7DBfMulckGN7g7nV9Fl1NpGrfOnTWBUHDS+UWyodtJyltQAD2+i54oj
         rNgHcLz/XyfVnoe26X2cehEIwB7CGRmzhaF4EILnrYuSrtqWx/coCNJWNkHjkRvdI3aW
         dNeItESvKhgTI6HIgYTSRPvEg9BrHhIxj+Nd8+yIWgbRHSHrQ4XJCP9Wk3v9xsd/NqLC
         W4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdVcgyFrt783lScdfhCI3lPMqTnUeK9ABSA/mH1ibjA=;
        b=G/+AConNENujU5xPfNqIkB4wKwQsuSs0qY2DyRRj8lwoqyLHpNghA497+gnuFDYvjP
         hDsVkDGzyYGPMhSFitBFlZgbrtB75sIfAoyGnj9YHwDdjQeWWZ6yvCPc/dfvKE4nAmYj
         8+paeWILcdVXQBu0RN7vhwZQmlX7ZtjWVnMTw8zv5f0j7Ht8stvqnw13I8vQZpGM3Dhj
         05ol1F6Z80ekJzV85aWh20exEerIwd128qj2y+Zv7CTMj90X2umOsKt/Thy+48uaAfLP
         6kIsoE6T6CW825nDK2GfOvOifcaXzopMXSxYmu7gU8H9H9PIhtLoFr6YaTPk1wYnZeto
         IMbg==
X-Gm-Message-State: AOAM531KqU+8VFDdQiDnNhtR63/l9PZ8FnlXwBiS2K1bJJto1K4HLotL
        IKIhSfmEJuPPSOJ3e1D1ERyDRbS8Zat7mMAbo2o=
X-Google-Smtp-Source: ABdhPJx6C1BNH+dXBtZGhfH7IpQO10Bys3xuxRePvkRl3kG+SS2EgsEpLMT1bFABsd4JrLjCtuYKWGMBZvd6/yXFCLI=
X-Received: by 2002:a2e:92c8:: with SMTP id k8mr15788610ljh.136.1626915873774;
 Wed, 21 Jul 2021 18:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210721072048.3035928-1-daeho43@gmail.com> <YPiTLwB3d8BWSKje@gmail.com>
 <CACOAw_xq3_ccqzh8dnomFXBOK_iN9LOTsOBYSBzDJHSSDrRxVw@mail.gmail.com> <YPi4rRg2ZPFBWaTZ@sol.localdomain>
In-Reply-To: <YPi4rRg2ZPFBWaTZ@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 21 Jul 2021 18:04:22 -0700
Message-ID: <CACOAw_xeTSa8J_9=+6thXvFT75u734D5asNRogUxt+DC-tPhxg@mail.gmail.com>
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

On Wed, Jul 21, 2021 at 5:15 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jul 21, 2021 at 03:30:46PM -0700, Daeho Jeong wrote:
> > Hi Eric,
> >
> > On Wed, Jul 21, 2021 at 2:35 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Wed, Jul 21, 2021 at 12:20:48AM -0700, Daeho Jeong wrote:
> > > > From: Daeho Jeong <daehojeong@google.com>
> > > >
> > > > When we print out a discontinuous compression chunk, it shows like a
> > > > continuous chunk now. To show it more correctly, I've changed the way of
> > > > printing fiemap info like below. Plus, eliminated NEW_ADDR(-1) in fiemap
> > > > info, since it is not in fiemap user api manual.
> > > >
> > > > 0: 0000000000000000 0000000000000000 0000000000001000 1008 (M/E)
> > > > 1: 0000000000001000 0000000f15c0f000 0000000000001000 1008 (M/E)
> > > > 2: 0000000000002000 0000000000000000 0000000000002000 1808 (M/U/E)
> > > > 3: 0000000000004000 0000000000000000 0000000000001000 1008 (M/E)
> > > > 4: 0000000000005000 0000000f15c10000 0000000000001000 1008 (M/E)
> > > > 5: 0000000000006000 0000000000000000 0000000000002000 1808 (M/U/E)
> > > > 6: 0000000000008000 0000000000000000 0000000000001000 1008 (M/E)
> > >
> > > Please label these columns.
> > >
> > > Anyway, this doesn't appear to work quite in the way I had in mind.  With this
> > > patch, what I'm seeing is:
> > >
> > > $ head -c 16384 /dev/zero > file; xfs_io -c "fiemap -v" file
> > > file:
> > >  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> > >    0: [0..7]:          0..7                 8 0x1008
> > >    1: [8..15]:         2683128..2683135     8 0x1008
> > >    2: [16..31]:        0..15               16 0x1809
> > >
> > > So, working in 512-byte sectors, the logical sectors 0-31 are stored as one
> > > compressed cluster in the 8 physical sectors 2683128-2683135.
> > >
> > > The problem is, with this patch these physical sectors are reported at logical
> > > sectors 8-15 instead of 0-7.  Obviously, this isn't particularly well-defined,
> > > but I thought it was logical for the physical blocks to be associated with the
> > > first logical blocks.  That is what the tests I've written (xfstest f2fs/002,
> > > and the Android vts_kernel_encryption_test) assume.
> > >
> > > Is there any particular reason why you wouldn't report instead:
> > >
> > >    0: [0..7]:         2683128..2683135     8 0x1008
> > >    1: [8..31]:        0..23                8 0x1809
> > >
> > > - Eric
> >
> > The reason is related to how F2FS stores the mapping information in
> > the mapping table.
> > Actually, the mapping inside of the table is like this.
> > [0..7]:  COMPR_ADDR flag(0x1008) -> merged, encoded
> > [8..15]: 2683128..2683135 flag(0x1008) -> merged, encoded
> > [16..31]: NEW_ADDR flag(0x1809) -> merged, unwritten(!), last_extent
> >
> > I understand what you mean.
> > But, if we adapt to your way, how do you think we can print out when
> > we ask for f2fs to print out only the [8..15] area? Zero address? How
> > about flags?
> > I think the current way explains the layout of the f2fs metadata more exactly.
> >
>
> How f2fs stores the mapping information doesn't matter.  That's an
> implementation detail that shouldn't be exposed to userspace.  The only thing
> that should be exposed is the actual mapping, and for that it seems natural to
> report the physical blocks first.
>
> There is no perfect solution for how to handle the remaining logical blocks,
> given that the fiemap API was not designed for compressed files, but I think we
> should just go with extending the length of the last compressed extent in the
> cluster to cover the remaining logical blocks, i.e.:
>
>   [0..31]: 2683128..2683159 flag(0x1009) -> merged, encoded, last_extent
>
> That's what btrfs does on compressed files.
>
> - Eric

I also agree that that's an implementation detail that shouldn't be
exposed to userspace.

I want to make it more clear for better appearance.

Do you think we have to remove "unwritten" information below? I also
think it might be unnecessary information for the user.
[0..31]: 2683128..2683159 flag(0x1009) -> merged, encoded, last_extent
(unwritten?)

Do you want f2fs to print out the info on a cluster basis, even when
the user asks for one block information?
Like
If the user asks for the info of [8..15], f2fs will return the info of [0..31]?

Thank you,
