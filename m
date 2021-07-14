Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A5E3C8983
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbhGNRRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:17:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:35631 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239234AbhGNRR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:17:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="232208058"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="232208058"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="413353793"
Received: from alpinagh-mobl1.amr.corp.intel.com (HELO [10.212.71.223]) ([10.212.71.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:35 -0700
Subject: Re: [PATCH v2 12/16] ASoC: qcom: audioreach: add q6prm support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-13-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <65c935b8-fb36-8da7-9a27-1ecd6559c41b@linux.intel.com>
Date:   Wed, 14 Jul 2021 12:09:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714153039.28373-13-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> +static int q6prm_send_cmd_sync(struct q6prm *prm, struct gpr_pkt *pkt,
> +			uint32_t rsp_opcode)
> +{
> +	gpr_device_t *gdev = prm->gdev;
> +	struct gpr_hdr *hdr = &pkt->hdr;
> +	int rc;
> +
> +	mutex_lock(&prm->lock);
> +	prm->result.opcode = 0;
> +	prm->result.status = 0;
> +
> +	rc = gpr_send_pkt(prm->gdev, pkt);
> +	if (rc < 0)
> +		goto err;
> +
> +	if (rsp_opcode)
> +		rc = wait_event_timeout(prm->wait,
> +					(prm->result.opcode == hdr->opcode) ||
> +					(prm->result.opcode == rsp_opcode),
> +					5 * HZ);
> +	else
> +		rc = wait_event_timeout(prm->wait,
> +					(prm->result.opcode == hdr->opcode),
> +					5 * HZ);
> +
> +	if (!rc) {
> +		dev_err(&gdev->dev, "CMD timeout for [%x] opcode\n",
> +			hdr->opcode);
> +		rc = -ETIMEDOUT;
> +	} else if (prm->result.status > 0) {
> +		dev_err(&gdev->dev, "DSP returned error[%x] %x\n", hdr->opcode,
> +			prm->result.status);
> +		rc = -EINVAL;
> +	} else {
> +		dev_err(&gdev->dev, "DSP returned [%x]\n",
> +			prm->result.status);
> +		rc = 0;
> +	}
> +
> +err:
> +	mutex_unlock(&prm->lock);
> +	return rc;
> +}

In patch7 you had more or less the same code. can a helper be used?

+int audioreach_graph_send_cmd_sync(struct q6apm_graph *graph,
+				   struct gpr_pkt *pkt, uint32_t rsp_opcode)
+{
+
+	struct device *dev = graph->dev;
+	struct gpr_hdr *hdr = &pkt->hdr;
+	int rc;
+
+	mutex_lock(&graph->cmd_lock);
+	graph->result.opcode = 0;
+	graph->result.status = 0;
+
+	rc = gpr_send_port_pkt(graph->port, pkt);
+	if (rc < 0)
+		goto err;
+
+	if (rsp_opcode)
+		rc = wait_event_timeout(graph->cmd_wait,
+					(graph->result.opcode == hdr->opcode) ||
+					(graph->result.opcode == rsp_opcode),
+					5 * HZ);
+	else
+		rc = wait_event_timeout(graph->cmd_wait,
+					(graph->result.opcode == hdr->opcode),
+					5 * HZ);
+
+	if (!rc) {
+		dev_err(dev, "CMD timeout for [%x] opcode\n", hdr->opcode);
+		rc = -ETIMEDOUT;
+	} else if (graph->result.status > 0) {
+		dev_err(dev, "DSP returned error[%x] %x\n", hdr->opcode,
+			graph->result.status);
+		rc = -EINVAL;
+	} else {
+		dev_err(dev, "DSP returned [%x]\n", graph->result.status);
+		rc = 0;
+	}
+
+err:
+	mutex_unlock(&graph->cmd_lock);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(audioreach_graph_send_cmd_sync);


> +static int q6prm_set_hw_core_req(struct device *dev, uint32_t hw_block_id,   bool enable)
> +{
> +	struct prm_cmd_request_hw_core *req;
> +	struct apm_module_param_data *param_data;
> +	struct gpr_pkt *pkt;
> +	struct q6prm *prm = dev_get_drvdata(dev);
> +	gpr_device_t *gdev  = prm->gdev;
> +	void *p;
> +	int rc = 0;
> +	uint32_t opcode, rsp_opcode;
> +
> +	if (enable) {
> +		opcode = PRM_CMD_REQUEST_HW_RSC;
> +		rsp_opcode = PRM_CMD_RSP_REQUEST_HW_RSC;
> +	} else {
> +		opcode = PRM_CMD_RELEASE_HW_RSC;
> +		rsp_opcode = PRM_CMD_RSP_RELEASE_HW_RSC;
> +	}
> +
> +	p = audioreach_alloc_cmd_pkt(sizeof(*req), opcode, 0, gdev->svc.id,
> +				     GPR_PRM_MODULE_IID);
> +	if (IS_ERR(p))
> +		return -ENOMEM;
> +
> +	pkt = p;
> +	req = p + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
> +
> +	param_data = &req->param_data;
> +
> +	param_data->module_instance_id = GPR_PRM_MODULE_IID;
> +	param_data->error_code = 0;
> +	param_data->param_id = PARAM_ID_RSC_HW_CORE;
> +	param_data->param_size = sizeof(*req) - APM_MODULE_PARAM_DATA_SIZE;
> +
> +	req->hw_clk_id = hw_block_id;
> +
> +	q6prm_send_cmd_sync(prm, pkt, rsp_opcode);
> +
> +	kfree(pkt);
> +
> +	return rc;

rc is not assigned, should this not trap the result of sending a command?

> +}
> +
> +static int q6prm_set_lpass_clock(struct device *dev, int clk_id, int clk_attr,
> +				 int clk_root, unsigned int freq)
> +{
> +	struct prm_cmd_request_rsc *req;
> +	struct apm_module_param_data *param_data;
> +	struct gpr_pkt *pkt;
> +	struct q6prm *prm = dev_get_drvdata(dev);
> +	gpr_device_t *gdev  = prm->gdev;
> +	void *p;
> +	int rc = 0;
> +
> +	p = audioreach_alloc_cmd_pkt(sizeof(*req), PRM_CMD_REQUEST_HW_RSC,
> +				     0, gdev->svc.id, GPR_PRM_MODULE_IID);
> +	if (IS_ERR(p))
> +		return -ENOMEM;
> +
> +	pkt = p;
> +	req = p + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
> +
> +	param_data = &req->param_data;
> +
> +	param_data->module_instance_id = GPR_PRM_MODULE_IID;
> +	param_data->error_code = 0;
> +	param_data->param_id = PARAM_ID_RSC_AUDIO_HW_CLK;
> +	param_data->param_size = sizeof(*req) - APM_MODULE_PARAM_DATA_SIZE;
> +
> +	req->num_clk_id = 1;
> +	req->clock_ids[0].clock_id = clk_id;
> +	req->clock_ids[0].clock_freq = freq;
> +	req->clock_ids[0].clock_attri = clk_attr;
> +	req->clock_ids[0].clock_root = clk_root;
> +
> +	q6prm_send_cmd_sync(prm, pkt, PRM_CMD_RSP_REQUEST_HW_RSC);

rc = q6prm_send_cmd_sync(prm, pkt, PRM_CMD_RSP_REQUEST_HW_RSC);

?

> +
> +	kfree(pkt);
> +
> +	return rc;
> +}
> +
