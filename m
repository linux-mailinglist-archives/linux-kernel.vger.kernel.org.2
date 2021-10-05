Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3872742348B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhJEXpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhJEXph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:45:37 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E9C061749;
        Tue,  5 Oct 2021 16:43:45 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n71so914481iod.0;
        Tue, 05 Oct 2021 16:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=yOOtA2M5QmbPjwtL+wKK/+7csoshQHh+btCjE+xfZwY=;
        b=brsVG4NgXYbFNluXPs7dRISQW8XIZwmAjNCXL0N2wa0n0plZlVmBgmGYI09gx4a0vl
         JfXlgA85tP2GOCttLxBo7oFwvSoQhDaSeAX3ilMz//tW4T0Cy73l+rI5UEKn2hrOR88k
         y8ZmI4AnwD+0BZvuoJu4gSSczDvdJbaJGOJkLYLzgr8ub85NxAYHyULWFwlu9+PL9Uqe
         wSTmUdX/sCIgqAugWhdFVnkqq0+J28Jw8eJxXZWlfIS4PiFurbGHy6eSXf9Zx1N6eCBx
         trH4uf+y4+slwClGAStVPpvIN6ycsINV8dRIYyvdXccIwrOZcauEtou3+9ML4W/RSMko
         ms4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=yOOtA2M5QmbPjwtL+wKK/+7csoshQHh+btCjE+xfZwY=;
        b=C8h/AyIzUYq4dlOzanwRp04bv+XaTUYHOblmUCZ/oi7BWhsHOvUFxjo0WzXUVhbftO
         kXNS3AxbL407qhK39E8MMOF0UMySnT5DvdNEX4f44enT/ad+LEjsb3U4Dxb+3dyFbV/u
         nMq6Ga+fOPCP7uiui1gDTDursX5N3mXqdqGoUjLsCagyApiJMFG9b16GH5a7x3/sQu+X
         DVTmKShGVmDU3MmiJ7uvr9Qqw90qX7hQ7GJw7Vtc8itWd9hY1GdcTNYWPqqQ7eoJzUmW
         WIKMmQU9SpOS2XtAK4qmqR5PnMi++SbDrxswwp12+DgxLR5JEo8TNfpDNMWHHNJhRIAp
         whQg==
X-Gm-Message-State: AOAM530Fm32wG6M4Ucp/0oiGt4HHax3QdrVIJetX1STDyW2DfYZPzWQs
        Tmu8a0r55EfRx4dVQRHJmtXSZH2ARpIZxWGaC9g=
X-Google-Smtp-Source: ABdhPJw3SgXd3oHcPoAw+z0DymvtQNLu2F7ZsAMQ6X+pzgYxia7GeRCtol2YORg1xumdm2dZMS0j/DZ8eDYj7xEx9zE=
X-Received: by 2002:a05:6602:2c09:: with SMTP id w9mr4429098iov.78.1633477425014;
 Tue, 05 Oct 2021 16:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210929224823.556943-1-rajatja@google.com> <20210929224823.556943-2-rajatja@google.com>
 <YVVLxi/on9x6nfCZ@kroah.com> <CACK8Z6EamamgYExt629gyNrYKpvnu2Gh0eGOOvOa5LH-jnOmaQ@mail.gmail.com>
 <20211005145655.GJ621017@rowland.harvard.edu> <CAE_wzQ-XG3YBtKTmbn1LSGETCUg5AYjTmcnwOnc1h57OaL9+Cw@mail.gmail.com>
 <20211005195929.GA634685@rowland.harvard.edu>
In-Reply-To: <20211005195929.GA634685@rowland.harvard.edu>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Tue, 5 Oct 2021 16:43:33 -0700
Message-ID: <CAA93t1qzJuN8M2zbs+Kt9JXWP1H2kjKSxBp8-TXEfaMeZ1iggQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: hub: Mark devices downstream a removable hub, as removable
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Dmitry Torokhov <dtor@google.com>, Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        levinale@google.com, bleung@google.com, jsbarnes@google.com,
        pmalani@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 5, 2021 at 12:59 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, Oct 05, 2021 at 09:51:02AM -0700, Dmitry Torokhov wrote:
> > Hi Alan,
> >
> > On Tue, Oct 5, 2021 at 7:56 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > As I understand it, the "removable" property refers specifically to
> > > the device's upstream link, not to whether _any_ of the links leading
> > > from the device to the computer could be removed.
> >
> > No, that is not what it means. I'll cite our sysfs ABI:
> >
> > What:           /sys/devices/.../removable
> > Date:           May 2021
> > Contact:        Rajat Jain <rajatxjain@gmail.com>
> > Description:
> >                 Information about whether a given device can be removed from the
> >                 platform by the user. This is determined by its subsystem in a
> >                 bus / platform-specific way. This attribute is only present for
> >                 devices that can support determining such information:
> >
> >                 "removable": device can be removed from the platform by the user
> >                 "fixed":     device is fixed to the platform / cannot be removed
> >                              by the user.
> >                 "unknown":   The information is unavailable / cannot be deduced.
> >
> >                 Currently this is only supported by USB (which infers the
> >                 information from a combination of hub descriptor bits and
> >                 platform-specific data such as ACPI) and PCI (which gets this
> >                 from ACPI / device tree).
> >
> > It specifically talks about _platform_, not about properties of some
> > peripheral attached to a system. Note that the wording is very similar
> > to what we had for USB devices that originally implemented "removable"
> > attribute:
>
> In that case, shouldn't Rajat's patch change go into the driver core
> rather than the hub driver?  _Every_ device downstream from a
> removable link should count as removable, yes?  Not just the USB
> devices.

I have no preference either way, and can do that if that is more acceptable.

>
> And to say that the attribute is supported only by USB and PCI is
> misleading, since it applies to every device downstream from a
> removable link.

However I do think it makes sense to have the bus control whether this
attribute applies to it or not. Determining the first point in a
hierarchy of devices, where a device can be removed is highly bus
specific (set_usb_port_removable()).

AFAIK, the primary reason / use of this attribute was to distinguish
devices that can be removed by the user, and really all such devices
(at least the ones that matter to user) today sit either on PCI or USB
bus. We intend to use this attribute to segregate internal devices
from external devices, and collect some statistics about usb device
usage this way. There is also a VM case that I think Dmitry or Benson
on this thread can elaborate more about. There seem to be hundreds of
other bus types and I'm not sure if we want to unnecessarily flood the
sysfs with a removable attribute under each device.

Thanks & Best Regards,

Rajat

>
> > > This is probably what Oliver meant when he complained about losing
> > > information.  With the knowledge of whether each individual link is
> > > removable, you can easily tell whether there's some way to remove a
> > > device from the system.  But if you only know whether the device is
> > > removable from the system overall, you generally can't tell whether
> > > the link to the device's parent is removable.
> >
> > If we need this data then we need to establish some new attribute to
> > convey this info.
>
> I don't know if we need it, but such an attribute seems like a good
> idea.
>
> Alan Stern
