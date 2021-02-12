Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A2C319892
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 04:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhBLDFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 22:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhBLDFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 22:05:45 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084CCC061786
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 19:05:04 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id k4so7749516ybp.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 19:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umGRLg+1wx6Dct4xi++63waA6bhM8DuWO/MBgfuP+to=;
        b=lsYcskdEfrp1rxwOSLfMqivVJo7Eb/oCK4ZrFyXldZVxt+imnfC2bhNK2sjF2ipVpu
         zrz+ZBYcBg8XtdfcB4ufK2WQ+WoHHBIWzPYtmClrGYWKdN5myUty6b5PVtlqHBnkjhHh
         jn3gUCXdspQAlsvVxDpLat72A9XXVYoqYP1Sq6UvQcSp2JD9pOXbEtpzLQ/5iSs0rNt1
         XEHSysOyNIjyhN/usLmg7Mee3yeyEU9qB7SSkCEYwGCtZPQeKKuISp66qKABB/n9rqub
         OA37bViFiHQm6uBKIRutBZMytB6oZPHDrsdJt3aSTPq7l+adm+bXfmphTKeu5Hzmj14z
         6ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umGRLg+1wx6Dct4xi++63waA6bhM8DuWO/MBgfuP+to=;
        b=EqL1xpaYbqqNLpYYXZfsmIP8D5aE7Rlquts7yVwgaye47+Yladt9ZsWodr1lQGFpda
         Q0YJIUjCdf93hUAV/J07pCigDFzGVZyyNlzUiL47yULXMXZgGi0o1XYVDEbb3+FZzIkH
         VHcy6HOPibDN7vYZmLSvVnjrDNe33DWy2UaHdnkDzSvoqHKPB4aIDeQW4RaSpREPwc77
         Ux07+tX547avrPawWyyD6FmXRh22Efb8kcyhVd+lsLIN2A90nxpqZdf0xueFaMHZlXqh
         w41o6rXs0sCNzDk1H7dYWcOQT1VyXd1mp1GNFs3zi09/VkIA6xJpUsvCKsB4fmRUfjQw
         jaVw==
X-Gm-Message-State: AOAM531Cv+4dGVdZTOe+xa/Wf9NrhwwkHUI7SWncVwZ3UEmZ6DD08JBZ
        3X+6xlldny1v4Swb2dntvSQ1pDx/75zjpS2NdrKY+1+5Tko=
X-Google-Smtp-Source: ABdhPJwbFxKsHdBt5t1veT/tIV3pPie1EclgzZtn0vZznGL3ATsg54MPxKEJCSIDP2nRsDk86HDxpF/SC6W+cofl9Eo=
X-Received: by 2002:a25:8b8b:: with SMTP id j11mr1225200ybl.310.1613099103994;
 Thu, 11 Feb 2021 19:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <56f7d032-ba5a-a8c7-23de-2969d98c527e@nvidia.com> <CAGETcx9FAAa+gUOTJX76DGGOAE4g3cTbZhwNQ-pLioYzg=fTOw@mail.gmail.com>
 <17939709-f6f4-fa9c-836f-9779081c4087@nvidia.com> <CAGETcx_1x7LFprsEM+-X8Y42-sbajBav5Bik4U=s4Z5XCSZtUg@mail.gmail.com>
 <e11bc6a2-ec9d-ea3b-71f7-13c9f764bbfc@nvidia.com> <6a43e209-1d2d-b10a-4564-0289d54135d3@nvidia.com>
 <CAGETcx9ZaBLRVPqiSkPf_4Tm5dDLNbLBM2RmHk1jr7yLp_1CCQ@mail.gmail.com>
 <CAJZ5v0iv9fRzM8cbGrPhutPNpod-gLWcZ8fWzDpfJ=NUVmm5Og@mail.gmail.com>
 <CAGETcx9qA-nq01ojfP73UJ0KjJCxd3Qhes0hatQGzNKYxuUj-w@mail.gmail.com> <CAJZ5v0g+cd_r=UzzEXAQAqVnVyN3czv4WCyBib5=e2a4X53VNA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g+cd_r=UzzEXAQAqVnVyN3czv4WCyBib5=e2a4X53VNA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 11 Feb 2021 19:04:28 -0800
Message-ID: <CAGETcx-RWyNgdyZ77i_7wQ8U2bCYQ7i0M5xswK-3iJ8PPWPW5w@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 9:48 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 11, 2021 at 6:15 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Feb 11, 2021 at 7:03 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Feb 11, 2021 at 1:02 AM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Thu, Jan 28, 2021 at 7:03 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> > > > >
> > > > >
> > > > > On 14/01/2021 16:56, Jon Hunter wrote:
> > > > > >
> > > > > > On 14/01/2021 16:47, Saravana Kannan wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > >>> Yes this is the warning shown here [0] and this is coming from
> > > > > >>> the 'Generic PHY stmmac-0:00' device.
> > > > > >>
> > > > > >> Can you print the supplier and consumer device when this warning is
> > > > > >> happening and let me know? That'd help too. I'm guessing the phy is
> > > > > >> the consumer.
> > > > > >
> > > > > >
> > > > > > Sorry I should have included that. I added a print to dump this on
> > > > > > another build but failed to include here.
> > > > > >
> > > > > > WARNING KERN Generic PHY stmmac-0:00: supplier 2200000.gpio (status 1)
> > > > > >
> > > > > > The status is the link->status and looks like the supplier is the
> > > > > > gpio controller. I have verified that the gpio controller is probed
> > > > > > before this successfully.
> > > > > >
> > > > > >> So the warning itself isn't a problem -- it's not breaking anything or
> > > > > >> leaking memory or anything like that. But the device link is jumping
> > > > > >> states in an incorrect manner. With enough context of this code (why
> > > > > >> the device_bind_driver() is being called directly instead of going
> > > > > >> through the normal probe path), it should be easy to fix (I'll just
> > > > > >> need to fix up the device link state).
> > > > > >
> > > > > > Correct, the board seems to boot fine, we just get this warning.
> > > > >
> > > > >
> > > > > Have you had chance to look at this further?
> > > >
> > > > Hi Jon,
> > > >
> > > > I finally got around to looking into this. Here's the email[1] that
> > > > describes why it's done this way.
> > > >
> > > > [1] - https://lore.kernel.org/lkml/YCRjmpKjK0pxKTCP@lunn.ch/
> > > >
> > > > >
> > > > > The following does appear to avoid the warning, but I am not sure if
> > > > > this is the correct thing to do ...
> > > > >
> > > > > index 9179825ff646..095aba84f7c2 100644
> > > > > --- a/drivers/base/dd.c
> > > > > +++ b/drivers/base/dd.c
> > > > > @@ -456,6 +456,10 @@ int device_bind_driver(struct device *dev)
> > > > >  {
> > > > >         int ret;
> > > > >
> > > > > +       ret = device_links_check_suppliers(dev);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > >         ret = driver_sysfs_add(dev);
> > > > >         if (!ret)
> > > > >                 driver_bound(dev);
> > > >
> > > > So digging deeper into the usage of device_bind_driver and looking at
> > > > [1], it doesn't look like returning an error here is a good option.
> > > > When device_bind_driver() is called, the driver's probe function isn't
> > > > even called. So, there's no way for the driver to even defer probing
> > > > based on any of the suppliers. So, we have a couple of options:
> > > >
> > > > 1. Delete all the links to suppliers that haven't bound.
> > >
> > > Or maybe convert them to stateless links?  Would that be doable at all?
> >
> > Yeah, I think it should be doable.
> >
> > >
> > > > We'll still leave the links to active suppliers alone in case it helps with
> > > > suspend/resume correctness.
> > > > 2. Fix the warning to not warn on suppliers that haven't probed if the
> > > > device's driver has no probe function. But this will also need fixing
> > > > up the cleanup part when device_release_driver() is called. Also, I'm
> > > > not sure if device_bind_driver() is ever called when the driver
> > > > actually has a probe() function.
> > > >
> > > > Rafael,
> > > >
> > > > Option 1 above is pretty straightforward.
> > >
> > > I would prefer this ->
> >
> > Ok
> >
> > >
> > > > Option 2 would look something like what's at the end of this email +
> > > > caveat about whether the probe check is sufficient.
> > >
> > > -> because "fix the warning" really means that we haven't got the
> > > device link state machine right and getting it right may imply a major
> > > redesign.
> > >
> > > Overall, I'd prefer to take a step back and allow things to stabilize
> > > for a while to let people catch up with this.
> >
> > Are you referring to if/when we implement Option 2? Or do you want to
> > step back for a while even before implementing Option 1?
>
> I would do option 1 and if then see what happens and maybe go back
> from there if need be until getting a reasonably stable situation
> (that is all of the systems that used to work before still work at
> least).

Ok, I'll implement Option 1 soon. Also, thinking more about it, I
don't like converting it into STATELESS links. It's easy to do, but it
doesn't feel right for the driver core to "create" a STATELESS link
and then "forget" about it. So, when a device is force bound, I'll
just delete the links where the suppliers haven't probed yet.

-Saravana
