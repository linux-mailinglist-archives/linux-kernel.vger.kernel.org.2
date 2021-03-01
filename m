Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A99327A93
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhCAJTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:19:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233751AbhCAJTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:19:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61AFF64E01;
        Mon,  1 Mar 2021 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614590304;
        bh=gVfBaC9t4lrXYWRSjC58vVIt9/hAhY6mrbALiLX78AI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATP+2R9F4edZqLGKdjeEQQ1gGWuAM5vuZtw2Hx0SPgfcONLwBb+wtGGjqm56RNsTn
         sN6cg03B9gblos0R7mEJ7FtRUd8OTXWIuM9nyIlKQxYrJ6BSD+5I6SuR72XWPewoo+
         Q6FkQk6aj81uuwwe8Ho9L6KMEMsWX2gXiZ/3L05Qh0HQ9hxAQiP3ZoqkkqF8IaIaIK
         vgVqkKjHa6AdL2AK72Wox+2PgepVvV1wEXEwmvYar9Pus6Cv+Zv6v7H0AKe53ND6SW
         x8BQ6nwzgClOk4k10xyLjlrcrBExrJl/HC/+EPcIcwXld/vY7qqZAocEjjI5U1/uZs
         AlJC1gLTjzdIQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lGehN-0007sg-TM; Mon, 01 Mar 2021 10:18:41 +0100
Date:   Mon, 1 Mar 2021 10:18:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] USB: serial: xr: fix NULL-deref on disconnect
Message-ID: <YDyxcQfUabhJruuA@hovoldconsulting.com>
References: <20210226100826.18987-1-johan@kernel.org>
 <20210226115447.6ace5490@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226115447.6ace5490@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:54:47AM +0100, Mauro Carvalho Chehab wrote:
> Em Fri, 26 Feb 2021 11:08:26 +0100
> Johan Hovold <johan@kernel.org> escreveu:
> 
> > Claiming the sibling control interface is a bit more involved and
> > specifically requires adding support to USB-serial core for managing
> > either interface being unbound first, something which could otherwise
> > lead to a NULL-pointer dereference.
> > 
> > Similarly, additional infrastructure is also needed to handle suspend
> > properly.
> > 
> > Since the driver currently isn't actually using the control interface,
> > we can defer this for now by simply not claiming the control interface.
> > 
> > Fixes: c2d405aa86b4 ("USB: serial: add MaxLinear/Exar USB to Serial driver")
> > Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Cc: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> That solved the issue with XR21V1410:
> 
> 	[ 8176.265862] usbcore: registered new interface driver xr_serial
> 	[ 8176.265885] usbserial: USB Serial support registered for xr_serial
> 	[ 8176.265921] xr_serial 2-1:1.1: xr_serial converter detected
> 	[ 8176.266041] usb 2-1: xr_serial converter now attached to ttyUSB0
> 	[ 8176.268023] printk: console [ttyUSB0] enabled
> 	[ 8186.512841] usb 2-1: USB disconnect, device number 5
> 	[ 8186.513131] printk: console [ttyUSB0] disabled
> 	[ 8186.513340] xr_serial ttyUSB0: xr_serial converter now disconnected from ttyUSB0
> 	[ 8186.513376] xr_serial 2-1:1.1: device disconnected
> 
> Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks for testing, and thanks to Greg and Manivannan for the review.

Now applied.

Johan
