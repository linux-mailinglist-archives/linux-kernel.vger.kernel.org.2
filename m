Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C643040BFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhIOGa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhIOGa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:30:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B31360BD3;
        Wed, 15 Sep 2021 06:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631687378;
        bh=ch01/WbeIC8zu+C33l/ZDhbb3eivc2zeXl3cs9KVGHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D8yyuXJaAa84N82v74hL6teSI8tZKGzRVI5hHkhv14Ghy16hPIJEluBEFDG3ajiMe
         PRGSvdpQZ+Dkshg6oqAeHY18tZ22wwpmOJUh6g+7KV3LVUBKsNEoiWQD1tA5oFjgrF
         trp2Axf44bOEhFSr29kBF78uexqBl9n7YW/jbJeo=
Date:   Wed, 15 Sep 2021 08:29:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronak Jain <ronakj@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>
Subject: Re: [PATCH v2 3/3] firmware: xilinx: Add sysfs support for feature
 config
Message-ID: <YUGSvO5tHYd4cTkc@kroah.com>
References: <20210913083955.27146-1-ronak.jain@xilinx.com>
 <20210913083955.27146-4-ronak.jain@xilinx.com>
 <YUBpjUGaB3G72wRa@kroah.com>
 <BYAPR02MB4488F74E21490FC4801BA375A4DB9@BYAPR02MB4488.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB4488F74E21490FC4801BA375A4DB9@BYAPR02MB4488.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 06:16:16AM +0000, Ronak Jain wrote:
> Hi Greg KH,
> 
> Thanks for reviewing.
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, September 14, 2021 2:51 PM
> > To: Ronak Jain <ronakj@xilinx.com>
> > Cc: Michal Simek <michals@xilinx.com>; linux-kernel@vger.kernel.org; Rajan
> > Vaja <RAJANV@xilinx.com>; corbet@lwn.net; linux-arm-
> > kernel@lists.infradead.org; arnd@arndb.de; Sai Krishna Potthuri
> > <lakshmis@xilinx.com>
> > Subject: Re: [PATCH v2 3/3] firmware: xilinx: Add sysfs support for feature
> > config
> > 
> > On Mon, Sep 13, 2021 at 01:39:55AM -0700, Ronak Jain wrote:
> > > Add support for sysfs interface for runtime features configuration.
> > >  The user can configure the features at runtime. First the user need
> > > to select the config id of the supported features and then the user
> > > can configure the parameters of the feature based on the config id.
> > >  So far the support is added for the over temperature and external
> > > watchdog features.
> > >
> > > Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> > > ---
> > > Changes in v2:
> > > - Update commit message
> > > ---
> > >  drivers/firmware/xilinx/zynqmp.c | 71
> > > ++++++++++++++++++++++++++++++++
> > >  1 file changed, 71 insertions(+)
> > >
> > > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > > b/drivers/firmware/xilinx/zynqmp.c
> > > index 875d13bc1a57..a1434dd368f2 100644
> > > --- a/drivers/firmware/xilinx/zynqmp.c
> > > +++ b/drivers/firmware/xilinx/zynqmp.c
> > > @@ -1361,6 +1361,75 @@ static DEVICE_ATTR_RW(pggs1);  static
> > > DEVICE_ATTR_RW(pggs2);  static DEVICE_ATTR_RW(pggs3);
> > >
> > > +static atomic_t feature_conf_id;
> > 
> > Why does this have to be an atomic?
> Use atomic to avoid race conditions. Suppose the case where the user
> is trying to write the variable and at the same time it tries to read,
> so there might be chances of occurrence of race condition. Also, I am
> not so sure whether the race condition will occur or not but just to
> prevent race condition I have used atomic variable so, the read/write
> operations can handle automatically.

Reading/writing a single variable like this will not be a problem with
races.  If you care about stuff like this, just use a lock to protect
it, don't try to mess with an atomic if you do not have to have it.

> > And shouldn't this be per-device, not global to all devices in the system?
> This is to store the config-id set by the user which will be used to
> retrieve config. There is only one firmware device so we can consider
> it systemwide. Please let me know if you think of a better way of
> handling it.

So is it a device attribute or a driver attribute?

And you never know how many devices you have in a system, do not assume
you will not have multiple ones.  Use the proper structures to start
with and you never will have to change things in the future if you have
multiple devices.

thanks,

greg k-h
