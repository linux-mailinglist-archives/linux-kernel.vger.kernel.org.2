Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D5D34BC3D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhC1LrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 07:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhC1Lqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 07:46:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F175C61941;
        Sun, 28 Mar 2021 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616932007;
        bh=M03bi7a09kKMaiL8zfuIoUIH/ryWLbTyZYNO5lendgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xxF4LxBCH2dHD3mn+2oOZcEFHMrXY05NG5tAzKyysx9k+8xdqD8ISYgKnVYY090GO
         4ztdV0uoVpfmbZChASboEXdGLe3KvH7ZRNNNlvhI56dRE3fSiGcFxAjkBrM2+8q4VR
         71n8A0LJkgPtOg2kPLXpkny/pmC29PEkuDkEbemA=
Date:   Sun, 28 Mar 2021 13:46:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v4 1/2] char: xillybus: Move class-related functions to
 new xillybus_class.c
Message-ID: <YGBspAmjcIO6agIm@kroah.com>
References: <20210311095033.20956-1-eli.billauer@gmail.com>
 <20210311095033.20956-2-eli.billauer@gmail.com>
 <YFc65bvAN3/ZNsww@kroah.com>
 <6058792C.90801@gmail.com>
 <YFh7dlY9cntgoLXD@kroah.com>
 <6059D983.5080306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6059D983.5080306@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 02:05:23PM +0200, Eli Billauer wrote:
> On 22/03/21 13:11, Greg KH wrote:
> > 
> > > XILLYBUS and XILLYBUS_PCIE are currently enabled as M in several Linux
> > > distributions. Making them depend on, rather than select XILLYBUS_CLASS is
> > > likely to disable the driver in those distributions.
> > That's not an issue here, depends-on will allow those distros to also
> > enable this option.
> > 
> > But wait, why is this a separate option at all?  Shouldn't the class
> > code just be part of the "core" XILLYBUS code anyway?
> > 
> I'll try to explain the whole picture:
> 
>            XILLYBUS_CLASS
>               /        \
>              |          |
>          XILLYBUS   XILLYUSB
>       /           \
>      |             |
> XILLYBUS_PCIE  XILLYBUS_OF
> 
> XILLYBUS_CLASS is new and common to all drivers in this group.
> 
> XILLYBUS is for drivers based upon memory registers + DMA-based interfaces,
> and it's combined with XILLYBUS_PCIE and/or XILLYBUS_OF. XILLYUSB is for the
> USB variant only.
> 
> Or a more detailed, bottom-up outline:
> 
> * CONFIG_XILLYBUS_PCIE -> xillybus_pcie.c: Functions related to PCIe.
> * CONFIG_XILLYBUS_OF -> xillybus_of.c: Functions related to Xillybus as a
> peripheral on an FPGA / Processor combo chip.
> * CONFIG_XILLYBUS -> xillybus_core.c: Functions that are common to the two
> above, mainly access to the peripheral with memory-mapped registers and DMA.
> * CONFIG_XILLYUSB -> xillyusb.c: The driver for the USB variant, accesses
> the peripheral through the USB framework.
> * CONFIG_XILLYBUS_CLASS -> xillybus_class.c: The new module, which contains
> the class and API parts that would otherwise appear both in xillybus_core.c
> and xillyusb.c. Contains utility functions for the two latter.
> 
> Because XILLYBUS_CLASS is new and "N" by default, making a "depends on"
> relationship means that "make olddefconfig" silently turns off
> CONFIG_XILLYBUS and CONFIG_XILLYBUS_PCIE. That's a bug: Adding a new driver
> shouldn't change anything in the existing configuration.
> 
> That's why I had the "select XILLYBUS_CLASS" to begin with: It ensures a
> smooth transition on a kernel upgrade, by adding XILLYBUS_CLASS to kernels
> that had CONFIG_XILLYBUS enabled. Is there another way to prevent the said
> bug, without "select"?

Ok, that explains it a bit better, thanks for taking the time to explain
it.  At first glance it seems odd, but this looks better, if you include
this information in the changelog texts for your patches when you send
the next series, that will help out with the review.

thanks,

greg k-h
