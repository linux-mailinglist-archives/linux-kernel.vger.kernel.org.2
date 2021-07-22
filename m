Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A03D1E14
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhGVFi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhGVFi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:38:57 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC47C061575;
        Wed, 21 Jul 2021 23:19:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k16so5055928ios.10;
        Wed, 21 Jul 2021 23:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3V37YpWkwckpHPTf6pL1DwFRL4vi/b1aUTSd0wef44w=;
        b=J64VgAQk7mD51huTpjO1UlpSq7iNposcMAxYlxfB+IYj1n6XNgcqUIwVLDM9qw8nYY
         PVat6u+IRLKNUapAm5rFC4+FS4zxRHYDq2OUtv78OywiheQOeVQ5CtH6OCpEKgPsK8Lo
         oSaJE9dM6K8BKZzvhdPGaL4PTxy+eEI1RwFs5XE7WLTs9kjqpO2ltp+PiQA8nO3p5K/k
         Ht7ztdrYHkuHCmWfFxX2zxKadhus04mwIJAK1XE9fK8bNdspNeGL/MoEsf2DIrpIIqFU
         FSfPTu/Q3AP+QW7lyJW07+psgVckVFDljmXQ7TByAu6J4M5xnDPSNkPjaF9HziLBDK6n
         NzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3V37YpWkwckpHPTf6pL1DwFRL4vi/b1aUTSd0wef44w=;
        b=UU6EaDExyDiGjmnGwefvEgpxXn46eRM405BDaguYBjp7Lrz8H+ruXlly568Oo/uTk8
         Ysg5JZhPKg25kv4bgPn8yye8B6aBSXQx5GGF9InLUgZ3JrqADcdh0JbfUfTGkV2VNvyu
         ji9evbVi8sy8Kgr+csnsuTO9rxtwsPxCBwNI4LfvsPB+LfZs7AbP8z+cIzNIWLJIOYBK
         WAPDzFsUqJpFTaHb2EKnupmPY8RraUtGJmUMtLgGiYYshL9GS4e9oBdIZvehZvxZkIK3
         RILA8vsLW0vVOq2M16uOa+KUVNshKgV6zGMr4trJC7eTPA5VrdIenIBoWi2pkDXpdEbN
         A5hw==
X-Gm-Message-State: AOAM5310SYx5TT+jPGmBfpVej1SK8L1O0Hso0afLdfIDRw/ZRepiJ8IA
        +VvanHsa7CQTb3Ws9C1/g0dC6pYqBjNiSetpiG4ejAg7EN4=
X-Google-Smtp-Source: ABdhPJxLiduZaKfvkzzF8+IDjRNGt9fn7xOfj+lM0h8zfJHBcXll+u03YqaKjQVsNPKSMcyy1NECTCgNTDrmFKzp5pk=
X-Received: by 2002:a05:6602:1603:: with SMTP id x3mr19022106iow.66.1626934770010;
 Wed, 21 Jul 2021 23:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210721235526.10588-1-msbroadf@gmail.com> <7b02cb66-d672-ae95-01ea-c6015725e1ac@linuxfoundation.org>
 <CALdjXpA4_eXen6RjhsEBYt8CQs-2gzwYs9h9q0Z2LKZ=rXVp+Q@mail.gmail.com>
In-Reply-To: <CALdjXpA4_eXen6RjhsEBYt8CQs-2gzwYs9h9q0Z2LKZ=rXVp+Q@mail.gmail.com>
From:   Michael <msbroadf@gmail.com>
Date:   Thu, 22 Jul 2021 16:19:16 +1000
Message-ID: <CALdjXpCaLQps7_XM05grMAScm9EC-tMP6bqf-+OSQvVOX4fhig@mail.gmail.com>
Subject: Re: [PATCH v2] vhci_hcd: USB port can get stuck in the disabled state
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can pass through any bluetooth dongle (or xbox wireless dongle)
through usbip and it will cause this issue.

For example, here is one of my customers
https://www.virtualhere.com/comment/9432#comment-9432 with the issue.

The device is in the  VDEV_ST_USED state when a reset occurs and so
its never re-enabled

Furthermore there is a bug in the line pr_err("vhci_device speed not set\n");
(L479) because resetting a full-speed device is not an error.


 On Thu, 22 Jul 2021 at 11:26, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/21/21 5:55 PM, Michael Broadfoot wrote:
> > When a remote usb device is attached to the local Virtual USB
> > Host Controller Root Hub port, the bound device driver may send a
> > port reset command. For example to initialize firmware (eg. btusb does this).
> > This port reset command can be sent at any time, however the VHCI hcd
> > root hub is only expecting reset to occur before the device receives
> > SET_ADDRESS. The USB port should always be enabled after a reset
> > (because the port is virtual and there is no possibility of hardware errors)
> >
> >
> >
> > Signed-off-by: Michael Broadfoot <msbroadf@gmail.com>
> > ---
> >   drivers/usb/usbip/vhci_hcd.c | 13 ++++---------
> >   1 file changed, 4 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > index 4ba6bcdaa8e9..d3cda1b2c15a 100644
> > --- a/drivers/usb/usbip/vhci_hcd.c
> > +++ b/drivers/usb/usbip/vhci_hcd.c
> > @@ -455,15 +455,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> >                       vhci_hcd->port_status[rhport] &= ~(1 << USB_PORT_FEAT_RESET);
> >                       vhci_hcd->re_timeout = 0;
> >
> > -                     if (vhci_hcd->vdev[rhport].ud.status ==
> > -                         VDEV_ST_NOTASSIGNED) {
> > -                             usbip_dbg_vhci_rh(
> > -                                     " enable rhport %d (status %u)\n",
> > -                                     rhport,
> > -                                     vhci_hcd->vdev[rhport].ud.status);
> > -                             vhci_hcd->port_status[rhport] |=
> > -                                     USB_PORT_STAT_ENABLE;
> > -                     }
>
> VDEV_ST_NOTASSIGNED status indicates that the vdev is in use without
> address assigned - in other words port is initializing.
>
> This is part of the attach request handling when user requests to
> attach to a remote device. attach_store() will change the status
> to VDEV_ST_NOTASSIGNED and then initiate port_connect sequence.
>
> We don't want to touch the vdev when it is in other states.
>
> > +                     usbip_dbg_vhci_rh(" enable rhport %d (status %u)\n",
> > +                                       rhport,
> > +                                       vhci_hcd->vdev[rhport].ud.status);
> > +                     vhci_hcd->port_status[rhport] |= USB_PORT_STAT_ENABLE;
> >
> >                       if (hcd->speed < HCD_USB3) {
> >                               switch (vhci_hcd->vdev[rhport].speed) {
> >
>
> How did you find this problem? Does the port get into stuck state
> while attaching to a remote usbip device on the host?
>
> thanks,
> -- Shuah
