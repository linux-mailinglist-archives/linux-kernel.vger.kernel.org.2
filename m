Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20B6334755
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhCJTCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:02:09 -0500
Received: from smtp109.iad3a.emailsrvr.com ([173.203.187.109]:42164 "EHLO
        smtp109.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233342AbhCJTBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:01:46 -0500
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 14:01:46 EST
X-Auth-ID: markh@compro.net
Received: by smtp22.relay.iad3a.emailsrvr.com (Authenticated sender: markh-AT-compro.net) with ESMTPSA id 3E956684A;
        Wed, 10 Mar 2021 13:55:36 -0500 (EST)
From:   Mark Hounschell <markh@compro.net>
Subject: Logitech G602 wireless mouse kernel error messages in 5.10.11+
 kernels
Reply-To: markh@compro.net
To:     lains@archlinux.org, Jiri Kosina <jkosina@suse.cz>,
        sashal@kernel.org, Linux-kernel <linux-kernel@vger.kernel.org>
Organization: Compro Computer Svcs.
Message-ID: <ac5dde9c-194f-ce40-5c13-2a6890fad6a9@compro.net>
Date:   Wed, 10 Mar 2021 13:55:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Classification-ID: de7ac740-cf62-4499-830a-fafd7529c1b9-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using a Logitech wireless G602 mouse since forever. As of 
kernel 5.10.11 I get the following kernel messages;


$dmesg | grep -i logitech
[    7.102140] usb 3-3.4: Manufacturer: Logitech
[   10.036763] input: Logitech USB Receiver as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.0/0003:046D:C537.0001/input/input10
[   10.037904] hid-generic 0003:046D:C537.0001: input,hidraw0: USB HID 
v1.11 Mouse [Logitech USB Receiver] on usb-0000:16:00.3-3.4/input0
[   10.039542] input: Logitech USB Receiver Keyboard as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.1/0003:046D:C537.0002/input/input11
[   10.092374] input: Logitech USB Receiver Consumer Control as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.1/0003:046D:C537.0002/input/input12
[   10.093726] input: Logitech USB Receiver System Control as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.1/0003:046D:C537.0002/input/input13
[   10.094924] input: Logitech USB Receiver as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.1/0003:046D:C537.0002/input/input16
[   10.096155] hid-generic 0003:046D:C537.0002: input,hiddev96,hidraw1: 
USB HID v1.11 Keyboard [Logitech USB Receiver] on 
usb-0000:16:00.3-3.4/input1
[   10.121557] logitech-djreceiver 0003:046D:C537.0001: hidraw0: USB HID 
v1.11 Mouse [Logitech USB Receiver] on usb-0000:16:00.3-3.4/input0
[   10.264445] logitech-djreceiver 0003:046D:C537.0002: 
hiddev96,hidraw1: USB HID v1.11 Keyboard [Logitech USB Receiver] on 
usb-0000:16:00.3-3.4/input1
[   10.320315] logitech-djreceiver 0003:046D:C537.0002: device of type 
eQUAD step 4 Gaming (0x07) connected on slot 1
[   10.321505] input: Logitech Wireless Mouse PID:402c Mouse as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.1/0003:046D:C537.0002/0003:046D:402C.0003/input/input17
[   10.322637] hid-generic 0003:046D:402C.0003: input,hidraw2: USB HID 
v1.11 Mouse [Logitech Wireless Mouse PID:402c] on 
usb-0000:16:00.3-3.4/input1:1
[   10.360344] input: Logitech G602 as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.1/0003:046D:C537.0002/0003:046D:402C.0003/input/input21
[   10.361537] logitech-hidpp-device 0003:046D:402C.0003: input,hidraw2: 
USB HID v1.11 Mouse [Logitech G602] on usb-0000:16:00.3-3.4/input1:1
[   23.271323] logitech-hidpp-device 0003:046D:402C.0003: HID++ 2.0 
device connected.
[   36.471326] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   36.565317] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   42.390321] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   42.478325] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   42.771318] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   42.859318] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   42.955318] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   43.049318] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   43.105317] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   43.200317] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   43.280318] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   43.375321] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   43.455318] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   43.558317] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   43.638318] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   43.741319] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   43.812319] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   43.916318] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   44.003318] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
[   44.106318] logitech-djreceiver 0003:046D:C537.0002: Unexpected input 
report number 128
.
.
.
Every mouse event seems to produce another "Unexpected input report 
number 128" kernel message.

The commit that started this is:

commit 1e6fc9768ed2c3917e1fd7af26cb194dfe14f7da
Author: Filipe LaÃ­ns <lains@archlinux.org>
Date:   Mon Jan 4 20:47:17 2021 +0000

     HID: logitech-dj: add the G602 receiver

     [ Upstream commit e400071a805d6229223a98899e9da8c6233704a1 ]

     Tested. The device gets correctly exported to userspace and I can see
     mouse and keyboard events.

     Signed-off-by: Filipe LaÃ­ns <lains@archlinux.org>
     Signed-off-by: Jiri Kosina <jkosina@suse.cz>
     Signed-off-by: Sasha Levin <sashal@kernel.org>

The actual patch:

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 1ffcfc9a1e033..45e7e0bdd382b 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1869,6 +1869,10 @@ static const struct hid_device_id 
logi_dj_receivers[] = {
           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
                 0xc531),
          .driver_data = recvr_type_gaming_hidpp},
+       { /* Logitech G602 receiver (0xc537) */
+         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+               0xc537),
+        .driver_data = recvr_type_gaming_hidpp},
         { /* Logitech lightspeed receiver (0xc539) */
           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
                 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1),



markh@harley:~> lsusb
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 003: ID 046d:c537 Logitech, Inc.
Bus 003 Device 002: ID 0424:2504 Standard Microsystems Corp. USB 2.0 Hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub



With the patch reverted:

$dmesg | grep -i logitech
[    6.748821] usb 3-3.4: Manufacturer: Logitech
[    9.738428] input: Logitech USB Receiver as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.0/0003:046D:C537.0001/input/input10
[    9.738605] hid-generic 0003:046D:C537.0001: input,hidraw0: USB HID 
v1.11 Mouse [Logitech USB Receiver] on usb-0000:16:00.3-3.4/input0
[    9.740277] input: Logitech USB Receiver Keyboard as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.1/0003:046D:C537.0002/input/input11
[    9.794321] input: Logitech USB Receiver Consumer Control as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.1/0003:046D:C537.0002/input/input12
[    9.795535] input: Logitech USB Receiver System Control as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.1/0003:046D:C537.0002/input/input13
[    9.795565] input: Logitech USB Receiver as 
/devices/pci0000:00/0000:00:08.1/0000:16:00.3/usb3/3-3/3-3.4/3-3.4:1.1/0003:046D:C537.0002/input/input16
[    9.795624] hid-generic 0003:046D:C537.0002: input,hiddev96,hidraw1: 
USB HID v1.11 Keyboard [Logitech USB Receiver] on 
usb-0000:16:00.3-3.4/input1

$lsusb
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 003: ID 046d:c537 Logitech, Inc.
Bus 003 Device 002: ID 0424:2504 Standard Microsystems Corp. USB 2.0 Hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

With or without the patch and error messages the mouse has always worked.

Regards
Mark
