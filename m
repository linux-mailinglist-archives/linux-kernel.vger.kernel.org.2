Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5FC3F9348
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 05:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbhH0DwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 23:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbhH0DwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 23:52:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63DFC0611C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 20:51:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p38so11666158lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 20:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inTQ6tazFaF4bvjhOnspVyUwS2KREEgp4ab3cX5P6fU=;
        b=S8VtJSlqFVoLo2B4SvZzc0CvwIfroqHAIGDWD9apVBSn+UM7iSed0ytHJUN0/y45Eq
         9pkWRGjFbpubhUV7yOxdGWbjUYMs0prdvPqfGnqx6z2/0CbLO/UqCOX9JqqMfvbDX06Y
         k0lgQIm9wM7peAAqlQvpEzSRQuJUS/moFmWcnEUj4fGfmkmO6W8NqkuykNIMNImWU+P6
         t04tNEfiuOnRBXj6+o6YFOxZdzStWg5N2p3a9ZHulnPciHTLsWbMF5BF96a6abxFMAXa
         rxhL0TOJVQKfCH9r3aXJ/EgJxcuIl2TEvOPi3X6buFmONNHr8M2fZU5YdpBIoJ3KP2Kc
         MWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inTQ6tazFaF4bvjhOnspVyUwS2KREEgp4ab3cX5P6fU=;
        b=G43cP46mXK1TiKFNltG2K5FeqdtVsZvY2C2XVTgDZ96Mxh02AXB8QSTyLJcIDiWGEX
         rsZWiXAvV8Y7ipAQbLPbE0EE8F+JP8+ieanosI0TEnf3hFdVer44wtKp/tNhw7SkvLaH
         rDahSGsE+yhmA1o0ej9M79rgnnCLJ6vvu5mNOr0Y5mKc0+5k43IIWCJkV2z7q6ayLjcy
         vrcSMmiGq5yF05TgG/g4jd3JuqgJ+BYAQmhExmH5ZGKM6J/FO1LjCMf/RZ3pjh5ucUu3
         /qgYIDaloORDivdEPVIUqJSSBpaayfH7P+5CC1S9kA04DEads4YU6ArgtFMDhxsFdNaL
         LqLg==
X-Gm-Message-State: AOAM532zLBNwwQiAtk7A7WMBdyC8XfMQyzJMG4E/F6HNwWci21/wSPZX
        Qfcz9OWMEi+H/aUA+Hv4uqpl2H0rvoHc0m/AYGL/Lg==
X-Google-Smtp-Source: ABdhPJzemFkSoczzSTPaKMxMZwM/QKdXBeaqfgLGupOqbF+ZOv32LK6+hl68qhagApwWjCao+pDt0TZC0/rVdacdWXs=
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr5332672lfg.162.1630036274307;
 Thu, 26 Aug 2021 20:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210826092854.58694-1-woodylin@google.com> <YSdjgnUwt76cknQ6@kroah.com>
 <CAHn4Deczc6gSSsxys6UeAMB99p1jHMZmLFj+KwZ2QhH7dx8E8w@mail.gmail.com> <YSdy1pAS1hkLVEH9@kroah.com>
In-Reply-To: <YSdy1pAS1hkLVEH9@kroah.com>
From:   Woody Lin <woodylin@google.com>
Date:   Fri, 27 Aug 2021 11:51:03 +0800
Message-ID: <CAHn4Dee0d+cdSmMCB4YVMp-9swo=0UQ5gm4kz43RVY11KFnM1w@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: staging: add userpanic-dev driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 6:54 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 26, 2021 at 06:23:53PM +0800, Woody Lin wrote:
> > On Thu, Aug 26, 2021 at 5:48 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Aug 26, 2021 at 05:28:54PM +0800, Woody Lin wrote:
> > > > Add char device driver 'userpanic-dev' that exposes an interface to
> > > > userspace processes to request a system panic with customized panic
> > > > message.
> > > >
> > > > Signed-off-by: Woody Lin <woodylin@google.com>
> > > > ---
> > > >  drivers/staging/android/Kconfig         |  12 +++
> > > >  drivers/staging/android/Makefile        |   1 +
> > > >  drivers/staging/android/userpanic-dev.c | 110 ++++++++++++++++++++++++
> > >
> > > Why is this in staging?  What is wrong with it that it can not just go
> > > into the real part of the kernel?  A TODO file is needed explaining what
> > > needs to be done here in order for it to be accepted.
> >
> > Got it. No more TODO for this driver and I will move it to drivers/android/.
> >
> > >
> > > But why is this really needed at all?  Why would userspace want to panic
> > > the kernel in yet-another-way?
> >
> > The idea is to panic the kernel with a panic message specified by the userspace
> > process requesting the panic. Without this the panic handler can only collect
> > panic message "sysrq triggered crash" for a panic triggered by user processes.
> > Using this driver, user processes can put an informative description -
> > process name,
> > reason ...etc. - to the panic message.
>
> What custom userspace tool is going to use this new user/kernel api and
> again, why is it needed?  Who needs to panic the kernel with a custom
> message and where is that used?

It's for Android's services. Currently there are usages like these:

* init requests panic in InitFatalReboot (abort handler).
https://android.googlesource.com/platform/system/core/+/master/init/reboot_utils.cpp#170
  android::base::WriteStringToFile("c", PROC_SYSRQ);

* llkd requests panic to recover kernel live-lock.
https://android.googlesource.com/platform/system/core/+/master/llkd/libllkd.cpp#564
  android::base::WriteStringToFd("c", sysrqTriggerFd);

* Watchdog requests panic to recover timeout-loop.
https://android.googlesource.com/platform/frameworks/base/+/master/services/core/java/com/android/server/Watchdog.java#847
  doSysRq('c');

So to improve the panic message from "sysrq triggered crash" to a more
informative one (e.g.: "Watchdog break timeout-loop", "llkd panic
live-lock"), we'd like to add this driver to expose a dedicated
interface for userspace to panic the kernel with a custom message. Later
the panic handler implemented per platform can collect the message and
use it to build the crash report. A crash report with a more readable
title (compared to the generic "sysrq triggered crash") will be easier
to categorize, triage, etc.

And the reason to submit this to upstream, instead of making it a vendor
module, is that we'd like to enable it for the early stage of "init", where
none of the kernel module has been mounted.

>
> thanks,
>
> greg k-h

Regards,
Woody
