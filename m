Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5460E32EFAC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEQH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:07:57 -0500
Received: from netrider.rowland.org ([192.131.102.5]:43041 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230034AbhCEQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:07:29 -0500
Received: (qmail 41316 invoked by uid 1000); 5 Mar 2021 11:07:28 -0500
Date:   Fri, 5 Mar 2021 11:07:28 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using
 xhci_hcd
Message-ID: <20210305160728.GE38200@rowland.harvard.edu>
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
 <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
 <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
 <20210301155321.GA1490228@rowland.harvard.edu>
 <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 01:09:16PM +0100, Sedat Dilek wrote:
> On Mon, Mar 1, 2021 at 4:53 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> [ ... ]
> > You can use usbmon on bus 4 to record the USB traffic.  It may indicate
> > why the resets occur.
> >
> 
> Hi Alan,
> 
> I followed the instructions in [1].
> 
> root# modprobe -v usbmon
> 
> root# ls /sys/kernel/debug/usb/usbmon
> 0s  0u  1s  1t  1u  2s  2t  2u  3s  3t  3u  4s  4t  4u
> 
> root# cat /sys/kernel/debug/usb/usbmon/4u > /tmp/usbmon-log_4u.txt
> [ Ctrl+C ]
> 
> I recorded 13:03 - 13:04 (one minute).
> 
> So these xhci-resets should be included:
> 
> [Fri Mar  5 13:03:07 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar  5 13:03:07 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar  5 13:03:27 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar  5 13:03:27 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar  5 13:03:27 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar  5 13:03:28 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> [Fri Mar  5 13:03:28 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> number 2 using xhci_hcd
> 
> The usbmon-log is attached.
> 
> Unsure how to interpret the log - the kernel-doc says `raw data`.
> How can I bring this into a human-readable format?
> Can you give me a hand?

Don't worry about trying to decode the output.  To me it looks like the 
drive crashes and needs to be reset at times when the computer sends it 
an ATA command.  (Not all ATA commands, but some.)  You can prevent this 
by setting the following module parameter for the usb-storage driver:

	quirks=174c:55aa:t

where the two numbers are the Vendor and Product IDs for the external 
drive, and the 't' is a quirks flag saying not to use any ATA commands.  
If this module parameter fixes the problem, we can add a permanent quirk 
setting to the kernel.

Alan Stern
