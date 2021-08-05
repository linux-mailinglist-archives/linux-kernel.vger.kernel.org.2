Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A733E1ACB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbhHERvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236297AbhHERvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:51:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 176AF610A2;
        Thu,  5 Aug 2021 17:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628185889;
        bh=5jNjejyjxB7nwfUqDY9J1juhKh4IHwjC1LQw9Czvn0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0U2Rduft6AQmfcB8IFmxBcBpgCDSzI2fZI16xXYHSWXvqNx9IGlG1OrG/WlVZNiF
         567k3XoLLUD1Q4ynHes8cLrnUBq1BRCfIsLvrIENZnwcwOURDgr2pnSiVZJDUtutPu
         vuXOxfVd7Cn2X4fNA9Pw4PWfhO9dY3bB0LY9nKVE=
Date:   Thu, 5 Aug 2021 19:51:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQwlHrJBw79xhTSI@kroah.com>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com>
 <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com>
 <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 06:52:25AM -0700, Andi Kleen wrote:
> 
> > Both thunderbolt and USB have the idea of "authorized" devices, that is
> > the logic that should be made generic and available for all busses to
> > use, by moving it to the driver core, just like the "removable" logic
> > got moved to the driver core recently (see 70f400d4d957 ("driver core:
> > Move the "removable" attribute from USB to core")
> 
> This looks like it's controlled by udev?  Have a default per bus, and let
> user space override it before setting up the device.

It's controlled by whatever you want to use in userspace.  usbguard has
been handling this logic in userspace for over a decade now just fine.

> This doesn't help us handle builtin drivers that initialize before user
> space is up.

Then have the default setting for your bus be "unauthorized" like we
allow for some busses today.

> We need something that works for all drivers. Also cannot just use a default
> at bootup because some drivers (like virtio or rtc) need to be initialized
> in early boot to make the system functional at all. So you need a way to
> distinguish these two cases in the pre user space boot.
> 
> That's basically what this patch implements the infrastructure for.

It also ignores the existing implementation we already have for this for
some busses, please do not do that.

> > Please use that type of interface, as we already have userspace tools
> > using it, and expand it for all busses in the system to use if they
> > want.  Otherwise with this proposal you will end up with multiple ways
> > to control the same bus type with different types of "filtering",
> > ensuring a mess.
> 
> How would such a proposal work for a platform driver that doesn't have a
> bus?

There is a platform bus, it's just a fake one.  The platform bus code
does the binding just like any other bus does, why is platform somehow
"special"?  Except for how it is abused...

thanks,

greg k-h
