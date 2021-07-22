Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA763D1A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 02:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhGUXfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 19:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhGUXfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 19:35:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25C266124B;
        Thu, 22 Jul 2021 00:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626912943;
        bh=Qi3eR8xtzF26kiZ/SexfczHNUk8vNBP4CNqtBcnRUz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlp3kMuyWwjBup3T8xmMDvY1XbcRSc4ahYSiLtUemz2qP5FPPS0dRsWqROxmMHp8D
         OuHZzX7MvrLVSNlc6m4xlfXnHbHdPThtquLrVG436+htzpsQkOcmMrnBe1RxPGh5cV
         tlTb3MfyGJp6AR+sHw+kv+A79fut394cWt1VtXM0WfDiTvPkPpdT7cSdSUpP7ftxms
         aWrJ3UtxjPRD0ZrBlbPLou5jRBm65vzpPo9YzP50pzcI+BJZ5M88yrMJjmLPqviRBX
         c733iBldFIWacFWvYdgKQm0gELYLyR9TDjFIWXY6+PXrXaBYN/WkV+NmJ6OPGXJ6XN
         WRIOxLZLS1VDQ==
Date:   Wed, 21 Jul 2021 17:15:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: change fiemap way in printing
 compression chunk
Message-ID: <YPi4rRg2ZPFBWaTZ@sol.localdomain>
References: <20210721072048.3035928-1-daeho43@gmail.com>
 <YPiTLwB3d8BWSKje@gmail.com>
 <CACOAw_xq3_ccqzh8dnomFXBOK_iN9LOTsOBYSBzDJHSSDrRxVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_xq3_ccqzh8dnomFXBOK_iN9LOTsOBYSBzDJHSSDrRxVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 03:30:46PM -0700, Daeho Jeong wrote:
> Hi Eric,
> 
> On Wed, Jul 21, 2021 at 2:35 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Wed, Jul 21, 2021 at 12:20:48AM -0700, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > When we print out a discontinuous compression chunk, it shows like a
> > > continuous chunk now. To show it more correctly, I've changed the way of
> > > printing fiemap info like below. Plus, eliminated NEW_ADDR(-1) in fiemap
> > > info, since it is not in fiemap user api manual.
> > >
> > > 0: 0000000000000000 0000000000000000 0000000000001000 1008 (M/E)
> > > 1: 0000000000001000 0000000f15c0f000 0000000000001000 1008 (M/E)
> > > 2: 0000000000002000 0000000000000000 0000000000002000 1808 (M/U/E)
> > > 3: 0000000000004000 0000000000000000 0000000000001000 1008 (M/E)
> > > 4: 0000000000005000 0000000f15c10000 0000000000001000 1008 (M/E)
> > > 5: 0000000000006000 0000000000000000 0000000000002000 1808 (M/U/E)
> > > 6: 0000000000008000 0000000000000000 0000000000001000 1008 (M/E)
> >
> > Please label these columns.
> >
> > Anyway, this doesn't appear to work quite in the way I had in mind.  With this
> > patch, what I'm seeing is:
> >
> > $ head -c 16384 /dev/zero > file; xfs_io -c "fiemap -v" file
> > file:
> >  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >    0: [0..7]:          0..7                 8 0x1008
> >    1: [8..15]:         2683128..2683135     8 0x1008
> >    2: [16..31]:        0..15               16 0x1809
> >
> > So, working in 512-byte sectors, the logical sectors 0-31 are stored as one
> > compressed cluster in the 8 physical sectors 2683128-2683135.
> >
> > The problem is, with this patch these physical sectors are reported at logical
> > sectors 8-15 instead of 0-7.  Obviously, this isn't particularly well-defined,
> > but I thought it was logical for the physical blocks to be associated with the
> > first logical blocks.  That is what the tests I've written (xfstest f2fs/002,
> > and the Android vts_kernel_encryption_test) assume.
> >
> > Is there any particular reason why you wouldn't report instead:
> >
> >    0: [0..7]:         2683128..2683135     8 0x1008
> >    1: [8..31]:        0..23                8 0x1809
> >
> > - Eric
> 
> The reason is related to how F2FS stores the mapping information in
> the mapping table.
> Actually, the mapping inside of the table is like this.
> [0..7]:  COMPR_ADDR flag(0x1008) -> merged, encoded
> [8..15]: 2683128..2683135 flag(0x1008) -> merged, encoded
> [16..31]: NEW_ADDR flag(0x1809) -> merged, unwritten(!), last_extent
> 
> I understand what you mean.
> But, if we adapt to your way, how do you think we can print out when
> we ask for f2fs to print out only the [8..15] area? Zero address? How
> about flags?
> I think the current way explains the layout of the f2fs metadata more exactly.
> 

How f2fs stores the mapping information doesn't matter.  That's an
implementation detail that shouldn't be exposed to userspace.  The only thing
that should be exposed is the actual mapping, and for that it seems natural to
report the physical blocks first.

There is no perfect solution for how to handle the remaining logical blocks,
given that the fiemap API was not designed for compressed files, but I think we
should just go with extending the length of the last compressed extent in the
cluster to cover the remaining logical blocks, i.e.:

  [0..31]: 2683128..2683159 flag(0x1009) -> merged, encoded, last_extent

That's what btrfs does on compressed files.

- Eric
