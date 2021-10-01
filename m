Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0541EC8C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354072AbhJALvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:51:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:60070 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353912AbhJALvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:51:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="247968436"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="247968436"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:49:54 -0700
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="540047578"
Received: from pwhela2-mobl1.ger.corp.intel.com (HELO [10.213.160.166]) ([10.213.160.166])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:49:54 -0700
Subject: Re: [PATCH] soundwire: qcom: add debugfs entry for soundwire register
 dump
To:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210907105636.3171-1-srinivas.kandagatla@linaro.org>
 <YVaMlSbmFnrQyb0u@matsya>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ada6763f-7821-6388-2c7a-3a771450c7bf@linux.intel.com>
Date:   Fri, 1 Oct 2021 06:45:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVaMlSbmFnrQyb0u@matsya>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/21 11:20 PM, Vinod Koul wrote:
> HI Srini,
> 
> On 07-09-21, 11:56, Srinivas Kandagatla wrote:
>> +#ifdef CONFIG_DEBUG_FS
>> +static int swrm_reg_show(struct seq_file *s_file, void *data)
>> +{
>> +	struct qcom_swrm_ctrl *swrm = s_file->private;
>> +	int reg, reg_val;
>> +
>> +	for (reg = 0; reg <= SWR_MSTR_MAX_REG_ADDR; reg += 4) {
>> +		swrm->reg_read(swrm, reg, &reg_val);
> 
> Why not use regmap_read here, that would avoid reading from the bus when
> we already have the values...

It's an indirect read based on regmap.

	ctrl->reg_read = qcom_swrm_ahb_reg_read;
	ctrl->reg_write = qcom_swrm_ahb_reg_write;

static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
				  u32 *val)
{
	struct regmap *wcd_regmap = ctrl->regmap;
	int ret;

	/* pg register + offset */
	ret = regmap_bulk_write(wcd_regmap, SWRM_AHB_BRIDGE_RD_ADDR_0,
			  (u8 *)&reg, 4);
	if (ret < 0)
		return SDW_CMD_FAIL;

	ret = regmap_bulk_read(wcd_regmap, SWRM_AHB_BRIDGE_RD_DATA_0,
			       val, 4);
	if (ret < 0)
		return SDW_CMD_FAIL;

	return SDW_CMD_OK;
}

> Second make sure later when pm_runtime support is added, this take a
> reference ..

Yes indeed, the SoundWire regmap doesn't change the pm_runtime status.
