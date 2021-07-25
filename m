Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF173D4F8E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 20:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhGYSGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 14:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhGYSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 14:06:41 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4036FC061760
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 11:47:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l4so8504444ljq.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dMobSfRHYbBWRl4NVdimPbb8fzSNZf3DH5Ga5CsdP9A=;
        b=kofqxs3IcH4r80Mh3VhgS17F6onJlEBLQsXvccZRkpAGoQj6UEXsEy2ywe5eGdREOy
         pavfTVf0qTu6CNMNihtymfWzlDuq60oLr4bb2l3p7cZojDlaafWY4Rz+X5qfYwy0IgaS
         +gRUnN+B3ArdxWFZxZQVwZY0bIRwaS6Al/gMdBw8RiQKA2lMVxta1lZhtAknSQFNUkYQ
         grej9h0SzYh5fntuFr/SZblKXy8ByyDlTqc1bUaOBFv0cCGmnAz81dAnY/zTBnT/WJX9
         U1shyXqlXjgKNxGM232HJ1iQH6pJZONt3IMU+/kX59qkfX5zJmjj7nJstIG2sl2vPWDS
         wPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dMobSfRHYbBWRl4NVdimPbb8fzSNZf3DH5Ga5CsdP9A=;
        b=J25C8+JiRwBYM8AuhtWYh0ohTivfGT3ZHopHF3+kLtHtpX1+A612qzbv/5+7svwHb2
         GEMOQOpFrxnhKg4l+GZIU6R5FZnckbIo3Cpn8E/AsR97afHvKEFD20QnRRu0m5yMBwxh
         rTxRb3qFJDBSTUHcsF1E0/6TLoOonmii0pXEgAqVFn9axv48TBhkEsiaV8Jefnsadzde
         1vJ+qlSTWNG4R6fQA8eFhitBbhg96ckVdUiNLQ9DD5Vk0RVOgv8e/OHfk4qK6rT880hP
         dICaCy4bP+/hrIz5l6Njz4VGnXKjDsWsNmapDs76PkyWe4JYyUk/lEKfjSy3HTYTv2mK
         wBjQ==
X-Gm-Message-State: AOAM532mRvLbYbnJGwx4KIJwteaHvUJieqHGrMgQzrhhd1cgHBJLpKmI
        l/oHRtnVIeeEbDUEeGzm25GRBSw46nkHWBx3fQIwQA==
X-Google-Smtp-Source: ABdhPJyaQUhZXeVKxo2rypW+WiKWhPSHjT17vEfE2fB3aZvRU5bRyYzgAJDv7mKrN8A0xdfgcpRVPdM/qiIRUAAJeZ8=
X-Received: by 2002:a2e:8909:: with SMTP id d9mr9764014lji.65.1627238828055;
 Sun, 25 Jul 2021 11:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210723012835.1935471-1-rajatja@google.com> <YPpqJ6k5M3skTYdA@kroah.com>
 <CACK8Z6FXLY8p=15JbYp3x3QvTgeWhmrRb_ACyNr+tNe68MOstw@mail.gmail.com>
In-Reply-To: <CACK8Z6FXLY8p=15JbYp3x3QvTgeWhmrRb_ACyNr+tNe68MOstw@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Sun, 25 Jul 2021 11:46:32 -0700
Message-ID: <CACK8Z6EdBYWG7nv0ViumA72NK4h2G0cW9d2rn3BbHFTrLqhU-g@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: For dev authorization changes, include the
 actual event in udev change notification
To:     Greg KH <gregkh@linuxfoundation.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkelshb@gmail.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, Had hit "Reply"" while responding, instead of "Reply All" - so
it went only to Greg. Now added back everyone else.


On Fri, Jul 23, 2021 at 4:43 PM Rajat Jain <rajatja@google.com> wrote:
>
> Hello,
>
>
> On Fri, Jul 23, 2021 at 12:05 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 22, 2021 at 06:28:34PM -0700, Rajat Jain wrote:
> > > For security, we would like to monitor and track when the
> > > thunderbolt devices are authorized and deauthorized. Currently
> > > the userspace gets a udev change notification when there is a
> > > change, but the state may have changed (again) by the time we
> > > look at the authorized attribute in sysfs. So an authorization
> > > event may go unnoticed. Thus make it easier by informing the
> > > actual change (authorized/deauthorized) in the udev change
> > > notification.
> >
> > We do have 72 columns to work with... :)
>
> Sorry, fixed now.
>
> >
> > >
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > ---
> > >  drivers/thunderbolt/switch.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> > > index 83b1ef3d5d03..5d3e9dcba44a 100644
> > > --- a/drivers/thunderbolt/switch.c
> > > +++ b/drivers/thunderbolt/switch.c
> > > @@ -1499,6 +1499,7 @@ static ssize_t authorized_show(struct device *dev,
> > >  static int disapprove_switch(struct device *dev, void *not_used)
> > >  {
> > >       struct tb_switch *sw;
> > > +     char *envp[] = { "AUTHORIZED=0", NULL };
> > >
> > >       sw = tb_to_switch(dev);
> > >       if (sw && sw->authorized) {
> > > @@ -1514,7 +1515,7 @@ static int disapprove_switch(struct device *dev, void *not_used)
> > >                       return ret;
> > >
> > >               sw->authorized = 0;
> > > -             kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> > > +             kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
> > >       }
> > >
> > >       return 0;
> > > @@ -1523,6 +1524,8 @@ static int disapprove_switch(struct device *dev, void *not_used)
> > >  static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
> > >  {
> > >       int ret = -EINVAL;
> > > +     char envp_string[13];
> > > +     char *envp[] = { envp_string, NULL };
> > >
> > >       if (!mutex_trylock(&sw->tb->lock))
> > >               return restart_syscall();
> > > @@ -1560,7 +1563,8 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
> > >       if (!ret) {
> > >               sw->authorized = val;
> > >               /* Notify status change to the userspace */
> > > -             kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> > > +             sprintf(envp_string, "AUTHORIZED=%u", val);
> > > +             kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
> >
> > So now "val" is a userspace visable value?  Is that documented anywhere
> > what it is and what are you going to do to ensure it never changes in
> > the future?
> >
> > Also this new value "field" should be documented somewhere as well,
> > otherwise how will any tool know it is there?
>
> Sorry I should have clarified and elaborated (now done in the new
> commit log). The field / value being exposed is that of the existing
> sysfs attribute "authorized"
> (/sys/bus/thunderbolt/devices/.../authorized), which is already
> documented. I made it clearer in the commit log now. I looked at other
> uses of kobject_uevent_env() and couldn't find examples of documenting
> the Udev environment in Documentation/.
>
> >
> > And what userspace tool will be looking for this?
>
> It will likely be a udev rule which will trigger a script when it see
> device authorization change event. Something like this:
> SUBSYSTEM=="thunderbolt", ACTION=="change", ENV{AUTHORIZED}=="1",
> RUN+="alert.sh"
>
> However, now that I say it, is it possible to check for such (kernel
> supplied) udev event environment key value pair, using
> udev_device_get_property_value()? If so, that makes it very easy for
> us, and the tool to use it would be Chromeos daemon called
> cros_healthd.
>
> Thanks,
>
> Rajat
>
> >
> > thanks,
> >
> > greg k-h
