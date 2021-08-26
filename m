Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530AE3F863A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbhHZLPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241883AbhHZLPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:15:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48A9F60F25;
        Thu, 26 Aug 2021 11:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629976503;
        bh=l34iZ6OiUVG6vmzegiT/WRNXQh5qJnN85muDTV61VIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mL4+d1KRYd2xWMSSSMk4xdPCFBT/uF9nD3GvQfOqlpQqJYS6cGPpyaq17NNebjsm1
         UYCPQYdr6c0pNbCubO8BIZLsbUjJ9cKJJgyRBqh1nhHrI3SzETz4YPd0dKbBufBnnI
         +CTvXRD1WRnu6S/dT1F3cUnX7TpW9ARJsONXBxPE=
Date:   Thu, 26 Aug 2021 13:14:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com
Subject: Re: [RFC PATCH 1/5] usb: core: hcd: Modularize HCD stop
 configuration in usb_stop_hcd()
Message-ID: <YSd3sVYxptQP8WVN@kroah.com>
References: <20210824105302.25382-1-kishon@ti.com>
 <20210824105302.25382-2-kishon@ti.com>
 <YSTu5KCQV242XuXV@kroah.com>
 <bb64fbf9-4342-7d36-de4f-0ab719b8f479@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb64fbf9-4342-7d36-de4f-0ab719b8f479@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 08:48:45PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> On 24/08/21 6:36 pm, Greg Kroah-Hartman wrote:
> > On Tue, Aug 24, 2021 at 04:22:58PM +0530, Kishon Vijay Abraham I wrote:
> >> No functional change. Since configuration to stop HCD is invoked from
> >> multiple places, group all of them in usb_stop_hcd().
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/usb/core/hcd.c | 42 +++++++++++++++++++++++++-----------------
> >>  1 file changed, 25 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> >> index 0f8b7c93310e..c036ba5311b3 100644
> >> --- a/drivers/usb/core/hcd.c
> >> +++ b/drivers/usb/core/hcd.c
> >> @@ -2760,6 +2760,29 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
> >>  	usb_put_dev(rhdev);
> >>  }
> >>  
> >> +/**
> >> + * usb_stop_hcd - Halt the HCD
> >> + * @hcd: the usb_hcd that has to be halted
> >> + *
> >> + * Stop the timer and invoke ->stop() callback on the HCD
> >> + */
> >> +static void usb_stop_hcd(struct usb_hcd *hcd)
> >> +{
> >> +	if (!hcd)
> >> +		return;
> > 
> > That's impossible to hit, so no need to check for it, right?
> 
> Patch 3 of this series adds support for registering roothub of shared
> HCD. So after that patch there can be a case where shared_hcd is NULL.
> The other option would be to check for non-null value in hcd and then
> invoke usb_stop_hcd().

Then add the check when you need it please.

thanks,

greg k-h
