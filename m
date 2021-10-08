Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F654426F92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhJHRdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:33:15 -0400
Received: from first.geanix.com ([116.203.34.67]:37354 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhJHRdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:33:13 -0400
Received: from skn-laptop (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 1487FC3B66;
        Fri,  8 Oct 2021 17:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1633714276; bh=JWfS19275allVPCWaX4T20Mtdi7r0TA98mw4cxYeGko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PWcMunuVSeH7rAPyXy1fFh23IUGE+SJoEHu/9fWi1I/uAyrgs8vjzkiOgF78NZe7Z
         7ygVRXI/3qy6bS0gfft4O2h0u0pA4VBc1XtKYww7bwp7taAkUxuFwYNBt+c9ekozkd
         NKhpy4lMcxI2NMH3+dh9/wiVrgSapHF1xX1VlD3jocqLlRSBcPIwddW5pwB7tnMEeq
         fUG9VvVA2lNx+zQsP7YOUnurhRR9EttRhmYPGoVi0IyFyKZIcRMZSyDmCgv/R3KTtb
         4EAM0zWdj8WVlGg0faGaJpWhADELcMr95JtBGKT8vIRileOBSlzRS8DLHy0EKlXaEb
         +SH4uk2HB+qrw==
Date:   Fri, 8 Oct 2021 19:31:14 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mtd: core: protect access to mtd devices while
 in suspend
Message-ID: <20211008173114.fmwbs3j3ufjvpcqd@skn-laptop>
References: <20211008141524.20ca8219@collabora.com>
 <20211008143825.3717116-1-sean@geanix.com>
 <20211008173043.6263ba80@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008173043.6263ba80@collabora.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 05:30:43PM +0200, Boris Brezillon wrote:
> Hi Sean,
> 
> Can you please submit that as a separate thread, ideally with an
> incremented version number, a changelog and a reference to all your
> previous attempts.

Yes, I'll do that with the next one.

> 
> On Fri,  8 Oct 2021 16:38:24 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
> > This will prevent reading/writing/erasing to a suspended mtd device.
> > It will force mtd_write()/mtd_read()/mtd_erase() to wait for
> > mtd_resume() to unlock access to mtd devices.
> 
> I think this has to be done for all the hooks except ->_reboot(),
> ->_get_device() and ->_put_device().
> 
> > 
> > Exec_op[0] speed things up, so we see this race when rawnand devices going
> 
> Mention the commit directly:
> 
> Commit ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op") speed
> things up, so we see this race when rawnand devices going ...
> 
> > into suspend. But it's actually "mtd: rawnand: Simplify the locking" that
> 
> But it's actually commit 013e6292aaf5 ("mtd: rawnand: Simplify the
> locking") that ...
> 
> > allows it to return errors rather than locking, before that commit it would
> > have waited for the rawnand device to resume.
> > 
> > Tested on a iMX6ULL.
> > 
> > [0]:
> > ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
> > 
> > Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> 
> You flagged yourself as the author even though you didn't really write
> that code. I guess I'm fine with that, but I'd appreciate a
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> here, at least.
> 

Of course, of course I forgot it... Still an RFC after all :)

> > ---
> > 
> > Hope I got it all :)
> > 
> >  drivers/mtd/mtdcore.c   | 57 ++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/mtd/mtd.h | 36 ++++++++++++++++++--------
> >  2 files changed, 81 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > index c8fd7f758938..3c93202e6cbb 100644
> > --- a/drivers/mtd/mtdcore.c
> > +++ b/drivers/mtd/mtdcore.c
> > @@ -36,6 +36,44 @@
> >  
> >  struct backing_dev_info *mtd_bdi;
> >  
> > +static void mtd_start_access(struct mtd_info *mtd)
> > +{
> > +	struct mtd_info *master = mtd_get_master(mtd);
> > +
> > +	/*
> > +	 * Don't take the suspend_lock on devices that don't
> > +	 * implement the suspend hook. Otherwise, lockdep will
> > +	 * complain about nested locks when trying to suspend MTD
> > +	 * partitions or MTD devices created by gluebi which are
> > +	 * backed by real devices.
> > +	 */
> > +	if (!master->_suspend)
> > +		return;
> > +
> 
> You need to remove the ->_suspend()/->_resume() implementation in
> mtd_concat.c, otherwise you'll hit the case described in the comment.

Do you mean to remove concat_suspend() and concat_resume() together
with the references to them?

> 
> BTW, did you test this series with lockdep enabled to make sure we
> don't introduce a deadlock?
> 

Good you mentioned it... I thought the kernel had LOCKDEP enabled, but I
guess it at some point got removed.

It reveals that mtd_read_oob() -> mtd_start_access() is using the suspend_lock
rw_semaphore before it's initialized...
But it's not complaining when going suspend and resuming, will continue
to test with LOCKDEP enabled.

/Sean

> > +	/*
> > +	 * Wait until the device is resumed. Should we have a
> > +	 * non-blocking mode here?
> > +	 */
> > +	while (1) {
> > +		down_read(&master->master.suspend_lock);
> > +		if (!master->master.suspended)
> > +			return;
> > +
> > +		up_read(&master->master.suspend_lock);
> > +		wait_event(master->master.resume_wq, master->master.suspended == 0);
> > +	}
> > +}
> > +
> > +static void mtd_end_access(struct mtd_info *mtd)
> > +{
> > +	struct mtd_info *master = mtd_get_master(mtd);
> > +
> > +	if (!master->_suspend)
> > +		return;
> > +
> > +	up_read(&master->master.suspend_lock);
> > +}
> > +

