Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1431A22A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhBLP4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231611AbhBLP4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:56:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5869C64E3B;
        Fri, 12 Feb 2021 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613145326;
        bh=z8cgzmvcHY5pt2ILY8k3eQGEZLQX9gIzKT1h/OeeR+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqUN1mfjhccLKAgT8v2qHaqgUE2mTTZdqzoi1Kf2mavW7aLD6mpXHprHyBc1XuKHo
         dDe7G8mkE9NSrQXXibAUu3FQ/hP39N6VarDRaxaaCZ6bl1VOQFWnSIdvpIDrxTZdIA
         A5Al2r20PjOXyejV3EOsM8fj7ZbVh3Y6Zk41jlMU=
Date:   Fri, 12 Feb 2021 16:55:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YCak7Eu2X0dzapPz@kroah.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
 <YCYw5xXe16fSj6eI@kroah.com>
 <OSBPR01MB4773472EE0C8D34456C79121BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4773472EE0C8D34456C79121BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 03:44:52PM +0000, Min Li wrote:
> > >
> > > -set combomode
> > > -get dpll's state
> > > -get dpll's ffo
> > >
> > > This driver must work with Renesas MFD driver to access SMU through
> > > I2C/SPI.
> > >
> > > Changes since v1:
> > > -Provide more background for purpose of the change.
> > > -Provide compat_ioctl support
> > > -Fix ioctl cmd definition
> > 
> > This "changes" list goes below the --- line.
> > 
> 
> Sorry, is this a problem that you are requesting me to address? I am bit confused...

Yes, please place that list of changes below the --- line in your patch.
The documentation says to do this, right?

> > And you seem to have ignored my review, especially about documenting the
> > sysfs files here, please do that as I can not accept this patch as-is.
> > 
> 
> If I come up with an rsmu.rst under Documentation/driver-api, is that something you are looking for?

No, all sysfs files need to be documented in Documentation/ABI/

thanks,

greg k-h
