Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C54343F54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhCVLMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhCVLLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:11:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C3326192E;
        Mon, 22 Mar 2021 11:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616411513;
        bh=0CN0X34xkIfwT4nyg0xZ77hwCD6IbLh1oX9HfmB0giY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sr1cvS6ZEd8qQWkOHNT+0H/fM1D/RwxUR2H4SFMhsuWTEzbP3a7/ZYh7X/XUwZrd0
         Izw5ViLWfVpwKsdWUgpqmFelpFm15jo8gAsjQW9bZ1qMVncn0QOhXfi4uXQpuNHOIO
         TIg3RzO9zH6FK0Gg0Aml2zEXZBHLzzxGxsF9mY5Y=
Date:   Mon, 22 Mar 2021 12:11:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     devel@driverdev.osuosl.org, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH v4 1/2] char: xillybus: Move class-related functions to
 new xillybus_class.c
Message-ID: <YFh7dlY9cntgoLXD@kroah.com>
References: <20210311095033.20956-1-eli.billauer@gmail.com>
 <20210311095033.20956-2-eli.billauer@gmail.com>
 <YFc65bvAN3/ZNsww@kroah.com>
 <6058792C.90801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6058792C.90801@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 01:02:04PM +0200, Eli Billauer wrote:
> On 21/03/21 14:24, Greg KH wrote:
> > > +config XILLYBUS_CLASS
> > > >  +	tristate
> > > >  +
> > > >    config XILLYBUS
> > > >    	tristate "Xillybus generic FPGA interface"
> > > >    	depends on PCI || OF
> > > >    	select CRC32
> > > >  +	select XILLYBUS_CLASS
> > depends on, do not select.
> > 
> XILLYBUS and XILLYBUS_PCIE are currently enabled as M in several Linux
> distributions. Making them depend on, rather than select XILLYBUS_CLASS is
> likely to disable the driver in those distributions.

That's not an issue here, depends-on will allow those distros to also
enable this option.

But wait, why is this a separate option at all?  Shouldn't the class
code just be part of the "core" XILLYBUS code anyway?

thanks,

greg k-h
