Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401E540C7AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhIOOr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhIOOr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:47:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D22EC60E90;
        Wed, 15 Sep 2021 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631717168;
        bh=1r+zXP5h+3hNBMoJbh26kMNfLM1fbaF7tV2heVrir+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEqioIZuvY92a5wYiMJqFTgUn3qZlSCQt9oQLjdp/BtxZj9djTpXHSRX2fs/dDpDc
         k5wUYg153aED2O/rZbN9R6fKFvpidfx94VNtUsH+F6Pv01JnPvoYPAjsvwKqb5X5L+
         YzDVKU5W9rZ0bPdLZjk3Xtz65bSfJOFJoeabYs3Y=
Date:   Wed, 15 Sep 2021 16:46:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH misc] misc: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <YUIHLrgU3H2ECoCf@kroah.com>
References: <1630608353-7606-1-git-send-email-min.li.xe@renesas.com>
 <YUBmIWU6HwIjjeXa@kroah.com>
 <OS3PR01MB6593057EA6257006C7228542BADA9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YUGG8iPWMLx5vJ1f@kroah.com>
 <OS3PR01MB65934A451D6B347C207E222BBADB9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB65934A451D6B347C207E222BBADB9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:42:55PM +0000, Min Li wrote:
> > > > > +/*
> > > > > + * RSMU IOCTL List
> > > > > + */
> > > > > +#define RSMU_MAGIC '?'
> > > >
> > > > Where did you get this value from?
> > > >
> > > > Where did you reserve it?
> > >
> > > No I didn't reserve it. I checked other code and they all seem to use
> > > a random character
> > 
> > That's not the best way to do this.
> > 
> > Why do you need ioctls at all anyway?  What userspace tools will be
> > accessing this driver?  Do you have a link to where they are located at?
> 
> Hi Greg
> 
> The userspace tool is called PCM4L (PTP Clock Manager for Linux) from Renesas
> 
> https://www.renesas.com/us/en/software-tool/ptp-clock-manager-linux
> 
> But the functions of this misc driver is not ptp related. It is meant for being called by pcm4l to
> support GNSS assisted partial timing support (APTS), which doesn't have abstracted/dedicated
> Linux Kernel API's. That is why I went for IOCTL in the first place.

Why not work on a real set of apis for this type of thing so that all
devices of this type will work properly?

thanks,

greg k-h
