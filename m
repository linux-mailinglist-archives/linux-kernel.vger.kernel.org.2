Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD131A290
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBLQX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhBLQXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:23:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53D1464E00;
        Fri, 12 Feb 2021 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613146959;
        bh=cGis2STI/FXiZ6D9aq1qL5hwCPADBv6IX2lNQypgg48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvA3dK6zB63Q3prs2eh8ASE5tD8BKIpOsT97w1RGrtG0ZysJy23Hr0l+2xTjdc3Zx
         szVDsbRzOcvP7MLWbhrsQmfta5zXh5PiKZcGqv6GYoI1f7+DsA5GDg52yR9ZvTMNoR
         Mn1wN3rNi3P1Zw6PozC4A/c8aCzjRwcGYwYc0DPw=
Date:   Fri, 12 Feb 2021 17:22:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YCarTeNR/Jxd2inD@kroah.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
 <YCYwrNE8547uuODo@kroah.com>
 <OSBPR01MB47733A5CB20E20E48EE84602BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YCajam09pnhVHqkQ@kroah.com>
 <OSBPR01MB47734853C9CAAE5AD9C4AD0FBA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB47734853C9CAAE5AD9C4AD0FBA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 04:02:14PM +0000, Min Li wrote:
> > 
> > xilinx_sdfec.c has:
> > 
> > 	static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
> > 	{
> > 	        return 0;
> > 	}
> > 
> > Which isn't even needed at all, but it is NOT trying to keep people from
> > calling open multiple times.
> > 
> > As for why the above logic does not work in your driver, think of what
> > happens if someone opens the character device node, and then calls
> > dup(2) on it and passes that file descriptor off to another program.  Or just
> > calls it multiple times from different threads in the same program.
> > The kernel does not know what is happening here, and so, "do not allow to
> > be opened multiple times" does not do anything to keep userspace from
> > actually writing to the device node from multiple processes or threads.
> > 
> > So don't even try, it's not worth it.
> > 
> > > I mean if an application failed at opening the device, how can it
> > > proceed to talk the device without a file descriptor?
> > 
> > See above for how to do this.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg
> 
> Thanks for your insight for this. Now I can see this change doesn't prevent deliberate hacker from opening the driver multiple times.
> 
> What I had in mind is that it does prevent some unintentional mistake like some one accidentally opens the application twice. The second
> one would fail due to the change here.

Do not add kernel code that does not work for it's intended purpose :)

thanks,

greg k-h
