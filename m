Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B504D32C3E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354438AbhCDAIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:08:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:63205 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1390535AbhCCWKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:10:10 -0500
IronPort-SDR: SD2vLxZcJ0EFrpvHSy4AUDihSFGvnsysWXdEsFrj9dAbpSTByvGz5K02XsgRwuS88L0OeHVf2B
 QbxJe+5QraWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="174925418"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="174925418"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 13:59:13 -0800
IronPort-SDR: xPuyXcgcp6AOnk3OFK851lgX0vAM/NBvbQ0XwP74WyfCB4aJvCI4Javx8OhCLDT8ngD4ZjmfuB
 gl+tbVVgTmgg==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="586487017"
Received: from srcook1-mobl1.amr.corp.intel.com (HELO [10.209.143.11]) ([10.209.143.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 13:59:12 -0800
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
 <06a687f6-e79c-9bad-32c2-ea61356f882e@linux.intel.com>
 <d0dc4c6f-cbd5-06e8-6ed8-234a55f9de9c@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <de3b8223-f51d-6cb1-6346-7bd7dcefb482@linux.intel.com>
Date:   Wed, 3 Mar 2021 10:16:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d0dc4c6f-cbd5-06e8-6ed8-234a55f9de9c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> soundwire-controller@3210000 {
>      reg = <0 0x3210000 0 0x2000>;
>      compatible = "qcom,soundwire-v1.5.1";
>      interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
>      clocks = <&rxmacro>;
>      clock-names = "iface";
>      qcom,clock-stop-mode0;
>      qcom,din-ports = <0>;
>      qcom,dout-ports = <5>;
> 
>      qcom,ports-sinterval-low = /bits/ 8 <0x03 0x1F 0x1F 0x07 0x00>;
>      qcom,ports-offset1 = /bits/ 8 <0x00 0x00 0x0B 0x01 0x00>;
>      qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
>      qcom,ports-hstart = /bits/ 8 <0xFF 0x03 0xFF 0xFF 0xFF>;
>      qcom,ports-hstop = /bits/ 8 <0xFF 0x06 0xFF 0xFF 0xFF>;
>      qcom,ports-word-length = /bits/ 8 <0x01 0x07 0x04 0xFF 0xFF>;
>      qcom,ports-block-pack-mode = /bits/ 8 <0xFF 0x00 0x01 0xFF 0xFF>;
>      qcom,ports-lane-control = /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
>      qcom,ports-block-group-count = /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0x00>;
> 
>      #sound-dai-cells = <1>;
>      #address-cells = <2>;
>      #size-cells = <0>;
> };
>> properties that may or may not be valid. If this is intentional and 
>> desired, this should still be captured somehow, e.g. in the bindings 
>> documentation or in the code with a comment, no?
> 
> Yes, I agree with you on this, I should document this in bindings!

thanks for the explanations, it'd be useful indeed to document what this 
magic 0xFF value means.

