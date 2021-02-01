Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44B30A63B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhBALKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:10:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233221AbhBALKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:10:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1699664E2B;
        Mon,  1 Feb 2021 11:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612177766;
        bh=+uv3hQSOboXmjIsSolO71gnocEb65dPd0/BtQNeuvtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0CNjgcNC/blrdUb1tgCI0u86g9VYoks28Q4IQ9Uw43iFCBr/LybOFjr6oz1wp5nW
         py2rh6lbmJcTHr6EF1K6qHTETARheA1nTBxiJJ8GLbH8FROyq3sjS6oAgedLBkWhfn
         lA3N1/pG6ImlOnIp3lSmpW1f/Mt7vi61uc5SzQxYOtUdg2Jw909w6huvTD2c3zyL6y
         EF6+a5zLffG/x70bxZqeCzDPojIO+yy6Fcf0kg/oj8LsRWSbtg7IiCQfimmOlxbDCi
         vlns1u48Aeo+0r7+VhnvT2wMpBmIgwZ9St4kLL3QeEYV/4qEiXF7qFnelmU1PJuTG2
         DTprUuKieO78Q==
Date:   Mon, 1 Feb 2021 16:39:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 3/3] soundwire: bus: clear parity interrupt before the
 mask is enabled
Message-ID: <20210201110921.GZ2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-4-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126083746.3238-4-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-21, 16:37, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We recently added the ability to discard bus clash interrupts reported
> on startup. These bus clash interrupts can happen randomly on some
> platforms and don't seem to be valid. A master-level quirk helped
> squelch those spurious errors.
> 
> Additional tests on a new platform with the Maxim 98373 amplifier
> showed a rare case where the parity interrupt is also thrown on
> startup, at the same time as bus clashes. This issue only seems to
> happen infrequently and was only observed during suspend-resume stress
> tests while audio is streaming. We could make the problem go away by
> adding a Slave-level quirk, but there is no evidence that the issue is
> actually a Slave problem: the parity is provided by the Master, which
> could also set an invalid parity in corner cases.
> 
> This patch suggests an additional bus-level quirk for parity, which is
> only applied when the codec device is not known to have an issue with
> parity. The initial parity error will be ignored, but a trace will be
> logged to help identify potential root causes (likely a combination of
> issues on both master and slave sides influenced by board-specific
> electrical parameters).
> 
> BugLink: https://github.com/thesofproject/linux/issues/2533
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/bus.c       | 9 +++++++++
>  drivers/soundwire/intel.c     | 3 ++-
>  include/linux/soundwire/sdw.h | 1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index d394905936e4..57581fdb2ea9 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1256,6 +1256,15 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>  			sdw_write_no_pm(slave, SDW_SCP_INT1, SDW_SCP_INT1_BUS_CLASH);
>  		}
>  	}
> +	if ((slave->bus->prop.quirks & SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY) &&
> +	    !(slave->prop.quirks & SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY)) {
> +		/* Clear parity interrupt before enabling interrupt mask */
> +		status = sdw_read_no_pm(slave, SDW_SCP_INT1);
> +		if (status & SDW_SCP_INT1_PARITY) {
> +			dev_warn(&slave->dev, "PARITY error detected before INT mask is enabled\n");
> +			sdw_write_no_pm(slave, SDW_SCP_INT1, SDW_SCP_INT1_PARITY);
> +		}
> +	}
>  
>  	/*
>  	 * Set SCP_INT1_MASK register, typically bus clash and
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index f7ba1a77a1df..c1fdc85d0a74 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1286,7 +1286,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
>  	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
>  		prop->hw_disabled = true;
>  
> -	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH;
> +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
> +		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;

move this to intel patch please..

>  
>  	return 0;
>  }
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index a2766c3b603d..30415354d419 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -426,6 +426,7 @@ struct sdw_master_prop {
>  };
>  
>  #define SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH	BIT(0)
> +#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY	BIT(1)

Why not add this quirk in patch 1..?

Also add comments about each quirk, hopefully it wont be a big table

-- 
~Vinod
