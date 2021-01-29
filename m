Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7444A308E51
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhA2UVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:21:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:36288 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232858AbhA2UUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:20:42 -0500
IronPort-SDR: 5SBtKPOm1Wv3P/p9j1tT0nXKOrS0Oe7S3FRo8WCeWgL+nfXBmZTWuE+aSW7hMePURs7yRcdoBF
 4QcCPZioyX4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="244564166"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="244564166"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 12:17:08 -0800
IronPort-SDR: qHj/GQWRqrWl8Gv7Xv74XQ/ak345shFCLAWaWQwR7iVGOqIBp79D3eVwJFtmsfEOcS0v47wQ/7
 cyoWYq5/CPaA==
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="431150003"
Received: from kagerrar-mobl.amr.corp.intel.com (HELO [10.212.16.186]) ([10.212.16.186])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 12:17:07 -0800
Subject: Re: [PATCH 5/6] soundwire: qcom: update register read/write routine
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-6-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5c69ed09-60be-2f3d-ed25-f6dbfcb9d62f@linux.intel.com>
Date:   Fri, 29 Jan 2021 13:33:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210129173248.5941-6-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/21 11:32 AM, Srinivas Kandagatla wrote:
> In the existing code every soundwire register read and register write
> are kinda blocked. Each of these are using a special command id that

what does 'kinda blocked' mean?

> generates interrupt after it successfully finishes. This is really
> overhead, limiting and not really necessary unless we are doing
> something special.
> 
> We can simply read/write the fifo that should also give exactly
> what we need! This will also allow to read/write registers in
> interrupt context, which was not possible with the special
> command approach.

This is really unclear, sorry.

> +	if (id != SWR_BROADCAST_CMD_ID) {
> +		if (id < 14)
> +			id += 1;
> +		else
> +			id = 0;

that is really odd. if id=13 (group2) then id becomes 14 (master 
address). A comment is really needed here.

> +	if (cmd_id == SWR_BROADCAST_CMD_ID) {
> +		/*
> +		 * sleep for 10ms for MSM soundwire variant to allow broadcast
> +		 * command to complete.

that's also super-odd. There is nothing in SoundWire that makes any 
difference between a regular and a broadcast command. they all complete 
in the same time (a frame).
> +		 */
> +		ret = wait_for_completion_timeout(&swrm->broadcast, (2 * HZ/10));

is this 10ms really or dependent on CONFIG_HZ?

> +		if (!ret)
> +			ret = SDW_CMD_IGNORED;
> +		else
> +			ret = SDW_CMD_OK;

no CMD_FAILED support?

> +static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *swrm,
> +				     u8 dev_addr, u16 reg_addr,
> +				     u32 len, u8 *rval)
> +{
> +	u32 val;
> +	u32 retry_attempt = 0;
> +	u32 cmd_data;
> +	int ret = SDW_CMD_OK;
> +
> +	mutex_lock(&swrm->io_lock);
> +	val = swrm_get_packed_reg_val(&swrm->rcmd_id, len, dev_addr, reg_addr);
> +
> +	/* wait for FIFO RD to complete to avoid overflow */
> +	usleep_range(100, 105);
> +	swrm->reg_write(swrm, SWRM_CMD_FIFO_RD_CMD, val);
> +	/* wait for FIFO RD CMD complete to avoid overflow */
> +	usleep_range(250, 255);
> +
> +retry_read:
> +
> +	swrm->reg_read(swrm, SWRM_CMD_FIFO_RD_FIFO_ADDR, &cmd_data);
> +	rval[0] = cmd_data & 0xFF;
> +
> +	if ((((cmd_data) & 0xF00) >> 8) != swrm->rcmd_id) {
> +		if (retry_attempt < MAX_FIFO_RD_FAIL_RETRY) {
> +			/* wait 500 us before retry on fifo read failure */
> +			usleep_range(500, 505);
> +			if (retry_attempt == (MAX_FIFO_RD_FAIL_RETRY - 1)) {
> +				swrm->reg_write(swrm, SWRM_CMD_FIFO_CMD, 0x1);
> +				swrm->reg_write(swrm, SWRM_CMD_FIFO_RD_CMD, val);
> +			}
> +			retry_attempt++;
> +			goto retry_read;
> +		} else {
> +			dev_err(swrm->dev,
> +					"failed to read fifo: reg: 0x%x, \
> +					rcmd_id: 0x%x, dev_num: 0x%x, cmd_data: 0x%x\n",
> +					reg_addr, swrm->rcmd_id,
> +					dev_addr, cmd_data);
> +			ret = SDW_CMD_IGNORED;
> +		}
>   	}

the flow seems complicated with multiple tests and goto? Can this be 
simplified?
