Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A27310767
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBEJLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:11:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhBEJJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:09:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98A5264FC5;
        Fri,  5 Feb 2021 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612516139;
        bh=RS2Nxh+BIHk70SPCLHvH3UHMEVYoRMyAH5V4+gpwaFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wi3JO5qF/iD6hWWPJclYRvpw0zeikX7qaL+FUPqwt1VQQ6Lj9Mxos9UHNh5zF7W9y
         NFJQIQiUWNYSz+rP0zrQRhYKvw9bn6EjXfN1CkfHL5ssfnTDhaYgLf3Rm9eYs3rLBm
         kK6xd5KKpKTEK+mafWe35arr3qi6e8L3GlS3F0sY=
Date:   Fri, 5 Feb 2021 10:08:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] software node: Provide replacement for
 device_add_properties()
Message-ID: <YB0LI3S63Od8er2d@kroah.com>
References: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
 <20210204141711.53775-2-heikki.krogerus@linux.intel.com>
 <CAJZ5v0j+fTG4rw6Z9XU9h=UFSObT5s2a=EY21g5YYyk9BDNtsQ@mail.gmail.com>
 <YBwdEKPIDbbYWAbR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBwdEKPIDbbYWAbR@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 05:13:04PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 04, 2021 at 05:06:53PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 4, 2021 at 3:17 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > At the moment the function device_del() is calling
> > > device_remove_properties() unconditionally. That will result into the
> > > reference count of the software node attached to the device being
> > > decremented, and in most cases it will hit 0 at that point. So in
> > > practice device_del() will unregister the software node attached to
> > > the device, even if that was not the intention of the caller. Right
> > > now software nodes can not be reused or shared because of that.
> > >
> > > So device_del() can not unregister the software nodes unconditionally
> > > like that. Unfortunately some of the users of device_add_properties()
> > > are now relying on this behaviour. Because of that, and also in
> > > general, we do need a function that can offer similar behaviour where
> > > the lifetime of the software node is bound to the lifetime of the
> > > device. But it just has to be a separate function so the behaviour is
> > > optional. We can not remove the device_remove_properties() call from
> > > device_del() before we have that new function, and before we have
> > > replaced device_add_properties() calls with it in all the places that
> > > require that behaviour.
> > >
> > > This adds function device_create_managed_software_node() that can be
> > > used for exactly that purpose. Software nodes created with it are
> > > declared "managed", and separate handling for those nodes is added to
> > > the software node code. The reference count of the "managed" nodes is
> > > decremented when the device they are attached to is removed. This will
> > > not affect the other nodes that are not declared "managed".
> > >
> > > The function device_create_managed_software_node() has also one
> > > additional feature that device_add_properties() does not have. It
> > > allows the software nodes created with it to be part of a node
> > > hierarchy by taking also an optional parent node as parameter.
> > >
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > The rationale is clear now, so
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > and I'm assuming that this will be routed via the USB tree.
> 
> Yes, I will do so, thanks.

Now queued up, thanks!

greg k-h
