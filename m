Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACDF316521
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhBJLXv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Feb 2021 06:23:51 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46601 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhBJLPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:15:45 -0500
X-Originating-IP: 90.2.4.167
Received: from xps13 (aputeaux-654-1-105-167.w90-2.abo.wanadoo.fr [90.2.4.167])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 44AA11BF206;
        Wed, 10 Feb 2021 11:14:55 +0000 (UTC)
Date:   Wed, 10 Feb 2021 12:14:29 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
Message-ID: <20210210121429.4fb5ecf3@xps13>
In-Reply-To: <CAJfpegugbvppOKhJ8KjSVGgZOGVuj6NSiy4n18mbD7Ui3wme6g@mail.gmail.com>
References: <20210124232007.21639-1-richard@nod.at>
        <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
        <1507208626.379155.1612906761549.JavaMail.zimbra@nod.at>
        <CAJfpegugbvppOKhJ8KjSVGgZOGVuj6NSiy4n18mbD7Ui3wme6g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos,

Miklos Szeredi <miklos@szeredi.hu> wrote on Wed, 10 Feb 2021 11:16:45
+0100:

> On Tue, Feb 9, 2021 at 10:39 PM Richard Weinberger <richard@nod.at> wrote:
> >
> > Miklos,
> >
> > ----- Ursprüngliche Mail -----  
> > > If you look at fuse_do_ioctl() it does variable length input and
> > > output at the same time.  I guess you need something similar to that.  
> >
> > I'm not sure whether I understand correctly.
> >
> > In MUSE one use case would be attaching two distinct (variable length) buffers to a
> > single FUSE request, in both directions.
> > If I read fuse_do_ioctl() correctly, it attaches always a single buffer per request
> > but does multiple requests.  
> 
> Right.
> 
> > In MUSE we cold go the same path and issue up to two requests.
> > One for in-band and optionally a second one for the out-of-band data.
> > Hmmm?  
> 
> Does in-band and OOB data need to be handled together?

Short answer: yes.

> If so, then two requests is not a good option.

More detailed answer:

There is a type of MTD device (NAND devices) which are composed, for
each page, of X in-band bytes plus Y out-of-band metadata bytes.

Accessing either the in-band data, or the out-of-band data, or both at
the same time are all valid use cases.

* Read operation details:
  From a hardware point of view, the out-of-band data is (almost)
  always retrieved when the in-band data is read because it contains
  meta-data used to correct eventual bitflips. In this case, if both
  areas are requested, it is highly non-efficient to do two requests,
  that's why the MTD core allows to do both at the same time.
* Write operation details:
  Even worse, in the write case, you *must* write both at the same
  time. It is physically impossible to do one after the other (still
  with actual hardware, of course).

That is why it is preferable that MUSE will be able to access both in
a single request.

Thanks,
Miquèl
