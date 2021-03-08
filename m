Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7922E3312F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhCHQJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:09:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:55326 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231148AbhCHQIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:08:40 -0500
IronPort-SDR: E1EKJIbrG0I6teYnQ1vMujRGvqXt6z0mSnlisY56/XNe14YLExgBwB26ltpoRaXLcuzdNRzf9k
 ahnIy/rmbpkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175670117"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="175670117"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:08:39 -0800
IronPort-SDR: 2VERmWGctb+b5z/m+BKxlPqrNO9O0q4LWw6g4Par9ALswrtH4t1omCAI5olzZPl+6b0BgjWcV5
 IUE1gHVED7gg==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="430419063"
Received: from dbdavenp-mobl1.amr.corp.intel.com (HELO [10.212.234.206]) ([10.212.234.206])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:08:38 -0800
Subject: Re: [PATCH v3 8/9] soundwire: qcom: add auto enumeration support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
 <20210308134957.16024-9-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ab00438b-dbb9-e6c6-019a-d50494e5dee1@linux.intel.com>
Date:   Mon, 8 Mar 2021 09:56:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308134957.16024-9-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int qcom_swrm_enumerate(struct sdw_bus *bus)
> +{
> +	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
> +	struct sdw_slave *slave, *_s;
> +	struct sdw_slave_id id;
> +	u32 val1, val2;
> +	bool found;
> +	u64 addr;
> +	int i;
> +	char *buf1 = (char *)&val1, *buf2 = (char *)&val2;
> +
> +	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
> +		/*SCP_Devid5 - Devid 4*/
> +		ctrl->reg_read(ctrl, SWRM_ENUMERATOR_SLAVE_DEV_ID_1(i), &val1);
> +
> +		/*SCP_Devid3 - DevId 2 Devid 1 Devid 0*/
> +		ctrl->reg_read(ctrl, SWRM_ENUMERATOR_SLAVE_DEV_ID_2(i), &val2);
> +
> +		if (!val1 && !val2)
> +			break;
> +
> +		addr = buf2[1] | (buf2[0] << 8) | (buf1[3] << 16) |
> +			((u64)buf1[2] << 24) | ((u64)buf1[1] << 32) |
> +			((u64)buf1[0] << 40);
> +
> +		sdw_extract_slave_id(bus, addr, &id);
> +		found = false;
> +		/* Now compare with entries */
> +		list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
> +			if (sdw_compare_devid(slave, id) == 0) {
> +				u32 status = qcom_swrm_get_n_device_status(ctrl, i);
> +
> +				found = true;
> +				if (status == SDW_SLAVE_ATTACHED) {
> +					slave->dev_num = i;
> +					mutex_lock(&bus->bus_lock);
> +					set_bit(i, bus->assigned);
> +					mutex_unlock(&bus->bus_lock);
> +
> +				}

you haven't changed that part, if the device is not in DT we should 
still set bus->assigned::i

