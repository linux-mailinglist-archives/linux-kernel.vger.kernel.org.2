Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3C351D58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbhDAS2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236824AbhDASDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:03:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3A326138E;
        Thu,  1 Apr 2021 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617295620;
        bh=f3yZ/9sfR8caygUqeEk+iSpCs9WAqRkd59lqpXyjtlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y2qmaWu7xE5U8wJYR/J0QQzSKnLxAJNwTm8015Yyk28A+wnnGi7/RAYrFhSADnUID
         EDyTPjkesEekvBMbPtDLYSQFNU3NVzUCLXja5bLtlz3H71Kqd/BfydWKSIHUWQXhSo
         EkQ6CWkVqe9OE05P5LS1DcAtw1P3OAIHCCyg0heY=
Date:   Thu, 1 Apr 2021 18:46:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/2] soundwire: add macro to selectively change error
 levels
Message-ID: <YGX5AUQi41z52xk8@kroah.com>
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
 <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
 <YGV1HYL+XcVmxfQG@vkoul-mobl.Dlink>
 <0834b9fc-9b3a-1184-fed2-6f9c7e66c6fb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0834b9fc-9b3a-1184-fed2-6f9c7e66c6fb@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 09:30:27AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 4/1/21 2:24 AM, Vinod Koul wrote:
> > On 31-03-21, 09:13, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > 
> > > We sometimes discard -ENODATA when reporting errors and lose all
> > > traces of issues in the console log, add a macro to add use dev_dbg()
> > > in such cases.
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Reviewed-by: Rander Wang <rander.wang@intel.com>
> > > Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > ---
> > >   drivers/soundwire/bus.h | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> > > index 40354469860a..8370216f95d4 100644
> > > --- a/drivers/soundwire/bus.h
> > > +++ b/drivers/soundwire/bus.h
> > > @@ -227,4 +227,12 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
> > >   void sdw_clear_slave_status(struct sdw_bus *bus, u32 request);
> > >   int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
> > > +#define sdw_dev_dbg_or_err(dev, is_err, fmt, ...)			\
> > > +	do {								\
> > > +		if (is_err)						\
> > > +			dev_err(dev, fmt, __VA_ARGS__);			\
> > > +		else							\
> > > +			dev_dbg(dev, fmt, __VA_ARGS__);			\
> > > +	} while (0)
> > 
> > I see a variant in sof code and now here, why not add in a
> > dev_dbg_or_err() and use everywhere?
> 
> Good point, I hesitated back and forth on specific v. generic macro.
> 
> The main reason why I added this macro for SoundWire is that quite a few
> subsystems have their own debug functions (DRM, ACPI, etc), and I wasn't
> sure if there was any appetite to add more options in
> include/linux/dev_printk.h. SOF also uses a different format due to history.

It is better if those other subsystems move to using the common kernel
debug functions.  Historically they were all separate, there is no good
reason for them to be that way today.

So please do not create custom subsystem debug macros like this just for
this tiny set of drivers.

My bigger issue with this is that this macro is crazy.  Why do you need
debugging here at all for this type of thing?  That's what ftrace is
for, do not sprinkle code with "we got this return value from here!" all
over the place like what this does.

thanks,

greg k-h
