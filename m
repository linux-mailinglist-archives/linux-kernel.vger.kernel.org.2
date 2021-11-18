Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5808E455211
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbhKRBTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 20:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbhKRBTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:19:15 -0500
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A383C061570;
        Wed, 17 Nov 2021 17:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3hXJGY24NI7G4XU0T1oCc+5EesCfCIfsM2ayVoqTu+E=; b=Ald4o4x2LjlweAwuFNXKr0IijF
        t4NYHA/6KzSyPf8SBZ5VziHZRcDy+raJ0y2GsGEGpjemMSDCvnnpiEaB4lVXbcvmSbuFZzp6SfAl1
        DD+5fvr5c3rOXXPbCf6BzJAziOEJ3G7nQReusAGEhU7siDZPESOfawMFpX6r7uX1OsJf5rR1+h3Gs
        L1A52+qNvbpq6PYph5GJCN336al7HJUGuZGUz7K6erWGMW5b7LvA2s37cDHoENUSur0nY2zRxToNw
        Dw/FSuC3sBTeYNlrow1+Ewee29pewoTN35DPNVmVQw/4C3m8q4mjfXu1Oi9wbuKFAZpiPiOXS0WJr
        kH2glRVg==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1mnW29-0004kc-1o; Thu, 18 Nov 2021 01:16:13 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id CBEBD1A5AE695; Thu, 18 Nov 2021 10:16:09 +0900 (JST)
Date:   Thu, 18 Nov 2021 10:16:09 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [5.12 - 5.15] xHCI controller dead - not renesas but intel
Message-ID: <YZWpWZsQ7uu4NvdW@bulldog.preining.info>
References: <YY3RIdKBbIL3Dw/q@bulldog.preining.info>
 <8f752efb-e38e-b012-de98-e4b938dde7b7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f752efb-e38e-b012-de98-e4b938dde7b7@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias, hi all,

(please cc, thanks)

> Patch in link below resolved another case with similar log. 
> Does it help in your case?

Unfortunately not, happened again after redirecting a web cam to a
virtual machine, then removing the redirection and shutting down the VM.
After that, boom.
Nov 18 09:49:37 bulldog systemd-machined[1806]: Machine qemu-3-FujitsuWin10 terminated.
Nov 18 09:49:43 bulldog kernel: xhci_hcd 0000:00:14.0: Abort failed to stop command ring: -110
Nov 18 09:49:43 bulldog kernel: xhci_hcd 0000:00:14.0: xHCI host controller not responding, assume dead
Nov 18 09:49:43 bulldog kernel: xhci_hcd 0000:00:14.0: HC died; cleaning up
Nov 18 09:49:43 bulldog kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
Nov 18 09:49:43 bulldog kernel: xhci_hcd 0000:00:14.0: xHCI host not responding to stop endpoint command.
Nov 18 09:49:43 bulldog kernel: xhci_hcd 0000:00:14.0: USBSTS: HCHalted EINT

After that, I logged into the machine via ssh, and send unbind / bind
requests:
        echo -n "0000:14:00.0" > /sys/bus/pci/drivers/xhci_hcd/unbind
gave
Nov 18 09:54:48 bulldog kernel: xhci_hcd 0000:00:14.0: remove, state 4
Nov 18 09:54:48 bulldog kernel: usb usb2: USB disconnect, device number 1
Nov 18 09:54:48 bulldog kernel: xhci_hcd 0000:00:14.0: USB bus 2 deregistered
Nov 18 09:54:48 bulldog kernel: xhci_hcd 0000:00:14.0: remove, state 1
Nov 18 09:54:48 bulldog kernel: usb usb1: USB disconnect, device number 1
Nov 18 09:54:48 bulldog kernel: xhci_hcd 0000:00:14.0: USB bus 1 deregistered

and then
        echo -n "0000:14:00.0" > /sys/bus/pci/drivers/xhci_hcd/bind
gave
Nov 18 09:55:00 bulldog kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
Nov 18 09:55:00 bulldog kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
Nov 18 09:55:00 bulldog kernel: xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
...

then it adds a few devices without any problem, until it comes to here:
Nov 18 09:55:01 bulldog kernel: usb 1-11: new high-speed USB device number 4 using xhci_hcd
Nov 18 09:55:01 bulldog kernel: usb 1-11: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 6.33
Nov 18 09:55:01 bulldog kernel: usb 1-11: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 18 09:55:01 bulldog kernel: usb 1-11: Product: USB2.0 Hub
Nov 18 09:55:01 bulldog kernel: usb 1-11: Manufacturer: VIA Labs, Inc.
Nov 18 09:55:01 bulldog kernel: hub 1-11:1.0: USB hub found
Nov 18 09:55:01 bulldog kernel: hub 1-11:1.0: 4 ports detected

I think this is my monitor (Fujitsu) with integrated USB hub.
There mouse and kbd are connected, but while doing some stuff it departs
again into dead land:
Nov 18 09:55:01 bulldog kernel: usb 1-12: new high-speed USB device number 5 using xhci_hcd
Nov 18 09:55:07 bulldog kernel: usb 1-12: device descriptor read/64, error -110
Nov 18 09:55:22 bulldog kernel: usb 1-12: device descriptor read/64, error -110
Nov 18 09:55:22 bulldog kernel: usb 1-11.1: new high-speed USB device number 6 using xhci_hcd
Nov 18 09:55:23 bulldog kernel: usb 1-11.1: New USB device found, idVendor=2109, idProduct=2817, bcdDevice= 6.23
Nov 18 09:55:23 bulldog kernel: usb 1-11.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 18 09:55:23 bulldog kernel: usb 1-11.1: Product: USB2.0 Hub
Nov 18 09:55:23 bulldog kernel: usb 1-11.1: Manufacturer: VIA Labs, Inc.
Nov 18 09:55:23 bulldog kernel: hub 1-11.1:1.0: USB hub found
Nov 18 09:55:23 bulldog kernel: hub 1-11.1:1.0: 4 ports detected
Nov 18 09:55:23 bulldog kernel: usb 1-12: new high-speed USB device number 7 using xhci_hcd
Nov 18 09:55:28 bulldog kernel: usb 1-12: device descriptor read/64, error -110
Nov 18 09:55:44 bulldog kernel: usb 1-12: device descriptor read/64, error -110
Nov 18 09:55:44 bulldog kernel: usb usb1-port12: attempt power cycle
Nov 18 09:55:44 bulldog kernel: usb 1-11.2: new full-speed USB device number 8 using xhci_hcd
Nov 18 09:55:44 bulldog kernel: usb 1-11.2: device descriptor read/64, error -32
Nov 18 09:55:44 bulldog kernel: usb 1-11.2: New USB device found, idVendor=062a, idProduct=4102, bcdDevice= 1.03
Nov 18 09:55:44 bulldog kernel: usb 1-11.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Nov 18 09:55:44 bulldog kernel: usb 1-11.2: Product: 2.4G Wireless Mouse
Nov 18 09:55:44 bulldog kernel: usb 1-11.2: Manufacturer: MOSART Semi.
Nov 18 09:55:44 bulldog kernel: input: MOSART Semi. 2.4G Wireless Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11.2/1-11.2:1.0/>
Nov 18 09:55:44 bulldog kernel: input: MOSART Semi. 2.4G Wireless Mouse Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-11/1>
Nov 18 09:55:44 bulldog kernel: input: MOSART Semi. 2.4G Wireless Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11.2/1-11.2:1.0/>
Nov 18 09:55:44 bulldog kernel: hid-generic 0003:062A:4102.000A: input,hiddev1,hidraw2: USB HID v1.10 Mouse [MOSART Semi. 2.4G Wireless >
Nov 18 09:55:44 bulldog kernel: usb 1-11.1.2: new high-speed USB device number 9 using xhci_hcd
Nov 18 09:55:45 bulldog kernel: usb 1-11.1.2: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=31.01
Nov 18 09:55:45 bulldog kernel: usb 1-11.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=6
Nov 18 09:55:45 bulldog kernel: usb 1-11.1.2: Product: USB 10/100/1000 LAN
Nov 18 09:55:45 bulldog kernel: usb 1-11.1.2: Manufacturer: Realtek
Nov 18 09:55:45 bulldog kernel: usb 1-11.1.2: SerialNumber: 101000001
Nov 18 09:55:45 bulldog kernel: usb 1-12: new high-speed USB device number 10 using xhci_hcd
Nov 18 09:55:55 bulldog kernel: xhci_hcd 0000:00:14.0: Abort failed to stop command ring: -110
Nov 18 09:55:55 bulldog kernel: xhci_hcd 0000:00:14.0: xHCI host controller not responding, assume dead
Nov 18 09:55:55 bulldog kernel: xhci_hcd 0000:00:14.0: HC died; cleaning up
Nov 18 09:55:55 bulldog kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
Nov 18 09:55:56 bulldog kernel: usb 1-12: device not accepting address 10, error -108
Nov 18 09:55:56 bulldog kernel: usb usb1-port12: couldn't allocate usb_device
Nov 18 09:55:56 bulldog kernel: usb 1-3: USB disconnect, device number 2
Nov 18 09:55:56 bulldog kernel: usb 1-11-port4: couldn't allocate usb_device
Nov 18 09:55:56 bulldog kernel: usb 1-11.1-port3: couldn't allocate usb_device
Nov 18 09:55:56 bulldog kernel: usb 1-7: USB disconnect, device number 3
Nov 18 09:55:56 bulldog kernel: usb 1-11: USB disconnect, device number 4
Nov 18 09:55:56 bulldog kernel: usb 1-11.1: USB disconnect, device number 6
Nov 18 09:55:56 bulldog kernel: usb 1-11.1.2: USB disconnect, device number 9
Nov 18 09:55:56 bulldog kernel: usb 1-11.2: USB disconnect, device number 8


More information: when shutting down the system, it failed to turn of
the computer (systemctl halt), but screen went off, all services
stopped, and at the end the machine was just brrmmming away with me not
having an idea what it is doing.

Hard reset.

First reboot gave no useable mouse/kbd.

Shutdown/wait/boot - all back to normal.

Any suggestion? I compile all my kernels (currently 5.15.2), so any
patch can be tested.

(Please cc, thanks)

Thanks a lot

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research  +  IFMGA Guide  +  TU Wien  +  TeX Live  + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
