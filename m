Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861DC31AA84
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 09:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBMI2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 03:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhBMI2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 03:28:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C11964E02;
        Sat, 13 Feb 2021 08:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613204888;
        bh=hR3FNv1WASv3Nh/3JxuayCot/MOkeoou3QnNQbWayJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rhsa9AfrZPXctKOIgkGMsqyhmD/RZdMBzCj1IPI4Mp8+a7bxYfYcfEAN3g7kBpDi5
         GkMTVPVR2Sdg+pD9799XK22PzZMvIls2+wMw52wAy8XOSAVqtG+OeJFi/PHlSiLYLu
         exYeMiqPQQkPHzx1O+jCXUuxdCe+RZ0fZZzgpmQk=
Date:   Sat, 13 Feb 2021 09:28:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YCeNlIDDO+2SqNkx@kroah.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
 <YCYw5xXe16fSj6eI@kroah.com>
 <OSBPR01MB4773472EE0C8D34456C79121BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YCak7Eu2X0dzapPz@kroah.com>
 <OSBPR01MB47733B3FE2242E0338DC5983BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB47733B3FE2242E0338DC5983BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 07:06:17PM +0000, Min Li wrote:
> > 
> > On Fri, Feb 12, 2021 at 03:44:52PM +0000, Min Li wrote:
> > > > >
> > > > > -set combomode
> > > > > -get dpll's state
> > > > > -get dpll's ffo
> > > > >
> > > > > This driver must work with Renesas MFD driver to access SMU
> > > > > through I2C/SPI.
> > > > >
> > > > > Changes since v1:
> > > > > -Provide more background for purpose of the change.
> > > > > -Provide compat_ioctl support
> > > > > -Fix ioctl cmd definition
> > > >
> > > > This "changes" list goes below the --- line.
> > > >
> > >
> > > Sorry, is this a problem that you are requesting me to address? I am bit
> > confused...
> > 
> > Yes, please place that list of changes below the --- line in your patch.
> > The documentation says to do this, right?
> > 
> Hi Greg
> 
> Do you mean this "---" like below? How can I do that? Sorry I was never asked to do that from other reviewer.

Yes, that line.

The documentation should tell you how to do that, as per my patch bot:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

thanks,

greg k-h
