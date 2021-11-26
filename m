Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5699F45EA72
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbhKZJgj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Nov 2021 04:36:39 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43217 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376303AbhKZJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:34:34 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4DE162000E;
        Fri, 26 Nov 2021 09:31:17 +0000 (UTC)
Date:   Fri, 26 Nov 2021 10:31:16 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtdchar: prevent unbounded allocation in MEMWRITE ioctl
Message-ID: <20211126103116.5bef6bc0@xps13>
In-Reply-To: <YZ98sDJZIqdhP0NF@larwa.hq.kempniu.pl>
References: <20211025082104.8017-1-kernel@kempniu.pl>
        <20211122103122.424326a1@xps13>
        <YZ98sDJZIqdhP0NF@larwa.hq.kempniu.pl>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michał,

kernel@kempniu.pl wrote on Thu, 25 Nov 2021 13:08:16 +0100:

> Hi Miquèl,
> 
> TL;DR: thanks, your comment made me look closer and I found what seems
> to be a feasible workaround that I will apply in v2 (along other fixes).
> 
> > > Despite my efforts, the patch does _not_ retain absolute backward
> > > compatibility and I do not know whether this is acceptable.
> > > Specifically, multi-eraseblock-sized writes (requiring multiple loop
> > > iterations to be processed) which succeeded with the original code _may_
> > > now return errors and/or write different contents to the device than the
> > > original code, depending on the MTD mode of operation requested and on
> > > whether the start offset is page-aligned.  The documentation for struct
> > > mtd_oob_ops warns about even multi-page write requests, but...
> > > 
> > > Example:
> > > 
> > >     MTD device parameters:
> > > 
> > >       - mtd->writesize = 2048
> > >       - mtd->erasesize = 131072
> > >       - 64 bytes of raw OOB space per page
> > > 
> > >     struct mtd_write_req req = {
> > >         .start = 2048,
> > >         .len = 262144,
> > >         .ooblen = 64,
> > >         .usr_data = ...,
> > >         .usr_oob = ...,
> > >         .mode = MTD_OPS_RAW,
> > >     };
> > > 
> > >     (This is a 128-page write with OOB data supplied for just one page.)
> > > 
> > >     Current mtdchar_write_ioctl() returns 0 for this request and writes
> > >     128 pages of data and 1 page's worth of OOB data (64 bytes) to the
> > >     MTD device.
> > > 
> > >     Patched mtdchar_write_ioctl() may return an error because the
> > >     original request gets split into two chunks (<data_len, oob_len>):
> > > 
> > >         <131072, 64>
> > >         <131072, 0>
> > > 
> > >     and the second chunk with zero OOB data length may make the MTD
> > >     driver unhappy in raw mode (resulting in only the first 64 pages of
> > >     data and 1 page's worth of OOB data getting written to the MTD
> > >     device).  
> > 
> > Isn't this a driver issue instead? I mean, writing an eraseblock
> > without providing any OOB data is completely fine, if the driver
> > accepts 2 blocks + 1 page OOB but refuses 1 block + 1 page OOB and then
> > 1 block, it's broken, no? Have you experienced such a situation in your
> > testing?  
> 
> I may not have expressed myself clearly here, sorry - the example was
> already getting a bit lengthy at that point... :)
> 
> I tested the patch with nandsim, but I do not think it is that specific
> driver that is broken.  The catch is that when mtd_write_oob() is
> called, nand_do_write_ops() splits multi-page requests into single-page
> requests and what it passes to nand_write_page() depends on whether the
> struct mtd_oob_ops it was invoked with has the oobbuf field set to NULL
> or not.  This is okay in itself, but when another request-splitting
> "layer" is introduced by my patch, the ioctl may start returning
> different result codes than it used to.
> 
> Here is what happens with the unpatched code for the example above:
> 
>  1. mtdchar_write_ioctl() gets called with the following request:
> 
>     struct mtd_write_req req = {
>         .start = 2048,
>         .len = 262144,
>         .ooblen = 64,
>         .usr_data = 0x10000000,
>         .usr_oob = 0x20000000,
>         .mode = MTD_OPS_RAW,
>     };
> 
>  2. The above request is passed through to mtd_write_oob() verbatim:
> 
>     struct mtd_oob_ops ops = {
>         .mode = MTD_OPS_RAW,
> 	.len = 262144,
> 	.ooblen = 64,
>         .datbuf = 0x10000000,
>         .oobbuf = 0x20000000,
>     };
> 
>  3. nand_do_write_ops() splits this request up into page-sized requests.
> 
>      a) For the first page, the initial 2048 bytes of data + 64 bytes of
>         OOB data are passed to nand_write_page().
> 
>      b) For each subsequent page, a 2048-byte chunk of data + 64 bytes
>         of 0xff bytes are passed to nand_write_page().
> 
>     Since the oobbuf field in the struct mtd_oob_ops passed is not NULL,
>     oob_required is set to 1 for all nand_write_page() calls.
> 
>  4. The above causes the driver to receive 2112 bytes of data for each
>     page write, which results in the ioctl being successful.
> 
> Here is what happens with the patched code:
> 
>  1. mtdchar_write_ioctl() gets called with the same request as above.
> 
>  2. The original request gets split into two eraseblock-sized
>     mtd_write_oob() calls:
> 
>      a) struct mtd_oob_ops ops = {
>             .mode = MTD_OPS_RAW,
>             .len = 131072,
>             .ooblen = 64,
>             .datbuf = 0x10000000,
>             .oobbuf = 0x20000000,
>         };
> 
>      b) struct mtd_oob_ops ops = {
>             .mode = MTD_OPS_RAW,
>             .len = 131072,
>             .ooblen = 0,
>             .datbuf = 0x10020000,
>             .oobbuf = NULL,
>         };
> 
>     (My code sets oobbuf to NULL if ooblen is 0.)
> 
>  3. nand_do_write_ops() splits the first request up into page-sized
>     requests the same way as for the original code.  It returns
>     successfully, so mtdchar_write_ioctl() proceeds with the next
>     eraseblock-sized request.
> 
>  4. nand_do_write_ops() splits the second request up into page-sized
>     requests.  The first page write contains 2048 bytes of data and no
>     OOB data; since the oobbuf field in the struct mtd_oob_ops passed is
>     NULL, oob_required is set to 0.
> 
>  5. The above causes the driver to receive 2048 bytes of data for a page
>     write in raw mode, which results in an error that propagates all the
>     way up to mtdchar_write_ioctl().

This is definitely far from an expected behavior. Writing a page
without OOB is completely fine.

> 
> The nandsim driver returns the same error if you pass the following
> request to the MEMWRITE ioctl:
> 
>     struct mtd_write_req req = {
>         .start = 2048,
>         .len = 2048,
>         .ooblen = 0,
>         .usr_data = 0x10000000,
>         .usr_oob = NULL,
>         .mode = MTD_OPS_RAW,
>     };
> 
> so it is not the driver that is broken or insane, it is the splitting
> process that may cause the MEMWRITE ioctl to return different error
> codes than before.
> 
> I played with the code a bit more and I found a fix which addresses this
> issue without breaking other scenarios: setting oobbuf to the same
> pointer for every loop iteration (if ooblen is 0, no OOB data will be
> written anyway).

You mean that
	{ .user_oob = NULL, .ooblen = 0 }
fails, while
	{ .user_oob = random, .ooblen = 0 }
works? This seems a little bit fragile.

Could you tell us the origin of the error? Because in
nand_do_write_ops() if ops->oobbuf is populated then oob_required is
set to true no matter the value set in ooblen.

Plus, the code in mtdchar is clear: .oobbuf is set to NULL if there are
no OOBs provided by the user so I believe this is a situation that
should already work. 

> I also tackled the problem of mishandling large non-page-aligned writes
> in v1 and I managed to fix it by trimming the first mtd_write_oob() call
> so that it ends on an eraseblock boundary.  This implicitly makes
> subsequent writes page-aligned and seems to fix the problem.

Great!

> 
> Finally, I reworked the OOB length adjustment code to address other
> cases of mishandling non-page-aligned writes.
> 
> I could not find any other cases in which the revised code behaves
> differently than the original one.  I will send v2 soon.

Thanks for all work on this topic!

Cheers,
Miquèl
