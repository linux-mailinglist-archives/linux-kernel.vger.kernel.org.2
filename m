Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B06A422182
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhJEJAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhJEJAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:00:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B00EC061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 01:58:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3410D1F4385F;
        Tue,  5 Oct 2021 09:58:39 +0100 (BST)
Date:   Tue, 5 Oct 2021 10:58:36 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: use mutex to protect access while in
 suspend
Message-ID: <20211005105836.6c300f25@collabora.com>
In-Reply-To: <20211005084938.jcbw24umhehoiirs@skn-laptop>
References: <20211004065608.3190348-1-sean@geanix.com>
        <20211004104147.579f3b01@collabora.com>
        <20211004085509.iikxtdvxpt6bri5c@skn-laptop>
        <20211004115817.18739936@collabora.com>
        <20211004101246.kagtezizympxupat@skn-laptop>
        <20211004134700.26327f6f@collabora.com>
        <20211005070930.epgxb5qzumk4awxq@skn-laptop>
        <20211005102300.5da6d480@collabora.com>
        <20211005084938.jcbw24umhehoiirs@skn-laptop>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 10:49:38 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On Tue, Oct 05, 2021 at 10:23:00AM +0200, Boris Brezillon wrote:
> > On Tue, 5 Oct 2021 09:09:30 +0200
> > Sean Nyekjaer <sean@geanix.com> wrote:  
> 
> [ ... ]
> 
> > > 
> > > Have you seen the reproducer script?  
> > 
> > How would I know about this script or your previous attempt (mentioned
> > at the end of this email) given I was not Cc-ed on the previous
> > discussion, and nothing mentions it in this RFC...
> >   
> 
> That's why I shared it here ;)
> Initially I thought this was a bug introduced by exec_op.
> 
> > > ---
> > > root@iwg26-v1:/data/root# cat /data/crash.sh
> > > #!/bin/sh -x
> > > 
> > > echo enabled > /sys/devices/platform/soc/2100000.bus/21f4000.serial/tty/ttymxc4/power/wakeup
> > > 
> > > rm /data/test50M
> > > dd if=/dev/urandom of=/tmp/test50M bs=1M count=50
> > > cp /tmp/test50M /data/ &
> > > sleep 1
> > > echo mem > /sys/power/state
> > > ---
> > > 
> > > As seen in the log above disk is synced before suspend.
> > > cp is continuing to copy data to ubifs.
> > > And then user space processes are frozen.
> > > At this point the kernel thread would have unwritten data.
> > > 
> > > We tried to solve this with:
> > > https://lkml.org/lkml/2021/9/1/280  
> > 
> > I see. It's still unclear to me when the write happens. Is it in the
> > suspend path (before the system is actually suspended), or in the
> > resume path (when the system is being resumed).
> > 
> > Anyway, let's admit writing to a storage device while it's suspended is
> > a valid use case and requires the storage layer to put this request on
> > old. This wait should not, IMHO, be handled at the NAND level, but at
> > the MTD level (using a waitqueue, and an atomic to make
> > suspended/resumed transitions safe). And abusing a mutex to implement
> > that is certainly not a good idea.  
> 
> I did't say this was the right solution ;) I actually asked in the RFC:
> "Should we introduce a new mutex? Or maybe a spin_lock?"
> 
> What are you proposing, a waitqueue in mtd_info? That gets checked in
> mtd_write()/mtd_read()?

Yes, and replacing the suspended state by an atomic, and providing a
helper to wait on the device readiness. Helper you will call in every
path involving a communication with the HW, not just mtd_read/write()
(you're missing erase at least, and I fear there are other hooks that
might lead to commands being issued to the device). But before we get
there, I think it's important to understand what the kernel expects.
IOW, if and when threads can do a request on a suspended device, and
when it's acceptable to wait (vs returning -EBUSY), otherwise I fear
we'll end up with deadlocks in the suspend/resume path.
