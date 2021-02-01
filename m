Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CBD30A970
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhBAOOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:14:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhBAOOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:14:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11B1B64DE1;
        Mon,  1 Feb 2021 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612188830;
        bh=Nu9j1OWOkq/s5auhZCIUqzVrcpOG7g4ONvSHTtNOvgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELGeWr/lGlNDzjIBEWGa7dMKIB5T0Vpt2Yfc1iyonLPCttW9sso5a5llv5b9OTRmE
         MTvffA8F3Cje2bA0erMQJ+8hDlDju1Ssgy8MNPvoI8KxqG6yrEk50iItnnXHkL4q3+
         6cjMKM8+dXroojwV7MPWeM5fyPxP17cdH0IoKIF3EofyvPev+1EVJ3Ec5zq32WpOlF
         /GRYI9V7ZD/91B3p4L5Us32Bosch23pZVzU1hfm4fDG4CRcc1l1K1LwgV2eYjImfF/
         p1uuV+yn5TGuaIs/i66ktZkR98TbXHm0qJfvnkqmoNvmcRdB4bvvbkz/vzgjuJID+a
         TucyyRkRYfwag==
Date:   Mon, 1 Feb 2021 19:43:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/6] soundwire: qcom: add support to missing transport
 params
Message-ID: <20210201141345.GA2771@vkoul-mobl>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129173248.5941-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-21, 17:32, Srinivas Kandagatla wrote:
> Some of the transport parameters derived from device tree
> are not fully parsed by the driver.
> 
> This patch adds support to parse those missing parameters.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 107 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 103 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 6d22df01f354..36e273795cbe 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -54,7 +54,13 @@
>  #define SWRM_MCP_SLV_STATUS					0x1090
>  #define SWRM_MCP_SLV_STATUS_MASK				GENMASK(1, 0)
>  #define SWRM_DP_PORT_CTRL_BANK(n, m)	(0x1124 + 0x100 * (n - 1) + 0x40 * m)
> +#define SWRM_DP_PORT_CTRL_2_BANK(n, m)	(0x1128 + 0x100 * (n - 1) + 0x40 * m)
> +#define SWRM_DP_BLOCK_CTRL_1(n)		(0x112C + 0x100 * (n - 1))
> +#define SWRM_DP_BLOCK_CTRL2_BANK(n, m)	(0x1130 + 0x100 * (n - 1) + 0x40 * m)
> +#define SWRM_DP_PORT_HCTRL_BANK(n, m)	(0x1134 + 0x100 * (n - 1) + 0x40 * m)
>  #define SWRM_DP_BLOCK_CTRL3_BANK(n, m)	(0x1138 + 0x100 * (n - 1) + 0x40 * m)
> +#define SWRM_DIN_DPn_PCM_PORT_CTRL(n)	(0x1054 + 0x100 * (n - 1))
> +
>  #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
>  #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
>  #define SWRM_DP_PORT_CTRL_OFFSET1_SHFT				0x08
> @@ -73,12 +79,20 @@
>  #define QCOM_SDW_MAX_PORTS	14
>  #define DEFAULT_CLK_FREQ	9600000
>  #define SWRM_MAX_DAIS		0xF
> +#define SWR_INVALID_PARAM 0xFF
> +#define SWR_HSTOP_MAX_VAL 0xF
> +#define SWR_HSTART_MIN_VAL 0x0
>  
>  struct qcom_swrm_port_config {
>  	u8 si;
>  	u8 off1;
>  	u8 off2;
>  	u8 bp_mode;
> +	u8 hstart;
> +	u8 hstop;
> +	u8 word_length;
> +	u8 bgp_count;
> +	u8 lane_control;
>  };
>  
>  struct qcom_swrm_ctrl {
> @@ -396,7 +410,13 @@ static int qcom_swrm_port_params(struct sdw_bus *bus,
>  				 struct sdw_port_params *p_params,
>  				 unsigned int bank)
>  {
> -	/* TBD */
> +	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
> +
> +	if (p_params->bps != SWR_INVALID_PARAM)
> +		return ctrl->reg_write(ctrl,
> +				       SWRM_DP_BLOCK_CTRL_1(p_params->num),
> +				       p_params->bps - 1);
> +
>  	return 0;
>  }
>  
> @@ -415,10 +435,32 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
>  
>  	ret = ctrl->reg_write(ctrl, reg, value);
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
>  	}
>  
>  	return ret;
> @@ -470,6 +512,17 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
>  			p_rt->transport_params.offset1 = pcfg->off1;
>  			p_rt->transport_params.offset2 = pcfg->off2;
>  			p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
> +			p_rt->transport_params.blk_grp_ctrl = pcfg->bgp_count;
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
>  		}
>  
>  		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
> @@ -481,6 +534,18 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
>  				p_rt->transport_params.offset1 = pcfg->off1;
>  				p_rt->transport_params.offset2 = pcfg->off2;
>  				p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
> +				p_rt->transport_params.blk_grp_ctrl = pcfg->bgp_count;
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
>  				i++;
>  			}
>  		}
> @@ -728,6 +793,11 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>  	u8 off2[QCOM_SDW_MAX_PORTS];
>  	u8 si[QCOM_SDW_MAX_PORTS];
>  	u8 bp_mode[QCOM_SDW_MAX_PORTS] = { 0, };
> +	u8 hstart[QCOM_SDW_MAX_PORTS];
> +	u8 hstop[QCOM_SDW_MAX_PORTS];
> +	u8 word_length[QCOM_SDW_MAX_PORTS];
> +	u8 bgp_count[QCOM_SDW_MAX_PORTS];
> +	u8 lane_control[QCOM_SDW_MAX_PORTS];
>  	int i, ret, nports, val;
>  
>  	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
> @@ -772,11 +842,40 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>  
>  	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
>  					bp_mode, nports);
> +
> +	ret = of_property_read_u8_array(np, "qcom,ports-hstart", hstart, nports);
> +	if (ret)
> +		memset(hstart, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> +
> +	ret = of_property_read_u8_array(np, "qcom,ports-hstop", hstop, nports);
> +	if (ret)
> +		memset(hstop, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);

why not memset the whole area here and then populate it..?
> +
> +	ret = of_property_read_u8_array(np, "qcom,ports-word-length",
> +					word_length, nports);

> +	if (ret)
> +		memset(word_length, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> +
> +	ret = of_property_read_u8_array(np, "qcom,ports-block-group-count",
> +					bgp_count, nports);
> +	if (ret)
> +		memset(bgp_count, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> +
> +	ret = of_property_read_u8_array(np, "qcom,ports-lane-control",
> +					lane_control, nports);
> +	if (ret)
> +		memset(lane_control, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> +
>  	for (i = 0; i < nports; i++) {
>  		ctrl->pconfig[i].si = si[i];
>  		ctrl->pconfig[i].off1 = off1[i];
>  		ctrl->pconfig[i].off2 = off2[i];
>  		ctrl->pconfig[i].bp_mode = bp_mode[i];
> +		ctrl->pconfig[i].hstart = hstart[i];
> +		ctrl->pconfig[i].hstop = hstop[i];
> +		ctrl->pconfig[i].word_length = word_length[i];
> +		ctrl->pconfig[i].bgp_count = bgp_count[i];
> +		ctrl->pconfig[i].lane_control = lane_control[i];
-- 
~Vinod
