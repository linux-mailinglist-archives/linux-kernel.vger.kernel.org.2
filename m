Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813E530D842
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhBCLO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:14:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233575AbhBCLOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:14:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 292C264E31;
        Wed,  3 Feb 2021 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612350854;
        bh=yTTSZXtKOP0hXijrZvbt5YVyPq1ma21SJMRh676m8jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXcNvsrz+kIcQR+uut/MCuVnjuYPcqBcZ7oa6UoHBqiHVZAg89LW74En1EayiYVec
         zeu4D8ycJzy0gmw0kWGIi4FdgdkCbK26VTIBcYqrVM/OimdiAXEtJjh+hLip2kt0QQ
         8FKXZ46sFBPzaAp8RZXQqhh4i+DbK/edPgfuykKJkoZNp/4T8W6bCOi2SKC0ze+xd+
         6zlJbElI+YyJ0HXzgeaveYF3qyJssyejrOi+xqfnhT/GFJgtnXM2TBbTyznlZ2rgJB
         6X52n0CjaIGPR6NFlXBhaltIsE4ii64Kfgb69ykQCiIL8LI4DX6lxT7Vgc/L0Nazts
         gHg739nMlPN6w==
Date:   Wed, 3 Feb 2021 16:44:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
Message-ID: <20210203111409.GM2771@vkoul-mobl>
References: <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
 <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
 <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
 <33fe8455-01b4-f867-4974-a3e867c930f0@linux.intel.com>
 <feee8676-33fe-7929-8b6c-6abe3a09159a@linaro.org>
 <20210201101414.GS2771@vkoul-mobl>
 <4b850685-1058-0e18-d3e8-e23e20086235@linux.intel.com>
 <20210202041853.GF2771@vkoul-mobl>
 <6eebbadd-d26b-9dba-f425-01988fb64bec@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eebbadd-d26b-9dba-f425-01988fb64bec@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-21, 10:43, Pierre-Louis Bossart wrote:
> 
> 
> On 2/1/21 10:18 PM, Vinod Koul wrote:
> > On 01-02-21, 10:10, Pierre-Louis Bossart wrote:
> > > On 2/1/21 4:14 AM, Vinod Koul wrote:
> > > > On 21-01-21, 17:23, Srinivas Kandagatla wrote:
> > > > > On 21/01/2021 15:12, Pierre-Louis Bossart wrote:
> > > > > > On 1/21/21 6:03 AM, Srinivas Kandagatla wrote:
> > 
> > > > > I totally agree!
> > > > > 
> > > > > If I understand it correctly in Intel case there will be only one Link ID
> > > > > per bus.
> > > > 
> > > > Yes IIUC there would be one link id per bus.
> > > > 
> > > > the ida approach gives us unique id for each master,bus I would like to
> > > > propose using that everywhere
> > > 
> > > We have cases where link2 is not used but link0, 1 and 3 are.
> > > Using the IDA would result in master-0,1,2 being shown, that would throw the
> > > integrator off. the link_id is related to hardware and can tolerate gaps,
> > > the IDA is typically always increasing and is across the system, not
> > > controller specific.
> > > 
> > > We can debate forever but both pieces of information are useful, so my
> > > recommendation is to use both:
> > > 
> > > snprintf(name, sizeof(name), "master-%d-%d", bus_id, bus->link_id);
> > 
> > I agree we should use both, but does it really make sense for naming? We
> > can keep name in ida and expose the link_id as a parameter for
> > integrators to see in sysfs.
> 
> That would mean changing the meaning of sysfs properties:
> 
> /*
>  * The sysfs for properties reflects the MIPI description as given
>  * in the MIPI DisCo spec
>  *
>  * Base file is:
>  *	sdw-master-N

Key is "The sysfs for properties" is for property files. I am not sure
how this implies for a number above. I was thinking of using ID for N
here and add a link_id file below which represents the link-id property

>  *      |---- revision
>  *      |---- clk_stop_modes
>  *      |---- max_clk_freq
>  *      |---- clk_freq
>  *      |---- clk_gears
>  *      |---- default_row
>  *      |---- default_col
>  *      |---- dynamic_shape
>  *      |---- err_threshold
>  */
> 
> N is the link ID in the spec. I am not convinced we'd do the community a
> service by unilaterally changing what an external spec means, or add a
> property that's kernel-defined while the rest is supposed to come from
> firmware. If you want to change the spec then you can contribute feedback in
> MIPI circles (MIPI have a mechanism for maintainers to provide such feedback
> without company/employer membership requirements)
> 
> So either we add a sysfs layer that represents a controller (better in my
> opinion so that we can show the link/master count), or keep the existing
> hierarchy but expand the name with a unique ID so that Qualcomm don't get
> errors with duplicate sysfs link0 entries.

Anyway we are late in cycle for this.. I am reverting this patch and we
can arrive at consensus and fix this for next cycle

Thanks
-- 
~Vinod
