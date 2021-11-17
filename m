Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968EB454A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbhKQPnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:43:42 -0500
Received: from netrider.rowland.org ([192.131.102.5]:35523 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S238487AbhKQPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:43:37 -0500
Received: (qmail 173452 invoked by uid 1000); 17 Nov 2021 10:40:36 -0500
Date:   Wed, 17 Nov 2021 10:40:36 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: Mouse stops working at random intervals in latest kernel
Message-ID: <20211117154036.GC172151@rowland.harvard.edu>
References: <CAHP4M8UvwsS6QpV6PX-qf=d2u9Qw35Hafv-BTMGUWeSc0nUBXA@mail.gmail.com>
 <CAHP4M8V4ow_JUj9gjcrZoyFtnTcqngHqiD2da-v-w4VZ2WL1hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8V4ow_JUj9gjcrZoyFtnTcqngHqiD2da-v-w4VZ2WL1hg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 08:52:47AM +0530, Ajay Garg wrote:
> Looping in linux-usb list members.
> Pasting the original content again, to avoid top-posting visual headaches :)
> 
> 
> Hello everyone,
> 
> I have been seeing following errors at random times.
> When this happens, the (wireless-)mouse stops working. The USB-dongle
> has to be removed, and re-inserted again to get the mouse working
> again.
> 
> This has not happened before, only observing it since last 2-3 days.
> Kernel is mainline at 8ab774587903771821b59471cc723bba6d893942.
> 
> Anyone seeing similar issue?
> 
> 
> ###########################
> Nov 16 18:15:19 host-x86-64 kernel: [ 5005.107017] usb 2-1.2: reset
> full-speed USB device number 11 using ehci-pci
> Nov 16 18:15:19 host-x86-64 kernel: [ 5005.186745] usb 2-1.2: device
> descriptor read/64, error -32
> Nov 16 18:15:20 host-x86-64 kernel: [ 5005.374638] usb 2-1.2: device
> descriptor read/64, error -32
> Nov 16 18:15:20 host-x86-64 kernel: [ 5005.562650] usb 2-1.2: reset
> full-speed USB device number 11 using ehci-pci
> Nov 16 18:15:20 host-x86-64 kernel: [ 5005.642638] usb 2-1.2: device
> descriptor read/64, error -32
> Nov 16 18:15:20 host-x86-64 kernel: [ 5005.830670] usb 2-1.2: device
> descriptor read/64, error -32
> Nov 16 18:15:20 host-x86-64 kernel: [ 5006.018544] usb 2-1.2: reset
> full-speed USB device number 11 using ehci-pci
> Nov 16 18:15:21 host-x86-64 kernel: [ 5006.434527] usb 2-1.2: device
> not accepting address 11, error -32
> Nov 16 18:15:21 host-x86-64 kernel: [ 5006.514531] usb 2-1.2: reset
> full-speed USB device number 11 using ehci-pci
> Nov 16 18:15:21 host-x86-64 kernel: [ 5006.930613] usb 2-1.2: device
> not accepting address 11, error -32
> Nov 16 18:15:21 host-x86-64 kernel: [ 5006.931546] usb 2-1.2: USB
> disconnect, device number 11
> Nov 16 18:15:21 host-x86-64 upowerd[1241]: treating change event as
> add on /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
> Nov 16 18:15:21 host-x86-64 kernel: [ 5007.102858] usb 2-1.2: new
> full-speed USB device number 12 using ehci-pci
> Nov 16 18:15:21 host-x86-64 libvirtd[855]: internal error: Missing
> udev property 'ID_VENDOR_ID' on '2-1.2'
> Nov 16 18:15:21 host-x86-64 kernel: [ 5007.182555] usb 2-1.2: device
> descriptor read/64, error -32
> Nov 16 18:15:22 host-x86-64 kernel: [ 5007.370518] usb 2-1.2: device
> descriptor read/64, error -32
> Nov 16 18:15:22 host-x86-64 kernel: [ 5007.558677] usb 2-1.2: new
> full-speed USB device number 13 using ehci-pci
> Nov 16 18:15:22 host-x86-64 kernel: [ 5007.638657] usb 2-1.2: device
> descriptor read/64, error -32
> Nov 16 18:15:22 host-x86-64 kernel: [ 5007.826664] usb 2-1.2: device
> descriptor read/64, error -32
> Nov 16 18:15:22 host-x86-64 kernel: [ 5007.935063] usb 2-1-port2:
> attempt power cycle
> Nov 16 18:15:23 host-x86-64 kernel: [ 5008.538604] usb 2-1.2: new
> full-speed USB device number 14 using ehci-pci
> Nov 16 18:15:23 host-x86-64 kernel: [ 5008.956553] usb 2-1.2: device
> not accepting address 14, error -32
> Nov 16 18:15:23 host-x86-64 kernel: [ 5009.034629] usb 2-1.2: new
> full-speed USB device number 15 using ehci-pci
> Nov 16 18:15:24 host-x86-64 kernel: [ 5009.450570] usb 2-1.2: device
> not accepting address 15, error -32
> Nov 16 18:15:24 host-x86-64 kernel: [ 5009.450881] usb 2-1-port2:
> unable to enumerate USB device
> #######################################

Going just by your description and the log contents, it sounds like the 
wireless dongle's firmware is crashing.  Or possibly something has gone 
wrong with the motherboard's on-board "rate-matching" hub.

To rule out software issues, you could try running an earlier kernel 
version.  If that doesn't show any problems then you may want to perform 
a git bisection.

As far as I know there have been no recent changes to ehci-hcd or 
ehci-pci that could cause this to happen.

Alan Stern
