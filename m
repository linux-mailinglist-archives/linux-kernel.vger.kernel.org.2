Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C952E448069
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbhKHNos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:44:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238563AbhKHNoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7311261406;
        Mon,  8 Nov 2021 13:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636378922;
        bh=o6tTgLJbR17uxZtLsffdqLahX8ng39xVFVu68NfdQ2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JE4q6xmsxSzVG8DCPw4fIHdiOD55MOERNGDo/aN2glSwq5OhGU3/tpHUPUPIgnyeU
         j0t44NDI70P3HLow/66+YUM7NsV3BCycW1wL3268FaTvgfYSsIAXgvIjZkBQcHtrVa
         4k4HqCjZG4v2G4LgOR0v0SJoVMOjc2WKAlSr93qw=
Date:   Mon, 8 Nov 2021 14:41:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6IOh5ZCv6IiqKE5pY2sgSHUp?= <huqihang@oppo.com>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: gadget: composite: Fix null pointer exception
Message-ID: <YYkpJ4GB0+MmYXDA@kroah.com>
References: <20211105104840.159533-1-huqihang@oppo.com>
 <YYUnM0/82FwS5OUE@kroah.com>
 <KU1PR02MB253627CFDBE573DE95F3A09EB0919@KU1PR02MB2536.apcprd02.prod.outlook.com>
 <YYkeUgz1wr4s772X@kroah.com>
 <KU1PR02MB2536DA8D51945A1CD85A9C09B0919@KU1PR02MB2536.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KU1PR02MB2536DA8D51945A1CD85A9C09B0919@KU1PR02MB2536.apcprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 01:10:14PM +0000, 胡启航(Nick Hu) wrote:
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, November 8, 2021 8:56 PM
> > To: 胡启航(Nick Hu) <huqihang@oppo.com>
> > Cc: balbi@kernel.org; peter.chen@kernel.org; linux-usb@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2] usb: gadget: composite: Fix null pointer exception
> > 
> > On Mon, Nov 08, 2021 at 12:42:24PM +0000, 胡启航(Nick Hu) wrote:
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Friday, November 5, 2021 8:45 PM
> > > > To: 胡启航(Nick Hu) <huqihang@oppo.com>
> > > > Cc: balbi@kernel.org; peter.chen@kernel.org;
> > > > linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v2] usb: gadget: composite: Fix null pointer
> > > > exception
> > > >
> > > > On Fri, Nov 05, 2021 at 06:48:40PM +0800, Qihang Hu wrote:
> > > > > In the config_ep_by_speed_and_alt function, select the
> > > > > corresponding descriptor through g->speed, but the function driver
> > > > > may not support the corresponding speed. So, we need to check
> > > > > whether the function driver provides the corresponding speed
> > > > > descriptor when selecting the descriptor.
> > > > >
> > > > > [  237.708146]  android_work: sent uevent USB_STATE=CONNECTED [
> > > > > 237.712464]  kconfigfs-gadget gadget: super-speed config #1: b [
> > > > > 237.712487]  kUnable to handle kernel NULL pointer dereference at
> > > > virtual address 0000000000000000
> > > >
> > > > So this is an invalid driver causing this problem?  Or can this be
> > > > triggered by userspace?
> > >
> > > Yes, if the kernel is loaded with an interface driver that does not
> > > support all speeds, this problem can be triggered in userspace.
> > 
> > What in-kernel driver does not support all speeds that can trigger this?
> > 
> > Why not fix the drivers?
> 
> This problem is caused by android f_audio_source.c

That file should not be used anymore, please use the proper USB gadget
code for Android instead.  There is a reason that code was never merged
upstream.

> I think the core driver code should be improved to make it less susceptible to function-driven influence. 
> Of course, repairing the function driver is the fundamental solution to the problem.

There is no need to use that code at all, so you are trying to fix an
external driver's bug with a core kernel change.  That's not the best
thing to do here :)

> > > I have not submitted a BUG.
> > > I will study and submit a BUG as soon as possible.
> > 
> > I do not understand what you mean by this.  I am asking what commit caused
> > this problem so we can mark this one as fixing it.
> > 
> 
> This is a problem with Android's driver code.
> The kernel does not include it.

Great, then fix the android driver's code and then do not use it anymore :)

thanks,

greg k-h
