Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A25835DB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhDMJnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhDMJnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:43:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85D5F6128E;
        Tue, 13 Apr 2021 09:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618306974;
        bh=VPjEbzIUQB+FM5ql6HWhHWQTcduq0dn9rEfvn/lG86E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LP202iCvhIZ/X9C8YYNO+W3L3dN7Elbb2lxUw5PqbrZDjIUpI7M434F5hPRtsAZfs
         NmdMMkt7qO6rpS77QeWTtA3P1JmYkA0sL7efsAzgnnu4EbicOZEKNlnSuVe07wReKM
         /WDBV28zog4Yb+WNNF83Ikorg7LJzI+9fQ76e13Q=
Date:   Tue, 13 Apr 2021 11:42:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     joe@perches.com, julia.lawall@inria.fr,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: cocci script hints request
Message-ID: <YHVnm+MFvUZ7PYRd@kroah.com>
References: <20210413090400.GA5477@agape.jhs>
 <YHVgSuRCW1fdabrH@kroah.com>
 <20210413092455.GB5477@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413092455.GB5477@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:24:56AM +0200, Fabio Aiuto wrote:
> On Tue, Apr 13, 2021 at 11:11:38AM +0200, Greg KH wrote:
> > On Tue, Apr 13, 2021 at 11:04:01AM +0200, Fabio Aiuto wrote:
> > > Hi,
> > > 
> > > I would like to improve the following coccinelle script:
> > > 
> > > @@
> > > expression a, fmt;
> > > expression list var_args;
> > > @@
> > > 
> > > -       DBG_871X_LEVEL(a, fmt, var_args);
> > > +       printk(fmt, var_args);
> > > 
> > > I would  replace the DBG_871X_LEVEL macro with printk,
> > 
> > No you really do not, you want to change that to a dev_*() call instead
> > depending on the "level" of the message.
> > 
> > No "raw" printk() calls please, I will just reject them :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> but there are very few occurences of DBG_871X_LEVEL in module init functions:

Then do those "by hand", if they really are needed.

Drivers, when they are working properly, are totally quiet.

> 
> static int __init rtw_drv_entry(void)
> {
>         int ret;
> 
>         DBG_871X_LEVEL(_drv_always_, "module init start\n");

Horrible, please remove.

>         dump_drv_version(RTW_DBGDUMP);
> #ifdef BTCOEXVERSION
>         DBG_871X_LEVEL(_drv_always_, "rtl8723bs BT-Coex version = %s\n", BTCOEXVERSION);

Not needed at all.

> #endif /*  BTCOEXVERSION */
> 
>         sdio_drvpriv.drv_registered = true;
> 
>         ret = sdio_register_driver(&sdio_drvpriv.r871xs_drv);
>         if (ret != 0) {
>                 sdio_drvpriv.drv_registered = false;
>                 rtw_ndev_notifier_unregister();
>         }
> 
>         DBG_871X_LEVEL(_drv_always_, "module init ret =%d\n", ret);

Again, not needed this is noise and if someone really needs to debug
this, they can use the built-in kernel ftrace logic instead.

>         return ret;
> }
> 
> where I don't have a device available... shall I pass NULL to
> first argument?

No, that would be a mess :)

I bet almost all of these can be removed if they are like the above
examples as we do not need a lot of "look, the code got here!" type of
messages at all.

> Another question: may I use netdev_dbg in case of rtl8723bs?

Yes please, that is even better and recommended.

thanks,

greg k-h
