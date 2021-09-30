Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FA141D399
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348405AbhI3GxW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Sep 2021 02:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348384AbhI3GxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:53:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D8DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 23:51:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9D0EE1F4491C;
        Thu, 30 Sep 2021 07:51:36 +0100 (BST)
Date:   Thu, 30 Sep 2021 08:51:33 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: add MEMREAD ioctl
Message-ID: <20210930085133.13b5a228@collabora.com>
In-Reply-To: <YVTBoAnQKYLNpOPc@larwa.hq.kempniu.pl>
References: <20210920070221.10173-1-kernel@kempniu.pl>
        <20210928155859.433844cb@xps13>
        <20210928162402.6bb64fcf@collabora.com>
        <20210928163519.08cd1138@xps13>
        <YVTBoAnQKYLNpOPc@larwa.hq.kempniu.pl>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Michal,

On Wed, 29 Sep 2021 21:42:24 +0200
Michał Kępień <kernel@kempniu.pl> wrote:

> Miquel, Boris,
> 
> Thank you both for your input.
> 
> > > I do agree that a new interface is needed, but if we're adding a new
> > > entry point, let's make sure it covers all possible use cases we have
> > > now. At the very least, I think we're missing info about the maximum
> > > number of corrected bits per ECC region on the portion being read.
> > > Propagating EUCLEAN errors is nice, but it's not precise enough IMHO.
> > > 
> > > I remember discussing search a new READ ioctl with Sascha Hauer a few
> > > years back, but I can't find the discussion...  
> 
> I think this is the thread in question:
> 
>     https://www.infradead.org/pipermail/linux-mtd/2016-April/thread.html#67085
> 
> In fact, it looks like Boris beat me to preparing a draft patch adding a
> MEMREAD ioctl by some five years:
> 
>     https://www.infradead.org/pipermail/linux-mtd/2016-April/067187.html

Exactly the one I was referring to. Note that this patch still contains
the unbounded malloc which I think is worth fixing, but other than
that and the addition of ECC stats, it looks pretty similar to yours.

> 
> It is apparently true that "everything that can be invented has been
> invented"... :-)  I did search the web for existing mentions of a
> MEMREAD ioctl before submitting my patch, but this thread did not turn
> up in the results :(
> 
> Anyway, back in 2016, Sascha hinted that he might move forward with the
> draft prepared by Boris:
> 
>     https://www.infradead.org/pipermail/linux-mtd/2016-April/067215.html
> 
> but I cannot find any related submissions from Sascha in linux-mtd's
> Patchwork.
> 
> > We also discussed a mtd_io_op some time ago, which would equivalently
> > replace mtd_oob_ops at some point, including more information such as
> > the bitflips which happened on every chunk instead of the information
> > regarding the maximum number of bitflips in one of the chunks only.  
> 
> Is that discussion available online?  Search engines seem to be
> oblivious to that term, which makes it hard for me to get acquainted
> with that idea and/or to comment on it ;)

Not sure this has been discussed publicly, but I remember suggesting
that to Miquel a while ago to simplify the in-kernel MTD interface.

> 
> > IIRC the point was to get rid of the mtd_{read,write}{,_oob} hooks and
> > structures in favor of a more robust and complete set of operations.  
> 
> That sounds like a major overhaul, right?
> 
> I guess the big question from my perspective is: should I revive Boris'
> original effort on the MEMREAD ioctl (which returns more detailed
> bitflip stats in the structure passed by user space) or would that be a
> waste of time because the subsystem will be switched over wholesale to a
> new way of doing I/O (mtd_io_op) in the foreseeable future and therefore
> exposing yet another ioctl to user space today would be frowned upon?
> 

That's not my call to make, but I think those 2 things are orthogonal
and can be addressed separately.

Regards,

Boris
