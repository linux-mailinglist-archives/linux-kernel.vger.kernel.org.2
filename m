Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C946F426D82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243001AbhJHPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242978AbhJHPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:32:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DECC061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:30:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 879331F45B04;
        Fri,  8 Oct 2021 16:30:52 +0100 (BST)
Date:   Fri, 8 Oct 2021 17:30:43 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mtd: core: protect access to mtd devices while
 in suspend
Message-ID: <20211008173043.6263ba80@collabora.com>
In-Reply-To: <20211008143825.3717116-1-sean@geanix.com>
References: <20211008141524.20ca8219@collabora.com>
        <20211008143825.3717116-1-sean@geanix.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Can you please submit that as a separate thread, ideally with an
incremented version number, a changelog and a reference to all your
previous attempts.

On Fri,  8 Oct 2021 16:38:24 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> This will prevent reading/writing/erasing to a suspended mtd device.
> It will force mtd_write()/mtd_read()/mtd_erase() to wait for
> mtd_resume() to unlock access to mtd devices.

I think this has to be done for all the hooks except ->_reboot(),
->_get_device() and ->_put_device().

> 
> Exec_op[0] speed things up, so we see this race when rawnand devices going

Mention the commit directly:

Commit ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op") speed
things up, so we see this race when rawnand devices going ...

> into suspend. But it's actually "mtd: rawnand: Simplify the locking" that

But it's actually commit 013e6292aaf5 ("mtd: rawnand: Simplify the
locking") that ...

> allows it to return errors rather than locking, before that commit it would
> have waited for the rawnand device to resume.
> 
> Tested on a iMX6ULL.
> 
> [0]:
> ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
> 
> Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

You flagged yourself as the author even though you didn't really write
that code. I guess I'm fine with that, but I'd appreciate a

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>

here, at least.

> ---
> 
> Hope I got it all :)
> 
>  drivers/mtd/mtdcore.c   | 57 ++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mtd/mtd.h | 36 ++++++++++++++++++--------
>  2 files changed, 81 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index c8fd7f758938..3c93202e6cbb 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -36,6 +36,44 @@
>  
>  struct backing_dev_info *mtd_bdi;
>  
> +static void mtd_start_access(struct mtd_info *mtd)
> +{
> +	struct mtd_info *master = mtd_get_master(mtd);
> +
> +	/*
> +	 * Don't take the suspend_lock on devices that don't
> +	 * implement the suspend hook. Otherwise, lockdep will
> +	 * complain about nested locks when trying to suspend MTD
> +	 * partitions or MTD devices created by gluebi which are
> +	 * backed by real devices.
> +	 */
> +	if (!master->_suspend)
> +		return;
> +

You need to remove the ->_suspend()/->_resume() implementation in
mtd_concat.c, otherwise you'll hit the case described in the comment.

BTW, did you test this series with lockdep enabled to make sure we
don't introduce a deadlock?

> +	/*
> +	 * Wait until the device is resumed. Should we have a
> +	 * non-blocking mode here?
> +	 */
> +	while (1) {
> +		down_read(&master->master.suspend_lock);
> +		if (!master->master.suspended)
> +			return;
> +
> +		up_read(&master->master.suspend_lock);
> +		wait_event(master->master.resume_wq, master->master.suspended == 0);
> +	}
> +}
> +
> +static void mtd_end_access(struct mtd_info *mtd)
> +{
> +	struct mtd_info *master = mtd_get_master(mtd);
> +
> +	if (!master->_suspend)
> +		return;
> +
> +	up_read(&master->master.suspend_lock);
> +}
> +
