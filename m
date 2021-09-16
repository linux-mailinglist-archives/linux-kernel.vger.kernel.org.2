Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D240DEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhIPPwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240307AbhIPPvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:51:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FF5560F51;
        Thu, 16 Sep 2021 15:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631807431;
        bh=P2L2Oi/gSe2RrKROPMRV8i054hHPUcCZWhcbeKtWzPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdLjDKulRiGNPHxTETnbnwvUkFSAVSL/33ao0GvfIKS7aq8gOdc1cK36QEiAzwn0r
         CkKen01F3/f/2u68u7U8Ea60kwUNG0fRwbPbHWCzguc8YjUXtuddbX2/Bdr9N2OY1e
         RQ2pj7EV1EAI2B1nYbgz7MZIPCznPmTqC1e6i654=
Date:   Thu, 16 Sep 2021 17:50:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     arnd@arndb.de, derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org
Subject: Re: [PATCH misc v2 1/2] mfd: rsmu: Resolve naming conflict between
 idt8a340_reg.h and idt82p33_reg.h
Message-ID: <YUNnxbhiRv73tDfX@kroah.com>
References: <1631806867-25003-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631806867-25003-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:41:06AM -0400, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> Resolve name conflicts so that rsmu misc driver can be simplified to
> one c file suggested by Greg KH
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  include/linux/mfd/idt82p33_reg.h | 148 ++++++++++++++++++++-------------------
>  1 file changed, 75 insertions(+), 73 deletions(-)
> 
> diff --git a/include/linux/mfd/idt82p33_reg.h b/include/linux/mfd/idt82p33_reg.h
> index 129a6c0..ded0ab8 100644
> --- a/include/linux/mfd/idt82p33_reg.h
> +++ b/include/linux/mfd/idt82p33_reg.h
> @@ -7,106 +7,108 @@
>  #ifndef HAVE_IDT82P33_REG
>  #define HAVE_IDT82P33_REG
>  
> +#define SABRE_REG_ADDR(page, offset) (((page) << 0x7) | ((offset) & 0x7f))
> +
>  /* Register address */
> -#define DPLL1_TOD_CNFG 0x134
> -#define DPLL2_TOD_CNFG 0x1B4
> +#define SABRE_DPLL1_TOD_CNFG 0x134
> +#define SABRE_DPLL2_TOD_CNFG 0x1B4
>  
> -#define DPLL1_TOD_STS 0x10B
> -#define DPLL2_TOD_STS 0x18B
> +#define SABRE_DPLL1_TOD_STS 0x10B
> +#define SABRE_DPLL2_TOD_STS 0x18B
>  
> -#define DPLL1_TOD_TRIGGER 0x115
> -#define DPLL2_TOD_TRIGGER 0x195
> +#define SABRE_DPLL1_TOD_TRIGGER 0x115
> +#define SABRE_DPLL2_TOD_TRIGGER 0x195
>  
> -#define DPLL1_OPERATING_MODE_CNFG 0x120
> -#define DPLL2_OPERATING_MODE_CNFG 0x1A0
> +#define SABRE_DPLL1_OPERATING_MODE_CNFG 0x120
> +#define SABRE_DPLL2_OPERATING_MODE_CNFG 0x1A0
>  
> -#define DPLL1_HOLDOVER_FREQ_CNFG 0x12C
> -#define DPLL2_HOLDOVER_FREQ_CNFG 0x1AC
> +#define SABRE_DPLL1_HOLDOVER_FREQ_CNFG 0x12C
> +#define SABRE_DPLL2_HOLDOVER_FREQ_CNFG 0x1AC
>  
> -#define DPLL1_PHASE_OFFSET_CNFG 0x143
> -#define DPLL2_PHASE_OFFSET_CNFG 0x1C3
> +#define SABRE_DPLL1_PHASE_OFFSET_CNFG 0x143
> +#define SABRE_DPLL2_PHASE_OFFSET_CNFG 0x1C3
>  
> -#define DPLL1_SYNC_EDGE_CNFG 0x140
> -#define DPLL2_SYNC_EDGE_CNFG 0x1C0
> +#define SABRE_DPLL1_SYNC_EDGE_CNFG 0x140
> +#define SABRE_DPLL2_SYNC_EDGE_CNFG 0x1C0
>  
> -#define DPLL1_INPUT_MODE_CNFG 0x116
> -#define DPLL2_INPUT_MODE_CNFG 0x196
> +#define SABRE_DPLL1_INPUT_MODE_CNFG 0x116
> +#define SABRE_DPLL2_INPUT_MODE_CNFG 0x196
>  
> -#define DPLL1_OPERATING_STS 0x102
> -#define DPLL2_OPERATING_STS 0x182
> +#define SABRE_DPLL1_OPERATING_STS 0x102
> +#define SABRE_DPLL2_OPERATING_STS 0x182
>  
> -#define DPLL1_CURRENT_FREQ_STS 0x103
> -#define DPLL2_CURRENT_FREQ_STS 0x183
> +#define SABRE_DPLL1_CURRENT_FREQ_STS 0x103
> +#define SABRE_DPLL2_CURRENT_FREQ_STS 0x183
>  
> -#define REG_SOFT_RESET 0X381
> +#define SABRE_REG_SOFT_RESET 0X381
>  
> -#define OUT_MUX_CNFG(outn) REG_ADDR(0x6, (0xC * (outn)))
> +#define SABRE_OUT_MUX_CNFG(outn) REG_ADDR(0x6, (0xC * (outn)))
>  
>  /* Register bit definitions */
> -#define SYNC_TOD BIT(1)
> -#define PH_OFFSET_EN BIT(7)
> -#define SQUELCH_ENABLE BIT(5)
> +#define SABRE_SYNC_TOD BIT(1)
> +#define SABRE_PH_OFFSET_EN BIT(7)
> +#define SABRE_SQUELCH_ENABLE BIT(5)
>  
>  /* Bit definitions for the DPLL_MODE register */
> -#define PLL_MODE_SHIFT		(0)
> -#define PLL_MODE_MASK		(0x1F)
> -#define COMBO_MODE_EN		BIT(5)
> -#define COMBO_MODE_SHIFT	(6)
> -#define COMBO_MODE_MASK		(0x3)
> +#define SABRE_PLL_MODE_SHIFT		(0)
> +#define SABRE_PLL_MODE_MASK		(0x1F)
> +#define SABRE_COMBO_MODE_EN		BIT(5)
> +#define SABRE_COMBO_MODE_SHIFT	(6)
> +#define SABRE_COMBO_MODE_MASK		(0x3)
>  
>  /* Bit definitions for DPLL_OPERATING_STS register */
> -#define OPERATING_STS_MASK	(0x7)
> -#define OPERATING_STS_SHIFT	(0x0)
> +#define SABRE_OPERATING_STS_MASK	(0x7)
> +#define SABRE_OPERATING_STS_SHIFT	(0x0)
>  
>  /* Bit definitions for DPLL_TOD_TRIGGER register */
> -#define READ_TRIGGER_MASK	(0xF)
> -#define READ_TRIGGER_SHIFT	(0x0)
> -#define WRITE_TRIGGER_MASK	(0xF0)
> -#define WRITE_TRIGGER_SHIFT	(0x4)
> +#define SABRE_READ_TRIGGER_MASK	(0xF)
> +#define SABRE_READ_TRIGGER_SHIFT	(0x0)
> +#define SABRE_WRITE_TRIGGER_MASK	(0xF0)
> +#define SABRE_WRITE_TRIGGER_SHIFT	(0x4)
>  
>  /* Bit definitions for REG_SOFT_RESET register */
> -#define SOFT_RESET_EN		BIT(7)
> -
> -enum pll_mode {
> -	PLL_MODE_MIN = 0,
> -	PLL_MODE_AUTOMATIC = PLL_MODE_MIN,
> -	PLL_MODE_FORCE_FREERUN = 1,
> -	PLL_MODE_FORCE_HOLDOVER = 2,
> -	PLL_MODE_FORCE_LOCKED = 4,
> -	PLL_MODE_FORCE_PRE_LOCKED2 = 5,
> -	PLL_MODE_FORCE_PRE_LOCKED = 6,
> -	PLL_MODE_FORCE_LOST_PHASE = 7,
> -	PLL_MODE_DCO = 10,
> -	PLL_MODE_WPH = 18,
> -	PLL_MODE_MAX = PLL_MODE_WPH,
> +#define SABRE_SOFT_RESET_EN		BIT(7)
> +
> +enum sabre_pll_mode {
> +	SABRE_PLL_MODE_MIN = 0,
> +	SABRE_PLL_MODE_AUTOMATIC = SABRE_PLL_MODE_MIN,
> +	SABRE_PLL_MODE_FORCE_FREERUN = 1,
> +	SABRE_PLL_MODE_FORCE_HOLDOVER = 2,
> +	SABRE_PLL_MODE_FORCE_LOCKED = 4,
> +	SABRE_PLL_MODE_FORCE_PRE_LOCKED2 = 5,
> +	SABRE_PLL_MODE_FORCE_PRE_LOCKED = 6,
> +	SABRE_PLL_MODE_FORCE_LOST_PHASE = 7,
> +	SABRE_PLL_MODE_DCO = 10,
> +	SABRE_PLL_MODE_WPH = 18,
> +	SABRE_PLL_MODE_MAX = SABRE_PLL_MODE_WPH,
>  };
>  
> -enum hw_tod_trig_sel {
> -	HW_TOD_TRIG_SEL_MIN = 0,
> -	HW_TOD_TRIG_SEL_NO_WRITE = HW_TOD_TRIG_SEL_MIN,
> -	HW_TOD_TRIG_SEL_NO_READ = HW_TOD_TRIG_SEL_MIN,
> -	HW_TOD_TRIG_SEL_SYNC_SEL = 1,
> -	HW_TOD_TRIG_SEL_IN12 = 2,
> -	HW_TOD_TRIG_SEL_IN13 = 3,
> -	HW_TOD_TRIG_SEL_IN14 = 4,
> -	HW_TOD_TRIG_SEL_TOD_PPS = 5,
> -	HW_TOD_TRIG_SEL_TIMER_INTERVAL = 6,
> -	HW_TOD_TRIG_SEL_MSB_PHASE_OFFSET_CNFG = 7,
> -	HW_TOD_TRIG_SEL_MSB_HOLDOVER_FREQ_CNFG = 8,
> -	HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG = 9,
> -	HW_TOD_RD_TRIG_SEL_LSB_TOD_STS = HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
> -	WR_TRIG_SEL_MAX = HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
> +enum sabre_hw_tod_trig_sel {
> +	SABRE_HW_TOD_TRIG_SEL_MIN = 0,
> +	SABRE_HW_TOD_TRIG_SEL_NO_WRITE = SABRE_HW_TOD_TRIG_SEL_MIN,
> +	SABRE_HW_TOD_TRIG_SEL_NO_READ = SABRE_HW_TOD_TRIG_SEL_MIN,
> +	SABRE_HW_TOD_TRIG_SEL_SYNC_SEL = 1,
> +	SABRE_HW_TOD_TRIG_SEL_IN12 = 2,
> +	SABRE_HW_TOD_TRIG_SEL_IN13 = 3,
> +	SABRE_HW_TOD_TRIG_SEL_IN14 = 4,
> +	SABRE_HW_TOD_TRIG_SEL_TOD_PPS = 5,
> +	SABRE_HW_TOD_TRIG_SEL_TIMER_INTERVAL = 6,
> +	SABRE_HW_TOD_TRIG_SEL_MSB_PHASE_OFFSET_CNFG = 7,
> +	SABRE_HW_TOD_TRIG_SEL_MSB_HOLDOVER_FREQ_CNFG = 8,
> +	SABRE_HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG = 9,
> +	SABRE_HW_TOD_RD_TRIG_SEL_LSB_TOD_STS = SABRE_HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
> +	SABRE_WR_TRIG_SEL_MAX = SABRE_HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
>  };
>  
>  /** @brief Enumerated type listing DPLL operational modes */
> -enum dpll_state {
> -	DPLL_STATE_FREERUN = 1,
> -	DPLL_STATE_HOLDOVER = 2,
> -	DPLL_STATE_LOCKED = 4,
> -	DPLL_STATE_PRELOCKED2 = 5,
> -	DPLL_STATE_PRELOCKED = 6,
> -	DPLL_STATE_LOSTPHASE = 7,
> -	DPLL_STATE_MAX
> +enum sabre_dpll_state {
> +	SABRE_DPLL_STATE_FREERUN = 1,
> +	SABRE_DPLL_STATE_HOLDOVER = 2,
> +	SABRE_DPLL_STATE_LOCKED = 4,
> +	SABRE_DPLL_STATE_PRELOCKED2 = 5,
> +	SABRE_DPLL_STATE_PRELOCKED = 6,
> +	SABRE_DPLL_STATE_LOSTPHASE = 7,
> +	SABRE_DPLL_STATE_MAX
>  };
>  
>  #endif
> -- 
> 2.7.4
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
