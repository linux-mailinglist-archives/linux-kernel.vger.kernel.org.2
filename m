Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34894422E67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhJEQxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbhJEQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:53:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA5EC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:51:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t8so38671456wri.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0oYgCq8tdGL5ZnFMRu0rVxW8eQ2Me6G+FliJuxkQGT8=;
        b=LQoDamG/0yIG0jhB3YGreFjRgT9SUHOOeZblFDFaZlUTvvjj1Apbv9AUs5jG0g2X5k
         zUUjfGVhtjzs9Xgkfl3rGNUobgp0st2d45dKirMaCW7cIYWs5UsGqS/UjZI4dspV78mt
         qYxx7SZtd0mj07iKnlU7ZlmBMJUeIw1N89iJ1IVAuxdhYESZhOxrUq5XYBdmtr+SaHBT
         +kqeiN7RF8hzqrEMElIfy7FYb93pDJGZ6AEiq59eFm9m+JRgfIpMZY0/gOWDt5ejocoG
         Oiw28g5/9nqV51WozZHfMoOO1pp+vGWBWzjZDhwlMTM89D6BUDrZnb7aXvrR/Zw0h3Md
         dJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oYgCq8tdGL5ZnFMRu0rVxW8eQ2Me6G+FliJuxkQGT8=;
        b=m7QIn3JVICkffMXiaRELAu7jS9EL+K2xm5Wg5tZt2ee2+Yj+k/ztJzCqI0WpIxFllZ
         eI7lkLrNsG3ipnc3ExEvAikUc5r4tRBjTaebIE8zsdSA3YjBoKyF/F4X/ac+29t10EeO
         zBUrZvXFTl7Fd3aMY3NUSoFipUcy+gFCAVjiHMflnfU8Yv0hHz5dTsZahCoj30CLGdzj
         rkin+uH8aFokFwjTxHpOevL0yuqFiqvSYlU7lfQyYR9LDk4qKg6fGGQuScZmNJOkfEmQ
         eJ+MYGS5lZqspe8ouUZgI3x42h8+R+dXSC77+7ebV30+45EUvB4Met6Hc5e2PRzfoWcW
         RWwA==
X-Gm-Message-State: AOAM5328DEw9LUKF1drUBE97BEn73sr8rZkQYGl8mqyTfnbmAq84ORoH
        DES/SUUh7Z+3sbV5ver7OGyxB+ftzqDXpp/s4CE14w==
X-Google-Smtp-Source: ABdhPJxIcRRhtZXhKjFg/Twt+0uxoC+Lb8/6VVNoDaqELQr9ZnABVR2MLDmqkQkwA+1HHVIGUKu9+IznAxkAvDhcArw=
X-Received: by 2002:adf:a390:: with SMTP id l16mr630649wrb.291.1633452678797;
 Tue, 05 Oct 2021 09:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210929224823.556943-1-rajatja@google.com> <20210929224823.556943-2-rajatja@google.com>
 <YVVLxi/on9x6nfCZ@kroah.com> <CACK8Z6EamamgYExt629gyNrYKpvnu2Gh0eGOOvOa5LH-jnOmaQ@mail.gmail.com>
 <20211005145655.GJ621017@rowland.harvard.edu>
In-Reply-To: <20211005145655.GJ621017@rowland.harvard.edu>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Tue, 5 Oct 2021 09:51:02 -0700
Message-ID: <CAE_wzQ-XG3YBtKTmbn1LSGETCUg5AYjTmcnwOnc1h57OaL9+Cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: hub: Mark devices downstream a removable hub, as removable
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        levinale@google.com, bleung@google.com, rajatxjain@gmail.com,
        jsbarnes@google.com, pmalani@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, Oct 5, 2021 at 7:56 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, Oct 04, 2021 at 03:42:46PM -0700, Rajat Jain wrote:
> > +Dmitry Torokhov
> >
> > Hi Greg, Oliver,
> >
> > Thanks for taking a look.
> >
> > On Wed, Sep 29, 2021 at 10:31 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Sep 29, 2021 at 03:48:23PM -0700, Rajat Jain wrote:
> > > > If a usb device sits below a removable hub, mark the device also as
> > > > removable. This helps with devices inserted on a standard removable hub or
> > > > also thunderbold docks, to be shown as removable.
> > > >
> > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > ---
> > > >  drivers/usb/core/hub.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > >
> > > Combined with the previous patch, you are now marking all devices that
> > > happen to be attached to a root hub that is on a thunderbolt controller
> > > as removable.  So all USB devices inside of a docking station are now
> > > removable?
> >
> > With this patch, yes that was my intent. I think what we are debating
> > here is should the "removable" attribute imply possibility of removal
> > from "the system" or just the "local immediate box" (e.g. thunderbolt
> > dock). In my mind, the removable property was analogous to imply an
> > "external device", i.e a device that may be removed from the system,
> > perhaps as a result of its parent devices being removed from the
> > system. I guess this definition doesn't match what you believe it
> > should be?
>
> As I understand it, the "removable" property refers specifically to
> the device's upstream link, not to whether _any_ of the links leading
> from the device to the computer could be removed.

No, that is not what it means. I'll cite our sysfs ABI:

What:           /sys/devices/.../removable
Date:           May 2021
Contact:        Rajat Jain <rajatxjain@gmail.com>
Description:
                Information about whether a given device can be removed from the
                platform by the user. This is determined by its subsystem in a
                bus / platform-specific way. This attribute is only present for
                devices that can support determining such information:

                "removable": device can be removed from the platform by the user
                "fixed":     device is fixed to the platform / cannot be removed
                             by the user.
                "unknown":   The information is unavailable / cannot be deduced.

                Currently this is only supported by USB (which infers the
                information from a combination of hub descriptor bits and
                platform-specific data such as ACPI) and PCI (which gets this
                from ACPI / device tree).

It specifically talks about _platform_, not about properties of some
peripheral attached to a system. Note that the wording is very similar
to what we had for USB devices that originally implemented "removable"
attribute:

>
> This is probably what Oliver meant when he complained about losing
> information.  With the knowledge of whether each individual link is
> removable, you can easily tell whether there's some way to remove a
> device from the system.  But if you only know whether the device is
> removable from the system overall, you generally can't tell whether
> the link to the device's parent is removable.

If we need this data then we need to establish some new attribute to
convey this info.

Thanks,
Dmitry
