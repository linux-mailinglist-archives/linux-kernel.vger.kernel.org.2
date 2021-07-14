Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AEE3C8978
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhGNRRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:17:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:35631 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhGNRRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:17:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="232208011"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="232208011"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="413353696"
Received: from alpinagh-mobl1.amr.corp.intel.com (HELO [10.212.71.223]) ([10.212.71.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:23 -0700
Subject: Re: [PATCH v2 05/16] ASoC: qcom: audioreach: add basic pkt alloc
 support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-6-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <58d6df8d-83ed-c716-81b2-e0927f58da6f@linux.intel.com>
Date:   Wed, 14 Jul 2021 11:30:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714153039.28373-6-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index cc7c1de2f1d9..721ea56b2cb5 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -103,6 +103,12 @@ config SND_SOC_QDSP6
>  	 audio drivers. This includes q6asm, q6adm,
>  	 q6afe interfaces to DSP using apr.
>  
> +config SND_SOC_QCOM_AUDIOREACH
> +	tristate "SoC ALSA audio drives for Qualcomm AUDIOREACH"

typo: drivers?


> +/* container config */
> +struct apm_container_obj  {
> +	struct apm_container_cfg container_cfg;
> +	/* Capablity ID list */

typo: Capability

> +	struct apm_prop_data cap_data;
> +	uint32_t num_capablity_id;


> +static void *__audioreach_alloc_pkt(int payload_size, uint32_t opcode,
> +				     uint32_t token, uint32_t src_port,
> +				     uint32_t dest_port, bool has_cmd_hdr)
> +{
> +	struct apm_cmd_header *cmd_header;
> +	struct gpr_pkt *pkt;
> +	void *p;
> +	int pkt_size = GPR_HDR_SIZE + payload_size;
> +
> +	if (has_cmd_hdr)
> +		pkt_size += APM_CMD_HDR_SIZE;
> +
> +	p = kzalloc(pkt_size, GFP_ATOMIC);

is GFP_ATOMIC required? it's the same question really than my earlier one on spinlock_irqsave, it's rather hard to figure out in what context this code will run.

> +	if (!p)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pkt = p;
> +	pkt->hdr.version = GPR_PKT_VER;
> +	pkt->hdr.hdr_size = 6;

magic number. looks like a missing macro...

> +	pkt->hdr.pkt_size = pkt_size;
> +	pkt->hdr.dest_port = dest_port;
> +	pkt->hdr.src_port = src_port;
> +
> +	pkt->hdr.dest_domain = GPR_DOMAIN_ID_ADSP;
> +	pkt->hdr.src_domain = GPR_DOMAIN_ID_APPS;
> +	pkt->hdr.token = token;
> +	pkt->hdr.opcode = opcode;
> +
> +	if (has_cmd_hdr) {
> +		p = p + GPR_HDR_SIZE;
> +		cmd_header = p;
> +		cmd_header->payload_size = payload_size;
> +	}
> +
> +	return pkt;
> +}

