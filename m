Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F7A32A00F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575231AbhCBDy2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Mar 2021 22:54:28 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbhCAWOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:14:12 -0500
Received: from FRIBB15 ([84.62.17.44]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MjSwu-1lfhvj1GA6-00ktqf; Mon, 01
 Mar 2021 23:11:17 +0100
From:   "Johannes Freyberger" <Johannes@Freyberger.de>
To:     "'Ruslan Bilovol'" <ruslan.bilovol@gmail.com>
Cc:     "'Felipe Balbi'" <balbi@kernel.org>,
        "'Jonathan Corbet'" <corbet@lwn.net>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Glenn Schmottlach'" <gschmottlach@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Linux USB'" <linux-usb@vger.kernel.org>
References: <002f01d70eba$d1b365a0$751a30e0$@Freyberger.de> <CAB=otbQLO451REYQg3ZAR+bwAFaX5VFfz9_fVGvY3yGGxEWsaA@mail.gmail.com>
In-Reply-To: <CAB=otbQLO451REYQg3ZAR+bwAFaX5VFfz9_fVGvY3yGGxEWsaA@mail.gmail.com>
Subject: AW: [PATCH 0/8] USB Audio Gadget part 2: Feedback endpoint, Volume/Mute support
Date:   Mon, 1 Mar 2021 23:11:16 +0100
Message-ID: <003801d70ee7$cd1504e0$673f0ea0$@Freyberger.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGFXHO3TXrQzcL2BMtuE/hHhswd6wGYK5GrqwZQaqA=
Content-Language: de
X-Provags-ID: V03:K1:UYkqifTYWpQ/uzm/bkAUa37QQ9Gf63Bhc+fGv3h19S3P6Zhd3A4
 wxZ6P37WTJ2j/xawsZfUp1+IbdQgFH1/o0XC1eXq/ln3OCY2TW67Ae9TiqKU/6xLD90+DKp
 6z7EDou7BLZj+1r/Qhftn1My9JDVx2Bv+diva0hfwvyeQb6xPSBFlcsQVCuM41gRCPgYm0D
 pW3Wt68RQyQT9WlGvy2ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pn564xEqm58=:9+LQZRztMvShkSA72rg6hz
 8gNIruxa044OXjkp02f+1S0myF0nbb0UTuEf6QdMps1zAObhSGfVqIyWvYaP1S9C/+Jk4jYdE
 OwC6HwMHE+/kSvRLrzx5q9/OOx5VAe2osJjS2KOJazuPVsT4zvRQbd/+lZsDRWSgqLuOzni2T
 F8l/ruEad/yfWIHmQqmlkhjKi3TpCIabFYgK8ziXNtut24VVmGgKw0+1N4zqt/Ka9QZKrfQce
 Wb0h0ChJMZvpbVQdRc4/uAgtGbjVZODZWSArtc5VaY9SlAVaAyd17ckhAz0evG4E44L4CVWoK
 TIt93p+t6rKLxGMg/X1QeVOyTaj9l37swDL728sS0W7emUkycBKywBxO3OG/DVzu+HtdKIOA6
 VHZELqom7BLsD9JuY/BE9BLICz6PIWLsFCk53qdToavacNygaIKfg4Ck3Tx+As9rErgQhFOYs
 aFBo6r+85Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ruslan,

thanks a lot for your quick answer.

> -----Ursprüngliche Nachricht-----
> Von: Ruslan Bilovol
> Gesendet: Montag, 1. März 2021 22:34
> An: Johannes Freyberger <Johannes@freyberger.de>
> Cc: Felipe Balbi <balbi@kernel.org>; Jonathan Corbet <corbet@lwn.net>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Glenn Schmottlach
> <gschmottlach@gmail.com>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linux USB <linux-usb@vger.kernel.org>
> Betreff: Re: [PATCH 0/8] USB Audio Gadget part 2: Feedback endpoint,
> Volume/Mute support
> 
> Hi Johannes,
> 
> On Mon, Mar 1, 2021 at 6:49 PM Johannes Freyberger
> <Johannes@freyberger.de> wrote:
> >
> > Hi Ruslan,
> >
> > thanks for all your efforts to make the USB Audio Gadget work in Win10
> > using UAC2. Meanwhile I managed to apply and compile your previous
> > modifications and now my Raspberry PI shows up in the Windows Device
> > Manager as a valid
> > UAC2 audio device. Unfortunately it still doesn't work to transfer any
> > audio as it seems the audio endpoints or the topology is not working.
> 
> Are you testing my previous version of the patches on some older kernel?
> 
> Just for records - these two patch sets (part 1 and part 2) are based on Greg's
> usb-next branch (commit b5a12546e779d4f5586f58e60e0ef5070a833a64
> which is based on v5.11-rc5 tag). I retested them today with a BBB board and
> it works fine under Win 10. Also I rebased these two patchsets today against
> latest Greg's usb-next branch which is now Linus's v5.12-rc1 tag and again it
> works fine under Win10 - both Volume/Mute controls and audio streaming.
> 
> These patches have been tested previously on Raspberry PI 4 running v5.9
> and v5.10 stable kernels. The only issues I've seen were because of
> Raspberry's DWC2 DMA issue in the driver that I described in this cover
> letter.
> However if you disable volume/mute controls, it won't affect you.
> 
> > I checked it
> > with some tools and found one providing some information on the USB
> > part (it's called UVCview.exe and is part of the Windows Driver Kit).
> > Here's the output which I hope can give some hints on the problems
> > still existing in this driver:
> 
> From the output below I see UAC2 descriptors are completely screwed up
> (or UVCview.exe doesn't show them correctly). Windows is very strict to the
> descriptors and doesn't allow devices to start in case of any issues.
> So if it appears as a valid UAC2 device in Device Manager, most likely
> UVCview.exe doesn't decode UAC2 descriptors well.
> 

You are right, they really look screwed up. Meanwhile I found another similar tool which also knows Audio 2.0 and here everything looks fine ( https://www.uwe-sieber.de/usbtreeview.html#download )

> Could you please also apply these patches to the latest kernel (v5.12-rc1) and
> test?

Yes, I'd like to do this and I want to apologize for my newbie questions in advance. But I have to admit I'm rather new to Linux, Kernel compiling etc. and I followed the description on https://www.raspberrypi.org/documentation/linux/kernel/building.md and then applied your patches - partially I had to do some modifications by hand as the sources had changed. The version I downloaded via "git clone --depth=1 https://github.com/raspberrypi/linux" seems to be Linux 5.10.17-v7l. And I cannot see the version you mention at https://github.com/raspberrypi/linux/branches . Where can I get the version v5.12-rc1 for these tests?

> 
> Thanks,
> Ruslan
> 

Thanks to you for helping beginners like me,
best regards,
Johannes

> >
> >           ---===>Device Information<===--- English product name:
> > "Linux USB Audio Gadget"
> >
> > ConnectionStatus:
> > Current Config Value:              0x01  -> Device Bus Speed: High
> > Device Address:                    0x0F
> > Open Pipes:                           0
> > *!*ERROR:  No open pipes!
> >
> >           ===>Device Descriptor<===
> > bLength:                           0x12
> > bDescriptorType:                   0x01
> > bcdUSB:                          0x0200
> > bDeviceClass:                      0xEF  -> This is a Multi-interface
> > Function Code Device
> > bDeviceSubClass:                   0x02  -> This is the Common Class Sub
> > Class
> > bDeviceProtocol:                   0x01  -> This is the Interface
> > Association Descriptor protocol
> > bMaxPacketSize0:                   0x40 = (64) Bytes
> > idVendor:                        0x1D6B = The Linux Foundation
> > idProduct:                       0x0101
> > bcdDevice:                       0x0510
> > iManufacturer:                     0x01
> >      English (United States)  "Linux 5.10.17-v7l-R3LAY_TEST+ with
> > fe980000.usb"
> > iProduct:                          0x02
> >      English (United States)  "Linux USB Audio Gadget"
> > iSerialNumber:                     0x00
> > bNumConfigurations:                0x01
> >
> >           ===>Configuration Descriptor<===
> > bLength:                           0x09
> > bDescriptorType:                   0x02
> > wTotalLength:                    0x00E2  -> Validated
> > bNumInterfaces:                    0x03
> > bConfigurationValue:               0x01
> > iConfiguration:                    0x00
> > bmAttributes:                      0xC0  -> Bus Powered
> > MaxPower:                          0x01 =   2 mA
> >
> >           ===>IAD Descriptor<===
> > bLength:                           0x08
> > bDescriptorType:                   0x0B
> > bFirstInterface:                   0x00
> > bInterfaceCount:                   0x03
> > bFunctionClass:                    0x01  -> Audio Interface Class
> > bFunctionSubClass:                 0x00
> > *!*CAUTION:    This appears to be an invalid bFunctionSubClass
> > bFunctionProtocol:                 0x20
> > iFunction:                         0x04
> >      English (United States)  "R3lay PI"
> >
> >           ===>Interface Descriptor<===
> > bLength:                           0x09
> > bDescriptorType:                   0x04
> > bInterfaceNumber:                  0x00
> > bAlternateSetting:                 0x00
> > bNumEndpoints:                     0x00
> > bInterfaceClass:                   0x01  -> Audio Interface Class
> > bInterfaceSubClass:                0x01  -> Audio Control Interface SubClass
> > bInterfaceProtocol:                0x20
> > CAUTION:  This may be an invalid bInterfaceProtocol
> > iInterface:                        0x05
> >      English (United States)  "Topology Control"
> >
> >           ===>Audio Control Interface Header Descriptor<===
> > bLength:                           0x09
> > bDescriptorType:                   0x24
> > bDescriptorSubtype:                0x01
> > bcdADC:                          0x0200
> > wTotalLength:                    0x5308
> > bInCollection:                     0x00
> >
> >           ===>Descriptor Hex Dump<===
> > bLength:                           0x08
> > bDescriptorType:                   0x24
> > 08 24 0A 06 01 01 00 06
> >
> >           ===>Descriptor Hex Dump<===
> > bLength:                           0x08
> > bDescriptorType:                   0x24
> > 08 24 0A 05 01 01 00 07
> >
> >           ===>Descriptor Hex Dump<===
> > bLength:                           0x11
> > bDescriptorType:                   0x24
> > 11 24 02 01 01 01 00 05 02 03 00 00 00 00 03 00
> > 08
> >
> >           ===>Descriptor Hex Dump<===
> > bLength:                           0x11
> > bDescriptorType:                   0x24
> > 11 24 02 02 00 02 00 06 02 03 00 00 00 00 03 00
> > 09
> >
> >           ===>Descriptor Hex Dump<===
> > bLength:                           0x0C
> > bDescriptorType:                   0x24
> > 0C 24 03 04 01 01 00 02 06 03 00 0A
> >
> >           ===>Descriptor Hex Dump<===
> > bLength:                           0x0C
> > bDescriptorType:                   0x24
> > 0C 24 03 03 00 03 00 01 05 03 00 0B
> >
> >           ===>Interface Descriptor<===
> > bLength:                           0x09
> > bDescriptorType:                   0x04
> > bInterfaceNumber:                  0x01
> > bAlternateSetting:                 0x00
> > bNumEndpoints:                     0x00
> > bInterfaceClass:                   0x01  -> Audio Interface Class
> > bInterfaceSubClass:                0x02  -> Audio Streaming Interface
> > SubClass
> > bInterfaceProtocol:                0x20
> > CAUTION:  This may be an invalid bInterfaceProtocol
> > iInterface:                        0x0C
> >      English (United States)  "Playback Inactive"
> >
> >           ===>Interface Descriptor<===
> > bLength:                           0x09
> > bDescriptorType:                   0x04
> > bInterfaceNumber:                  0x01
> > bAlternateSetting:                 0x01
> > bNumEndpoints:                     0x02
> > bInterfaceClass:                   0x01  -> Audio Interface Class
> > bInterfaceSubClass:                0x02  -> Audio Streaming Interface
> > SubClass
> > bInterfaceProtocol:                0x20
> > CAUTION:  This may be an invalid bInterfaceProtocol
> > iInterface:                        0x0D
> >      English (United States)  "Playback Active"
> >
> >           ===>Descriptor Hex Dump<===
> > bLength:                           0x10
> > bDescriptorType:                   0x24
> > 10 24 01 01 00 01 01 00 00 00 02 03 00 00 00 00
> >
> >           ===>Audio Streaming Format Type Descriptor<===
> > bLength:                           0x06
> > bDescriptorType:                   0x24
> > bDescriptorSubtype:                0x02
> > bFormatType:                       0x01
> > bNrChannels:                       0x02
> > bSubframeSize:                     0x10
> > bBitResolution:                    0x07
> > bSamFreqType:                      0x05
> > tSamFreq[1]:                   0x380501 (3671297 Hz)
> > tSamFreq[2]:                   0x080401 (525313 Hz)
> > tSamFreq[3]:                   0x000125 (293 Hz)
> > tSamFreq[4]:                   0x000000 (0 Hz)
> > tSamFreq[5]:                   0x050700 (329472 Hz)
> >
> >           ===>Endpoint Descriptor<===
> > bLength:                           0x07
> > bDescriptorType:                   0x05
> > bEndpointAddress:                  0x01  -> Direction: OUT - EndpointID: 1
> > bmAttributes:                      0x05  -> Isochronous Transfer Type
> >                    Synchronization Type = Asynchronous Bulk Transfer
> > Type
> > wMaxPacketSize:                  0x0138 = 1 transactions per microframe,
> > 0x138 max bytes
> > bInterval:                         0x04
> >
> >           ===>Descriptor Hex Dump<===
> > bLength:                           0x08
> > bDescriptorType:                   0x25
> > 08 25 01 00 00 00 00 00
> >
> >           ===>Endpoint Descriptor<===
> > bLength:                           0x07
> > bDescriptorType:                   0x05
> > bEndpointAddress:                  0x81  -> Direction: IN - EndpointID: 1
> > bmAttributes:                      0x11  -> Isochronous Transfer Type
> >                    Synchronization Type = No Synchronization Bulk
> > Transfer Type
> > wMaxPacketSize:                  0x0004 = 1 transactions per microframe,
> > 0x04 max bytes
> > bInterval:                         0x04
> >
> >           ===>Interface Descriptor<===
> > bLength:                           0x09
> > bDescriptorType:                   0x04
> > bInterfaceNumber:                  0x02
> > bAlternateSetting:                 0x00
> > bNumEndpoints:                     0x00
> > bInterfaceClass:                   0x01  -> Audio Interface Class
> > bInterfaceSubClass:                0x02  -> Audio Streaming Interface
> > SubClass
> > bInterfaceProtocol:                0x20
> > CAUTION:  This may be an invalid bInterfaceProtocol
> > iInterface:                        0x0E
> >      English (United States)  "Capture Inactive"
> >
> >           ===>Interface Descriptor<===
> > bLength:                           0x09
> > bDescriptorType:                   0x04
> > bInterfaceNumber:                  0x02
> > bAlternateSetting:                 0x01
> > bNumEndpoints:                     0x01
> > bInterfaceClass:                   0x01  -> Audio Interface Class
> > bInterfaceSubClass:                0x02  -> Audio Streaming Interface
> > SubClass
> > bInterfaceProtocol:                0x20
> > CAUTION:  This may be an invalid bInterfaceProtocol
> > iInterface:                        0x0F
> >      English (United States)  "Capture Active"
> >
> >           ===>Descriptor Hex Dump<===
> > bLength:                           0x10
> > bDescriptorType:                   0x24
> > 10 24 01 04 00 01 01 00 00 00 02 03 00 00 00 00
> >
> >           ===>Audio Streaming Format Type Descriptor<===
> > bLength:                           0x06
> > bDescriptorType:                   0x24
> > bDescriptorSubtype:                0x02
> > bFormatType:                       0x01
> > bNrChannels:                       0x02
> > bSubframeSize:                     0x10
> > bBitResolution:                    0x07
> > bSamFreqType:                      0x05
> > tSamFreq[1]:                   0xC40582 (12846466 Hz)
> > tSamFreq[2]:                   0x080400 (525312 Hz)
> > tSamFreq[3]:                   0x000125 (293 Hz)
> > tSamFreq[4]:                   0x000000 (0 Hz)
> > tSamFreq[5]:                   0x000000 (0 Hz)
> >
> >           ===>Endpoint Descriptor<===
> > bLength:                           0x07
> > bDescriptorType:                   0x05
> > bEndpointAddress:                  0x82  -> Direction: IN - EndpointID: 2
> > bmAttributes:                      0x05  -> Isochronous Transfer Type
> >                    Synchronization Type = Asynchronous Bulk Transfer
> > Type
> > wMaxPacketSize:                  0x00C4 = 1 transactions per microframe,
> > 0xC4 max bytes
> > bInterval:                         0x04
> >
> >           ===>Descriptor Hex Dump<===
> > bLength:                           0x08
> > bDescriptorType:                   0x25
> > 08 25 01 00 00 00 00 00
> >

