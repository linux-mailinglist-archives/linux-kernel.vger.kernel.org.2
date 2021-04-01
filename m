Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0911350FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhDAHIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233283AbhDAHHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A6C26100A;
        Thu,  1 Apr 2021 07:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617260856;
        bh=bVl57d/4fiyUdavdBfO/VSp+JHKCZiAnocwkVoIMVDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDKj2DSpEzRN15lhYNujT6MLgz+lAhTPmbYQL/gQ9HvrWDCZsNIaXc10i1iM6kwPu
         lVIZdIkzxU19G8GuvpGiTlak0W2qU6fO1J5psT96i4Tq6klhfZJHI+M+Iu2r49jo/q
         Sbkc4PrOV+x6wsh/IUcTHqtGiKesGQEFXsedvxREgu+BtKaTeGw623LU1w/q4lUzhe
         RqMLJ/OHfxG8i8/HXdYnaIQEC3uvOABTD3hLwfVMh6GgxQa183RVQdIvCnWrWyDrDG
         UYvuEPuxhYCyEBqoNxdmdYCCX+DdyYC515m+bd9RHtnNKQEoejKG2CQp6IrOlYV+Ju
         j8tbEDYwYjykA==
Date:   Thu, 1 Apr 2021 12:37:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] soundwire: qcom: wait for fifo space to be available
 before read/write
Message-ID: <YGVxNBKAESSLMeQ+@vkoul-mobl.Dlink>
References: <20210331170033.17174-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331170033.17174-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-03-21, 18:00, Srinivas Kandagatla wrote:
> If we write registers very fast we can endup in a situation where some
> of the writes will be dropped without any notice.
> 
> So wait for the fifo space to be available before reading/writing the
> soundwire registers.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 74 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 6affa3cd4039..9b45717577f2 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -24,6 +24,8 @@
>  #define SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK			BIT(1)
>  #define SWRM_COMP_CFG_ENABLE_MSK				BIT(0)
>  #define SWRM_COMP_PARAMS					0x100
> +#define SWRM_COMP_PARAMS_WR_FIFO_DEPTH				GENMASK(14, 10)
> +#define SWRM_COMP_PARAMS_RD_FIFO_DEPTH				GENMASK(19, 15)
>  #define SWRM_COMP_PARAMS_DOUT_PORTS_MASK			GENMASK(4, 0)
>  #define SWRM_COMP_PARAMS_DIN_PORTS_MASK				GENMASK(9, 5)
>  #define SWRM_INTERRUPT_STATUS					0x200
> @@ -51,6 +53,8 @@
>  #define SWRM_CMD_FIFO_CMD					0x308
>  #define SWRM_CMD_FIFO_FLUSH					0x1
>  #define SWRM_CMD_FIFO_STATUS					0x30C
> +#define SWRM_RD_CMD_FIFO_CNT_MASK				GENMASK(20, 16)
> +#define SWRM_WR_CMD_FIFO_CNT_MASK				GENMASK(12, 8)
>  #define SWRM_CMD_FIFO_CFG_ADDR					0x314
>  #define SWRM_CONTINUE_EXEC_ON_CMD_IGNORE			BIT(31)
>  #define SWRM_RD_WR_CMD_RETRIES					0x7
> @@ -104,6 +108,7 @@
>  #define SWR_BROADCAST_CMD_ID    0x0F
>  #define SWR_MAX_CMD_ID	14
>  #define MAX_FIFO_RD_RETRY 3
> +#define SWR_OVERFLOW_RETRY_COUNT 30
>  
>  struct qcom_swrm_port_config {
>  	u8 si;
> @@ -147,6 +152,8 @@ struct qcom_swrm_ctrl {
>  	int (*reg_read)(struct qcom_swrm_ctrl *ctrl, int reg, u32 *val);
>  	int (*reg_write)(struct qcom_swrm_ctrl *ctrl, int reg, int val);
>  	u32 slave_status;
> +	u32 wr_fifo_depth;
> +	u32 rd_fifo_depth;
>  };
>  
>  struct qcom_swrm_data {
> @@ -238,6 +245,63 @@ static u32 swrm_get_packed_reg_val(u8 *cmd_id, u8 cmd_data,
>  	return val;
>  }
>  
> +static int swrm_wait_for_rd_fifo_avail(struct qcom_swrm_ctrl *swrm)
> +{
> +	u32 fifo_outstanding_cmd, value;
> +	u8 fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
> +
> +	/* Check for fifo underflow during read */
> +	swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +	fifo_outstanding_cmd = FIELD_GET(SWRM_RD_CMD_FIFO_CNT_MASK, value);
> +
> +	 /* Check number of outstanding commands in fifo before read */
> +	if (fifo_outstanding_cmd)
> +		return 0;
> +
> +	do {
> +		usleep_range(500, 510);
> +		swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +		fifo_outstanding_cmd = FIELD_GET(SWRM_RD_CMD_FIFO_CNT_MASK, value);
> +		if (fifo_outstanding_cmd > 0)
> +			break;
> +	} while (fifo_retry_count--);
> +
> +	if (fifo_outstanding_cmd == 0) {
> +		dev_err_ratelimited(swrm->dev, "%s err read underflow\n", __func__);
> +		return -ENOMEM;

ENOMEM ? that should be EIO, we expected data but didnt get it in read
fifo

> +	}
> +
> +	return 0;
> +}
> +
> +static int swrm_wait_for_wr_fifo_avail(struct qcom_swrm_ctrl *swrm)
> +{
> +	u32 fifo_outstanding_cmd, value;
> +	u8 fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
> +
> +	/* Check for fifo overflow during write */
> +	swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +	fifo_outstanding_cmd = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
> +
> +	/* Check number of outstanding commands in fifo before write */
> +	if (fifo_outstanding_cmd != swrm->wr_fifo_depth)
> +		return 0;

maybe the comment should say, check for space in write fifo?

> +
> +	do {
> +		usleep_range(500, 510);
> +		swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +		fifo_outstanding_cmd = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
> +		if (fifo_outstanding_cmd < swrm->wr_fifo_depth)
> +			break;
> +	} while (fifo_retry_count--);
> +
> +	if (fifo_outstanding_cmd == swrm->wr_fifo_depth) {
> +		dev_err_ratelimited(swrm->dev, "%s err write overflow\n", __func__);
> +		return -ENOMEM;

EIO or better error code here too

-- 
~Vinod
