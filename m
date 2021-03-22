Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86A034407A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCVMHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhCVMHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:07:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44DB76197F;
        Mon, 22 Mar 2021 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616414842;
        bh=5GBNHdOGkQF5GWk/uL6fy+oR3V9jxg/jLYkdFoEbxeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRphNMpYOXUwh5i/ryvVs6L4FO9ppglCBGe9yYM2JMimaf6dzYsmK16QiUU6wogXn
         fNAfMtKwac8rq9Kp83hwfHpU5ILoP1NtgcyDMMXbrTRJrCRsUsVPGsl2A5GujcdQG/
         DiPjCiKVbBCW9ZKOTpIRpkfN+yq9IUniYytYTtOrm7aKho1hliyYv9u+POZvHdsfOH
         lpgeP+bH9NiRQ0HzTcWdyREnG3W83CFA0wAZ/1tW//Y3noSxUJTN82+VSP9tlZ7LHt
         dE5HaCtNbJYHVHmd5U3qF3vPCBU5P/RpIfm1dQvUJZi8FBNhc97CbT8kVMs8FB6R2k
         KzZ/FybRWTAWg==
Date:   Mon, 22 Mar 2021 17:37:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 1/3] soundwire: add master quirks for bus clash and
 parity
Message-ID: <YFiIdTL6tPnqtDy2@vkoul-mobl.Dlink>
References: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
 <20210302082720.12322-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302082720.12322-2-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-21, 16:27, Bard Liao wrote:
> Currently quirks are only allowed for Slave devices. This patch
> describes the need for two quirks at the Master level.
> 
> a) bus clash
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
> b) parity
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
> BugLink: https://github.com/thesofproject/linux/issues/2578
> BugLink: https://github.com/thesofproject/linux/issues/2533
> 

Please do not add blank lines here

> Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> ---
>  include/linux/soundwire/sdw.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index d08039d65825..25f2a14e2e83 100644
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
> @@ -421,8 +422,29 @@ struct sdw_master_prop {
>  	u32 err_threshold;
>  	u32 mclk_freq;
>  	bool hw_disabled;
> +	u64 quirks;
>  };
>  
> +/* Definitions for Master quirks */
> +
> +/*
> + * In a number of platforms bus clashes are reported after a hardware
> + * reset but without any explanations or evidence of a real problem.
> + * The following quirk will discard all initial bus clash interrupts
> + * but will leave the detection on should real bus clashes happen
> + */
> +#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH	BIT(0)
> +
> +/*
> + * Some Slave devices have known issues with incorrect parity errors
> + * reported after a hardware reset. However during integration unexplained
> + * parity errors can be reported by Slave devices, possibly due to electrical
> + * issues at the Master level.
> + * The following quirk will discard all initial parity errors but will leave
> + * the detection on should real parity errors happen.
> + */
> +#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY	BIT(1)
> +
>  int sdw_master_read_prop(struct sdw_bus *bus);
>  int sdw_slave_read_prop(struct sdw_slave *slave);
>  
> -- 
> 2.17.1

-- 
~Vinod
