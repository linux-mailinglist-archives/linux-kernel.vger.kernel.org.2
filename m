Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3754F41D5A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348711AbhI3ItK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Sep 2021 04:49:10 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:36473 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbhI3ItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:49:09 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0C60A200007;
        Thu, 30 Sep 2021 08:47:21 +0000 (UTC)
Date:   Thu, 30 Sep 2021 10:47:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: add MEMREAD ioctl
Message-ID: <20210930104721.03dc45bb@xps13>
In-Reply-To: <20210930085133.13b5a228@collabora.com>
References: <20210920070221.10173-1-kernel@kempniu.pl>
        <20210928155859.433844cb@xps13>
        <20210928162402.6bb64fcf@collabora.com>
        <20210928163519.08cd1138@xps13>
        <YVTBoAnQKYLNpOPc@larwa.hq.kempniu.pl>
        <20210930085133.13b5a228@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


boris.brezillon@collabora.com wrote on Thu, 30 Sep 2021 08:51:33 +0200:

> Hu Michal,
> 
> On Wed, 29 Sep 2021 21:42:24 +0200
> Michał Kępień <kernel@kempniu.pl> wrote:
> 
> > Miquel, Boris,
> > 
> > Thank you both for your input.
> >   
> > > > I do agree that a new interface is needed, but if we're adding a new
> > > > entry point, let's make sure it covers all possible use cases we have
> > > > now. At the very least, I think we're missing info about the maximum
> > > > number of corrected bits per ECC region on the portion being read.
> > > > Propagating EUCLEAN errors is nice, but it's not precise enough IMHO.
> > > > 
> > > > I remember discussing search a new READ ioctl with Sascha Hauer a few
> > > > years back, but I can't find the discussion...    
> > 
> > I think this is the thread in question:
> > 
> >     https://www.infradead.org/pipermail/linux-mtd/2016-April/thread.html#67085
> > 
> > In fact, it looks like Boris beat me to preparing a draft patch adding a
> > MEMREAD ioctl by some five years:
> > 
> >     https://www.infradead.org/pipermail/linux-mtd/2016-April/067187.html  
> 
> Exactly the one I was referring to. Note that this patch still contains
> the unbounded malloc which I think is worth fixing, but other than
> that and the addition of ECC stats, it looks pretty similar to yours.
> 
> > 
> > It is apparently true that "everything that can be invented has been
> > invented"... :-)  I did search the web for existing mentions of a
> > MEMREAD ioctl before submitting my patch, but this thread did not turn
> > up in the results :(
> > 
> > Anyway, back in 2016, Sascha hinted that he might move forward with the
> > draft prepared by Boris:
> > 
> >     https://www.infradead.org/pipermail/linux-mtd/2016-April/067215.html
> > 
> > but I cannot find any related submissions from Sascha in linux-mtd's
> > Patchwork.
> >   
> > > We also discussed a mtd_io_op some time ago, which would equivalently
> > > replace mtd_oob_ops at some point, including more information such as
> > > the bitflips which happened on every chunk instead of the information
> > > regarding the maximum number of bitflips in one of the chunks only.    
> > 
> > Is that discussion available online?  Search engines seem to be
> > oblivious to that term, which makes it hard for me to get acquainted
> > with that idea and/or to comment on it ;)  
> 
> Not sure this has been discussed publicly, but I remember suggesting
> that to Miquel a while ago to simplify the in-kernel MTD interface.

It certainly happened on IRC indeed.

> > > IIRC the point was to get rid of the mtd_{read,write}{,_oob} hooks and
> > > structures in favor of a more robust and complete set of operations.    
> > 
> > That sounds like a major overhaul, right?
> > 
> > I guess the big question from my perspective is: should I revive Boris'
> > original effort on the MEMREAD ioctl (which returns more detailed
> > bitflip stats in the structure passed by user space) or would that be a
> > waste of time because the subsystem will be switched over wholesale to a
> > new way of doing I/O (mtd_io_op) in the foreseeable future and therefore
> > exposing yet another ioctl to user space today would be frowned upon?
> >   
> 
> That's not my call to make, but I think those 2 things are orthogonal
> and can be addressed separately.

Agreed.

Thanks,
Miquèl
