Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA530A9A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhBAOXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:23:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232182AbhBAOWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:22:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26A8464DDE;
        Mon,  1 Feb 2021 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612189299;
        bh=saXB81rCBp5cIBvK13wj/wHHDWVKYzlvS9EQuCXX8PM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFPFpv/gHreo3nMrGcJ1nGRzWenR5Tzq9Jooii0VBCICl9xgEeP6o43OwFFivofip
         alWyr+BHMaTxclfyYCERmvP+1vFWxCCfYFzQ6uJLhVOWwy7fIH3Wx6EIt8j0n4Kn6H
         7uFiYvsE8v3f41RFPmi1NNlu+hDMhSUFjMF0bhcUya0QbwjNVgzMCQMmkOkPr4aRxC
         /UB/nTrW5CgD+MFM6LLtX5NWC9tO0JHPYhcLucVbvV9xLOlP1uYlpvIDatrtLkVvwr
         edCJs7QelY+qSZ5pVV8GnRVE7i2G5EGuqSCLvyTRy2cXyegwHz5PPsQGnALzC1AC22
         ct8BY8QLyATeQ==
Date:   Mon, 1 Feb 2021 19:51:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 4/6] soundwire: qcom: start the clock during
 initialization
Message-ID: <20210201142134.GC2771@vkoul-mobl>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129173248.5941-5-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-21, 17:32, Srinivas Kandagatla wrote:
> Start the clock during initialization.

A detailed log please, which clock..? Also how do older controllers work
w/o this clk

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 3669bac11a32..83df15d83935 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -47,6 +47,8 @@
>  #define SWRM_MCP_FRAME_CTRL_BANK_ADDR(m)		(0x101C + 0x40 * (m))
>  #define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK			GENMASK(2, 0)
>  #define SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK			GENMASK(7, 3)
> +#define SWRM_MCP_BUS_CTRL					0x1044
> +#define SWRM_MCP_BUS_CLK_START					BIT(1)
>  #define SWRM_MCP_CFG_ADDR					0x1048
>  #define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK		GENMASK(21, 17)
>  #define SWRM_DEF_CMD_NO_PINGS					0x1f
> @@ -345,6 +347,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
>  	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
>  
> +	ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
>  	/* Configure number of retries of a read/write cmd */
>  	if (ctrl->version_major == 1 && ctrl->version_minor >= 5 &&
>  	    ctrl->version_step >= 1) {
> -- 
> 2.21.0

-- 
~Vinod
