Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBA63171C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhBJU4x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Feb 2021 15:56:53 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:32771 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhBJU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:56:40 -0500
X-Originating-IP: 90.2.4.167
Received: from xps13 (aputeaux-654-1-105-167.w90-2.abo.wanadoo.fr [90.2.4.167])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 1883CFF803;
        Wed, 10 Feb 2021 20:55:49 +0000 (UTC)
Date:   Wed, 10 Feb 2021 21:55:48 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
Message-ID: <20210210215548.40ce9ba5@xps13>
In-Reply-To: <1183985773.380599.1612956233979.JavaMail.zimbra@nod.at>
References: <20210124232007.21639-1-richard@nod.at>
        <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
        <1507208626.379155.1612906761549.JavaMail.zimbra@nod.at>
        <CAJfpegugbvppOKhJ8KjSVGgZOGVuj6NSiy4n18mbD7Ui3wme6g@mail.gmail.com>
        <20210210121429.4fb5ecf3@xps13>
        <1183985773.380599.1612956233979.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Richard Weinberger <richard@nod.at> wrote on Wed, 10 Feb 2021 12:23:53
+0100 (CET):

> Miquel,
> 
> ----- Ursprüngliche Mail -----
> >> Does in-band and OOB data need to be handled together?  
> > 
> > Short answer: yes.
> >   
> >> If so, then two requests is not a good option.  
> > 
> > More detailed answer:
> > 
> > There is a type of MTD device (NAND devices) which are composed, for
> > each page, of X in-band bytes plus Y out-of-band metadata bytes.
> > 
> > Accessing either the in-band data, or the out-of-band data, or both at
> > the same time are all valid use cases.
> > 
> > * Read operation details:
> >  From a hardware point of view, the out-of-band data is (almost)
> >  always retrieved when the in-band data is read because it contains
> >  meta-data used to correct eventual bitflips. In this case, if both
> >  areas are requested, it is highly non-efficient to do two requests,
> >  that's why the MTD core allows to do both at the same time.
> > * Write operation details:
> >  Even worse, in the write case, you *must* write both at the same
> >  time. It is physically impossible to do one after the other (still
> >  with actual hardware, of course).
> > 
> > That is why it is preferable that MUSE will be able to access both in
> > a single request.  
> 
> By single request we meant FUSE op-codes. The NAND simulator in Userspace
> will see just one call. My plan is to abstract it in libfuse.

If libfuse abstracts it, as long as MTD only sees a single request I'm
fine :)

Thanks,
Miquèl
