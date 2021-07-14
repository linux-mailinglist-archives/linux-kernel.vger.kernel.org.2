Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFD3C897B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbhGNRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:17:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:35631 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238498AbhGNRRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:17:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="232208026"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="232208026"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:27 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="413353730"
Received: from alpinagh-mobl1.amr.corp.intel.com (HELO [10.212.71.223]) ([10.212.71.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:26 -0700
Subject: Re: [PATCH v2 06/16] ASoC: qcom: audioreach: add q6apm support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-7-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <77b9d17d-33b6-8a7a-bb1d-e32543d9da79@linux.intel.com>
Date:   Wed, 14 Jul 2021 11:40:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714153039.28373-7-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>  /* SubGraph Config */
> @@ -32,7 +33,7 @@ struct apm_sub_graph_params  {
>  /* container config */
>  struct apm_container_obj  {
>  	struct apm_container_cfg container_cfg;
> -	/* Capablity ID list */
> +	/* Capability ID list */

squash in wrong patch, this should have been included in the previous patch.

>  	struct apm_prop_data cap_data;
>  	uint32_t num_capablity_id;

and this is still wrong...

>  	uint32_t capability_id;
> @@ -270,3 +271,308 @@ void *audioreach_alloc_apm_cmd_pkt(int pkt_size, uint32_t opcode,
>  				       APM_MODULE_INSTANCE_ID,
>  				       true);
>  }
> +
> +static void apm_populate_container_config(
> +			struct apm_container_obj *cfg,
> +			struct audioreach_container *cont)
> +{
> +
> +	/* Container Config */
> +	cfg->container_cfg.container_id = cont->container_id;
> +	cfg->container_cfg.num_prop = 4;
> +
> +	/* Capablity list */

Man, again ...

> +	cfg->cap_data.prop_id = APM_CONTAINER_PROP_ID_CAPABILITY_LIST;
> +	cfg->cap_data.prop_size = APM_CONTAINER_PROP_ID_CAPABILITY_SIZE;
> +	cfg->num_capablity_id = 1;
> +	cfg->capability_id = cont->capability_id;
> +
> +	/* Graph Position */
> +	cfg->pos_data.prop_id = APM_CONTAINER_PROP_ID_GRAPH_POS;
> +	cfg->pos_data.prop_size = sizeof(struct apm_cont_prop_id_graph_pos);
> +	cfg->pos.graph_pos = cont->graph_pos;
> +
> +	/* Stack size */
> +	cfg->stack_data.prop_id = APM_CONTAINER_PROP_ID_STACK_SIZE;
> +	cfg->stack_data.prop_size = sizeof(struct
> +					       apm_cont_prop_id_stack_size);
> +	cfg->stack.stack_size = cont->stack_size;
> +
> +	/* Proc domain */
> +	cfg->domain_data.prop_id = APM_CONTAINER_PROP_ID_PROC_DOMAIN;
> +	cfg->domain_data.prop_size = sizeof(struct
> +					       apm_cont_prop_id_domain);
> +	cfg->domain.proc_domain = cont->proc_domain;
> +}

> +static struct audioreach_graph *q6apm_get_audioreach_graph(struct q6apm *apm,
> +						      uint32_t graph_id)
> +{
> +	struct audioreach_graph *graph = NULL;

useless init

> +	struct audioreach_graph_info *info;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&apm->lock, flags);
> +	graph = idr_find(&apm->graph_idr, graph_id);
> +	spin_unlock_irqrestore(&apm->lock, flags);
> +
> +	if (graph) {
> +		kref_get(&graph->refcount);
> +		return graph;
> +	}
> +
> +	info = idr_find(&apm->graph_info_idr, graph_id);
> +
> +	if (!info)
> +		return ERR_PTR(-ENODEV);
> +
> +	graph = kzalloc(sizeof(*graph), GFP_KERNEL);
> +	if (!graph)
> +		return ERR_PTR(-ENOMEM);
> +
> +	graph->apm = apm;
> +	graph->info = info;
> +	graph->id = graph_id;
> +
> +	/* Assuming Linear Graphs only for now! */
> +	graph->graph = audioreach_alloc_graph_pkt(apm, &info->sg_list, graph_id);
> +	if (IS_ERR(graph->graph))
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock(&apm->lock);
> +	idr_alloc(&apm->graph_idr, graph, graph_id,
> +		  graph_id + 1, GFP_ATOMIC);

ATOMIC?

> +	spin_unlock(&apm->lock);
> +
> +	kref_init(&graph->refcount);
> +
> +	q6apm_send_cmd_sync(apm, graph->graph, 0);
> +
> +	return graph;
> +}
> +
> +static int audioreach_graph_mgmt_cmd(struct audioreach_graph *graph,
> +				      uint32_t opcode)
> +{
> +	struct gpr_pkt *pkt;
> +	void *p;
> +	int i = 0, rc, payload_size;
> +	struct q6apm *apm = graph->apm;
> +	struct audioreach_graph_info *info = graph->info;
> +	int num_sub_graphs = info->num_sub_graphs;
> +	struct apm_graph_mgmt_cmd *mgmt_cmd;
> +	struct apm_module_param_data *param_data;
> +	struct audioreach_sub_graph *sg;
> +
> +	payload_size = APM_GRAPH_MGMT_PSIZE(num_sub_graphs);
> +
> +	p = audioreach_alloc_apm_cmd_pkt(payload_size, opcode, 0);
> +	if (IS_ERR(p))
> +		return -ENOMEM;
> +
> +	pkt = p;
> +	p = p + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
> +
> +	mgmt_cmd = p;
> +	mgmt_cmd->num_sub_graphs = num_sub_graphs;
> +
> +	param_data = &mgmt_cmd->param_data;
> +	param_data->module_instance_id = APM_MODULE_INSTANCE_ID;
> +	param_data->param_id = APM_PARAM_ID_SUB_GRAPH_LIST;
> +	param_data->param_size = payload_size - APM_MODULE_PARAM_DATA_SIZE;
> +
> +	list_for_each_entry(sg, &info->sg_list, node) {
> +		mgmt_cmd->sub_graph_id_list[i++] = sg->sub_graph_id;
> +	}
> +
> +	rc = q6apm_send_cmd_sync(apm, pkt, 0);
> +
> +	kfree(pkt);
> +
> +	return rc;
> +}
> +
> +static void q6apm_put_audioreach_graph(struct kref *ref)
> +{
> +	struct audioreach_graph *graph;
> +	struct q6apm *apm;
> +	unsigned long flags;
> +
> +	graph = container_of(ref, struct audioreach_graph, refcount);
> +	apm = graph->apm;
> +
> +	audioreach_graph_mgmt_cmd(graph, APM_CMD_GRAPH_CLOSE);
> +
> +	spin_lock_irqsave(&apm->lock, flags);
> +	graph = idr_remove(&apm->graph_idr, graph->id);
> +	spin_unlock_irqrestore(&apm->lock, flags);
> +
> +	kfree(graph->graph);
> +	kfree(graph);

earlier in the _get routine, you had a kref_get(&graph->refcount)

is it intentional that there's kref_put?

adding a comment on the refcounts might be useful...
