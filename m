Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD5732A995
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244590AbhCBSfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:35:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:45308 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351442AbhCBPrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:47:35 -0500
IronPort-SDR: 8tIcRBjAHevkoaj6AYwJyIomDI1ZtOr79gjQflzgtH9yeq9VS9ps/tqwterUrfebdlAB7ZUgHL
 krGrj2uZpn2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="183457935"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="183457935"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:38:14 -0800
IronPort-SDR: pd0hx9i9OFPb+eSE5RBvDAfkiQOAmym7xU9WtdTxfu5sfHJ5wAHS2J8HlY7DJb8AkdvcJ5oQJH
 NfIfu93nSH+w==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406768940"
Received: from bgrewell-mobl3.amr.corp.intel.com (HELO [10.212.242.206]) ([10.212.242.206])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:38:13 -0800
Subject: Re: [PATCH v2 1/5] soundwire: qcom: add support to missing transport
 params
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
 <20210226155814.27536-2-srinivas.kandagatla@linaro.org>
 <00842f73-c0fb-5728-3ed0-c0a1fd75f94e@linux.intel.com>
 <31eca99d-9f84-e088-443b-9aae782c2df2@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <06a687f6-e79c-9bad-32c2-ea61356f882e@linux.intel.com>
Date:   Tue, 2 Mar 2021 08:29:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <31eca99d-9f84-e088-443b-9aae782c2df2@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>       for (i = 0; i < nports; i++) {
>>>           ctrl->pconfig[i].si = si[i];
>>>           ctrl->pconfig[i].off1 = off1[i];
>>>           ctrl->pconfig[i].off2 = off2[i];
>>>           ctrl->pconfig[i].bp_mode = bp_mode[i];
>>> +        ctrl->pconfig[i].hstart = hstart[i];
>>> +        ctrl->pconfig[i].hstop = hstop[i];
>>> +        ctrl->pconfig[i].word_length = word_length[i];
>>> +        ctrl->pconfig[i].blk_group_count = blk_group_count[i];
>>> +        ctrl->pconfig[i].lane_control = lane_control[i];
>>>       }
>>
>> I don't get why you test the values parsed from DT before writing the 
>> registers. Why do test them here? if some values are incorrect it's 
>> much better to provide an error log instead of writing a partially 
>> valid setup to hardware, no?
> 
> from DT we pass parameters for all the master ports, however some of 
> these parameters are not really applicable for some of the ports! so the 
> way we handle this is by marking them as 0xFF which means these values 
> are not applicable for those ports! Having said that I think I should 
> probably redefine SWR_INVALID_PARAM to QCOM_SWR_PARAM_NA or something on 
> those lines!

Humm, do you have an example here? It's a bit odd to define DT 
properties that may or may not be valid. If this is intentional and 
desired, this should still be captured somehow, e.g. in the bindings 
documentation or in the code with a comment, no?
