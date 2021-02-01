Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B06C30A979
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhBAORa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:17:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232042AbhBAOR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:17:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B07B164EA3;
        Mon,  1 Feb 2021 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612189006;
        bh=IOhAKRWhf9s2LcVyWgiTkYA1yms+M5h8BHth71Hm2PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PTmpqvje7zZKA/bW7tfxiXdRdSMZGDscrq8TlBV2tWqfAfYpPMVxtkIITYwUTMDHN
         eLiIRNyp4ID63PQQpYoqAV2zgBo3CJ/wo6czRnNc453UAjc893x3Km0t4eh+/M00gZ
         VgMUKJjUO8x7+VDO8e58o57Ic8ZvCn1iLBHuxakUlcqHPWqaJ6shi+z3rYtfhf3PeQ
         7MaEmUW/igDHAHqFI3NNG1sSQWJ1+wKDb/UdJtja85R+PDejlkVPxbLa7Y9rgnQNBi
         Q3LqZ0w06lF8pZ7t2/Ie6Eafnw4RovSsZm6w2K8gDyAJIXnkGpSlaY0oEiCNaY7B/V
         hbjT7gIlPc0wA==
Date:   Mon, 1 Feb 2021 19:46:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/6] soundwire: qcom: set continue execution flag for
 ignored commands
Message-ID: <20210201141642.GB2771@vkoul-mobl>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129173248.5941-4-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-21, 17:32, Srinivas Kandagatla wrote:
> version 1.5.1 and higher IPs of this controller required to set
> continue execution on ingored command flag. This patch sets this flag.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index da6e0d4e9622..3669bac11a32 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -40,6 +40,7 @@
>  #define SWRM_CMD_FIFO_CMD					0x308
>  #define SWRM_CMD_FIFO_STATUS					0x30C
>  #define SWRM_CMD_FIFO_CFG_ADDR					0x314
> +#define SWRM_CONTINUE_EXEC_ON_CMD_IGNORE			BIT(31)
>  #define SWRM_RD_WR_CMD_RETRIES					0x7
>  #define SWRM_CMD_FIFO_RD_FIFO_ADDR				0x318
>  #define SWRM_ENUMERATOR_CFG_ADDR				0x500
> @@ -345,7 +346,16 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
>  
>  	/* Configure number of retries of a read/write cmd */
> -	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR, SWRM_RD_WR_CMD_RETRIES);
> +	if (ctrl->version_major == 1 && ctrl->version_minor >= 5 &&
> +	    ctrl->version_step >= 1) {

why not use raw version value?

        if (ctrl->raw > 0x10501 )

> +		/* Only for versions >= 1.5.1 */
> +		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
> +				SWRM_RD_WR_CMD_RETRIES |
> +				SWRM_CONTINUE_EXEC_ON_CMD_IGNORE);
> +	} else {
> +		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
> +				SWRM_RD_WR_CMD_RETRIES);
> +	}
>  
>  	/* Set IRQ to PULSE */
>  	ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR,
> -- 
> 2.21.0

-- 
~Vinod
