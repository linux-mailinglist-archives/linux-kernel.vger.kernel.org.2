Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B786328E17
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 20:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbhCATX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 14:23:59 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:39879 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhCAQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:52:03 -0500
Received: from FRIBB15 ([84.62.17.44]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MoNy4-1laiM12j0K-00opkm; Mon, 01
 Mar 2021 17:49:17 +0100
From:   "Johannes Freyberger" <Johannes@Freyberger.de>
To:     <ruslan.bilovol@gmail.com>
Cc:     <balbi@kernel.org>, <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
        <gschmottlach@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 0/8] USB Audio Gadget part 2: Feedback endpoint, Volume/Mute support
Date:   Mon, 1 Mar 2021 17:49:16 +0100
Message-ID: <002f01d70eba$d1b365a0$751a30e0$@Freyberger.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdcOt3r//gS6ofvdQq+9nU3AjE/rOg==
Content-Language: de
X-Provags-ID: V03:K1:v9xVgU/EbrblPbGe0hie//MyhZyjEtNfVSVOsu5t1vpScHoOmB4
 Od1ftIOiJU9qxp0Xd2E3Fi0feJutvjDptVa0xBFwpq3o+f20ieJMsCkoRqwzTlTVyfXEjwe
 lF35/7InNg1oHw16mYNaJkJxWK0n9Ka9aAFEMvZSZlcE3KYrPkGJqURrra/1FyqFkLOFuzI
 uSscD0mIfe5R9jSn0sNtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l/iXmPrCb4s=:LxGvaYbuu6M82e3I6Efcik
 vYuS4OCCtestn62OGjbDNie9k0f5eb1Ed0cJ9BVHRzzqPvbnePQPwc9AIAky3gKfQ10JlnHP+
 z0s8Sh4x88IZgE/hyFaTrI10psHTDH2atc6tyzSQ0dHvUGmkRxqGGLWXk9YRxXVc7Lj4EuqFR
 xgEn64Ad3+bphHZtLvxGCELpqteEMZctqIDx7OF9+OCxJ499SCczNn5GMGkdNg0/9C4/5J6Hx
 LBdRc6eAuUpYWPS5Ar9sNAEWOowEACiIZLBpB7LBI/BtJ3YergV/+9zPygsadMjX6AWe0xGEm
 +XaWvvKLRvSercbLoAjpLA1CYOAl40pCqv3RgmJ/eXEqFrIS8ldoAx8FCvU1IUFHqh7ybockG
 M9YOZdiGbxH+A030BWqfPqzrdbaZPUDWv1mFY89KC9gRHXGiAjzM4Se6eHQt9iH5H+kXy8nzF
 F35sS2Aayw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ruslan,

thanks for all your efforts to make the USB Audio Gadget work in Win10 using
UAC2. Meanwhile I managed to apply and compile your previous modifications
and now my Raspberry PI shows up in the Windows Device Manager as a valid
UAC2 audio device. Unfortunately it still doesn't work to transfer any audio
as it seems the audio endpoints or the topology is not working. I checked it
with some tools and found one providing some information on the USB part
(it's called UVCview.exe and is part of the Windows Driver Kit). Here's the
output which I hope can give some hints on the problems still existing in
this driver:

          ---===>Device Information<===---
English product name: "Linux USB Audio Gadget"

ConnectionStatus:                  
Current Config Value:              0x01  -> Device Bus Speed: High
Device Address:                    0x0F
Open Pipes:                           0
*!*ERROR:  No open pipes!

          ===>Device Descriptor<===
bLength:                           0x12
bDescriptorType:                   0x01
bcdUSB:                          0x0200
bDeviceClass:                      0xEF  -> This is a Multi-interface
Function Code Device
bDeviceSubClass:                   0x02  -> This is the Common Class Sub
Class
bDeviceProtocol:                   0x01  -> This is the Interface
Association Descriptor protocol
bMaxPacketSize0:                   0x40 = (64) Bytes
idVendor:                        0x1D6B = The Linux Foundation
idProduct:                       0x0101
bcdDevice:                       0x0510
iManufacturer:                     0x01
     English (United States)  "Linux 5.10.17-v7l-R3LAY_TEST+ with
fe980000.usb"
iProduct:                          0x02
     English (United States)  "Linux USB Audio Gadget"
iSerialNumber:                     0x00
bNumConfigurations:                0x01

          ===>Configuration Descriptor<===
bLength:                           0x09
bDescriptorType:                   0x02
wTotalLength:                    0x00E2  -> Validated
bNumInterfaces:                    0x03
bConfigurationValue:               0x01
iConfiguration:                    0x00
bmAttributes:                      0xC0  -> Bus Powered
MaxPower:                          0x01 =   2 mA

          ===>IAD Descriptor<===
bLength:                           0x08
bDescriptorType:                   0x0B
bFirstInterface:                   0x00
bInterfaceCount:                   0x03
bFunctionClass:                    0x01  -> Audio Interface Class
bFunctionSubClass:                 0x00
*!*CAUTION:    This appears to be an invalid bFunctionSubClass
bFunctionProtocol:                 0x20
iFunction:                         0x04
     English (United States)  "R3lay PI"

          ===>Interface Descriptor<===
bLength:                           0x09
bDescriptorType:                   0x04
bInterfaceNumber:                  0x00
bAlternateSetting:                 0x00
bNumEndpoints:                     0x00
bInterfaceClass:                   0x01  -> Audio Interface Class
bInterfaceSubClass:                0x01  -> Audio Control Interface SubClass
bInterfaceProtocol:                0x20
CAUTION:  This may be an invalid bInterfaceProtocol
iInterface:                        0x05
     English (United States)  "Topology Control"

          ===>Audio Control Interface Header Descriptor<===
bLength:                           0x09
bDescriptorType:                   0x24
bDescriptorSubtype:                0x01
bcdADC:                          0x0200
wTotalLength:                    0x5308
bInCollection:                     0x00

          ===>Descriptor Hex Dump<===
bLength:                           0x08
bDescriptorType:                   0x24
08 24 0A 06 01 01 00 06 

          ===>Descriptor Hex Dump<===
bLength:                           0x08
bDescriptorType:                   0x24
08 24 0A 05 01 01 00 07 

          ===>Descriptor Hex Dump<===
bLength:                           0x11
bDescriptorType:                   0x24
11 24 02 01 01 01 00 05 02 03 00 00 00 00 03 00 
08 

          ===>Descriptor Hex Dump<===
bLength:                           0x11
bDescriptorType:                   0x24
11 24 02 02 00 02 00 06 02 03 00 00 00 00 03 00 
09 

          ===>Descriptor Hex Dump<===
bLength:                           0x0C
bDescriptorType:                   0x24
0C 24 03 04 01 01 00 02 06 03 00 0A 

          ===>Descriptor Hex Dump<===
bLength:                           0x0C
bDescriptorType:                   0x24
0C 24 03 03 00 03 00 01 05 03 00 0B 

          ===>Interface Descriptor<===
bLength:                           0x09
bDescriptorType:                   0x04
bInterfaceNumber:                  0x01
bAlternateSetting:                 0x00
bNumEndpoints:                     0x00
bInterfaceClass:                   0x01  -> Audio Interface Class
bInterfaceSubClass:                0x02  -> Audio Streaming Interface
SubClass
bInterfaceProtocol:                0x20
CAUTION:  This may be an invalid bInterfaceProtocol
iInterface:                        0x0C
     English (United States)  "Playback Inactive"

          ===>Interface Descriptor<===
bLength:                           0x09
bDescriptorType:                   0x04
bInterfaceNumber:                  0x01
bAlternateSetting:                 0x01
bNumEndpoints:                     0x02
bInterfaceClass:                   0x01  -> Audio Interface Class
bInterfaceSubClass:                0x02  -> Audio Streaming Interface
SubClass
bInterfaceProtocol:                0x20
CAUTION:  This may be an invalid bInterfaceProtocol
iInterface:                        0x0D
     English (United States)  "Playback Active"

          ===>Descriptor Hex Dump<===
bLength:                           0x10
bDescriptorType:                   0x24
10 24 01 01 00 01 01 00 00 00 02 03 00 00 00 00 

          ===>Audio Streaming Format Type Descriptor<===
bLength:                           0x06
bDescriptorType:                   0x24
bDescriptorSubtype:                0x02
bFormatType:                       0x01
bNrChannels:                       0x02
bSubframeSize:                     0x10
bBitResolution:                    0x07
bSamFreqType:                      0x05
tSamFreq[1]:                   0x380501 (3671297 Hz)
tSamFreq[2]:                   0x080401 (525313 Hz)
tSamFreq[3]:                   0x000125 (293 Hz)
tSamFreq[4]:                   0x000000 (0 Hz)
tSamFreq[5]:                   0x050700 (329472 Hz)

          ===>Endpoint Descriptor<===
bLength:                           0x07
bDescriptorType:                   0x05
bEndpointAddress:                  0x01  -> Direction: OUT - EndpointID: 1
bmAttributes:                      0x05  -> Isochronous Transfer Type
                   Synchronization Type = Asynchronous
Bulk Transfer Type
wMaxPacketSize:                  0x0138 = 1 transactions per microframe,
0x138 max bytes
bInterval:                         0x04

          ===>Descriptor Hex Dump<===
bLength:                           0x08
bDescriptorType:                   0x25
08 25 01 00 00 00 00 00 

          ===>Endpoint Descriptor<===
bLength:                           0x07
bDescriptorType:                   0x05
bEndpointAddress:                  0x81  -> Direction: IN - EndpointID: 1
bmAttributes:                      0x11  -> Isochronous Transfer Type
                   Synchronization Type = No Synchronization
Bulk Transfer Type
wMaxPacketSize:                  0x0004 = 1 transactions per microframe,
0x04 max bytes
bInterval:                         0x04

          ===>Interface Descriptor<===
bLength:                           0x09
bDescriptorType:                   0x04
bInterfaceNumber:                  0x02
bAlternateSetting:                 0x00
bNumEndpoints:                     0x00
bInterfaceClass:                   0x01  -> Audio Interface Class
bInterfaceSubClass:                0x02  -> Audio Streaming Interface
SubClass
bInterfaceProtocol:                0x20
CAUTION:  This may be an invalid bInterfaceProtocol
iInterface:                        0x0E
     English (United States)  "Capture Inactive"

          ===>Interface Descriptor<===
bLength:                           0x09
bDescriptorType:                   0x04
bInterfaceNumber:                  0x02
bAlternateSetting:                 0x01
bNumEndpoints:                     0x01
bInterfaceClass:                   0x01  -> Audio Interface Class
bInterfaceSubClass:                0x02  -> Audio Streaming Interface
SubClass
bInterfaceProtocol:                0x20
CAUTION:  This may be an invalid bInterfaceProtocol
iInterface:                        0x0F
     English (United States)  "Capture Active"

          ===>Descriptor Hex Dump<===
bLength:                           0x10
bDescriptorType:                   0x24
10 24 01 04 00 01 01 00 00 00 02 03 00 00 00 00 

          ===>Audio Streaming Format Type Descriptor<===
bLength:                           0x06
bDescriptorType:                   0x24
bDescriptorSubtype:                0x02
bFormatType:                       0x01
bNrChannels:                       0x02
bSubframeSize:                     0x10
bBitResolution:                    0x07
bSamFreqType:                      0x05
tSamFreq[1]:                   0xC40582 (12846466 Hz)
tSamFreq[2]:                   0x080400 (525312 Hz)
tSamFreq[3]:                   0x000125 (293 Hz)
tSamFreq[4]:                   0x000000 (0 Hz)
tSamFreq[5]:                   0x000000 (0 Hz)

          ===>Endpoint Descriptor<===
bLength:                           0x07
bDescriptorType:                   0x05
bEndpointAddress:                  0x82  -> Direction: IN - EndpointID: 2
bmAttributes:                      0x05  -> Isochronous Transfer Type
                   Synchronization Type = Asynchronous
Bulk Transfer Type
wMaxPacketSize:                  0x00C4 = 1 transactions per microframe,
0xC4 max bytes
bInterval:                         0x04

          ===>Descriptor Hex Dump<===
bLength:                           0x08
bDescriptorType:                   0x25
08 25 01 00 00 00 00 00

