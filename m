Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD84330321
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 18:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhCGRHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 12:07:15 -0500
Received: from netrider.rowland.org ([192.131.102.5]:48077 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231395AbhCGRHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 12:07:03 -0500
Received: (qmail 105706 invoked by uid 1000); 7 Mar 2021 12:07:02 -0500
Date:   Sun, 7 Mar 2021 12:07:02 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using
 xhci_hcd
Message-ID: <20210307170702.GB104554@rowland.harvard.edu>
References: <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu>
 <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
 <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com>
 <20210306165808.GD74411@rowland.harvard.edu>
 <CA+icZUWXBtOo+7TBGHFA=aKBs5o9hy3Po6NM0EPssu6y4SOZsQ@mail.gmail.com>
 <CA+icZUXcYY53DxpMRQmveuwUv0QVV7rtRorbxWUaVujJZuCB-A@mail.gmail.com>
 <CA+icZUUyNQN_CEwJcTY887GOeWknz4h29b+XdY0FqUKVJD7cfQ@mail.gmail.com>
 <20210307154645.GA103559@rowland.harvard.edu>
 <CA+icZUVLC7=-MsXeGQOrAe1emzGW2UwWYxh3EHGPhjR=chygoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVLC7=-MsXeGQOrAe1emzGW2UwWYxh3EHGPhjR=chygoQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 05:57:39PM +0100, Sedat Dilek wrote:
> On Sun, Mar 7, 2021 at 4:46 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Sat, Mar 06, 2021 at 09:49:00PM +0100, Sedat Dilek wrote:
> >
> > > For testing purposes, I stopped these systemd services:
> > >
> > > 1. systemctl stop smartmontools.service
> > >
> > > 2. systemctl stop udisks2.service
> > >
> > > Last seen xhci-reset:
> > >
> > > [Sat Mar  6 21:37:40 2021] SCSI ioctl error, cmd 85, prog pool-udisksd
> > >
> > > So, that every 10min xhci-reset was caused by pool-udisksd from udisks2.service.
> >
> > You have found the cause of your problem!  Great!
> >
> > And now, obviously order to fix the problem, you'll have to look into
> > the udisks2 service.  Maybe you can configure it so that it won't send
> > the problem-causing commands.
> >
> 
> I tried yesterday to add --debug option to the ExexStart line of
> udisks2.service, but did not see anything helpful.
> 
> There exist more user-space than udisks2 causing these xhci-resets.
> The cmd#s are also clear: A1 and 85 - whatever they mean.

Those are the two prefixes which indicate an ATA command is present.  
You can find them listed as ATA_12 and ATA_16 in 
include/scsi/scsi_proto.h.

> As said with Linux v5.10.y and Linux v5.11 I have not seen this.

Have you tried setting the quirk flag we discussed earlier _and_ turning 
off udisks2?  Maybe also turning off the other services which generate 
these commands?  Perhaps you'll find that when the quirk flag is 
present, some of those programs _don't_ generate any ATA commands.

> What about CCing linux-block and linux-scsi people?

Sure, go ahead if you want to.

Alan Stern
