Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82213F85E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbhHZKzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234296AbhHZKzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:55:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A207160FC1;
        Thu, 26 Aug 2021 10:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629975258;
        bh=3COvzkeM/l1x3SVib6kbANwKzq1rzz8/bNWnK5LJTh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OjjbqPrErjAAwn/gK0egjwHkX1sjV9lqg3PgbElLuWvQZ/vtg3onfAeeqjepK+Jwk
         IxkzDexi1m+XzGInKdti3lY4O1igyftWtPppa4u2dZHvFNwFDfrJn8jKu4lLLiLY3w
         UoQwkqbfKGIxIWM+dcHdUv635O9ta7UMdSCEmbgU=
Date:   Thu, 26 Aug 2021 12:54:14 +0200
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
Message-ID: <YSdy1pAS1hkLVEH9@kroah.com>
References: <20210826092854.58694-1-woodylin@google.com>
 <YSdjgnUwt76cknQ6@kroah.com>
 <CAHn4Deczc6gSSsxys6UeAMB99p1jHMZmLFj+KwZ2QhH7dx8E8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHn4Deczc6gSSsxys6UeAMB99p1jHMZmLFj+KwZ2QhH7dx8E8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 06:23:53PM +0800, Woody Lin wrote:
> On Thu, Aug 26, 2021 at 5:48 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 26, 2021 at 05:28:54PM +0800, Woody Lin wrote:
> > > Add char device driver 'userpanic-dev' that exposes an interface to
> > > userspace processes to request a system panic with customized panic
> > > message.
> > >
> > > Signed-off-by: Woody Lin <woodylin@google.com>
> > > ---
> > >  drivers/staging/android/Kconfig         |  12 +++
> > >  drivers/staging/android/Makefile        |   1 +
> > >  drivers/staging/android/userpanic-dev.c | 110 ++++++++++++++++++++++++
> >
> > Why is this in staging?  What is wrong with it that it can not just go
> > into the real part of the kernel?  A TODO file is needed explaining what
> > needs to be done here in order for it to be accepted.
> 
> Got it. No more TODO for this driver and I will move it to drivers/android/.
> 
> >
> > But why is this really needed at all?  Why would userspace want to panic
> > the kernel in yet-another-way?
> 
> The idea is to panic the kernel with a panic message specified by the userspace
> process requesting the panic. Without this the panic handler can only collect
> panic message "sysrq triggered crash" for a panic triggered by user processes.
> Using this driver, user processes can put an informative description -
> process name,
> reason ...etc. - to the panic message.

What custom userspace tool is going to use this new user/kernel api and
again, why is it needed?  Who needs to panic the kernel with a custom
message and where is that used?

thanks,

greg k-h
