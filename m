Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C7F438264
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 10:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhJWIwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 04:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhJWIwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 04:52:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F05AC60EE9;
        Sat, 23 Oct 2021 08:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634979013;
        bh=k5TDwpRjfM6FNTSW43SsjGCLk72z6L9gprMqi1Lc93U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqCNRDouULhRBDP4KDAeS/ZudHsdzfIxKwTuoFpNi6OQowP6RbrJXwiUHVg4e9P55
         bZn4MDuxvtzP4q3wzs5Ey0PFIWF444/Jc+6TnRD2rkvGYdjVq45efqK0pEoVMd2zFh
         z1TpTadBnNoPN2HCzrSGZhz3jwUaj+fW7knLmDD0=
Date:   Sat, 23 Oct 2021 10:50:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH] usb: usb-skeleton: Add hint to find __init and __exit
Message-ID: <YXPMvi+A8h0ybR0t@kroah.com>
References: <20211023052538.GA5141@matrix-ESPRIMO-P710>
 <YXOwA6N2ffVIcA7L@kroah.com>
 <7ae5d5c1-4121-65b1-8a91-95513b945823@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae5d5c1-4121-65b1-8a91-95513b945823@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 09:11:37AM +0200, Philipp Hortmann wrote:
> On 10/23/21 8:47 AM, Greg KH wrote:
> > On Sat, Oct 23, 2021 at 07:25:38AM +0200, Philipp Hortmann wrote:
> > > Comment to find __init and __exit.
> > > 
> > > Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> > > ---
> > >   drivers/usb/usb-skeleton.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
> > > index 2dc58766273a..80338a50dcde 100644
> > > --- a/drivers/usb/usb-skeleton.c
> > > +++ b/drivers/usb/usb-skeleton.c
> > > @@ -641,6 +641,7 @@ static struct usb_driver skel_driver = {
> > >   	.supports_autosuspend = 1,
> > >   };
> > > +/* __init and __exit */
> > >   module_usb_driver(skel_driver);
> > 
> > This comment makes no sense, sorry.  __init and __exit are things that
> > the linker uses, why would you need to "find" them?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> When I want to add something to the __init function (debug comment for
> example), how to do this without knowing that it is in module_usb_driver?

The whole point of the module_usb_driver() macro is to keep a developer
from having to write that init_module() and exit_module() functions
entirely.  I think you are getting confused with the __init and __exit
linker hints with the module init/exit functions.  They are totally
different things.

thanks,

greg k-h
