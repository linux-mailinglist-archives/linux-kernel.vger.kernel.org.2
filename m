Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3863341D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhCJPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:45:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:58359 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCJPpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:45:14 -0500
IronPort-SDR: 4Y/B/dF594Fpl+TSIz75XyJbTD16igLimXn2eRgnAIjbpNBNzux/Rnr9ud2g9wQyAUvAWeWZ5t
 NtrD2PBzCq/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="176089373"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="176089373"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:45:13 -0800
IronPort-SDR: p60gojLrqWi7gsJ+jGQIvHKjinxj4Uyg3tK8TS2R54X0M1l56f9wlmWyvVrGUD3oyomvZXEd29
 rLz46anVIlZg==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="403722234"
Received: from huiyingw-mobl.amr.corp.intel.com (HELO [10.212.214.84]) ([10.212.214.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:45:12 -0800
Subject: Re: [PATCH v2 3/5] soundwire: qcom: add static port map support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
 <20210309141514.24744-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cc812a5b-c3c3-bb46-f2fe-3e0a14cf0524@linux.intel.com>
Date:   Tue, 9 Mar 2021 10:10:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309141514.24744-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>   	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
> @@ -473,8 +475,13 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
>   		}
>   
>   		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
> +			slave = s_rt->slave;
>   			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
> -				pcfg = &ctrl->pconfig[i];
> +				m_port = slave->m_port_map[_rtp->num - 1];
> +				if (m_port)
> +					pcfg = &ctrl->pconfig[m_port - 1];
> +				else
> +					pcfg = &ctrl->pconfig[i];

Maybe add a short comment on port allocation, I had to think a bit to 
figure out why the -1 was required on both peripheral and manager but it 
is not below [1]

>   				p_rt->transport_params.port_num = p_rt->num;
>   				p_rt->transport_params.sample_interval =
>   					pcfg->si + 1;
> @@ -535,8 +542,10 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
>   	struct sdw_master_runtime *m_rt;
>   	struct sdw_slave_runtime *s_rt;
>   	struct sdw_port_runtime *p_rt;
> +	struct sdw_slave *slave;
>   	unsigned long *port_mask;
>   	int i, maxport, pn, nports = 0, ret = 0;
> +	unsigned int m_port;
>   
>   	mutex_lock(&ctrl->port_lock);
>   	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> @@ -549,9 +558,15 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
>   		}
>   
>   		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
> +			slave = s_rt->slave;
>   			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
> +				m_port = slave->m_port_map[p_rt->num - 1];
>   				/* Port numbers start from 1 - 14*/
> -				pn = find_first_zero_bit(port_mask, maxport);
> +				if (m_port)
> +					pn = m_port;
> +				else
> +					pn = find_first_zero_bit(port_mask, maxport);

[1]

> +
>   				if (pn > (maxport)) {
>   					dev_err(ctrl->dev, "All ports busy\n");
>   					ret = -EBUSY;
> 
