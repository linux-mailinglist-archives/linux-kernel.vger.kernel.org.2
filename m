Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7940DE46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbhIPPlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhIPPlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:41:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDA9E61212;
        Thu, 16 Sep 2021 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631806790;
        bh=3vn7YL+5sPCmEXebrf4gKwhwgVs86WlquEukFERKLso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/vyyKO45JfHuuabM34iB46x0O9VKg9Z6ypahOTEL8LyIUkcHSaY7/24NLWYXKdRP
         CSvP03zCdgtSOgXC8UusFtPoxIe4dgTE8uQUGfLg6ym6mzZClYrw6kLCr1rpCYgPYb
         4jQHgTAP54tTeVqRIudc4Of5PClhH0Cch+0o7yWI=
Date:   Thu, 16 Sep 2021 17:39:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.or" <lee.jones@linaro.or>
Subject: Re: [PATCH misc v2 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YUNlQ1d8gsNzY0mz@kroah.com>
References: <1631731629-20862-1-git-send-email-min.li.xe@renesas.com>
 <1631731629-20862-2-git-send-email-min.li.xe@renesas.com>
 <YULVYrvUM+JQils9@kroah.com>
 <OS3PR01MB659340151F61C6ABA2D9043BBADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB659340151F61C6ABA2D9043BBADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 03:33:06PM +0000, Min Li wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: September 16, 2021 1:26 AM
> > To: Min Li <min.li.xe@renesas.com>
> > Cc: arnd@arndb.de; derek.kiernan@xilinx.com; dragan.cvetic@xilinx.com;
> > linux-kernel@vger.kernel.org; lee.jones@linaro.or
> > Subject: Re: [PATCH misc v2 2/2] misc: Add Renesas Synchronization
> > Management Unit (SMU) support
> > 
> > On Wed, Sep 15, 2021 at 02:47:09PM -0400, min.li.xe@renesas.com wrote:
> > > From: Min Li <min.li.xe@renesas.com>
> > >
> > > This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx
> > > families of timing and synchronization devices.It will be used by
> > > Renesas PTP Clock Manager for Linux (pcm4l) software to provide
> > > support to GNSS assisted partial timing support (APTS) and other
> > networking timing functions.
> > 
> > Where is that software?
> 
> https://www.renesas.com/us/en/software-tool/ptp-clock-manager-linux

Please put that link in the changelog comment and in the .c code as well
so that people know where to find it.

> > 
> > Why is this new api not a standard one?
> > 
> 
> There is no actual standard for the GNSS assisted partial timing support (APTS)
> In terms of Linux kernel API

Then make one!  :)

> > What is the standard here?
> > 
> > What do other devices do and why is this a new api?
> > 
> 
> There is really no standard for APTS and different company has its own hw/sw solutions

But userspace has to all deal with this in a standard way somehow,
right?  What libraries and apis do they interact with there?

> > > Current version provides kernel API's to support the following
> > > functions -set combomode to enable SYNCE clock support -read dpll's
> > > state to determine if the dpll is locked to the GNSS channel -read
> > > dpll's ffo (fractional frequency offset) in ppqt
> > 
> > Why do all of these have to be in the kernel at all?
> > 
> 
> Because all these API's need spi/i2c accesses to the RSMU card and spi/i2c accesses have been
> abstracted to the MFD driver in kernel

Why not just do this all from userspace then?  You can have spi/i2c
userspace code, right?  Why does this have to be a kernel driver?

thanks,

greg k-h
