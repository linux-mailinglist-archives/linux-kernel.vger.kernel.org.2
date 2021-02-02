Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5908830B6A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhBBEmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231809AbhBBEmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:42:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7A5D64ED3;
        Tue,  2 Feb 2021 04:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612240903;
        bh=nX3/V7s2GfjVuoWmd8LLu4djIxPn2e4AMdAsfP9xNxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBAlsTZoYJ7kCmoKDjbQR6NVHem1Yingf2BQgUp+mACYEyYvaky78aUieMODqBAXL
         wPiXHydG1oZc8O2ft/ksWi5u4RjbutGYJbW9ICQq1eas6YZ+h/gXBNkYV4lJyy22/R
         kKqSe/GJVO1D8a1kEUXcPkHkOAUayaU770/An6YRRYWc9EDmAaV5zYfPFnqN/x/IOA
         BOkGVIRnDxVBOswxwVZFmXhUDDUB5TSKBBrWXXu/rz22BGgbvzz8HilAAex6BtR48U
         maWJ3r0Jp8hz6W6tbPYdFso9T45+4WhZgX2QUZRN9RLn6p45ZDCPM/EaAw+A6P6ByS
         ACvM3kgoukrfQ==
Date:   Tue, 2 Feb 2021 10:11:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 2/3] soundwire: intel: add
 SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH quirk
Message-ID: <20210202044139.GH2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-3-yung-chuan.liao@linux.intel.com>
 <20210201104229.GY2771@vkoul-mobl>
 <0ed1c91b-09ca-dc6f-39d1-850d12f4f9c4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ed1c91b-09ca-dc6f-39d1-850d12f4f9c4@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-02-21, 10:20, Pierre-Louis Bossart wrote:
> 
> 
> On 2/1/21 4:42 AM, Vinod Koul wrote:
> > On 26-01-21, 16:37, Bard Liao wrote:
> > > There is nothing we can do to handle the bus clash interrupt before
> > > interrupt mask is enabled.
> > > 
> > > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> > > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   drivers/soundwire/intel.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> > > index a2d5cdaa9998..f7ba1a77a1df 100644
> > > --- a/drivers/soundwire/intel.c
> > > +++ b/drivers/soundwire/intel.c
> > > @@ -1286,6 +1286,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
> > >   	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
> > >   		prop->hw_disabled = true;
> > > +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH;
> > 
> > Should this not be last 'enabling' the quirk patch in series :)
> 
> Sorry, I don't understand the comment. Do you mind clarifying Vinod?

Sure, I would like to series built as, first defining the quirk
along/followed by bus changes. Then the last patch should be intel
controller changes and setting the quirks (like above) in the last
patch.

Let me know if you would need further clarification

-- 
~Vinod
