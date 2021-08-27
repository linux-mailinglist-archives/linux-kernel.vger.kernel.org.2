Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F713F94E9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbhH0HPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhH0HPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:15:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78AB660F5B;
        Fri, 27 Aug 2021 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630048457;
        bh=qrcqu6khz/oNNrbbJLXzcXuNnrVMH3an5CYyCW5I5VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAY7vaQObbsrxzuqp+RX7zgEHWa9M2/prE7QR06rBCqG+LNlUgFUA0E/HLLTnDGmS
         C1uLmyCHnChE15+z/zws6kqEZEnvwf11N/gimWRDDRubbuTsg8wwD0CLa1rrcOMQSs
         zgWXf37wMqBggZ61zZXc/kk0P/UJsiLJEsDxsLik=
Date:   Fri, 27 Aug 2021 09:14:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Woody Lin <woodylin@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] ANDROID: staging: add userpanic-dev driver
Message-ID: <YSiQxH5VehWoAcvO@kroah.com>
References: <20210826092854.58694-1-woodylin@google.com>
 <YSdjgnUwt76cknQ6@kroah.com>
 <CAHn4Deczc6gSSsxys6UeAMB99p1jHMZmLFj+KwZ2QhH7dx8E8w@mail.gmail.com>
 <YSdy1pAS1hkLVEH9@kroah.com>
 <CAHn4Dee0d+cdSmMCB4YVMp-9swo=0UQ5gm4kz43RVY11KFnM1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHn4Dee0d+cdSmMCB4YVMp-9swo=0UQ5gm4kz43RVY11KFnM1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 11:51:03AM +0800, Woody Lin wrote:
> On Thu, Aug 26, 2021 at 6:54 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 26, 2021 at 06:23:53PM +0800, Woody Lin wrote:
> > > On Thu, Aug 26, 2021 at 5:48 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Aug 26, 2021 at 05:28:54PM +0800, Woody Lin wrote:
> > > > > Add char device driver 'userpanic-dev' that exposes an interface to
> > > > > userspace processes to request a system panic with customized panic
> > > > > message.
> > > > >
> > > > > Signed-off-by: Woody Lin <woodylin@google.com>
> > > > > ---
> > > > >  drivers/staging/android/Kconfig         |  12 +++
> > > > >  drivers/staging/android/Makefile        |   1 +
> > > > >  drivers/staging/android/userpanic-dev.c | 110 ++++++++++++++++++++++++
> > > >
> > > > Why is this in staging?  What is wrong with it that it can not just go
> > > > into the real part of the kernel?  A TODO file is needed explaining what
> > > > needs to be done here in order for it to be accepted.
> > >
> > > Got it. No more TODO for this driver and I will move it to drivers/android/.
> > >
> > > >
> > > > But why is this really needed at all?  Why would userspace want to panic
> > > > the kernel in yet-another-way?
> > >
> > > The idea is to panic the kernel with a panic message specified by the userspace
> > > process requesting the panic. Without this the panic handler can only collect
> > > panic message "sysrq triggered crash" for a panic triggered by user processes.
> > > Using this driver, user processes can put an informative description -
> > > process name,
> > > reason ...etc. - to the panic message.
> >
> > What custom userspace tool is going to use this new user/kernel api and
> > again, why is it needed?  Who needs to panic the kernel with a custom
> > message and where is that used?
> 
> It's for Android's services. Currently there are usages like these:
> 
> * init requests panic in InitFatalReboot (abort handler).
> https://android.googlesource.com/platform/system/core/+/master/init/reboot_utils.cpp#170
>   android::base::WriteStringToFile("c", PROC_SYSRQ);
> 
> * llkd requests panic to recover kernel live-lock.
> https://android.googlesource.com/platform/system/core/+/master/llkd/libllkd.cpp#564
>   android::base::WriteStringToFd("c", sysrqTriggerFd);
> 
> * Watchdog requests panic to recover timeout-loop.
> https://android.googlesource.com/platform/frameworks/base/+/master/services/core/java/com/android/server/Watchdog.java#847
>   doSysRq('c');
> 
> So to improve the panic message from "sysrq triggered crash" to a more
> informative one (e.g.: "Watchdog break timeout-loop", "llkd panic
> live-lock"), we'd like to add this driver to expose a dedicated
> interface for userspace to panic the kernel with a custom message. Later
> the panic handler implemented per platform can collect the message and
> use it to build the crash report. A crash report with a more readable
> title (compared to the generic "sysrq triggered crash") will be easier
> to categorize, triage, etc.

But you can do that today from userspace, just write to the kernel log
before doing the sysrq call.  That way your tools can pick up what you
need later on, no kernel changes should be needed at all.

> And the reason to submit this to upstream, instead of making it a vendor
> module, is that we'd like to enable it for the early stage of "init", where
> none of the kernel module has been mounted.

Helps if it would actually build :(

thanks,

greg k-h
