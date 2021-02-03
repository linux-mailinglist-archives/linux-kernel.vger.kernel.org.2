Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398C530D81C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhBCLEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:04:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233827AbhBCLEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:04:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C16E664E42;
        Wed,  3 Feb 2021 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612350242;
        bh=nTKbJIzMVgfvkQz2CHCRBxy6K5TLiaBik2oQ2yvXaVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uubw5WQjqVOHLWytf9ROZ8n2LxH4R5ANttzp/WETJ8tW/jtRyvNC47akzw7zFgImO
         ExdWweW4OmW2Nn/8WZvR7wReKC9btWwT3ZUwzmkcl+JpO40di0a1nt+tQBbAed2Idu
         k8mmuj6fOC+2Av+xku9AvEF5iN01xxWBYdmFsTQW+uDfI6BPux2AhsuFXgzBvz+eKt
         De42EuniitBDQwLLXw56+CS7Eb3lnFZe/Y2pgO9QFSIRcu4ue1nZS7Ypgq0YivQUmq
         9u4H6rl7Yx4QORnySHxK0NN5rC1Y5qxXLg/MJcGlucgLNfrimvAKSRN4v6oTyeq1Sg
         aQWvo5yTA8Swg==
Date:   Wed, 3 Feb 2021 16:33:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/3] soundwire: bus: clear bus clash interrupt before the
 mask is enabled
Message-ID: <20210203110358.GL2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
 <20210201102844.GU2771@vkoul-mobl>
 <20210201103825.GV2771@vkoul-mobl>
 <7c4e1163-a6b3-2886-1963-7e2847dc2836@linux.intel.com>
 <20210202043909.GG2771@vkoul-mobl>
 <4117cd57-1643-758f-b59c-ac507a6f5ed2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4117cd57-1643-758f-b59c-ac507a6f5ed2@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-21, 10:52, Pierre-Louis Bossart wrote:
> 
> 
> On 2/1/21 10:39 PM, Vinod Koul wrote:
> > On 01-02-21, 10:18, Pierre-Louis Bossart wrote:
> > > On 2/1/21 4:38 AM, Vinod Koul wrote:
> > > > On 01-02-21, 15:58, Vinod Koul wrote:
> > > > > On 26-01-21, 16:37, Bard Liao wrote:
> > > > 
> > > > > >    struct sdw_master_prop {
> > > > > >    	u32 revision;
> > > > > > @@ -421,8 +422,11 @@ struct sdw_master_prop {
> > > > > >    	u32 err_threshold;
> > > > > >    	u32 mclk_freq;
> > > > > >    	bool hw_disabled;
> > > > > > +	u32 quirks;
> > > > > 
> > > > > Can we do u64 here please.. I dont know where we would end up.. but
> > > > > would hate if we start running out of space ..
> > > No objection.
> > > 
> > > > Also, is the sdw_master_prop right place for a 'quirk' property. I think
> > > > we can use sdw_master_device or sdw_bus as this seems like a bus
> > > > quirk..?
> > > 
> > > It's already part of sdw_bus
> > 
> > Right, but the point is that the properties were mostly derived from
> > DiSco, so am bit skeptical about it adding it there..
> 
> Oh, I am planning to contribute such quirks as MIPI DisCo properties for the
> next revision of the document (along with a capability to disable a link).
> This was not intended to remain Linux- or Intel-specific.

Okay lets keep it in properties then

-- 
~Vinod
