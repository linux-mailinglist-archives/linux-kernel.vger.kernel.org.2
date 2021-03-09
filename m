Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1967A3341D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhCJPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:45:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:58359 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232523AbhCJPpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:45:11 -0500
IronPort-SDR: iY17vb38ZFTK0YnwRmDiWzVGBTsgvVYMSQ4I7URcqzBgGwzeRad1cnT0VGNuqS6VgSQ6j0MXmV
 gth+dg+ATKHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="176089355"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="176089355"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:45:10 -0800
IronPort-SDR: HqmaViramXuMCp9/kgif+x29hhv50s1Kyy9Okq0ZpTO8MC2xdO7bPrO0r5Mjs1UsmAgF5RtfyO
 VOkV8rq7XeAg==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="403722190"
Received: from huiyingw-mobl.amr.corp.intel.com (HELO [10.212.214.84]) ([10.212.214.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:45:09 -0800
Subject: Re: [PATCH v2 2/5] soundwire: qcom: update port map allocation bit
 mask
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
 <20210309141514.24744-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <50c83be0-8948-8450-4b91-d43cc97f8640@linux.intel.com>
Date:   Tue, 9 Mar 2021 09:55:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309141514.24744-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/21 8:15 AM, Srinivas Kandagatla wrote:
> currently the internal bitmask used for allocating ports starts with offset 0.
> This is bit confusing as data port numbers on Qualcomm controller are valid
> from 1 to 14. So adjust this bit mask accordingly, this will also help while
> adding static port map support.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/qcom.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 6d22df01f354..f4f1c5f2af0b 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -519,7 +519,7 @@ static void qcom_swrm_stream_free_ports(struct qcom_swrm_ctrl *ctrl,
>   			port_mask = &ctrl->din_port_mask;
>   
>   		list_for_each_entry(p_rt, &m_rt->port_list, port_node)
> -			clear_bit(p_rt->num - 1, port_mask);
> +			clear_bit(p_rt->num, port_mask);
>   	}
>   
>   	mutex_unlock(&ctrl->port_lock);
> @@ -552,13 +552,13 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
>   			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
>   				/* Port numbers start from 1 - 14*/
>   				pn = find_first_zero_bit(port_mask, maxport);
> -				if (pn > (maxport - 1)) {
> +				if (pn > (maxport)) {

nit-pick: useless parentheses

>   					dev_err(ctrl->dev, "All ports busy\n");
>   					ret = -EBUSY;
>   					goto err;
>   				}
>   				set_bit(pn, port_mask);
> -				pconfig[nports].num = pn + 1;
> +				pconfig[nports].num = pn;
>   				pconfig[nports].ch_mask = p_rt->ch_mask;
>   				nports++;
>   			}
> @@ -580,7 +580,7 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
>   err:
>   	if (ret) {
>   		for (i = 0; i < nports; i++)
> -			clear_bit(pconfig[i].num - 1, port_mask);
> +			clear_bit(pconfig[i].num, port_mask);
>   	}
>   
>   	mutex_unlock(&ctrl->port_lock);
> @@ -754,6 +754,9 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>   	ctrl->num_dout_ports = val;
>   
>   	nports = ctrl->num_dout_ports + ctrl->num_din_ports;
> +	/* port numbers are non zero, so mark port 0 */

mask?

> +	set_bit(0, &ctrl->dout_port_mask);
> +	set_bit(0, &ctrl->din_port_mask);
>   
>   	ret = of_property_read_u8_array(np, "qcom,ports-offset1",
>   					off1, nports);
> 
