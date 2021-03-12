Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1321733995B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhCLV4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:56:54 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40369 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235369AbhCLV4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:56:43 -0500
Received: (qmail 314502 invoked by uid 1000); 12 Mar 2021 16:56:42 -0500
Date:   Fri, 12 Mar 2021 16:56:42 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using
 xhci_hcd
Message-ID: <20210312215642.GA314300@rowland.harvard.edu>
References: <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com>
 <CA+icZUUyNQN_CEwJcTY887GOeWknz4h29b+XdY0FqUKVJD7cfQ@mail.gmail.com>
 <20210307154645.GA103559@rowland.harvard.edu>
 <CA+icZUVLC7=-MsXeGQOrAe1emzGW2UwWYxh3EHGPhjR=chygoQ@mail.gmail.com>
 <20210307170702.GB104554@rowland.harvard.edu>
 <CA+icZUWaGt2k4kdV0JHqKUkB8DySqdeUgVNnVT1BUo8aveGZOw@mail.gmail.com>
 <CA+icZUWb40r1MTFYk9S0h2XgGfqCQtxpm9yHKNr3PDnDbUNBKQ@mail.gmail.com>
 <CA+icZUXkheVR-c9cdsJmeS9+FZj4Gswii+xBoAWK882QNdfcTg@mail.gmail.com>
 <20210312180523.GB302347@rowland.harvard.edu>
 <CA+icZUUysAE0fwDL2iDKsCgY=AfckOtAEi+86kkVEs0Lqc-Jkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUysAE0fwDL2iDKsCgY=AfckOtAEi+86kkVEs0Lqc-Jkg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 07:26:31PM +0100, Sedat Dilek wrote:
> On Fri, Mar 12, 2021 at 7:05 PM Alan Stern <stern@rowland.harvard.edu> wrote:

> > Although it's not conclusive, this log seems to indicate that ata_id
> > is the only program causing resets.  Have you tried preventing the
> > ata_id program from running (for example, by renaming it)?
> >
> 
> This is /lib/udev/ata_id from Debian's udev package.

That does not answer my question.

> > > Your diff now should say; s/SCSI ioctl error/SCSI ioctl info'.
> >
> > No, it shouldn't.  The log message itself is an info, but the event it
> > reports is an error.
> >
> 
> OK.
> Some of these SCSI ioctl errors are not causing a xhci-reset.

Yes, I noticed that.  In fact, the commands that cause a reset are all 
A1 (and not all of them), never 85.

> > > Alan, so "t" flags should be added as a quirks to linux-kernel sources...
> > >
> > > t = NO_ATA_1X  (don't allow ATA(12) and ATA(16) commands, uas only);
> > >
> > > ...for my ASMedia USB-3.0 controller?
> >
> > That's not at all clear.  This is a very common and popular device,
> > and nobody else has reported these problems.  It could be that
> > something is odd about your particular drive or computer, not these
> > drives in general.
> >
> 
> So, the external USB-3.0 HDD is now in "UAS only" mode/status.

Why?  Did you change something?

Alan Stern

> Cannot judge if things got better or not.
> 
> - Sedat -
