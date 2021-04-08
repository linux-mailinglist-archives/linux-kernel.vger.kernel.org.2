Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878DD357CA6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhDHGgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhDHGge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:36:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 230BB6113E;
        Thu,  8 Apr 2021 06:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617863782;
        bh=d4bJMeSthNxp55dudnuK71kNjSClI8zdSk9EiYVKAaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nTbfAuFM/rg4TQxV2/4IRTn5GspMUomlryuKbyH0G2kL2cfYbATZ492pBaAujihix
         hdLNLq70fkzUq2Dp3VdXLmjvzzxFZ4XPx2nHZADTh3mTB6FcicvQGwirE0e+2h+MyF
         Lmp3WjA6Ls7EmKsY1SZYHOrlchvdqvx/Z1EcpLY4=
Date:   Thu, 8 Apr 2021 08:36:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YG6kZDlCXs4MGHNw@kroah.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
 <YG3xKlSrOZvrIr3z@kroah.com>
 <OSBPR01MB477360E86A8913D07759C1C8BA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB477360E86A8913D07759C1C8BA759@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:12:10PM +0000, Min Li wrote:
> > 
> > Why not use the miscdev name field?
> > 
> miscdev name field is just a char pointer and I need an static array to manipulate the name with index

Why?

> > So it's a parent?  Why not make this a real platform_device pointer and not
> > a device pointer?
> > 
> 
> It is not parent and mfd field is the parent

Then why are you saving it off?

> > What operations?
> > 
> 
> The MFD driver will create 2 devices, one is for phc driver and another one is this driver.
> The lock is to make sure these 2 driver's operations are synchronized. 

Ok, that should be documented a bit, it wasn't obvious :)

> > Index into what?
> > 
> 
> index is passed by mfd driver and will be used as part of device name such as "rsmu0"

So you can just look it up from the name?

thanks,

greg k-h
