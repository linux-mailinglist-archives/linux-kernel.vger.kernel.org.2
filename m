Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3503FD607
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbhIAI5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbhIAI5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:57:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EF8C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 01:56:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id d16so3637564ljq.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RkP4boPB+hwm43igbyjeBM2G7tQ31bVoeCGcwryyz0=;
        b=t46HYZlq1rIsGdLMNDoBKZWl/E8RXSUWcuDx79JwCq4iW/EDBXUGSOa6t9becNEhH6
         EJuBZc9hszqF9s15MyIJnQENEre/JyXTZc66MW/1oCbgBncTlMcsluJYAhUBitmboJUB
         6Ycl0BcBsfloU3YN1FmoBmLBoS6B4P6fwBKyAz56T5IxTTPNq478rnenDRKbWuEd7lTj
         66Bl9QbPKTdm0tQs1gcREbbNCmIe0sW/8vEfCKOWCsbJd4tgzRP2nGjHLJh4k9vIshQS
         WAHcnBscC3oqkosnnp7hfgeVzCIRmxZLSUpRGSj/Z3/6bQpToQJIC+RDlyvhFH2XEpFg
         MUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RkP4boPB+hwm43igbyjeBM2G7tQ31bVoeCGcwryyz0=;
        b=imARHrFsb8uAL9IP+s6YQrMyZ4L0XnAH63ANFI/mx/6N7pVxHmZ0/AdH6l6Xujsq4q
         WYBmTGOCALHiPH//T2zGeIEEFLNIyBz9ghY6uIM55+gAUvZGNVFoV2GFnHsYtcCLSH+5
         W0uxmlH1f9Y1K9Idl0XtlXaujl0orANoLkhDr6V1gfjZUmibO4f4sRvKnZZfH7IG8aXg
         yaNH5K3lCPXHGiPjvX9u+kn7yYeCnVYahPJHlm9OSJyKJkhI9BlL18ByiCH+VDT/ztHP
         guy2srRERVbTN3uYTSSktT7UitI+dBnEik7lGw92yW9nUuLzmWEBU69dNpThfZt4eXYH
         aIZg==
X-Gm-Message-State: AOAM530zSKDy8PFwS7FETS1+nv2HUsn8vct1R2ObSrDVwcZG6+8WLsrT
        NxVilVYemBqoyF2UIXLPcAtjjw0HMVlc8w2ft7en2g==
X-Google-Smtp-Source: ABdhPJzOLrom9w8R6tPJaewkr7Uo8YA704UR65WrPfKGn9ty9MGKcizq1Pva3OHpUhkOy7JekGI5W9f/nx7oj+qmp3c=
X-Received: by 2002:a05:651c:3d9:: with SMTP id f25mr27885067ljp.334.1630486572194;
 Wed, 01 Sep 2021 01:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210826092854.58694-1-woodylin@google.com> <YSdjgnUwt76cknQ6@kroah.com>
 <CAHn4Deczc6gSSsxys6UeAMB99p1jHMZmLFj+KwZ2QhH7dx8E8w@mail.gmail.com>
 <YSdy1pAS1hkLVEH9@kroah.com> <CAHn4Dee0d+cdSmMCB4YVMp-9swo=0UQ5gm4kz43RVY11KFnM1w@mail.gmail.com>
 <YSiQxH5VehWoAcvO@kroah.com>
In-Reply-To: <YSiQxH5VehWoAcvO@kroah.com>
From:   Woody Lin <woodylin@google.com>
Date:   Wed, 1 Sep 2021 16:56:00 +0800
Message-ID: <CAHn4DeeTwCs0v8G8deLFzeoKFE=bNe3LFTG6ZAXT1YGNu-YCaw@mail.gmail.com>
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

On Fri, Aug 27, 2021 at 3:14 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 27, 2021 at 11:51:03AM +0800, Woody Lin wrote:
> > On Thu, Aug 26, 2021 at 6:54 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Aug 26, 2021 at 06:23:53PM +0800, Woody Lin wrote:
> > > > On Thu, Aug 26, 2021 at 5:48 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Aug 26, 2021 at 05:28:54PM +0800, Woody Lin wrote:
> > > > > > Add char device driver 'userpanic-dev' that exposes an interface to
> > > > > > userspace processes to request a system panic with customized panic
> > > > > > message.
> > > > > >
> > > > > > Signed-off-by: Woody Lin <woodylin@google.com>
> > > > > > ---
> > > > > >  drivers/staging/android/Kconfig         |  12 +++
> > > > > >  drivers/staging/android/Makefile        |   1 +
> > > > > >  drivers/staging/android/userpanic-dev.c | 110 ++++++++++++++++++++++++
> > > > >
> > > > > Why is this in staging?  What is wrong with it that it can not just go
> > > > > into the real part of the kernel?  A TODO file is needed explaining what
> > > > > needs to be done here in order for it to be accepted.
> > > >
> > > > Got it. No more TODO for this driver and I will move it to drivers/android/.
> > > >
> > > > >
> > > > > But why is this really needed at all?  Why would userspace want to panic
> > > > > the kernel in yet-another-way?
> > > >
> > > > The idea is to panic the kernel with a panic message specified by the userspace
> > > > process requesting the panic. Without this the panic handler can only collect
> > > > panic message "sysrq triggered crash" for a panic triggered by user processes.
> > > > Using this driver, user processes can put an informative description -
> > > > process name,
> > > > reason ...etc. - to the panic message.
> > >
> > > What custom userspace tool is going to use this new user/kernel api and
> > > again, why is it needed?  Who needs to panic the kernel with a custom
> > > message and where is that used?
> >
> > It's for Android's services. Currently there are usages like these:
> >
> > * init requests panic in InitFatalReboot (abort handler).
> > https://android.googlesource.com/platform/system/core/+/master/init/reboot_utils.cpp#170
> >   android::base::WriteStringToFile("c", PROC_SYSRQ);
> >
> > * llkd requests panic to recover kernel live-lock.
> > https://android.googlesource.com/platform/system/core/+/master/llkd/libllkd.cpp#564
> >   android::base::WriteStringToFd("c", sysrqTriggerFd);
> >
> > * Watchdog requests panic to recover timeout-loop.
> > https://android.googlesource.com/platform/frameworks/base/+/master/services/core/java/com/android/server/Watchdog.java#847
> >   doSysRq('c');
> >
> > So to improve the panic message from "sysrq triggered crash" to a more
> > informative one (e.g.: "Watchdog break timeout-loop", "llkd panic
> > live-lock"), we'd like to add this driver to expose a dedicated
> > interface for userspace to panic the kernel with a custom message. Later
> > the panic handler implemented per platform can collect the message and
> > use it to build the crash report. A crash report with a more readable
> > title (compared to the generic "sysrq triggered crash") will be easier
> > to categorize, triage, etc.
>
> But you can do that today from userspace, just write to the kernel log
> before doing the sysrq call.  That way your tools can pick up what you
> need later on, no kernel changes should be needed at all.

Thanks for the idea. I actually need it in panic message because in our
platforms, the message is saved in a specific buffer that can be
accessed by a crash handler (not running in the same execution level as
Linux) which is also used to build crash reports. So parsing log buffer
can be too complex for it when compared to reading from the dedicated
buffer. But I understand this may not be a good reason to phase in
interfaces like this to the kernel? If so, I am starting from building it as
a vendor module and giving up covering the early stage of "init" for now.

And also thanks for the suggestions on the patch, I will revise them
accordingly when submitting it to the internal kernel modules repo.

>
> > And the reason to submit this to upstream, instead of making it a vendor
> > module, is that we'd like to enable it for the early stage of "init", where
> > none of the kernel module has been mounted.
>
> Helps if it would actually build :(
>
> thanks,
>
> greg k-h
