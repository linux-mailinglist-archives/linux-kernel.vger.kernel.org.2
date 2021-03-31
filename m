Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44593350686
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhCaSjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:39:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:46847 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234963AbhCaSii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:38:38 -0400
IronPort-SDR: 5qxbLfrKzrhV5aDrhh6kn8b88+d4aKPY8uHyvmFWDV9D719NKwUIDT19EMiLgGWdq0zXuDcs71
 U4ua6NnMgN2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="256054236"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="256054236"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 11:38:35 -0700
IronPort-SDR: tgecgx9ye8u3SLe947FDLLViSgVcOUu1AX+GTEuhluo/vICKFCAZjZIQerNZD6opH7meP9H+sY
 qP10KS/C30mw==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="607291433"
Received: from tgvanner-mobl1.amr.corp.intel.com (HELO [10.254.114.81]) ([10.254.114.81])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 11:38:33 -0700
Subject: Re: [PATCH] soundwire: qcom: wait for fifo space to be available
 before read/write
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20210331170033.17174-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ad9f1d18-8f72-9a53-535a-ab5a99379016@linux.intel.com>
Date:   Wed, 31 Mar 2021 13:38:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331170033.17174-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
> +	}
> +
> +	return 0;
> +}

nit-pick: you could merge the prologue and loop body with a 
while(fifo_retry_count--) and put the usleep_range() at the end of the loop.

