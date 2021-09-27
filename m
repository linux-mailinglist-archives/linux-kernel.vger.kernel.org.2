Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47374418E16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 06:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhI0EGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 00:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhI0EGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 00:06:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30B26610A2;
        Mon, 27 Sep 2021 04:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632715476;
        bh=l8rONjICwE2lHMGY6qOv7rr80KcJ8HFyxEn+LuNw9d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7dd2NARTlgDGjZ3TONLGqhIXpIhI2ej0jM4+LCs/CqluMwgyLRPfO8iPu2CriXt9
         +SAD2jDm3AKA5Hs7IDvBWIaaVqrAfQsP+ebPSBEVPYf3SzLpyISLRbffCpILTMOtgX
         KBJoHevslCJxXRiDgznbWXHpwl4/pCTWn/jIalKU=
Date:   Mon, 27 Sep 2021 06:04:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YVFC0U+wOqbTgDhy@kroah.com>
References: <20210924213157.3584061-1-david.e.box@linux.intel.com>
 <20210924213157.3584061-2-david.e.box@linux.intel.com>
 <YU7BPIH123HUZKhw@kroah.com>
 <3392aea6b112926b063bbe46b1decaad4c9f9e6e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3392aea6b112926b063bbe46b1decaad4c9f9e6e.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 06:15:16PM -0700, David E. Box wrote:
> > > +static struct platform_driver sdsi_driver = {
> > > +       .driver = {
> > > +               .name           = SDSI_DEV_NAME,
> > > +               .dev_groups     = sdsi_groups,
> > > +       },
> > > +       .probe  = sdsi_probe,
> > > +       .remove = sdsi_remove,
> > > +};
> > > +module_platform_driver(sdsi_driver);
> > 
> > What causes the platform to know to register, and enable, this platform
> > driver?  Shouldn't there be some hardware involved that is discoverable
> > to enable it to load dynamically?
> 
> Ah. The patch that adds the SDSi platform device string was added to a series for the intel_pmt MFD
> driver and it's still waiting review. I see that complicates things. I can combine the two series
> together.

Do you have a pointer to the lore.kernel.org location of that series?

Your code right here will bind to any system that it is loaded on, a
very dangerous thing...

thanks,

greg k-h
