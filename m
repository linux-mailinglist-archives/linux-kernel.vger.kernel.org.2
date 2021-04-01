Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D2635212D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhDAU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234024AbhDAU4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:56:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6357D60BBB;
        Thu,  1 Apr 2021 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617310610;
        bh=9T/IXqBtp+umSPMgidOSDUq4bIQY292EI+YBBoHkTlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTqDelDp/ufSmnejeQjZT0LOta51/UU2Qah0+yFRPxcRPELTf2IVLz7as8EMCryoQ
         Wbz8iHuAjFCAyYsctedDXXcEDnlYFfC+/gmNPk8MeYyRRquao9EpTNXfk1tx1IgzE2
         So7xHHEA957/FJgqkIH+sWjqjQfAMgjMcISsqw+4=
Date:   Thu, 1 Apr 2021 22:56:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/2] soundwire: add macro to selectively change error
 levels
Message-ID: <YGYzjWOz076M3ZUq@kroah.com>
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
 <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
 <YGV1HYL+XcVmxfQG@vkoul-mobl.Dlink>
 <0834b9fc-9b3a-1184-fed2-6f9c7e66c6fb@linux.intel.com>
 <YGX5AUQi41z52xk8@kroah.com>
 <81c6b53b-e3fb-32d0-1e99-365d87ab6524@linux.intel.com>
 <YGYQIJh8X2C8sW44@kroah.com>
 <28515962-6fb1-511d-fc6b-f1422b11e6ab@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28515962-6fb1-511d-fc6b-f1422b11e6ab@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:43:53PM -0500, Pierre-Louis Bossart wrote:
> 
> > > > My bigger issue with this is that this macro is crazy.  Why do you need
> > > > debugging here at all for this type of thing?  That's what ftrace is
> > > > for, do not sprinkle code with "we got this return value from here!" all
> > > > over the place like what this does.
> > > 
> > > We are not sprinkling the code all over the place with any new logs, they
> > > exist already in the SoundWire code and this patch helps filter them out.
> > > See e.g. patch 2/2
> > > 
> > > -			dev_err(&slave->dev,
> > > -				"Clk Stop type =%d failed: %d\n", type, ret);
> > > +			sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
> > > +					   "Clk Stop mode %d type =%d failed: %d\n",
> > > +					   mode, type, ret);
> > 
> > You just added a debug log for no reason.
> 
> The number of logs is lower when dynamic debug is not enabled, and equal
> when it is. there's no addition.
> 
> The previous behavior was unconditional dev_err that everyone sees.
> 
> Now it's dev_err ONLY when the code is NOT -ENODATA, and dev_dgb otherwise,
> meaning it will seen ONLY be seen IF dynamic debug is enabled for
> drivers/soundwire/bus.c
> 
> Allow me to use another example from patch2:
> 
> -		if (ret == -ENODATA)
> -			dev_dbg(bus->dev,
> -				"ClockStopNow Broadcast msg ignored %d", ret);
> -		else
> -			dev_err(bus->dev,
> -				"ClockStopNow Broadcast msg failed %d", ret);
> +		sdw_dev_dbg_or_err(bus->dev, ret != -ENODATA,
> +				   "ClockStopNow Broadcast msg failed %d\n", ret);
> 
> There's no new log, is there?

No, but that is not what you showed above which was just an error
message being replaced with both a debug and an error message.

Just drop the debug messages, they are pointless, right?

thanks,

greg k-h
