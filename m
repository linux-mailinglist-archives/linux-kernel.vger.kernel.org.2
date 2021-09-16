Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD9340E943
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357019AbhIPRvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355808AbhIPRmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:42:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 893AF6327B;
        Thu, 16 Sep 2021 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631811261;
        bh=ymQzYeMkLSk6v7VLwAJT4gG7bsnwMv9w8QyoD1DrwQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QyOh7q7xkv+WP1e95rr6xb6oYW92hu5MI8ZsvQkDdmGHv6C9EkbpoiPQGOVZbzWiD
         XmmRtdIoz0tQAcACw5mp66RhQBm1jigAlpaMZNih9teUVJUlNWJwAtrYaHI7dyAfL6
         OsUkrawTFYPGMPo+ZJ9zn8y6J+uO2fxA0DbjKfUQ=
Date:   Thu, 16 Sep 2021 18:05:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.or" <lee.jones@linaro.or>
Subject: Re: [PATCH misc v2 2/2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YUNrPD5pbq5NBi26@kroah.com>
References: <1631731629-20862-1-git-send-email-min.li.xe@renesas.com>
 <1631731629-20862-2-git-send-email-min.li.xe@renesas.com>
 <YULVYrvUM+JQils9@kroah.com>
 <OS3PR01MB659340151F61C6ABA2D9043BBADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YUNlQ1d8gsNzY0mz@kroah.com>
 <OS3PR01MB65937881AFAA1D8C575E63DABADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB65937881AFAA1D8C575E63DABADC9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 03:54:52PM +0000, Min Li wrote:
> > 
> > Please put that link in the changelog comment and in the .c code as well so
> > that people know where to find it.
> > 
> > > >
> > > > Why is this new api not a standard one?
> > > >
> > >
> > > There is no actual standard for the GNSS assisted partial timing
> > > support (APTS) In terms of Linux kernel API
> > 
> > Then make one!  :)
> 
> Yes it is on our roadmap to do that for next release

Please do it for this kernel api, otherwise you have to support this for
the next 20+ years as-is :(

> > Why not just do this all from userspace then?  You can have spi/i2c
> > userspace code, right?  Why does this have to be a kernel driver?
> > 
> We used to do everything in userspace. But since PHC (ptp hardware clock) came along, we decided
> to move the driver part to kernel. Please take a look at drivers/ptp/ptp_clockmatrix.c for reference.
> Recently, we have some functions like APTS that doesn't belong to PTP or anything else so we have to split those functions
> to RSMU misc driver and i2c/spi bus accesses to RSMU MFD driver.

I still do not understand why this has to be a kernel driver, sorry.
What exactly forces it to be that way?

thanks,

greg k-h
