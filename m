Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20FF456176
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhKRRal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:30:41 -0500
Received: from netrider.rowland.org ([192.131.102.5]:35911 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231720AbhKRRak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:30:40 -0500
Received: (qmail 215955 invoked by uid 1000); 18 Nov 2021 12:27:38 -0500
Date:   Thu, 18 Nov 2021 12:27:38 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Subject: Re: USB: invalid maxpacket 8
Message-ID: <20211118172738.GA204683@rowland.harvard.edu>
References: <CAHhAz+i88SYbYTLY4Ti50LBx6cb3yogcjRtQ4rP1HBMei=8uFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+i88SYbYTLY4Ti50LBx6cb3yogcjRtQ4rP1HBMei=8uFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:04:03PM +0530, Muni Sekhar wrote:
> Hi all,
> 
> 
> I'm trying to connect to a USB device on Linux PC and getting an error
> about "invalid maxpacket 8". What does it mean?

It means that the kernel received two endpoint descriptors from the USB 
device containing invalid values.

For devices communicating at High Speed (480 Mb/s) like yours, the 
wMaxPacketSize field in the endpoint descriptor for a Bulk endpoint is 
required to contain the value 512, but your device sent a couple of Bulk 
endpoint descriptors in which wMaxPacketSize was set to 8.  You will see 
the invalid values if you look at the output from "lsusb -v" for the 
device.

>  Does this error causes
> USB packet transfer failures?

This message is only a warning; the kernel will try to communicate with 
the device regardless.  But since that the device is obviously faulty, 
the communication might not work.

> Any ideas how to fix this?

The only way to fix this is to change the device's firmware.

Alan Stern

> Thank you for any pointers.
> 
> 
> dmesg log:
> ---------------
> [1920549.030669] usb 2-2: New USB device found, idVendor=05c6, idProduct=9500
> 
> [1920549.030682] usb 2-2: New USB device strings: Mfr=0, Product=0,
> SerialNumber=0
> 
> [1920549.032623] hub 2-2:1.0: USB hub found
> 
> [1920549.032672] hub 2-2:1.0: 7 ports detected
> 
> [1920549.302875] usb 2-2.1: new high-speed USB device number 98 using xhci_hcd
> 
> [1920549.391765] usb 2-2.1: config 1 interface 0 altsetting 0 bulk
> endpoint 0x81 has invalid maxpacket 8
> 
> [1920549.391777] usb 2-2.1: config 1 interface 0 altsetting 0 bulk
> endpoint 0x2 has invalid maxpacket 8
> 
> 
> 
> 
> -- 
> Thanks,
> Sekhar
