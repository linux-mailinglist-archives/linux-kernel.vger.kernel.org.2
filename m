Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A9941DBA0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351591AbhI3OAT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Sep 2021 10:00:19 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:35201 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351513AbhI3OAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:00:18 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C7F57240014;
        Thu, 30 Sep 2021 13:58:32 +0000 (UTC)
Date:   Thu, 30 Sep 2021 15:58:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: add MEMREAD ioctl
Message-ID: <20210930155831.672acdee@xps13>
In-Reply-To: <YVXBf0v0AQ5+G9dt@larwa.hq.kempniu.pl>
References: <20210920070221.10173-1-kernel@kempniu.pl>
        <20210928155859.433844cb@xps13>
        <20210928162402.6bb64fcf@collabora.com>
        <20210928163519.08cd1138@xps13>
        <YVTBoAnQKYLNpOPc@larwa.hq.kempniu.pl>
        <20210930085133.13b5a228@collabora.com>
        <20210930104721.03dc45bb@xps13>
        <YVXBf0v0AQ5+G9dt@larwa.hq.kempniu.pl>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michał,

kernel@kempniu.pl wrote on Thu, 30 Sep 2021 15:54:07 +0200:

> > > > > > I remember discussing search a new READ ioctl with Sascha Hauer a few
> > > > > > years back, but I can't find the discussion...      
> > > > 
> > > > I think this is the thread in question:
> > > > 
> > > >     https://www.infradead.org/pipermail/linux-mtd/2016-April/thread.html#67085
> > > > 
> > > > In fact, it looks like Boris beat me to preparing a draft patch adding a
> > > > MEMREAD ioctl by some five years:
> > > > 
> > > >     https://www.infradead.org/pipermail/linux-mtd/2016-April/067187.html    
> > > 
> > > Exactly the one I was referring to. Note that this patch still contains
> > > the unbounded malloc which I think is worth fixing, but other than
> > > that and the addition of ECC stats, it looks pretty similar to yours.  
> 
> Right, thanks.
> 
> > > > I guess the big question from my perspective is: should I revive Boris'
> > > > original effort on the MEMREAD ioctl (which returns more detailed
> > > > bitflip stats in the structure passed by user space) or would that be a
> > > > waste of time because the subsystem will be switched over wholesale to a
> > > > new way of doing I/O (mtd_io_op) in the foreseeable future and therefore
> > > > exposing yet another ioctl to user space today would be frowned upon?
> > > >     
> > > 
> > > That's not my call to make, but I think those 2 things are orthogonal
> > > and can be addressed separately.  
> > 
> > Agreed.  
> 
> Thank you both - it sounds like I should start working on a v2 that will
> make the new MEMREAD ioctl return more detailed ECC statistics to user
> space.
> 
> Boris, I think a Suggested-by tag crediting you is in order for both the
> unbounded malloc issue and the MEMREAD ioctl, but submitting-patches.rst
> says I should not add this tag without your permission.  So, are you
> okay with me adding it?
> 
> Miquel, as for the unbounded malloc issue, should I address this in a
> separate (preliminary) patch or rather submit a two-patch v2 series
> (unbounded malloc fix + new MEMREAD ioctl)?

Both work as long as you keep the changes in different commits :)

Thanks,
Miquèl
