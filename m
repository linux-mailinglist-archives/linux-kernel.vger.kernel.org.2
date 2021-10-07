Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE7E4253DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240942AbhJGNQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhJGNQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:16:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E527C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 06:14:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 468A31F451F3;
        Thu,  7 Oct 2021 14:14:29 +0100 (BST)
Date:   Thu, 7 Oct 2021 15:14:26 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: use mutex to protect access while in
 suspend
Message-ID: <20211007151426.54db0764@collabora.com>
In-Reply-To: <20211007123916.w4oaooxfbawe6yw3@skn-laptop>
References: <20211004085509.iikxtdvxpt6bri5c@skn-laptop>
        <20211004115817.18739936@collabora.com>
        <20211004101246.kagtezizympxupat@skn-laptop>
        <20211004134700.26327f6f@collabora.com>
        <20211005070930.epgxb5qzumk4awxq@skn-laptop>
        <20211005102300.5da6d480@collabora.com>
        <20211005084938.jcbw24umhehoiirs@skn-laptop>
        <20211005105836.6c300f25@collabora.com>
        <20211007114351.3nafhtpefezxhanc@skn-laptop>
        <20211007141858.314533f2@collabora.com>
        <20211007123916.w4oaooxfbawe6yw3@skn-laptop>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 14:39:16 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> > >         return 0;
> > > 
> > >  free_detect_allocation:
> > > @@ -6264,6 +6272,8 @@ static int nand_scan_tail(struct nand_chip *chip)
> > >         if (chip->options & NAND_SKIP_BBTSCAN)
> > >                 return 0;
> > > 
> > > +       atomic_set(&chip->suspended, 0);
> > > +
> > >         /* Build bad block table */
> > >         ret = nand_create_bbt(chip);
> > >         if (ret)
> > > diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> > > index 88227044fc86..f7dcbc336170 100644
> > > --- a/include/linux/mtd/mtd.h
> > > +++ b/include/linux/mtd/mtd.h
> > > @@ -360,6 +360,8 @@ struct mtd_info {
> > >         int (*_get_device) (struct mtd_info *mtd);
> > >         void (*_put_device) (struct mtd_info *mtd);
> > > 
> > > +       wait_queue_head_t wait_queue;
> > > +  
> > 
> > wait_queue doesn't really describe what this waitqueue is used for
> > (maybe resume_wq), and the suspended state should be here as well
> > (actually, there's one already).  
> 
> I'll rename to something meaningful.
> > 
> > Actually, what we need is a way to prevent the device from being
> > suspended while accesses are still in progress, and new accesses from
> > being queued if a suspend is pending. So, I think you need a readwrite
> > lock here:
> > 
> > * take the lock in read mode for all IO accesses, check the
> >   mtd->suspended value
> >   - if true, release the lock, and wait (retry on wakeup)
> >   - if false, just do the IO
> > 
> > * take the lock in write mode when you want to suspend/resume the
> >   device and update the suspended field. Call wake_up_all() in the
> >   resume path  
> 
> Could we use the chip->lock mutex for this? It's does kinda what you
> described above?

No you can't. Remember I suggested to move all of that logic to
mtdcore.c, which doesn't know about the nand_chip struct.

> If we introduce a new lock, do we really need to have the suspended as
> an atomic?

Nope, I thought we could do without a lock, but we actually need to
track active IO requests, not just the suspended state.

> 
> I will test with some wait and retry added to nand_get_device().

Again, I think there's a misunderstanding here: if you move it to the
mtd layer, it can't be done in nand_get_device(). But once you've
implemented it in mtdcore.c, you should be able to get rid of the
nand_chip->suspended field.
