Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC43E1B7F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbhHESkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhHESkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:40:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A384D601FF;
        Thu,  5 Aug 2021 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628188801;
        bh=uieYp5dhE+BgI7VoI96Hu2v7JqETU3Mt5VK7tX6c9+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBqWXZTK4SvQZPLH6flfZWcY/SIWBu7fUYdkdHKHHgPo2QKkibu16RRHUFGqHdRQA
         RmfWLeB5aUFlLzFrqKeAb57N1MThNF3YdPMRIF+TnzZBqPQMBqSfJEzskEeWhvO8yH
         xXPx29sFSPYObnTH9vqEC24WsQ68Dsv8A7msmsOA=
Date:   Thu, 5 Aug 2021 20:39:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: USB xhci crash under load on 5.14-rc3
Message-ID: <YQwwfn2rQGvCrvXS@kroah.com>
References: <YQpJLk42b+0g7WFB@kroah.com>
 <9bb1d58b-5c68-86b7-13df-2faa749880c5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bb1d58b-5c68-86b7-13df-2faa749880c5@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 05:59:00PM +0300, Mathias Nyman wrote:
> On 4.8.2021 11.00, Greg KH wrote:
> > Hi,
> > 
> > I was doing some filesystem backups from one USB device to another one
> > this weekend and kept running into the problem of the xhci controller
> > shutting down after an hour or so of high volume traffic.
> > 
> > I finally captured the problem in the kernel log as this would also take
> > out my keyboard, making it hard to recover from :)
> > 
> > The log is below for when the problem happens, and then the devices are
> > disconnected from the bus (ignore the filesystem errors, those are
> > expected when i/o is in flight and we disconnect a device.
> > 
> > Any hint as to what the IO_PAGE_FAULT error messages are?
> > 
> 
> No idea, unfortunately.
> 
> > I'll go back to 5.13.y now and see if I can reproduce it there or not,
> > as my backups are not yet done...
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > 
> > [Aug 4 09:48] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff00000 flags=0x0000]
> > [  +0.000012] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff00f80 flags=0x0000]
> > [  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff01000 flags=0x0000]
> > [  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff01f80 flags=0x0000]
> > [  +0.000005] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff02000 flags=0x0000]
> > [  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff02f80 flags=0x0000]
> > [  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff03000 flags=0x0000]
> > [  +0.000005] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff03f80 flags=0x0000]
> > [  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff04000 flags=0x0000]
> > [Aug 4 09:49] sd 3:0:0:0: [sdc] tag#21 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN 
> > [  +0.000011] sd 3:0:0:0: [sdc] tag#21 CDB: Read(16) 88 00 00 00 00 01 8a 44 08 b0 00 00 00 08 00 00
> > [  +5.106493] xhci_hcd 0000:47:00.1: xHCI host not responding to stop endpoint command.
> > [  +0.000010] xhci_hcd 0000:47:00.1: USBSTS: HCHalted HSE
> 
> 
> HSE "Host System Error" bit is set, meaning xHC hardware detected a serious error and stopped the host.
> HSE was probably set 5-10 seconds earlier, but only discovered here.
> 
> Specs state:
> 
> xHC sets this bit to ‘1’ when a serious error
> is detected, either internal to the xHC or during a host system access involving the xHC module.
> (In a PCI system, conditions that set this bit to ‘1’ include PCI Parity error, PCI Master Abort, and
> PCI Target Abort.)

Ok, I would believe in a PCI error here, hammering a xhci controller
with read/write streams to two different storage devices on the same bus
for a few hours as fast as the bus allows is a good stress test.

I tried splitting this across PCI devices, and can not seem to duplicate
the failure in the xhci controllers, now the devices fail with disk
errors after about a terrabyte of traffic, but are recoverable after
unplug/plugging them back in and running fsck.

Cheap USB storage, gotta love it...

If I come up with a reproducable failure, I'll let you know, thanks for
the help,

greg k-h
