Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051743282DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhCAPyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:54:16 -0500
Received: from netrider.rowland.org ([192.131.102.5]:55657 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236976AbhCAPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:54:08 -0500
Received: (qmail 1490473 invoked by uid 1000); 1 Mar 2021 10:53:21 -0500
Date:   Mon, 1 Mar 2021 10:53:21 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using
 xhci_hcd
Message-ID: <20210301155321.GA1490228@rowland.harvard.edu>
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
 <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
 <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 09:54:38AM +0100, Sedat Dilek wrote:
> On Wed, Feb 24, 2021 at 6:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Wed, Feb 24, 2021 at 2:44 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > Hi Mathias,
> > >
> > > I am here on Linux-v5.11-10201-gc03c21ba6f4e.
> > >
> > > I see a lot xhci-resets in my dmesg-log:
> > >
> > > root# LC_ALL=C dmesg -T | grep 'usb 4-1: reset SuperSpeed Gen 1 USB
> > > device number 2 using xhci_hcd' | wc -l
> > > 75
> > >
> > > This is what I have:
> > >
> > > root# lsusb -s 004:001
> > > Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > >
> > > root# lsusb -s 004:002
> > > Bus 004 Device 002: ID 174c:55aa ASMedia Technology Inc. ASM1051E SATA
> > > 6Gb/s bridge, ASM1053E SATA 6Gb/s bridge, ASM1153 SATA 3Gb/s bridge,
> > > ASM1153E SATA 6Gb/s bridge
> > >
> > > My external USB 3.0 HDD contains the partition with my Debian-system
> > > and is attached to the above xhci bus/device.
> > >
> > > Can you enlighten what this means?
> > > Is this a known issue?
> > > Is there a fix around?
> > >
> > > BTW, in which Git tree is the xhci development happening?
> > > Can you point me to it?
> > >
> > > I am attaching my linux-config and full dmesg-log.
> > >
> > > Also I have attached outputs of:
> > >
> > > $ sudo lsusb -vvv -d 1d6b:0003
> > > $ sudo lsusb -vvv -d 174c:55aa
> > >
> > > If you need further information, please let me know.
> > >
> > > Thanks.
> > >
> >
> > Looks like that xhci-reset happens here every 10min.
> >
> 
> [ To Greg ]
> 
> The problem still remains with Linux v5.12-rc1 (see [1]).
> 
> Yesterday, I ran some disk-health checks with smartctl and gsmartcontrol.
> All good.
> 
> For the first time I used badblocks from e2fsprogs Debian package:
> 
> root# LC_ALL=C badblocks -v -p 1 -s /dev/sdc -o
> badblocks-v-p-1-s_dev-sdc_$(uname -r).txt
> Checking blocks 0 to 976762583
> Checking for bad blocks (read-only test): done
> Pass completed, 0 bad blocks found. (0/0/0 errors)
> 
> Good, there is no file-system corruption or badblocks or even a hardware damage.
> 
> Anyway, feedback is much appreciated.
> 
> Thanks.

You can use usbmon on bus 4 to record the USB traffic.  It may indicate 
why the resets occur.

Alan Stern
