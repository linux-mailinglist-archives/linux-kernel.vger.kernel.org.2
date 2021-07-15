Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD03C9CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbhGOKfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbhGOKf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:35:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E000C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:32:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d2so7177034wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogUkZMQle5D8vhGQlPdaF0V6lQAGwCn5kpEitnw6uQ4=;
        b=uoDFQHz4jKqL3MXptxfoHCEFo6Iis748rmY1c9AJFi0X4+K6J2VE+0YnAgCsOzLho9
         8uvBoMifRA3MEUGcWtEG6MAlyxXP+vbGS9p8xV/VzY88Zi34OU0cyRzfGaqxhLnFa615
         bJmql9PlFqA3J0YHL3an83BVG7pzmDYEx6hSfhqolTtgDkfueK1/SkxMQV6qPps0Xgp/
         geKuho/Wxrg8nNZaUZA69iobd+6oWQWaWezGc2vSF6SiMC9FRKcmAmttMfVG3AhY6d80
         TCHuazurFfwSviWSYDZlBnbtpSyxAwjcK6qphppcOnfQFzTG0govCqUSgLxLSaMiNHBW
         sENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogUkZMQle5D8vhGQlPdaF0V6lQAGwCn5kpEitnw6uQ4=;
        b=XMRuxgprbFt+T102FEsrZB9XlYXfJf9pK0jTSzH7S/N1uK8di6wN/ffFylfayMCBch
         3heRVBJA1uWwbZyzOqfYAluARUbckE31VN/wAPGCEFaTC4UiuZbb8hqHij1cgC55vSSz
         JOtamTCrP8i1O63EjOa0VS3mRIMXx18Odzz3gos6hMhcyqa7ue/dvVgFJWWyW/Ernjp2
         Bv4sMeF3y6VMUyQS31lauARHS2EgLLi2yveNeCBgNJ/dl24SBqpdlnDgdc8SAxdM1LMK
         YV8BcU+XUhx710Z5DHayXFwjeCcH1SamWgyVhdwNPHiydzBFWaMsivkl6oxvn3S8pSnS
         7HpA==
X-Gm-Message-State: AOAM530EjJqfpfa0ANn3WyACDZzAPZwTZi1PEdLIP7Jx+82LJmcIRYs/
        Koz+80sgYaJ4E1Hq3fEir1iPtB+uJrVwVw==
X-Google-Smtp-Source: ABdhPJxYME0Lv0oK8f5bk3/BtLMmAIb0vMrNxC2DwBMe5yMoa0qhcVSiuNlBu2Jgf1Z+gsiJRI7ptg==
X-Received: by 2002:a5d:5043:: with SMTP id h3mr4611038wrt.333.1626345154649;
        Thu, 15 Jul 2021 03:32:34 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id p2sm4507732wmg.6.2021.07.15.03.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 03:32:34 -0700 (PDT)
Subject: Re: [PATCH v2 12/16] ASoC: qcom: audioreach: add q6prm support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-13-srinivas.kandagatla@linaro.org>
 <65c935b8-fb36-8da7-9a27-1ecd6559c41b@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <50357647-7478-3848-74c4-1de50851d5d0@linaro.org>
Date:   Thu, 15 Jul 2021 11:32:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <65c935b8-fb36-8da7-9a27-1ecd6559c41b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2021 18:09, Pierre-Louis Bossart wrote:
> 
> 
> 
>> +static int q6prm_send_cmd_sync(struct q6prm *prm, struct gpr_pkt *pkt,
>> +			uint32_t rsp_opcode)
>> +{
>> +	gpr_device_t *gdev = prm->gdev;
>> +	struct gpr_hdr *hdr = &pkt->hdr;
>> +	int rc;
>> +
>> +	mutex_lock(&prm->lock);
>> +	prm->result.opcode = 0;
>> +	prm->result.status = 0;
>> +
>> +	rc = gpr_send_pkt(prm->gdev, pkt);
>> +	if (rc < 0)
>> +		goto err;
>> +
>> +	if (rsp_opcode)
>> +		rc = wait_event_timeout(prm->wait,
>> +					(prm->result.opcode == hdr->opcode) ||
>> +					(prm->result.opcode == rsp_opcode),
>> +					5 * HZ);
>> +	else
>> +		rc = wait_event_timeout(prm->wait,
>> +					(prm->result.opcode == hdr->opcode),
>> +					5 * HZ);
>> +
>> +	if (!rc) {
>> +		dev_err(&gdev->dev, "CMD timeout for [%x] opcode\n",
>> +			hdr->opcode);
>> +		rc = -ETIMEDOUT;
>> +	} else if (prm->result.status > 0) {
>> +		dev_err(&gdev->dev, "DSP returned error[%x] %x\n", hdr->opcode,
>> +			prm->result.status);
>> +		rc = -EINVAL;
>> +	} else {
>> +		dev_err(&gdev->dev, "DSP returned [%x]\n",
>> +			prm->result.status);
>> +		rc = 0;
>> +	}
>> +
>> +err:
>> +	mutex_unlock(&prm->lock);
>> +	return rc;
>> +}
> 
> In patch7 you had more or less the same code. can a helper be used?

Its possible, will abstract this out in audioreach.c.


> 
> +int audioreach_graph_send_cmd_sync(struct q6apm_graph *graph,
> +				   struct gpr_pkt *pkt, uint32_t rsp_opcode)
> +{
> +
> +	struct device *dev = graph->dev;
> +	struct gpr_hdr *hdr = &pkt->hdr;
> +	int rc;
> +
> +	mutex_lock(&graph->cmd_lock);
> +	graph->result.opcode = 0;
> +	graph->result.status = 0;
> +
> +	rc = gpr_send_port_pkt(graph->port, pkt);
> +	if (rc < 0)
> +		goto err;
> +
> +	if (rsp_opcode)
> +		rc = wait_event_timeout(graph->cmd_wait,
> +					(graph->result.opcode == hdr->opcode) ||
> +					(graph->result.opcode == rsp_opcode),
> +					5 * HZ);
> +	else
> +		rc = wait_event_timeout(graph->cmd_wait,
> +					(graph->result.opcode == hdr->opcode),
> +					5 * HZ);
> +
> +	if (!rc) {
> +		dev_err(dev, "CMD timeout for [%x] opcode\n", hdr->opcode);
> +		rc = -ETIMEDOUT;
> +	} else if (graph->result.status > 0) {
> +		dev_err(dev, "DSP returned error[%x] %x\n", hdr->opcode,
> +			graph->result.status);
> +		rc = -EINVAL;
> +	} else {
> +		dev_err(dev, "DSP returned [%x]\n", graph->result.status);
> +		rc = 0;
> +	}
> +
> +err:
> +	mutex_unlock(&graph->cmd_lock);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(audioreach_graph_send_cmd_sync);
> 
> 
>> +static int q6prm_set_hw_core_req(struct device *dev, uint32_t hw_block_id,   bool enable)
>> +{
>> +	struct prm_cmd_request_hw_core *req;
>> +	struct apm_module_param_data *param_data;
>> +	struct gpr_pkt *pkt;
>> +	struct q6prm *prm = dev_get_drvdata(dev);
>> +	gpr_device_t *gdev  = prm->gdev;
>> +	void *p;
>> +	int rc = 0;
>> +	uint32_t opcode, rsp_opcode;
>> +
>> +	if (enable) {
>> +		opcode = PRM_CMD_REQUEST_HW_RSC;
>> +		rsp_opcode = PRM_CMD_RSP_REQUEST_HW_RSC;
>> +	} else {
>> +		opcode = PRM_CMD_RELEASE_HW_RSC;
>> +		rsp_opcode = PRM_CMD_RSP_RELEASE_HW_RSC;
>> +	}
>> +
>> +	p = audioreach_alloc_cmd_pkt(sizeof(*req), opcode, 0, gdev->svc.id,
>> +				     GPR_PRM_MODULE_IID);
>> +	if (IS_ERR(p))
>> +		return -ENOMEM;
>> +
>> +	pkt = p;
>> +	req = p + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
>> +
>> +	param_data = &req->param_data;
>> +
>> +	param_data->module_instance_id = GPR_PRM_MODULE_IID;
>> +	param_data->error_code = 0;
>> +	param_data->param_id = PARAM_ID_RSC_HW_CORE;
>> +	param_data->param_size = sizeof(*req) - APM_MODULE_PARAM_DATA_SIZE;
>> +
>> +	req->hw_clk_id = hw_block_id;
>> +
>> +	q6prm_send_cmd_sync(prm, pkt, rsp_opcode);
>> +
>> +	kfree(pkt);
>> +
>> +	return rc;
> 
> rc is not assigned, should this not trap the result of sending a command?
My bad! will fix such instances.


--srini
