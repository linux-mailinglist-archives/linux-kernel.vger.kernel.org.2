Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523DA3582E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhDHMIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhDHMIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:08:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8066461164;
        Thu,  8 Apr 2021 12:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617883682;
        bh=CsoPgNcV3Hlu6+SPa15r83WWFyZ4xy+mR+J4x0wp6a0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2tXcNAQLC7RNFviqgmj1TIAuavR48MEvUi17tzr+8v6074QqXAM7Vm2fKP5EZaGY
         gbajnd636UMQ2Yfz88XDlQ5E9pzwlGqIkCRmKLj6UBJEhS80ZKXPVPNFotUr+YCw8u
         wJY8itsiPggejsR3XSfO3eBAX6zl4Pe7uxYSBrho=
Date:   Thu, 8 Apr 2021 14:07:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] USB: cdc-acm: fix TIOCGSERIAL implementation
Message-ID: <YG7yH1FzGsyOCefB@kroah.com>
References: <20210407102845.32720-1-johan@kernel.org>
 <20210407102845.32720-4-johan@kernel.org>
 <a1a94db2d373c4c7b8841908d8e6133ab022232e.camel@suse.com>
 <YG7RiLoscS6VXG7n@hovoldconsulting.com>
 <0049152ce9da85c50fda91c1b77ca233ba0fef3d.camel@suse.com>
 <YG7vEQa53AhN+piv@hovoldconsulting.com>
 <61df47f6708fc4bc9add8d42aff6edcbad6e9618.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61df47f6708fc4bc9add8d42aff6edcbad6e9618.camel@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:59:43PM +0200, Oliver Neukum wrote:
> Am Donnerstag, den 08.04.2021, 13:54 +0200 schrieb Johan Hovold:
> > On Thu, Apr 08, 2021 at 01:34:12PM +0200, Oliver Neukum wrote:
> > > Am Donnerstag, den 08.04.2021, 11:48 +0200 schrieb Johan Hovold:
> > > > On Thu, Apr 08, 2021 at 10:36:46AM +0200, Oliver Neukum wrote:
> > > > > Am Mittwoch, den 07.04.2021, 12:28 +0200 schrieb Johan Hovold:
> > > > > Well, the devices report it. It is part of the standard.
> > > > 
> > > > No, the standard doesn't include anything about a baud-base clock
> > > > AFAICT.
> > > 
> > > Unfortunately it does.
> > > dwDTERate - chapter 6.3.11 - table 17
> > 
> > That's not the base clock rate, that's just the currently configured
> > line speed which you can read from termios 
> > > If we does this wrongly, we should certainly fix it, but just removing
> > > the reporting doesn't look right to me.
> > 
> > The driver got its interpretation of baud_base wrong, and CDC doesn't
> > even have a concept of base clock rate so removing it is the right thing
> > to do.
> > 
> > Again, baud_base is really only relevant with legacy UARTs and when
> > using the deprecated ASYNC_SPD_CUST.
> > 
> > And if the user wants to knows the current line speed we have a
> > different interface for that.
> 
> Hi,
> 
> thank you, that clarifies things. I am happy with the patch itself,
> but could I ask you to do two things:
> 
> 1. Edit the commit description
> making clear that the difference
> between the base clock rate and the line speed.
> 
> 2. Mark the patch specially to NOT be included in stable. We may
> have
> users misusing the current API.

That doesn't matter, if there are misusers then their use will "break"
on newer kernels.  And if so, then it doesn't deserve to be in any
release.

If a change is good enough for Linus's tree, that means it is good
enough for a stable tree, the requirements are exactly the same when it
comes to userspace interactions.

thanks,

greg k-h
