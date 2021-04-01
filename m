Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D795351ED3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbhDASrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239234AbhDASZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37CFF60201;
        Thu,  1 Apr 2021 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617301538;
        bh=j5+Gt7YrskSy16RAzvRfGLikHQTlG4Rfz+SErDOkJ28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdXtqBV5YMaCOoxJsRTulppNVjInfNl6hw0ys7+jFGMlNRK0T/68rvgWFKHPTLqUf
         8tVUa0YByeIwwoaBQCRlFnMWruiUxdR/m+CKMKPALghW1DGEH59CwUUiUodMjh5ZWV
         wrakNHdIa5EGpQTljtJZKsv3qbjIf3IuFfxE22y8=
Date:   Thu, 1 Apr 2021 20:25:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/2] soundwire: add macro to selectively change error
 levels
Message-ID: <YGYQIJh8X2C8sW44@kroah.com>
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
 <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
 <YGV1HYL+XcVmxfQG@vkoul-mobl.Dlink>
 <0834b9fc-9b3a-1184-fed2-6f9c7e66c6fb@linux.intel.com>
 <YGX5AUQi41z52xk8@kroah.com>
 <81c6b53b-e3fb-32d0-1e99-365d87ab6524@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81c6b53b-e3fb-32d0-1e99-365d87ab6524@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:07:49PM -0500, Pierre-Louis Bossart wrote:
> 
> > > > > +#define sdw_dev_dbg_or_err(dev, is_err, fmt, ...)			\
> > > > > +	do {								\
> > > > > +		if (is_err)						\
> > > > > +			dev_err(dev, fmt, __VA_ARGS__);			\
> > > > > +		else							\
> > > > > +			dev_dbg(dev, fmt, __VA_ARGS__);			\
> > > > > +	} while (0)
> > > > 
> > > > I see a variant in sof code and now here, why not add in a
> > > > dev_dbg_or_err() and use everywhere?
> > > 
> > > Good point, I hesitated back and forth on specific v. generic macro.
> > > 
> > > The main reason why I added this macro for SoundWire is that quite a few
> > > subsystems have their own debug functions (DRM, ACPI, etc), and I wasn't
> > > sure if there was any appetite to add more options in
> > > include/linux/dev_printk.h. SOF also uses a different format due to history.
> > 
> > It is better if those other subsystems move to using the common kernel
> > debug functions.  Historically they were all separate, there is no good
> > reason for them to be that way today.
> > 
> > So please do not create custom subsystem debug macros like this just for
> > this tiny set of drivers.
> > 
> > My bigger issue with this is that this macro is crazy.  Why do you need
> > debugging here at all for this type of thing?  That's what ftrace is
> > for, do not sprinkle code with "we got this return value from here!" all
> > over the place like what this does.
> 
> We are not sprinkling the code all over the place with any new logs, they
> exist already in the SoundWire code and this patch helps filter them out.
> See e.g. patch 2/2
> 
> -			dev_err(&slave->dev,
> -				"Clk Stop type =%d failed: %d\n", type, ret);
> +			sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
> +					   "Clk Stop mode %d type =%d failed: %d\n",
> +					   mode, type, ret);

You just added a debug log for no reason.

That's what I was referring to :)

> If you see all my recent patches they were precisely trying to avoid
> polluting the console logs with too much information that is irrelevant from
> most users, and making sure that when a log is provided it's uniquely
> identifiable.
> 
> There are similar macros where -EPROBE_DEFER is ignored.

deffered probe is a totally different beast and one that I constantly am
ashamed I accepted into the kernel as the added complexity it has caused
is crazy.

> This addresses a very SoundWire-specific case where if we see a -ENODATA
> error code (Command Ignored), we ignore it and don't report it by default.
> We still have a rare set of cases where this -ENODATA code shows up
> unexpectedly, possibly due to problematic reset sequences, and we want
> developers to help track them down what causes this sequence using dynamic
> debug.
> 
> I am not arguing about ftrace v. dynamic debug, and that's also partly why I
> didn't feel comfortable expanding the generic set of debug functions.

Great, then don't add unneeded dev_dbg() lines :)

thanks,

greg k-h
