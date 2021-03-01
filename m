Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A40D329FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574710AbhCBDtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbhCAVfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:35:04 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AF9C061756;
        Mon,  1 Mar 2021 13:34:23 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id h10so7310950otm.1;
        Mon, 01 Mar 2021 13:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhG4rx0c+91LEIH+qR6RUNaHVNddgYArf242XPm3m3I=;
        b=TLPlCvv7mipFOgDdtuQYva3KVH/7Nyr7w5kNK0kqoF62qjVBG2oYj9l42gJkPUgSCg
         QZvX/gxXVXjEATlE1XdZn0rRcNBDF4SDqpbbf7UqgwAdeHxKsWtreNyF+5V3A2WUWxpc
         q9yUx0GTuuRbwgz7WfMDDtN3ZGmGhs3H6y2cu9pPgr6TK6GrQ0Sb3VjGMfB349z078kn
         sBUCghaYrk1edGmiRBKUNhchjd/285xwUmcsP+Qup6gPZkB4uhmpHkLvPDBSCdtjh4sF
         j4KLG+bvmPykP7N3TPAjZ7oJdR0w2jZhJscEML34odvoO+oV/8oYDn71fwHZpcyYtdcz
         Xjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhG4rx0c+91LEIH+qR6RUNaHVNddgYArf242XPm3m3I=;
        b=FpwAecnfdd366Gm40rw94u49FdXqbv4pVOZFxqo/i2vb6y95HTK9B2vjzTHSVUexve
         ETBvD0jkBIVc9czhBHxf78Dw+gN9ocOKMz2vcdo+M4yK9xKv0Bl4JRGETEHsnNLl4kth
         ZuSw5iZt1KqXNNJXy4kbw3zE1nMXtEatfyrpFvGGuTXsYyAYO9sCej+z5bgE7dKByg12
         zHdXQY/nEs0edCpbRsA8bZugf4e30hFqgXYtf1lKjpeCyiTsz/Su8ezYsJoUopQcM3MO
         TFwLsATmIjkmddlc6N0pq10oBDkNy4LZ4u82aRkLGT+XOWbvfzecnws7emYgb3BYfRBd
         +IRg==
X-Gm-Message-State: AOAM531EWyH5kiarmpZrSXcpQPIthYzmt/GbpUoZdcYomqkHf+062SuO
        CKNumhfB8JA+O5SXlpHI8m8iufHWnWH7aVE8+LYYMw9JWRi/xwkE
X-Google-Smtp-Source: ABdhPJyydZtffSv5+Wnv+dZFJc+0pWvWdVBBAHhFflSlXJ0QmxYPBVWgWsjiAjNpGuURs4rjqTKR28eWoDIKLZ1ik+E=
X-Received: by 2002:a9d:6012:: with SMTP id h18mr15104225otj.336.1614634462595;
 Mon, 01 Mar 2021 13:34:22 -0800 (PST)
MIME-Version: 1.0
References: <002f01d70eba$d1b365a0$751a30e0$@Freyberger.de>
In-Reply-To: <002f01d70eba$d1b365a0$751a30e0$@Freyberger.de>
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Mon, 1 Mar 2021 23:34:09 +0200
Message-ID: <CAB=otbQLO451REYQg3ZAR+bwAFaX5VFfz9_fVGvY3yGGxEWsaA@mail.gmail.com>
Subject: Re: [PATCH 0/8] USB Audio Gadget part 2: Feedback endpoint,
 Volume/Mute support
To:     Johannes Freyberger <Johannes@freyberger.de>
Cc:     Felipe Balbi <balbi@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Glenn Schmottlach <gschmottlach@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Mon, Mar 1, 2021 at 6:49 PM Johannes Freyberger
<Johannes@freyberger.de> wrote:
>
> Hi Ruslan,
>
> thanks for all your efforts to make the USB Audio Gadget work in Win10 using
> UAC2. Meanwhile I managed to apply and compile your previous modifications
> and now my Raspberry PI shows up in the Windows Device Manager as a valid
> UAC2 audio device. Unfortunately it still doesn't work to transfer any audio
> as it seems the audio endpoints or the topology is not working.

Are you testing my previous version of the patches on some older kernel?

Just for records - these two patch sets (part 1 and part 2) are based on Greg's
usb-next branch (commit b5a12546e779d4f5586f58e60e0ef5070a833a64 which
is based on v5.11-rc5 tag). I retested them today with a BBB board and it works
fine under Win 10. Also I rebased these two patchsets today against latest
Greg's usb-next branch which is now Linus's v5.12-rc1 tag and again it works
fine under Win10 - both Volume/Mute controls and audio streaming.

These patches have been tested previously on Raspberry PI 4 running v5.9
and v5.10 stable kernels. The only issues I've seen were because of
Raspberry's DWC2 DMA issue in the driver that I described in this cover letter.
However if you disable volume/mute controls, it won't affect you.

> I checked it
> with some tools and found one providing some information on the USB part
> (it's called UVCview.exe and is part of the Windows Driver Kit). Here's the
> output which I hope can give some hints on the problems still existing in
> this driver:

From the output below I see UAC2 descriptors are completely screwed up
(or UVCview.exe doesn't show them correctly). Windows is very strict to
the descriptors and doesn't allow devices to start in case of any issues.
So if it appears as a valid UAC2 device in Device Manager, most likely
UVCview.exe doesn't decode UAC2 descriptors well.

Could you please also apply these patches to the latest kernel (v5.12-rc1)
and test?

Thanks,
Ruslan

>
>           ---===>Device Information<===---
> English product name: "Linux USB Audio Gadget"
>
> ConnectionStatus:
> Current Config Value:              0x01  -> Device Bus Speed: High
> Device Address:                    0x0F
> Open Pipes:                           0
> *!*ERROR:  No open pipes!
>
>           ===>Device Descriptor<===
> bLength:                           0x12
> bDescriptorType:                   0x01
> bcdUSB:                          0x0200
> bDeviceClass:                      0xEF  -> This is a Multi-interface
> Function Code Device
> bDeviceSubClass:                   0x02  -> This is the Common Class Sub
> Class
> bDeviceProtocol:                   0x01  -> This is the Interface
> Association Descriptor protocol
> bMaxPacketSize0:                   0x40 = (64) Bytes
> idVendor:                        0x1D6B = The Linux Foundation
> idProduct:                       0x0101
> bcdDevice:                       0x0510
> iManufacturer:                     0x01
>      English (United States)  "Linux 5.10.17-v7l-R3LAY_TEST+ with
> fe980000.usb"
> iProduct:                          0x02
>      English (United States)  "Linux USB Audio Gadget"
> iSerialNumber:                     0x00
> bNumConfigurations:                0x01
>
>           ===>Configuration Descriptor<===
> bLength:                           0x09
> bDescriptorType:                   0x02
> wTotalLength:                    0x00E2  -> Validated
> bNumInterfaces:                    0x03
> bConfigurationValue:               0x01
> iConfiguration:                    0x00
> bmAttributes:                      0xC0  -> Bus Powered
> MaxPower:                          0x01 =   2 mA
>
>           ===>IAD Descriptor<===
> bLength:                           0x08
> bDescriptorType:                   0x0B
> bFirstInterface:                   0x00
> bInterfaceCount:                   0x03
> bFunctionClass:                    0x01  -> Audio Interface Class
> bFunctionSubClass:                 0x00
> *!*CAUTION:    This appears to be an invalid bFunctionSubClass
> bFunctionProtocol:                 0x20
> iFunction:                         0x04
>      English (United States)  "R3lay PI"
>
>           ===>Interface Descriptor<===
> bLength:                           0x09
> bDescriptorType:                   0x04
> bInterfaceNumber:                  0x00
> bAlternateSetting:                 0x00
> bNumEndpoints:                     0x00
> bInterfaceClass:                   0x01  -> Audio Interface Class
> bInterfaceSubClass:                0x01  -> Audio Control Interface SubClass
> bInterfaceProtocol:                0x20
> CAUTION:  This may be an invalid bInterfaceProtocol
> iInterface:                        0x05
>      English (United States)  "Topology Control"
>
>           ===>Audio Control Interface Header Descriptor<===
> bLength:                           0x09
> bDescriptorType:                   0x24
> bDescriptorSubtype:                0x01
> bcdADC:                          0x0200
> wTotalLength:                    0x5308
> bInCollection:                     0x00
>
>           ===>Descriptor Hex Dump<===
> bLength:                           0x08
> bDescriptorType:                   0x24
> 08 24 0A 06 01 01 00 06
>
>           ===>Descriptor Hex Dump<===
> bLength:                           0x08
> bDescriptorType:                   0x24
> 08 24 0A 05 01 01 00 07
>
>           ===>Descriptor Hex Dump<===
> bLength:                           0x11
> bDescriptorType:                   0x24
> 11 24 02 01 01 01 00 05 02 03 00 00 00 00 03 00
> 08
>
>           ===>Descriptor Hex Dump<===
> bLength:                           0x11
> bDescriptorType:                   0x24
> 11 24 02 02 00 02 00 06 02 03 00 00 00 00 03 00
> 09
>
>           ===>Descriptor Hex Dump<===
> bLength:                           0x0C
> bDescriptorType:                   0x24
> 0C 24 03 04 01 01 00 02 06 03 00 0A
>
>           ===>Descriptor Hex Dump<===
> bLength:                           0x0C
> bDescriptorType:                   0x24
> 0C 24 03 03 00 03 00 01 05 03 00 0B
>
>           ===>Interface Descriptor<===
> bLength:                           0x09
> bDescriptorType:                   0x04
> bInterfaceNumber:                  0x01
> bAlternateSetting:                 0x00
> bNumEndpoints:                     0x00
> bInterfaceClass:                   0x01  -> Audio Interface Class
> bInterfaceSubClass:                0x02  -> Audio Streaming Interface
> SubClass
> bInterfaceProtocol:                0x20
> CAUTION:  This may be an invalid bInterfaceProtocol
> iInterface:                        0x0C
>      English (United States)  "Playback Inactive"
>
>           ===>Interface Descriptor<===
> bLength:                           0x09
> bDescriptorType:                   0x04
> bInterfaceNumber:                  0x01
> bAlternateSetting:                 0x01
> bNumEndpoints:                     0x02
> bInterfaceClass:                   0x01  -> Audio Interface Class
> bInterfaceSubClass:                0x02  -> Audio Streaming Interface
> SubClass
> bInterfaceProtocol:                0x20
> CAUTION:  This may be an invalid bInterfaceProtocol
> iInterface:                        0x0D
>      English (United States)  "Playback Active"
>
>           ===>Descriptor Hex Dump<===
> bLength:                           0x10
> bDescriptorType:                   0x24
> 10 24 01 01 00 01 01 00 00 00 02 03 00 00 00 00
>
>           ===>Audio Streaming Format Type Descriptor<===
> bLength:                           0x06
> bDescriptorType:                   0x24
> bDescriptorSubtype:                0x02
> bFormatType:                       0x01
> bNrChannels:                       0x02
> bSubframeSize:                     0x10
> bBitResolution:                    0x07
> bSamFreqType:                      0x05
> tSamFreq[1]:                   0x380501 (3671297 Hz)
> tSamFreq[2]:                   0x080401 (525313 Hz)
> tSamFreq[3]:                   0x000125 (293 Hz)
> tSamFreq[4]:                   0x000000 (0 Hz)
> tSamFreq[5]:                   0x050700 (329472 Hz)
>
>           ===>Endpoint Descriptor<===
> bLength:                           0x07
> bDescriptorType:                   0x05
> bEndpointAddress:                  0x01  -> Direction: OUT - EndpointID: 1
> bmAttributes:                      0x05  -> Isochronous Transfer Type
>                    Synchronization Type = Asynchronous
> Bulk Transfer Type
> wMaxPacketSize:                  0x0138 = 1 transactions per microframe,
> 0x138 max bytes
> bInterval:                         0x04
>
>           ===>Descriptor Hex Dump<===
> bLength:                           0x08
> bDescriptorType:                   0x25
> 08 25 01 00 00 00 00 00
>
>           ===>Endpoint Descriptor<===
> bLength:                           0x07
> bDescriptorType:                   0x05
> bEndpointAddress:                  0x81  -> Direction: IN - EndpointID: 1
> bmAttributes:                      0x11  -> Isochronous Transfer Type
>                    Synchronization Type = No Synchronization
> Bulk Transfer Type
> wMaxPacketSize:                  0x0004 = 1 transactions per microframe,
> 0x04 max bytes
> bInterval:                         0x04
>
>           ===>Interface Descriptor<===
> bLength:                           0x09
> bDescriptorType:                   0x04
> bInterfaceNumber:                  0x02
> bAlternateSetting:                 0x00
> bNumEndpoints:                     0x00
> bInterfaceClass:                   0x01  -> Audio Interface Class
> bInterfaceSubClass:                0x02  -> Audio Streaming Interface
> SubClass
> bInterfaceProtocol:                0x20
> CAUTION:  This may be an invalid bInterfaceProtocol
> iInterface:                        0x0E
>      English (United States)  "Capture Inactive"
>
>           ===>Interface Descriptor<===
> bLength:                           0x09
> bDescriptorType:                   0x04
> bInterfaceNumber:                  0x02
> bAlternateSetting:                 0x01
> bNumEndpoints:                     0x01
> bInterfaceClass:                   0x01  -> Audio Interface Class
> bInterfaceSubClass:                0x02  -> Audio Streaming Interface
> SubClass
> bInterfaceProtocol:                0x20
> CAUTION:  This may be an invalid bInterfaceProtocol
> iInterface:                        0x0F
>      English (United States)  "Capture Active"
>
>           ===>Descriptor Hex Dump<===
> bLength:                           0x10
> bDescriptorType:                   0x24
> 10 24 01 04 00 01 01 00 00 00 02 03 00 00 00 00
>
>           ===>Audio Streaming Format Type Descriptor<===
> bLength:                           0x06
> bDescriptorType:                   0x24
> bDescriptorSubtype:                0x02
> bFormatType:                       0x01
> bNrChannels:                       0x02
> bSubframeSize:                     0x10
> bBitResolution:                    0x07
> bSamFreqType:                      0x05
> tSamFreq[1]:                   0xC40582 (12846466 Hz)
> tSamFreq[2]:                   0x080400 (525312 Hz)
> tSamFreq[3]:                   0x000125 (293 Hz)
> tSamFreq[4]:                   0x000000 (0 Hz)
> tSamFreq[5]:                   0x000000 (0 Hz)
>
>           ===>Endpoint Descriptor<===
> bLength:                           0x07
> bDescriptorType:                   0x05
> bEndpointAddress:                  0x82  -> Direction: IN - EndpointID: 2
> bmAttributes:                      0x05  -> Isochronous Transfer Type
>                    Synchronization Type = Asynchronous
> Bulk Transfer Type
> wMaxPacketSize:                  0x00C4 = 1 transactions per microframe,
> 0xC4 max bytes
> bInterval:                         0x04
>
>           ===>Descriptor Hex Dump<===
> bLength:                           0x08
> bDescriptorType:                   0x25
> 08 25 01 00 00 00 00 00
>
