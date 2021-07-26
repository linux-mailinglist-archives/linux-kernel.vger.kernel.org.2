Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232303D5477
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhGZG7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232483AbhGZG7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:59:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A7C1600D1;
        Mon, 26 Jul 2021 07:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627285173;
        bh=Lz22eR9Qxs3SEwlMtVJ4FCvrYRYfIXyQlcONvkYjjps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQUu4b11G3OBg8wS1deO28fSp9BLWmkNDHYnS9R0WGyD7rWPfpyFVhsaGIbIr/kM1
         GTZIRLCdZ84JaO/QVQhkQv6vr2fmK4MvEm8i3XoCPaqHn+ujAFxslOkOOsJIqWCRtj
         fQ2KsxWPykeHJOLxqC8zFi7OpuW5mg0LPAmPFXKw=
Date:   Mon, 26 Jul 2021 09:39:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkelshb@gmail.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] thunderbolt: For dev authorization changes, include the
 actual event in udev change notification
Message-ID: <YP5mrnaI1hyAU5Wp@kroah.com>
References: <20210723012835.1935471-1-rajatja@google.com>
 <YPpqJ6k5M3skTYdA@kroah.com>
 <CACK8Z6FXLY8p=15JbYp3x3QvTgeWhmrRb_ACyNr+tNe68MOstw@mail.gmail.com>
 <CACK8Z6EdBYWG7nv0ViumA72NK4h2G0cW9d2rn3BbHFTrLqhU-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6EdBYWG7nv0ViumA72NK4h2G0cW9d2rn3BbHFTrLqhU-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2021 at 11:46:32AM -0700, Rajat Jain wrote:
> Sorry, Had hit "Reply"" while responding, instead of "Reply All" - so
> it went only to Greg. Now added back everyone else.
> 
> 
> On Fri, Jul 23, 2021 at 4:43 PM Rajat Jain <rajatja@google.com> wrote:
> >
> > Hello,
> >
> >
> > On Fri, Jul 23, 2021 at 12:05 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Jul 22, 2021 at 06:28:34PM -0700, Rajat Jain wrote:
> > > > For security, we would like to monitor and track when the
> > > > thunderbolt devices are authorized and deauthorized. Currently
> > > > the userspace gets a udev change notification when there is a
> > > > change, but the state may have changed (again) by the time we
> > > > look at the authorized attribute in sysfs. So an authorization
> > > > event may go unnoticed. Thus make it easier by informing the
> > > > actual change (authorized/deauthorized) in the udev change
> > > > notification.
> > >
> > > We do have 72 columns to work with... :)
> >
> > Sorry, fixed now.
> >
> > >
> > > >
> > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > ---
> > > >  drivers/thunderbolt/switch.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> > > > index 83b1ef3d5d03..5d3e9dcba44a 100644
> > > > --- a/drivers/thunderbolt/switch.c
> > > > +++ b/drivers/thunderbolt/switch.c
> > > > @@ -1499,6 +1499,7 @@ static ssize_t authorized_show(struct device *dev,
> > > >  static int disapprove_switch(struct device *dev, void *not_used)
> > > >  {
> > > >       struct tb_switch *sw;
> > > > +     char *envp[] = { "AUTHORIZED=0", NULL };
> > > >
> > > >       sw = tb_to_switch(dev);
> > > >       if (sw && sw->authorized) {
> > > > @@ -1514,7 +1515,7 @@ static int disapprove_switch(struct device *dev, void *not_used)
> > > >                       return ret;
> > > >
> > > >               sw->authorized = 0;
> > > > -             kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> > > > +             kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
> > > >       }
> > > >
> > > >       return 0;
> > > > @@ -1523,6 +1524,8 @@ static int disapprove_switch(struct device *dev, void *not_used)
> > > >  static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
> > > >  {
> > > >       int ret = -EINVAL;
> > > > +     char envp_string[13];
> > > > +     char *envp[] = { envp_string, NULL };
> > > >
> > > >       if (!mutex_trylock(&sw->tb->lock))
> > > >               return restart_syscall();
> > > > @@ -1560,7 +1563,8 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
> > > >       if (!ret) {
> > > >               sw->authorized = val;
> > > >               /* Notify status change to the userspace */
> > > > -             kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> > > > +             sprintf(envp_string, "AUTHORIZED=%u", val);
> > > > +             kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
> > >
> > > So now "val" is a userspace visable value?  Is that documented anywhere
> > > what it is and what are you going to do to ensure it never changes in
> > > the future?
> > >
> > > Also this new value "field" should be documented somewhere as well,
> > > otherwise how will any tool know it is there?
> >
> > Sorry I should have clarified and elaborated (now done in the new
> > commit log). The field / value being exposed is that of the existing
> > sysfs attribute "authorized"
> > (/sys/bus/thunderbolt/devices/.../authorized), which is already
> > documented. I made it clearer in the commit log now. I looked at other
> > uses of kobject_uevent_env() and couldn't find examples of documenting
> > the Udev environment in Documentation/.

Perhaps a comment here showing that this is the same value as that
specific sysfs attribute as well?

> > > And what userspace tool will be looking for this?
> >
> > It will likely be a udev rule which will trigger a script when it see
> > device authorization change event. Something like this:
> > SUBSYSTEM=="thunderbolt", ACTION=="change", ENV{AUTHORIZED}=="1",
> > RUN+="alert.sh"
> >
> > However, now that I say it, is it possible to check for such (kernel
> > supplied) udev event environment key value pair, using
> > udev_device_get_property_value()? If so, that makes it very easy for
> > us, and the tool to use it would be Chromeos daemon called
> > cros_healthd.

It's been a long time since I last touched the udev codebase, sorry, try
it out yourself and see!

thanks,

greg k-h
