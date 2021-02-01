Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C8630AF3D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhBAS2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:28:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:7666 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232477AbhBASQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:16:50 -0500
IronPort-SDR: +RseacCnqil0Cfw2TPuQQjYyM5eHeRbNk7dXgOc0PzWeqQiwPzoVY000NnEzvGRn4HTVDUi7kY
 Z8LHhlwGNZdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="167833506"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="167833506"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:13:26 -0800
IronPort-SDR: t1ZT0Rp5UgHO5+G+Rjs+nf9ceH3biy6QpJfLCdyVByIjGwykT8kUnywRnfCd8mRgTlYb3D1yWN
 G12Cit0zw+Rg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="412516924"
Received: from dkhaldi-mobl1.amr.corp.intel.com (HELO [10.212.126.61]) ([10.212.126.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:13:25 -0800
Subject: Re: [PATCH 1/6] soundwire: qcom: add support to missing transport
 params
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-2-srinivas.kandagatla@linaro.org>
 <29eb1b75-d92f-9641-8181-1fe250b189ec@linux.intel.com>
 <3c801cef-0089-721d-d916-bf3eed060c6c@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fbfd11e5-eab8-f070-15b1-98559dac9214@linux.intel.com>
Date:   Mon, 1 Feb 2021 10:33:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3c801cef-0089-721d-d916-bf3eed060c6c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>   struct qcom_swrm_port_config {
>>>       u8 si;
>>>       u8 off1;
>>>       u8 off2;
>>>       u8 bp_mode;
>>> +    u8 hstart;
>>> +    u8 hstop;
>>> +    u8 word_length;
>>> +    u8 bgp_count;
>>
>> I couldn't figure out what 'bgp' was and had to search. Not sure how 
>> you came up with this abbreviation of "qcom,ports-block-group-count". 
>> Adding a comment wouldn't hurt.
> 
> I will rename this to blk_group_count which makes more sense!

sounds good.


>>
>>> +    u8 lane_control;
>>
>> Are you able to use lane_control != 0 ? I thought we were missing 
>> stuff at the bus.c level?
> Am not sure what is missing in bus.c but we do use lane_control for RX 
> slave on WCD938x codec. This uses datalane 1 for HPH and lane0 for 
> Compander/Class-H and other ports.
> 
> And it works!

Ah, good to know, thanks for the pointer.
