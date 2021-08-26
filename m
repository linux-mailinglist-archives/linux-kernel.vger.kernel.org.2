Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221BD3F8621
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbhHZLKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhHZLKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:10:19 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6365EC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 04:09:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x5so2065095qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEXF2y6A05AVCBay5D6JPgIFZCILYU47cKg+kBHuhaA=;
        b=tHgdjDOBKqfSgEkub1fiYL77mW7DT6AKEslDkuo6Kb/uqL7UWN9mmPProiCjWC0Yyz
         ch+WwK7drAErNNuco6P2ACdeXjqi/I07qACnW6yCSHJWVKCIxQEhM9ZJ9+io8sGrCx5T
         t9b05BA9bQKDVCgBRu8CrcHVMww/4qa5PV7zefrEBq/+Rk/1Ydq35V/HX1sQkR3zeUrJ
         kY50BWt9U1Im7KOf7/aUkrlWA9m08EFq0wX4AH5Y2gI+hURQcm45XXPcRQqlOy6TBw4D
         +3M1sD/HDocOK/pZifwP+yJFWgeOKhFIf9BE2ruem07aLfr93AKR7ikfxhUI4S2OgwN8
         bXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEXF2y6A05AVCBay5D6JPgIFZCILYU47cKg+kBHuhaA=;
        b=DFg14JcyodHKtdLsshmRNIRvvPm/ZyYQFX3KEkDoWJlwqzl/PO7nlQ+kQjT0QQAzld
         igHN+CUwewUm+XCTlngm/pTPBZRu9O46DLsdhsdRtazpN4NnxLybSwSv3U0fKwY9uZWM
         2rwoKVh0GoyYomY9qwrUOfEeeVnRBtbCPSUIZmStJ0KElsRHeMmds1NtFiPI4jjG85rQ
         YeRligJAFtVh06Ti/AoPtG4SQizn3cpnZAIuS0WDOUcgJiPP3k6vODpfw9NRLeTFfCN/
         9qF6LinN2YTTqCo/7OzynjLLgokiNzOTpGyXoq8JGB+TksUm42n88O0E76zRTjk8mwEE
         NdMQ==
X-Gm-Message-State: AOAM530Z6vgkIkbdqzA8WKj1t6jjZWrkBPRGBSkIckXGIothftsMLTln
        fwz+4q/FKGH7pH50G5fOkjNnWiAJW65+0AwvnQp4lw==
X-Google-Smtp-Source: ABdhPJzudFxHMdMyj/n8TBQl4uxcyqxa+OgKlYbhzI+0q03bkJ67zxJp1jm6tKBORWTl8ESR+3J29AgqW024tF2Rz7E=
X-Received: by 2002:ac8:5194:: with SMTP id c20mr2653988qtn.68.1629976171603;
 Thu, 26 Aug 2021 04:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210826110239.5269-1-robert.marko@sartura.hr> <YSd2D92RL9pJMdQY@hovoldconsulting.com>
In-Reply-To: <YSd2D92RL9pJMdQY@hovoldconsulting.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 26 Aug 2021 13:09:20 +0200
Message-ID: <CA+HBbNFx45eapEZ3wiNCC5X+cvrJoCF01jaHTvj835P79AoN-Q@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: pl2303: fix GL type detection
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 1:08 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Aug 26, 2021 at 01:02:39PM +0200, Robert Marko wrote:
> > At least some PL2303GL have a bcdDevice of 0x405 instead of 0x100 as the
> > datasheet claims. Add it to the list of known release numbers for the
> > HXN (G) type.
> >
> > Fixes: 894758d0571d ("USB: serial: pl2303: tighten type HXN (G) detection")
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>
> Thanks for the patch, looks good.
>
> Could you post the output of lsusb -v for your device as well for
> completeness?

Sure, here it is:
Bus 001 Device 003: ID 067b:23d3 Prolific Technology, Inc. USB-Serial Controller
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x067b Prolific Technology, Inc.
  idProduct          0x23d3
  bcdDevice            4.05
  iManufacturer           1 Prolific Technology Inc.
  iProduct                2 USB-Serial Controller
  iSerial                 3 DTBOb106315
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0027
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x000a  1x 10 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
Device Status:     0x0000
  (Bus Powered)

Regards,
Robert
>
> Johan



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
