Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69A030A554
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhBAK3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232290AbhBAK3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:29:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5D4F64E11;
        Mon,  1 Feb 2021 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612175328;
        bh=cYt/4tFrkPkgMO34ziTHv/Xl1CcvzqikMpKc4YYIK3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6ZoHjs8fw7VKf4QcU0XyCtgxal6MYEuJbZNANShek+No1IBv7+gBIir6zc58xDDB
         niMTmXK/7Wg8ljX3fe5HS4knDBq7ghL3y3B91toy8awjKPwncJ+emGAfwf7ZAtU/Wu
         y+YIZ2c3tffyUU7Xhe3aeUcnKp4PL3CuBrAWSFRCkD0l8L/gsEG1ktHS5JVgnx9Bwd
         coyzEzfty0ggFc7/mnIKWPxuKMVeaX9DkUf76A9JbLmyLjNJC0nCU3l3N5CvNK9Abt
         DmNmEunjd6gg9e7pBBb1AFhVBsWMz2b8VxqD/2OT9eQa+8V6LMM5eXMfUvyPBup/dl
         ZJ1VKiWZoJ6mQ==
Date:   Mon, 1 Feb 2021 15:58:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 1/3] soundwire: bus: clear bus clash interrupt before the
 mask is enabled
Message-ID: <20210201102844.GU2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126083746.3238-2-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-21, 16:37, Bard Liao wrote:
> The SoundWire specification allows a Slave device to report a bus clash
> with the in-band interrupt mechanism when it detects a conflict while
> driving a bitSlot it owns. This can be a symptom of an electrical conflict
> or a programming error, and it's vital to detect reliably.
> 
> Unfortunately, on some platforms, bus clashes are randomly reported by
> Slave devices after a bus reset, with an interrupt status set even before
> the bus clash interrupt is enabled. These initial spurious interrupts are
> not relevant and should optionally be filtered out, while leaving the
> interrupt mechanism enabled to detect 'true' issues.
> 
> This patch suggests the addition of a Master level quirk to discard such
> interrupts. The quirk should in theory have been added at the Slave level,
> but since the problem was detected with different generations of Slave
> devices it's hard to point to a specific IP. The problem might also be
> board-dependent and hence dealing with a Master quirk is simpler.
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c       | 10 ++++++++++
>  include/linux/soundwire/sdw.h |  4 ++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 6e1c988f3845..d394905936e4 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1240,6 +1240,7 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
>  static int sdw_initialize_slave(struct sdw_slave *slave)
>  {
>  	struct sdw_slave_prop *prop = &slave->prop;
> +	int status;
>  	int ret;
>  	u8 val;
>  
> @@ -1247,6 +1248,15 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (slave->bus->prop.quirks & SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH) {
> +		/* Clear bus clash interrupt before enabling interrupt mask */
> +		status = sdw_read_no_pm(slave, SDW_SCP_INT1);
> +		if (status & SDW_SCP_INT1_BUS_CLASH) {
> +			dev_warn(&slave->dev, "Bus clash detected before INT mask is enabled\n");
> +			sdw_write_no_pm(slave, SDW_SCP_INT1, SDW_SCP_INT1_BUS_CLASH);
> +		}
> +	}
> +
>  	/*
>  	 * Set SCP_INT1_MASK register, typically bus clash and
>  	 * implementation-defined interrupt mask. The Parity detection
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index f0b01b728640..a2766c3b603d 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -405,6 +405,7 @@ struct sdw_slave_prop {
>   * command
>   * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
>   * @hw_disabled: if true, the Master is not functional, typically due to pin-mux
> + * @quirks: bitmask identifying optional behavior beyond the scope of the MIPI specification
>   */
>  struct sdw_master_prop {
>  	u32 revision;
> @@ -421,8 +422,11 @@ struct sdw_master_prop {
>  	u32 err_threshold;
>  	u32 mclk_freq;
>  	bool hw_disabled;
> +	u32 quirks;

Can we do u64 here please.. I dont know where we would end up.. but
would hate if we start running out of space ..


>  };
>  
> +#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH	BIT(0)
> +
>  int sdw_master_read_prop(struct sdw_bus *bus);
>  int sdw_slave_read_prop(struct sdw_slave *slave);
>  
> -- 
> 2.17.1

-- 
~Vinod
