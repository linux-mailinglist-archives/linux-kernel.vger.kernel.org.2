Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215F93D19C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhGUVuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhGUVuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 17:50:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA13C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:30:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h9so4963133ljm.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TU/KkduaSrurFShl837GHBlKY1G5viwl2DwVlMVRYRw=;
        b=l4dD20jhcB0ra/CjblbMC0qwO/H7BusoqZ7Eq0FzOKayOixc7r03ufBjhWvwl6DhwG
         5iETQYa6bbNa6tPt15XKmTjIP781paRAP1XWM7Rnz4s2bpKTtVUP+WwybGTOY5tk3lAW
         M8mzKnhwBZ1GmAWoabjgkw+SwZ1FRXrk/cFzXteP7v7oxJpNUrB+a8bQ7vhlUhhuVzT9
         +4bh+PbOjDKt5+pcgsKQtRS9Hnm64RE6KTMOvvvf5F66DC/MCCTxkC/Ylexhp7Mh6KWq
         9X6KAY2CXc2mY7S9sGZ8fed9qOveL4HOf42PPGk4Htx56saBtItEPnxQit0SpALb+Vjt
         hsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TU/KkduaSrurFShl837GHBlKY1G5viwl2DwVlMVRYRw=;
        b=cwLjDFfIZ0XqxBJrH05elWOv2DxtePEivvKHKHGeWbRRnqbMfsKqfSKD3QTtW+lsaS
         JYmGEVTT2vj3lpPUh/KJtvXMFNZwO37cNC3yNLVpldg3TAfaNrY34ko3XPx5qc8lM/Q7
         x6m0+rfBHZGs6kj/oLjppevaHL5fM94Ts0J9IyfDkxcu89RSe3EPlISw8MU3h8Qk+rXQ
         jSmeYM35jK71qtIQi/Wgdf7RkSFUqGdkq3eCBEWl6fJ1BNBjw4aPkJOa3VXOfF/8cj07
         sXqzRw7iQDGi/4kiZKnHstMEstxD2y1tVYLNWXkjwt8FoMgxnK+IvcTmHNnJp3rYOChQ
         FuEg==
X-Gm-Message-State: AOAM532rFYNFrFHCypzb4velJ66t8+oFkEE8K4C0meVe4B2BjcdjRzpO
        /IvFXwy0Aj1yiWIJwyc3efVqKVLWs7JHx9G329w=
X-Google-Smtp-Source: ABdhPJzxAE1hlSvd2ajpDjbBz/1Yfz+4LI9qCBI+A/TBLOw3jZ74TptEiaagBCUqi1wMk7xqrudDnLBcQex5nUiQIyE=
X-Received: by 2002:a2e:8858:: with SMTP id z24mr7143087ljj.413.1626906656926;
 Wed, 21 Jul 2021 15:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210721072048.3035928-1-daeho43@gmail.com> <YPiTLwB3d8BWSKje@gmail.com>
In-Reply-To: <YPiTLwB3d8BWSKje@gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 21 Jul 2021 15:30:46 -0700
Message-ID: <CACOAw_xq3_ccqzh8dnomFXBOK_iN9LOTsOBYSBzDJHSSDrRxVw@mail.gmail.com>
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

Hi Eric,

On Wed, Jul 21, 2021 at 2:35 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jul 21, 2021 at 12:20:48AM -0700, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > When we print out a discontinuous compression chunk, it shows like a
> > continuous chunk now. To show it more correctly, I've changed the way of
> > printing fiemap info like below. Plus, eliminated NEW_ADDR(-1) in fiemap
> > info, since it is not in fiemap user api manual.
> >
> > 0: 0000000000000000 0000000000000000 0000000000001000 1008 (M/E)
> > 1: 0000000000001000 0000000f15c0f000 0000000000001000 1008 (M/E)
> > 2: 0000000000002000 0000000000000000 0000000000002000 1808 (M/U/E)
> > 3: 0000000000004000 0000000000000000 0000000000001000 1008 (M/E)
> > 4: 0000000000005000 0000000f15c10000 0000000000001000 1008 (M/E)
> > 5: 0000000000006000 0000000000000000 0000000000002000 1808 (M/U/E)
> > 6: 0000000000008000 0000000000000000 0000000000001000 1008 (M/E)
>
> Please label these columns.
>
> Anyway, this doesn't appear to work quite in the way I had in mind.  With this
> patch, what I'm seeing is:
>
> $ head -c 16384 /dev/zero > file; xfs_io -c "fiemap -v" file
> file:
>  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>    0: [0..7]:          0..7                 8 0x1008
>    1: [8..15]:         2683128..2683135     8 0x1008
>    2: [16..31]:        0..15               16 0x1809
>
> So, working in 512-byte sectors, the logical sectors 0-31 are stored as one
> compressed cluster in the 8 physical sectors 2683128-2683135.
>
> The problem is, with this patch these physical sectors are reported at logical
> sectors 8-15 instead of 0-7.  Obviously, this isn't particularly well-defined,
> but I thought it was logical for the physical blocks to be associated with the
> first logical blocks.  That is what the tests I've written (xfstest f2fs/002,
> and the Android vts_kernel_encryption_test) assume.
>
> Is there any particular reason why you wouldn't report instead:
>
>    0: [0..7]:         2683128..2683135     8 0x1008
>    1: [8..31]:        0..23                8 0x1809
>
> - Eric

The reason is related to how F2FS stores the mapping information in
the mapping table.
Actually, the mapping inside of the table is like this.
[0..7]:  COMPR_ADDR flag(0x1008) -> merged, encoded
[8..15]: 2683128..2683135 flag(0x1008) -> merged, encoded
[16..31]: NEW_ADDR flag(0x1809) -> merged, unwritten(!), last_extent

I understand what you mean.
But, if we adapt to your way, how do you think we can print out when
we ask for f2fs to print out only the [8..15] area? Zero address? How
about flags?
I think the current way explains the layout of the f2fs metadata more exactly.

Thank you,
