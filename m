Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305743E1AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbhHERtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236276AbhHERtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:49:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B17B4610A2;
        Thu,  5 Aug 2021 17:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628185772;
        bh=B6IL9Cpv/JUtI1XkONksmlrwilPPgHrXazVlYgLgEhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSfSwq7M7P7fkLYbRF2/4z3uyTAgo6LxrlojcSuwN1yV3P1ib9D/HWt97m7r+tSn0
         p9WuCndm9MKuMXgtUzaJc25kiWO/b52uRNOa8QQaAvXWW9oGXDKCUoitxNhPQeJLZv
         +wIVf+DpV8FqZHLbMSf48iRGi7/DqYHa858ybh1Q=
Date:   Thu, 5 Aug 2021 19:49:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQwkqg2/7888ic+O@kroah.com>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com>
 <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com>
 <CAPcyv4iCBknhGyw-YjO7_Tua9Vkw_UCSHVj3prL3mVfz4nj-_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iCBknhGyw-YjO7_Tua9Vkw_UCSHVj3prL3mVfz4nj-_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 09:37:28AM -0700, Dan Williams wrote:
> On Thu, Aug 5, 2021 at 12:58 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 05, 2021 at 09:55:33AM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Aug 05, 2021 at 09:49:29AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Aug 04, 2021 at 12:50:24PM -0700, Andi Kleen wrote:
> > > > > > And what's wrong with the current method of removing drivers from
> > > > > > devices that you do not want them to be bound to?  We offer that support
> > > > > > for all busses now that want to do it, what driver types are you needing
> > > > > > to "control" here that does not take advantage of the existing
> > > > > > infrastructure that we currently have for this type of thing?
> > > > >
> > > > > I'm not sure what mechanism you're referring to here, but in general don't
> > > > > want the drivers to initialize at all because they might get exploited in
> > > > > any code that they execute.
> > > >
> > > > That is exactly the mechanism we have today in the kernel for all busses
> > > > if they wish to take advantage of it.  We have had this for all USB
> > > > drivers for well over a decade now, this is not a new feature.  Please
> > > > use that instead.
> > >
> > > Hm, wait, maybe that didn't get merged yet, let me dig...
> > >
> >
> > Ok, my fault, I was thinking of the generic "removable" support that
> > recently got added.
> >
> > Both thunderbolt and USB have the idea of "authorized" devices, that is
> > the logic that should be made generic and available for all busses to
> > use, by moving it to the driver core, just like the "removable" logic
> > got moved to the driver core recently (see 70f400d4d957 ("driver core:
> > Move the "removable" attribute from USB to core")
> >
> > Please use that type of interface, as we already have userspace tools
> > using it, and expand it for all busses in the system to use if they
> > want.  Otherwise with this proposal you will end up with multiple ways
> > to control the same bus type with different types of "filtering",
> > ensuring a mess.
> 
> I overlooked the "authorized" attribute in usb and thunderbolt. The
> collision problem makes sense. Are you open to a core "authorized"
> attribute that buses like usb and thunderbolt would override in favor
> of their local implementation? I.e. similar to suppress_bind_attrs:

What about doing it the other way around and making it generic like was
done for the "removable" attribute?  That way the logic from both
thunderbolt and USB moves into the driver core as they really should be
shared.

See the above git commit as an example of what I mean.

thanks,

greg k-h
