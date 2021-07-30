Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28BE3DC1BC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 01:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhG3X4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 19:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhG3X4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:56:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA46AC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 16:56:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e5so12938888pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 16:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGMvOffBdoYIXnuZaEXKMaI0bhDyF8TwJALtJqSNt0Q=;
        b=T4BBwT2+qiPmLKFfCb3YI7lD6lYB54bCMYlevZQZ6ocsu0KU0jDt2CpIbntF2BA7Sm
         UZlp+0RZznBwpP+4McVcWGhJbQuZZ/6BG+Ly/rZiSIr6xFJj44JAEcurDn+U+0hIsN6b
         HIfR/GgEz0l4biKgaRG6SAvMV4EeJrO36SkOawZ50HyAvj2/TO+aLMi2dpi+tcS9J1dB
         t372ZtgvezPXJpRzdDcD1sm8TbH7I/jJJwioJGWZOu2pXYLOMcVdGYWXvZrGoNsPb5Fc
         6hkZswbBb9BxzcJ/KOFanotYnFm6tncBAxfI+dalcGhprWOO79EjcO4kIbk8PQlhUZtI
         4f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGMvOffBdoYIXnuZaEXKMaI0bhDyF8TwJALtJqSNt0Q=;
        b=SwIPNKQ3czR1OVYsFwimNHMH3O2XWi7xn9zozswG+6zpgbD4j8CBR8j/Z1X62kimnb
         vJQRoRVOkDZAnp6q4AKjG1tIeE3vdY+WoHUhg7ZIKJ5cGLWEmfBzuYs1SxqxmlDbFtyA
         LVXXUv5qCqp5jx2dfV2RpgD8n5uJkWJXRN5n8A/SsJ+vpx0QagOe41AhgHB3irp1PGk/
         BldqognzY5Q3TL1pjv3XW/4CCN6cO3Vw5dk796skenCdUSL3bdVTUcSZrR0p4lNjK4mH
         NEWHTghOi33bOcOVWX0b7M/n10KAH3MJitxBv7SQbQAg0R5qJJ1Wsx5Sk8P+CFW5+NZn
         gPUQ==
X-Gm-Message-State: AOAM533SbfBo7RP0b6QqWDMYHwG0Ox7SHfoUClA/XfaCN0KLoLH1Fshb
        4BG7h2nI6jHLQwoiHpDdNI+cw+i0J46jI6QIMkOgLA==
X-Google-Smtp-Source: ABdhPJxtT8TjaY5rXky7eiem9DUDlsd2YZeuJtzpgGcHqfV7329Res4p7rsCUFte3NvEj+Wu4GFIx3tNv8W3OUDToiA=
X-Received: by 2002:a65:50cb:: with SMTP id s11mr4512542pgp.236.1627689370053;
 Fri, 30 Jul 2021 16:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210724004043.2075819-1-rajatja@google.com> <CACK8Z6GsNi9FVUdqdfj0vUFj0mJtMQ_pm4aPH8d3ozsa5Zswhg@mail.gmail.com>
 <YP67VTcyFhro9wyX@lahna>
In-Reply-To: <YP67VTcyFhro9wyX@lahna>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 30 Jul 2021 16:55:34 -0700
Message-ID: <CACK8Z6GAZrk1XLamVp1Rh2uLYjfmaprAj==D4KR190Jp4dn5wg@mail.gmail.com>
Subject: Re: [PATCH v2] thunderbolt: For dev authorization changes, include
 the actual event in udev change notification
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkelshb@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 6:40 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Rajat,
>
> On Fri, Jul 23, 2021 at 05:41:58PM -0700, Rajat Jain wrote:
> > (fixing the typo in the email ID for Greg).
> >
> > On Fri, Jul 23, 2021 at 5:40 PM Rajat Jain <rajatja@google.com> wrote:
> > >
> > > For security, we would like to monitor and track when the thunderbolt
> > > devices are authorized and deauthorized (i.e. when the thunderbolt sysfs
> > > "authorized" attribute changes). Currently the userspace gets a udev
> > > change notification when there is a change, but the state may have
> > > changed (again) by the time we look at the authorized attribute in
> > > sysfs. So an authorization event may go unnoticed. Thus make it easier
> > > by informing the actual change (new value of authorized attribute) in
> > > the udev change notification.
> > >
> > > The change is included as a key value "authorized=<val>" where <val>
> > > is the new value of sysfs attribute "authorized", and is described at
> > > Documentation/ABI/testing/sysfs-bus-thunderbolt under
> > > /sys/bus/thunderbolt/devices/.../authorized
>
> Looking good, a couple of minor nits below.
>
> > >
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > ---
> > >  drivers/thunderbolt/switch.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> > > index 83b1ef3d5d03..382128dfbdee 100644
> > > --- a/drivers/thunderbolt/switch.c
> > > +++ b/drivers/thunderbolt/switch.c
> > > @@ -1499,6 +1499,7 @@ static ssize_t authorized_show(struct device *dev,
> > >  static int disapprove_switch(struct device *dev, void *not_used)
> > >  {
> > >         struct tb_switch *sw;
> > > +       char *envp[] = { "AUTHORIZED=0", NULL };
>
> Can you move arrange this to be before sw, like:

Done.

>
>         char *envp[] = { "AUTHORIZED=0", NULL };
>         struct tb_switch *sw;
>
> > >
> > >         sw = tb_to_switch(dev);
> > >         if (sw && sw->authorized) {
> > > @@ -1514,7 +1515,7 @@ static int disapprove_switch(struct device *dev, void *not_used)
> > >                         return ret;
> > >
> > >                 sw->authorized = 0;
> > > -               kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> > > +               kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
> > >         }
> > >
> > >         return 0;
> > > @@ -1523,6 +1524,8 @@ static int disapprove_switch(struct device *dev, void *not_used)
> > >  static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
> > >  {
> > >         int ret = -EINVAL;
> > > +       char envp_string[13];
> > > +       char *envp[] = { envp_string, NULL };
>
> Ditto.

Done. I still needed to define envp_string before envp (because it is
used in initialization).

I sent out a v3 with these changes.

Thanks,

Rajat

>
> > >
> > >         if (!mutex_trylock(&sw->tb->lock))
> > >                 return restart_syscall();
> > > @@ -1560,7 +1563,8 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
> > >         if (!ret) {
> > >                 sw->authorized = val;
> > >                 /* Notify status change to the userspace */
> > > -               kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> > > +               sprintf(envp_string, "AUTHORIZED=%u", sw->authorized);
> > > +               kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
> > >         }
> > >
> > >  unlock:
> > > --
> > > 2.32.0.432.gabb21c7263-goog
> > >
