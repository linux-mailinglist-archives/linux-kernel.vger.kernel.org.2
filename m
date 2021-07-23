Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720973D437D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 01:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhGWXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 19:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhGWXM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:12:57 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C80C061575;
        Fri, 23 Jul 2021 16:53:29 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r18so4512136iot.4;
        Fri, 23 Jul 2021 16:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1Ouoyc282n8cRglKql5qRrMEKm9c0HSU8jXOecOjS8=;
        b=VJPXZ82ESQFnQ0Q83zyOTc5aJJF2w7XaAlDIF/RlsKXX0xUzTcCMkGwKRKla0gSSQA
         0sQiwNIAb9PC8BMT8qBn2onrYt4TB2R850H2ku15hIHLwIyWEhb2s19lF++DUhNXmXib
         buANJjFMz7MPXALqJDvrGix1MyYDXsmySB0DatD7yCJ4uGxjWW8wf7asGSfLzpdqrinJ
         kf6nmKAT/4WGJhvElBkUSMrsx2kZGbqTz3cf+JuP1wFzpD2GhkM5DGiopmVI6Pr5Rec7
         SJitFv6fjoT16hvejTzoZ6wVOJADDpvCD/aVlBXzb7TK3G8rO6MCslyTNNNsi6r4Vv8/
         RGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1Ouoyc282n8cRglKql5qRrMEKm9c0HSU8jXOecOjS8=;
        b=Rt2pf4TsOy942p89q5ZxXwbNeeRwqp6UYuHh3Q4wv8mb2lcRB8rQaaYLyrTvv26vVx
         YM1qE4PquFe6jhZ7wPFJ5QOZl8C6TmApsyj2/Fnaa2I2Q2Ds8UACmkestd1dRo+Igw1U
         Au1VhgzAMPlfCYuGEXfmIJJ7Wp0KVnkEgzyjjcNDDZhRcJ4WDsNV2QmnThUPlrTHoYB2
         dumHbcr/lGug97+42/5ST+AzlijTUI6OPZX9Ks5lkZhg6lMuU1LcGpPOcXTQe3ZirGaI
         vfUXVsZPgRiA22zi3ECRx+04gi43dtqJk/ilUocMNjWGFzufju2i621zMQR3VY8O6ezI
         y4rA==
X-Gm-Message-State: AOAM530XsWTaKNRuXcPAKj/y4PjXoDmiYcSppb1pPRHL0wAqmKBUWRSS
        0g+BQgXrxO6cSNN7ytdiez78MubXo2oP+DIP4JRHXYa+3SGL8w==
X-Google-Smtp-Source: ABdhPJxZGMOuHexG1C/jPu96jJOOIPUd5Qy85yPlibIA3skAEr7sbCge2SD2YJS7cM/dH25zcl73/tcH+ibJTGvBuko=
X-Received: by 2002:a5e:c006:: with SMTP id u6mr5832579iol.66.1627084409249;
 Fri, 23 Jul 2021 16:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210721235526.10588-1-msbroadf@gmail.com> <7b02cb66-d672-ae95-01ea-c6015725e1ac@linuxfoundation.org>
 <CALdjXpA4_eXen6RjhsEBYt8CQs-2gzwYs9h9q0Z2LKZ=rXVp+Q@mail.gmail.com> <ad07410b-05d6-6a12-13df-14e31cbf50ff@linuxfoundation.org>
In-Reply-To: <ad07410b-05d6-6a12-13df-14e31cbf50ff@linuxfoundation.org>
From:   Michael <msbroadf@gmail.com>
Date:   Sat, 24 Jul 2021 09:53:16 +1000
Message-ID: <CALdjXpBzOCuJ-q0Co9ohc=GTBPuVUUaa7_DSbYJTeSSrN8KDyg@mail.gmail.com>
Subject: Re: [PATCH v2] vhci_hcd: USB port can get stuck in the disabled state
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an xbox controller. (Note this usb is just a mt76 usb->wifi
chip slightly modified).

Host commands
----------------------
sudo usbipd &
sudo modprobe usbip-host
sudo usbip bind -b 1-1.4

Client commands
-----------------------
sudo modprobe vhci-hcd
sudo usbip attach -r 192.168.1.189 -b 1-1.4

Host dmesg
-----------------
[   61.713164] usbcore: registered new device driver usbip-host
[   99.964196] mt76x2u 1-1.4:1.0: mac specific condition occurred
[  100.212477] usbip-host 1-1.4: usbip-host: register new device (bus 1 dev 3)
[  128.195578] usbip-host 1-1.4: stub up

Client dmesg
--------------------
[  184.764560] vhci_hcd vhci_hcd.0: pdev(0) rhport(0) sockfd(3)
[  184.764569] vhci_hcd vhci_hcd.0: devid(65539) speed(3) speed_str(high-speed)
[  184.764592] vhci_hcd vhci_hcd.0: Device attached
[  184.999634] usb 5-1: new high-speed USB device number 2 using vhci_hcd
[  185.127653] usb 5-1: SetAddress Request (2) to port 0
[  185.173988] usb 5-1: New USB device found, idVendor=045e,
idProduct=02e6, bcdDevice= 1.00
[  185.173996] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  185.174000] usb 5-1: Product: XBOX ACC
[  185.174003] usb 5-1: Manufacturer: Microsoft Inc.
[  185.174005] usb 5-1: SerialNumber: 203124
[  185.357262] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[  185.357936] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  186.387801] usb usb5-port1: Cannot enable. Maybe the USB cable is bad?
[  187.287921] usb usb5-port1: Cannot enable. Maybe the USB cable is bad?
[  188.188011] usb usb5-port1: Cannot enable. Maybe the USB cable is bad?
[  189.088116] usb usb5-port1: Cannot enable. Maybe the USB cable is bad?
[  189.088169] usb 5-1: USB disconnect, device number 2
[  189.088789] mt76x2u 5-1:1.0: ASIC revision: ffffffff
[  189.089569] usbcore: registered new interface driver mt76x2u
[  189.988201] usb usb5-port1: Cannot enable. Maybe the USB cable is bad?
[  190.888294] usb usb5-port1: Cannot enable. Maybe the USB cable is bad?
[  190.888321] usb usb5-port1: attempt power cycle
[  192.104419] usb usb5-port1: Cannot enable. Maybe the USB cable is bad?
[  193.004503] usb usb5-port1: Cannot enable. Maybe the USB cable is bad?
[  193.004531] usb usb5-port1: unable to enumerate USB device


On Sat, 24 Jul 2021 at 02:29, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/21/21 8:27 PM, Michael wrote:
> > You can pass through any bluetooth dongle (or xbox wireless dongle) through usbip and it will cause this issue.
> >
> > For example, here is one of my customers https://www.virtualhere.com/comment/9432#comment-9432 <https://www.virtualhere.com/comment/9432#comment-9432> with the issue.
> >
> > The device is in the VDEV_ST_USED state when a reset occurs and so its never re-enabled
> >
> > Furthermore there is a bug in the line pr_err("vhci_device speed not set\n");
> > (L479) because resetting a full-speed device is not an error.
> >
>
> Can you provide me the full demsg from host and client including the part
> where device is attached? I assume usbip tools from Linux sources are used?
>
> Also send me lsusb output on host and client
>
> thanks,
> -- Shuah
