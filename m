Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8554234B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhJEXvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhJEXvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:51:14 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011A6C061749;
        Tue,  5 Oct 2021 16:49:23 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i11so39853ila.12;
        Tue, 05 Oct 2021 16:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=KVkB/xxIaRrACI2ADXm7FeOgUQdS3/51LOFgkKYmnLo=;
        b=jJ/TIjRJrqA9Z7zVbo6ragjrWVn6/UHnEyFha+dGVKd5Nq4xMOFd+DMNPejPCimWD5
         ONuC1SmkKiAjs53YQZQ1fJHz2w7oaaC1oVZVVFLte58gx5mdC4chE81hLCl5GoCk4UuY
         T0ve7b5gQcDUmlTnQcf1J7aYhaGTOg3Nv0ZnfjkH0H4PbXHxLfVRGEtNbEqqVZDsDix0
         CCX4hiUVJSkr9X0EoT6PiV3Rhoo1dqs+1Hpg8uZ2PdkmNTPy/CJ4dZ9ebCZRFbK/nxuw
         40kg6JYfuoG7kJgC2IvV7lnCGucaxVn3IufUHmBU0cP9XpXh0rvFRElytUt8v4WGJYAD
         TgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=KVkB/xxIaRrACI2ADXm7FeOgUQdS3/51LOFgkKYmnLo=;
        b=yefGxTux27z5FlYSSnAB9eO1/xMeYnu1zADWmIjRoMRe7CYQX9a4Ja2YbXZ6Fq7UeU
         pdQmAR2uGXwQqkgmO2cSho5mEYyYZOnr/nQ9q/bvLGta3nMngyNEtMi/keeD+MT5za14
         FpvikhJnx5Mxqi8oecDqJp1vBPqu2Wdsa4EOutlXEe1wjZENlwZfH9nAOgGeDnjqzWLc
         H7PC2rT54deacyx94HFD0Fvo4vpKQ+OvoKou5DwT68mwgsNMKAPVEhhVPj1EXIDksime
         36ynBS9WMQHXH2Z9nVctZm4WLZSrqmEH5dm2igy0r1XzXzSZWTMtWtqW+XUK/6YLGbVj
         n3mA==
X-Gm-Message-State: AOAM533JHUiN8+0Ts14XfcqMBY4FDWmR6RYp3qUeTQcAizA/njazrWJK
        R7FDiMQb6OJI2pEbE25rFsM1NoFuChxY7OKyUdE=
X-Google-Smtp-Source: ABdhPJxnOgwxdOya9bNNcbF+ySG/v50f/uPZW5twUmmsEzCoZfwEMKy/QSFGXQ7Xt6ceDUfjE7H9KfmOj06tP1s0be8=
X-Received: by 2002:a92:ca46:: with SMTP id q6mr5257784ilo.59.1633477762353;
 Tue, 05 Oct 2021 16:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210929224823.556943-1-rajatja@google.com> <YVw02jUqxaVICKQU@kroah.com>
In-Reply-To: <YVw02jUqxaVICKQU@kroah.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Tue, 5 Oct 2021 16:49:11 -0700
Message-ID: <CAA93t1rg=E+2C5+j-i=6_upUH+QRrDZ8WVvtR60uxD+JwO2W3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: hub: Mark root hubs on removable devices, as removable.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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

On Tue, Oct 5, 2021 at 4:19 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 29, 2021 at 03:48:22PM -0700, Rajat Jain wrote:
> > Currently all usb root hubs are always marked as DEVICE_REMOVABLE_UNKNOWN
> > unconditionally. Let us try to help the users to identify the removable
> > root hubs, by checking the device on which the root hub sits. If the base
> > (parent) device on which the root hub sits, is removable (e.g. on
> > thunderbolt docks), then the roothub is also marked as removable.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/usb/core/hub.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 86658a81d284..45d1c81b121d 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -2440,8 +2440,16 @@ static void set_usb_port_removable(struct usb_device *udev)
> >
> >       dev_set_removable(&udev->dev, DEVICE_REMOVABLE_UNKNOWN);
> >
> > -     if (!hdev)
> > +     if (!hdev) {
> > +             /*
> > +              * If the root hub sits on a removable device, mark the root hub
> > +              * removable as well. This helps with the USB root hubs sitting
> > +              * on the thunderbolt docks.
> > +              */
> > +             if (udev->dev.parent && dev_is_removable(udev->dev.parent))
>
> How can a roothub device not have a parent?

It was a sanity check. I can remove that if we know that it can never happen.

>
> I still don't know about this.  What userspace tool is going to do
> anything with this information?  What is broken today that this fixes?

With these 2 patches, Chromeos intends to collect statistics about
external USB device usage in the system. The tool will be an internal
chrome os statistics collection tool. Today, any thunderbolt docks and
its devices appear as "unknown". There is also a VM case that is
helped by these patches, but I think Dmitry on Benson on this thread
can elaborate more about that.

Thanks & Best Regards,

Rajat


>
> thanks,
>
> greg k-h
