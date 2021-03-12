Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E894339404
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhCLQ4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:56:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:41916 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232506AbhCLQ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:56:36 -0500
IronPort-SDR: rfAVXrSVINwqSjKApjr0Efo3hp+Fi3ZzJb+U3YGE3HPFalidJDAzJL9QBZNdHF0jQsNNnBSpup
 4hbZOnDdOQkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="273900514"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="273900514"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:56:35 -0800
IronPort-SDR: cutKU5prVhwng0292vWVtBP8EBJJ+T4ZwcED7toVSBQeGb+2gIuX44RgbLOOWJZ4uVuG/rCSis
 nMlGnvaUkaeA==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="411064630"
Received: from akharche-mobl2.ccr.corp.intel.com (HELO [10.212.135.254]) ([10.212.135.254])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:56:35 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 1/5] soundwire: add static port mapping support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org
References: <20210312113929.17512-1-srinivas.kandagatla@linaro.org>
 <20210312113929.17512-2-srinivas.kandagatla@linaro.org>
Message-ID: <5869594c-dfd6-c49d-0168-1993cdeb5a43@linux.intel.com>
Date:   Fri, 12 Mar 2021 10:56:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312113929.17512-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/21 5:39 AM, Srinivas Kandagatla wrote:
> Some of the SoundWire device ports are statically mapped to Controller
> ports during design, however there is no way to expose this information
> to the controller. Controllers like Qualcomm ones use this info to setup
> static bandwidth parameters for those ports.
> 
> A generic port allocation is not possible in this cases!
> So this patch adds a new member m_port_map to struct sdw_slave to expose
> this static map.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   include/linux/soundwire/sdw.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index d08039d65825..b032d6ac0b39 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -614,6 +614,7 @@ struct sdw_slave_ops {
>    * @debugfs: Slave debugfs
>    * @node: node for bus list
>    * @port_ready: Port ready completion flag for each Slave port
> + * @m_port_map: static Master port map for each Slave port0 to port14

did you mean port1..port14?

DP0 is a special case that's not supposed to be used for audio transport 
but rather extended control and command?

>    * @dev_num: Current Device Number, values can be 0 or dev_num_sticky
>    * @dev_num_sticky: one-time static Device Number assigned by Bus
>    * @probed: boolean tracking driver state
> @@ -645,6 +646,7 @@ struct sdw_slave {
>   #endif
>   	struct list_head node;
>   	struct completion port_ready[SDW_MAX_PORTS];
> +	unsigned int m_port_map[SDW_MAX_PORTS];
>   	enum sdw_clk_stop_mode curr_clk_stop_mode;
>   	u16 dev_num;
>   	u16 dev_num_sticky;
> 
