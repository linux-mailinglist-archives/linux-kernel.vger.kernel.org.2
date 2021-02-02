Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7108F30B6A6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhBBEpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231540AbhBBEpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:45:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48A5A64EDA;
        Tue,  2 Feb 2021 04:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612241045;
        bh=/Uu6nhhPRG0xelNUcutobrsnbE1m4ygZ8a43Nff8nvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTaYaEz2TCCBkkNs/iHyu1FwyDOqbTbttAQDr83JrYM19iIB3vMQhpnzDwFwLZa+J
         9pJkCh9ccNULcmtcgKaXsbNPX43bw7ZmuYcmDWIdBdEY3guWL3OLP3vYks+Diy61nq
         mF85CVgRwHJNFLtQ1VJsejGMAMA3/INZsTL4Xhcmm8vKuehMPFKBAd0eujjdxr/J/7
         dtYogzETNb3Az4sn6SVgFpmp21EZT+IaYldj5WYa6ZEv3EWc3CdsOlUgWwjJI0BApI
         jtNa+s2jjYuxcofsV1XX4r3ObrN1+WcfWxcJOZCfvFcXaUbQqVN51oTL5nRHGKqwFv
         hFpOc6Wr1JLIw==
Date:   Tue, 2 Feb 2021 10:14:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 3/3] soundwire: bus: clear parity interrupt before the
 mask is enabled
Message-ID: <20210202044400.GI2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-4-yung-chuan.liao@linux.intel.com>
 <20210201110921.GZ2771@vkoul-mobl>
 <f5ef9a07-73df-c2b6-3e03-001f53700c5b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ef9a07-73df-c2b6-3e03-001f53700c5b@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-02-21, 10:29, Pierre-Louis Bossart wrote:
> 
> > >   	 * Set SCP_INT1_MASK register, typically bus clash and
> > > diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> > > index f7ba1a77a1df..c1fdc85d0a74 100644
> > > --- a/drivers/soundwire/intel.c
> > > +++ b/drivers/soundwire/intel.c
> > > @@ -1286,7 +1286,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
> > >   	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
> > >   		prop->hw_disabled = true;
> > > -	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH;
> > > +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
> > > +		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
> > 
> > move this to intel patch please..
> > 
> > >   	return 0;
> > >   }
> > > diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> > > index a2766c3b603d..30415354d419 100644
> > > --- a/include/linux/soundwire/sdw.h
> > > +++ b/include/linux/soundwire/sdw.h
> > > @@ -426,6 +426,7 @@ struct sdw_master_prop {
> > >   };
> > >   #define SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH	BIT(0)
> > > +#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY	BIT(1)
> > 
> > Why not add this quirk in patch 1..?
> 
> There is an element of history here. We first found out about the bus clash
> on multiple devices and dealt with a specific bug number. Then we spend
> weeks on the parity issue on a new platform and ultimately showed we needed
> a similar work-around.
> 
> All these problems are not typical from a user perspective; they appear when
> loading/unloading modules in loops, at some point it seems some hardware
> devices don't always reset properly or there's something problematic in
> power delivery.
> 
> I don't think it's an issue if we refactor the code to add the quirks first,
> and add the intel.c patches later. We probably want 2 intel changes to keep
> the references to the bugs though and the detailed explanations.

Yes I would like to see that. Explanations are always welcome including
development/debug notes.. Changelogs are very important documentation for
kernel, so relevant details are always good to add.
> 
> > Also add comments about each quirk, hopefully it wont be a big table
> 
> Sounds fine.

-- 
~Vinod
