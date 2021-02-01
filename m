Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E746B30AC48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhBAQGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:06:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231152AbhBAQFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:05:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2970664E3C;
        Mon,  1 Feb 2021 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612195498;
        bh=D9b+bomAg+Ztnipm+XQTB11VfNLgxTSH/6lQhlvAhrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4vl4hfQ6HtzcuP5/Z2I3c0sLTJwqnCNSTi+XBCPhfoIdIZr8sVs+EXDInviwJdLh
         d8EYKB0bs0cW86IC2kxaBhp72s9ol5+WJv/WWYEUrwqCGEzgKCrZXixe2ikAwMtlKv
         ruhngQNwGnU1MwSBp2o5mRgpEuqCnCHtxYxAg/ho=
Date:   Mon, 1 Feb 2021 17:04:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] char: xillybus: Add driver for XillyUSB (Xillybus
 variant for USB)
Message-ID: <YBgmqBi1PFDxWW1X@kroah.com>
References: <20210201141651.62853-1-eli.billauer@gmail.com>
 <YBgPcX0J5m0bkhuA@kroah.com>
 <601824B6.60803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <601824B6.60803@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 05:56:38PM +0200, Eli Billauer wrote:
> Hello, Greg.
> 
> On 01/02/21 16:25, Greg KH wrote:
> > As this has nothing to do with the existing XillyBus code, and you
> > aren't doing anything "fancy" with the character device nodes, why does
> > this need to be a kernel driver at all?  Why can't you just use libusb
> > and talk to the device directly from userspace with no kernel driver
> > needed?
> That's actually what I did in my first attempt.
> 
> However in order to provide the same API as the existing Xillybus driver,
> this driver must present some kind of device files.

But you are not providing the same API!  Or so you are saying in the
driver.

If you were, then you need to use the same device nodes that the
existing xillybus code uses and share them.  Which is what I asked about
before.

> Named pipes aren't sufficient, among others because closing a Xillybus
> device file is something that the hardware is informed about immediately.
> Also, when a device file is opened for write, the close() call should not
> return until all data has arrived to hardware (per existing API). This can't
> be guaranteed with named pipes.

What does a named pipe have to do with anything here?

> So a user-space driver needs to rely on CUSE. Which I wasted two months on
> before realizing it's not stable enough to rely upon. My whines on CUSE can
> be found in my blog:

Why is cuse an issue here?

Just use libusb and have your userspace programs link against it.

thanks,

greg k-h
