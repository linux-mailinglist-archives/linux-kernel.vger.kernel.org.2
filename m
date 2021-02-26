Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1823265D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhBZQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:48:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:8120 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhBZQsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:48:54 -0500
IronPort-SDR: hKhC8aLvU1JIqF00GilAWBG10CjAvB597g4fQddS04LHediENujRAh5MpUEnyJuBsnO79AmZ1j
 n4yXJpJoXg7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="185982831"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="185982831"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 08:47:05 -0800
IronPort-SDR: n6jJbB9MjjJrSSnt6rQaFpgc/1MgM9npPnr/g5jLkmTutNCSOZsSqUYr5VT7zM0l8ue2uGZWPF
 4u13XDNie6Kg==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="367846793"
Received: from ate-mobl.amr.corp.intel.com (HELO [10.209.93.21]) ([10.209.93.21])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 08:47:04 -0800
Subject: Re: [PATCH v2 1/5] soundwire: qcom: add support to missing transport
 params
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
 <20210226155814.27536-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <00842f73-c0fb-5728-3ed0-c0a1fd75f94e@linux.intel.com>
Date:   Fri, 26 Feb 2021 10:45:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210226155814.27536-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/21 9:58 AM, Srinivas Kandagatla wrote:
> Some of the transport parameters derived from device tree
> are not fully parsed by the driver.
> 
> This patch adds support to parse those missing parameters.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/qcom.c | 99 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 95 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 6d22df01f354..fee7465c72c2 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -54,7 +54,13 @@
>   #define SWRM_MCP_SLV_STATUS					0x1090
>   #define SWRM_MCP_SLV_STATUS_MASK				GENMASK(1, 0)
>   #define SWRM_DP_PORT_CTRL_BANK(n, m)	(0x1124 + 0x100 * (n - 1) + 0x40 * m)
> +#define SWRM_DP_PORT_CTRL_2_BANK(n, m)	(0x1128 + 0x100 * (n - 1) + 0x40 * m)
> +#define SWRM_DP_BLOCK_CTRL_1(n)		(0x112C + 0x100 * (n - 1))
> +#define SWRM_DP_BLOCK_CTRL2_BANK(n, m)	(0x1130 + 0x100 * (n - 1) + 0x40 * m)
> +#define SWRM_DP_PORT_HCTRL_BANK(n, m)	(0x1134 + 0x100 * (n - 1) + 0x40 * m)
>   #define SWRM_DP_BLOCK_CTRL3_BANK(n, m)	(0x1138 + 0x100 * (n - 1) + 0x40 * m)
> +#define SWRM_DIN_DPn_PCM_PORT_CTRL(n)	(0x1054 + 0x100 * (n - 1))
> +
>   #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
>   #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
>   #define SWRM_DP_PORT_CTRL_OFFSET1_SHFT				0x08
> @@ -73,12 +79,20 @@
>   #define QCOM_SDW_MAX_PORTS	14
>   #define DEFAULT_CLK_FREQ	9600000
>   #define SWRM_MAX_DAIS		0xF
> +#define SWR_INVALID_PARAM 0xFF
> +#define SWR_HSTOP_MAX_VAL 0xF
> +#define SWR_HSTART_MIN_VAL 0x0
>   
>   struct qcom_swrm_port_config {
>   	u8 si;
>   	u8 off1;
>   	u8 off2;
>   	u8 bp_mode;
> +	u8 hstart;
> +	u8 hstop;
> +	u8 word_length;
> +	u8 blk_group_count;
> +	u8 lane_control;
>   };
>   
>   struct qcom_swrm_ctrl {
> @@ -396,7 +410,13 @@ static int qcom_swrm_port_params(struct sdw_bus *bus,
>   				 struct sdw_port_params *p_params,
>   				 unsigned int bank)
>   {
> -	/* TBD */
> +	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
> +
> +	if (p_params->bps != SWR_INVALID_PARAM)

this is odd. sdw_port_params is a structure in 
include/linux/soundwire/sdw.h, but here you are comparing the value with 
a private qualcomm-defined value.

The Word length of the port is limited by the standard (64), so your 
choice of 0xFF for SWR_INVALID_PARAM is legit, but it should be a 
'public' define.

> +		return ctrl->reg_write(ctrl,
> +				       SWRM_DP_BLOCK_CTRL_1(p_params->num),
> +				       p_params->bps - 1);
> +
>   	return 0;
>   }
>   
> @@ -415,10 +435,32 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
>   
>   	ret = ctrl->reg_write(ctrl, reg, value);
>   
> -	if (!ret && params->blk_pkg_mode) {
> -		reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
> +	if (params->lane_ctrl != SWR_INVALID_PARAM) {
> +		reg = SWRM_DP_PORT_CTRL_2_BANK(params->port_num, bank);
> +		value = params->lane_ctrl;
> +		ret = ctrl->reg_write(ctrl, reg, value);
> +	}
>   
> -		ret = ctrl->reg_write(ctrl, reg, 1);
> +	if (params->blk_grp_ctrl != SWR_INVALID_PARAM) {
> +		reg = SWRM_DP_BLOCK_CTRL2_BANK(params->port_num, bank);
> +		value = params->blk_grp_ctrl;
> +		ret = ctrl->reg_write(ctrl, reg, value);
> +	}
> +
> +	if (params->hstart != SWR_INVALID_PARAM
> +			&& params->hstop != SWR_INVALID_PARAM) {
> +		reg = SWRM_DP_PORT_HCTRL_BANK(params->port_num, bank);
> +		value = (params->hstop << 4) | params->hstart;
> +		ret = ctrl->reg_write(ctrl, reg, value);
> +	} else {
> +		reg = SWRM_DP_PORT_HCTRL_BANK(params->port_num, bank);
> +		value = (SWR_HSTOP_MAX_VAL << 4) | SWR_HSTART_MIN_VAL;
> +		ret = ctrl->reg_write(ctrl, reg, value);
> +	}
> +
> +	if (params->blk_pkg_mode != SWR_INVALID_PARAM) {
> +		reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
> +		ret = ctrl->reg_write(ctrl, reg, params->blk_pkg_mode);
>   	}

same comments here, you should define a public define for all those 
parameters.

>   	return ret;
> @@ -470,6 +512,17 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
>   			p_rt->transport_params.offset1 = pcfg->off1;
>   			p_rt->transport_params.offset2 = pcfg->off2;
>   			p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
> +			p_rt->transport_params.blk_grp_ctrl = pcfg->blk_group_count;
> +			p_rt->transport_params.hstart = pcfg->hstart;
> +			p_rt->transport_params.hstop = pcfg->hstop;
> +			p_rt->transport_params.lane_ctrl = pcfg->lane_control;
> +			if (pcfg->word_length != SWR_INVALID_PARAM) {
> +				sdw_fill_port_params(&p_rt->port_params,
> +					     p_rt->num,  pcfg->word_length + 1,
> +					     SDW_PORT_FLOW_MODE_ISOCH,
> +					     SDW_PORT_DATA_MODE_NORMAL);
> +			}
> +
>   		}
>   
>   		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
> @@ -481,6 +534,18 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
>   				p_rt->transport_params.offset1 = pcfg->off1;
>   				p_rt->transport_params.offset2 = pcfg->off2;
>   				p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
> +				p_rt->transport_params.blk_grp_ctrl = pcfg->blk_group_count;
> +
> +				p_rt->transport_params.hstart = pcfg->hstart;
> +				p_rt->transport_params.hstop = pcfg->hstop;
> +				p_rt->transport_params.lane_ctrl = pcfg->lane_control;
> +				if (pcfg->word_length != SWR_INVALID_PARAM) {
> +					sdw_fill_port_params(&p_rt->port_params,
> +						     p_rt->num,
> +						     pcfg->word_length + 1,
> +						     SDW_PORT_FLOW_MODE_ISOCH,
> +						     SDW_PORT_DATA_MODE_NORMAL);
> +				}
>   				i++;
>   			}
>   		}
> @@ -728,6 +793,11 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>   	u8 off2[QCOM_SDW_MAX_PORTS];
>   	u8 si[QCOM_SDW_MAX_PORTS];
>   	u8 bp_mode[QCOM_SDW_MAX_PORTS] = { 0, };
> +	u8 hstart[QCOM_SDW_MAX_PORTS];
> +	u8 hstop[QCOM_SDW_MAX_PORTS];
> +	u8 word_length[QCOM_SDW_MAX_PORTS];
> +	u8 blk_group_count[QCOM_SDW_MAX_PORTS];
> +	u8 lane_control[QCOM_SDW_MAX_PORTS];
>   	int i, ret, nports, val;
>   
>   	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
> @@ -772,11 +842,32 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>   
>   	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
>   					bp_mode, nports);
> +
> +	memset(hstart, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> +	of_property_read_u8_array(np, "qcom,ports-hstart", hstart, nports);
> +
> +	memset(hstop, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> +	of_property_read_u8_array(np, "qcom,ports-hstop", hstop, nports);
> +
> +	memset(word_length, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> +	of_property_read_u8_array(np, "qcom,ports-word-length", word_length, nports);
> +
> +	memset(blk_group_count, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> +	of_property_read_u8_array(np, "qcom,ports-block-group-count", blk_group_count, nports);
> +
> +	memset(lane_control, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> +	of_property_read_u8_array(np, "qcom,ports-lane-control", lane_control, nports);
> +
>   	for (i = 0; i < nports; i++) {
>   		ctrl->pconfig[i].si = si[i];
>   		ctrl->pconfig[i].off1 = off1[i];
>   		ctrl->pconfig[i].off2 = off2[i];
>   		ctrl->pconfig[i].bp_mode = bp_mode[i];
> +		ctrl->pconfig[i].hstart = hstart[i];
> +		ctrl->pconfig[i].hstop = hstop[i];
> +		ctrl->pconfig[i].word_length = word_length[i];
> +		ctrl->pconfig[i].blk_group_count = blk_group_count[i];
> +		ctrl->pconfig[i].lane_control = lane_control[i];
>   	}

I don't get why you test the values parsed from DT before writing the 
registers. Why do test them here? if some values are incorrect it's much 
better to provide an error log instead of writing a partially valid 
setup to hardware, no?
>   
>   	return 0;
> 
