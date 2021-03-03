Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBAC32BCB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383436AbhCCOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842975AbhCCKXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:15 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDF4C08E8A8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:36:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d15so7644770wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e3QV9AU6iRpPBZ6EfqvhfdsrTKr6pttQKnm9uvKZZ7U=;
        b=IOBUVwcx6niakOkcT62K2hkhVczPuQm5I6xuYaF+8e1srwMD9pjXdUan2lMFyS0Ge6
         wO9/7LSVv3youC89baWMQvRgUo0QfNUixNyHCH4DwwenxYhAYA+h7l4RbSaOdQsqmrFI
         BFpEUQ3ja95Y6WrddWuwRVz3RBrdY3cZX5G0VkwtZsf7nk/jNWao9d31JvlugNYsrc/W
         aC4TTBky+zEOzIS0pgTpkDAC/KIwXlH+z/zr4VTnAEZy6dB2S2eTjUex0ioSXEgQX5a5
         FIJmbr0RYoW+BoZ1qgsWpKnE+7XsR4RypCM/KHu1cBQ0VqrjSVG/6yO/P5qwRB82HuOk
         yvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e3QV9AU6iRpPBZ6EfqvhfdsrTKr6pttQKnm9uvKZZ7U=;
        b=X3eqEgQeXnOkZ1VTjAlgIlO6ACAxjDXCPs/4th7y9WR/KK0hTS8JzDlKQnmScJ37tn
         o813X1Ry0/oEtq3ARW+mJYvnRh199SFN87BzKobUTpDIY1LMVo1hmXR/rm5j/d+2Uphv
         kRrTylh0VqONhjBw54ev85PFaH+zY2oJou1b+oq0wC0h/T2hwHNHeR5pfwO6TuJ/QbbA
         IKjB1Vv9EsWKa/i1Q7Q9vySWDjPbE/GsB7zPhg9zUfAoF/a7grtq0uHQBTifAxDxeOEy
         OW3FUInjzteT/9meRJoRHcSwwzT6uHJMG010Oj8lBd71b4/ZfoAUe6Cc4V3Hyx/AT+Bv
         dhFQ==
X-Gm-Message-State: AOAM530+3hcGc5CNSRE1GOSNWSXxkLAhsto+7YrtstfKqjgt0cjxROtk
        qbD0E0QxZhYxizn5G3anNar3BQ==
X-Google-Smtp-Source: ABdhPJytY/PGKRvUg4glI88jU/Ognn20af62M6KZdm4enB7KPRkvg7xChu/XvgYCkgLji+wjM7+4QQ==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr2232266wrz.74.1614764186628;
        Wed, 03 Mar 2021 01:36:26 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id r11sm8942797wrm.26.2021.03.03.01.36.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 01:36:26 -0800 (PST)
Subject: Re: [PATCH v2 1/5] soundwire: qcom: add support to missing transport
 params
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
 <20210226155814.27536-2-srinivas.kandagatla@linaro.org>
 <00842f73-c0fb-5728-3ed0-c0a1fd75f94e@linux.intel.com>
 <31eca99d-9f84-e088-443b-9aae782c2df2@linaro.org>
 <06a687f6-e79c-9bad-32c2-ea61356f882e@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d0dc4c6f-cbd5-06e8-6ed8-234a55f9de9c@linaro.org>
Date:   Wed, 3 Mar 2021 09:36:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <06a687f6-e79c-9bad-32c2-ea61356f882e@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/03/2021 14:29, Pierre-Louis Bossart wrote:
> 
>>>>       for (i = 0; i < nports; i++) {
>>>>           ctrl->pconfig[i].si = si[i];
>>>>           ctrl->pconfig[i].off1 = off1[i];
>>>>           ctrl->pconfig[i].off2 = off2[i];
>>>>           ctrl->pconfig[i].bp_mode = bp_mode[i];
>>>> +        ctrl->pconfig[i].hstart = hstart[i];
>>>> +        ctrl->pconfig[i].hstop = hstop[i];
>>>> +        ctrl->pconfig[i].word_length = word_length[i];
>>>> +        ctrl->pconfig[i].blk_group_count = blk_group_count[i];
>>>> +        ctrl->pconfig[i].lane_control = lane_control[i];
>>>>       }
>>>
>>> I don't get why you test the values parsed from DT before writing the 
>>> registers. Why do test them here? if some values are incorrect it's 
>>> much better to provide an error log instead of writing a partially 
>>> valid setup to hardware, no?
>>
>> from DT we pass parameters for all the master ports, however some of 
>> these parameters are not really applicable for some of the ports! so 
>> the way we handle this is by marking them as 0xFF which means these 
>> values are not applicable for those ports! Having said that I think I 
>> should probably redefine SWR_INVALID_PARAM to QCOM_SWR_PARAM_NA or 
>> something on those lines!
> 
> Humm, do you have an example here? It's a bit odd to define DT 



In DT we describe parameters for each port in an array so, parameters 
for ports that are not applicable/available for that platform can be 
marked with 0xFF.

Most importantly, Some of these registers are only implemented based on 
the data ports. Ex: GROUP_CONTROL register is only implemented for data 
ports that support Group Count other than 0. Like wise for HSTART/STOP 
for Full Data ports only!
So avoiding reading/writing to registers by passing 
invalid/not-applicable value 0xFF made more sense!

Here are some examples of controller instances on SM8250 SoC.

soundwire-controller@3230000 {
	reg = <0 0x3230000 0 0x2000>;
	compatible = "qcom,soundwire-v1.5.1";
	interrupts-extended = <&intc GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
			<&pdc 109 IRQ_TYPE_LEVEL_HIGH>;
	interrupt-names = "core", "wakeup";

	qcom,clock-stop-mode0;
	clocks = <&txmacro>;
	clock-names = "iface";

	qcom,din-ports = <5>;
	qcom,dout-ports = <0>;
	qcom,ports-sinterval-low = /bits/ 8 <0xFF 0x01 0x01 0x03 0x03>;
	qcom,ports-offset1 = /bits/ 8 <0xFF 0x01 0x00 0x02 0x00>;
	qcom,ports-offset2 = /bits/ 8 <0xFF 0x00 0x00 0x00 0x00>;
	qcom,ports-block-pack-mode = /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF>;
	qcom,ports-hstart = /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF>;
	qcom,ports-hstop = /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF>;
	qcom,ports-word-length = /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF>;
	qcom,ports-block-group-count = /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF>;
	qcom,ports-lane-control = /bits/ 8 <0xFF 0x00 0x01 0x00 0x01>;
	qcom,port-offset = <1>;
	#sound-dai-cells = <1>;
	#address-cells = <2>;
	#size-cells = <0>;
};


soundwire-controller@3210000 {
	reg = <0 0x3210000 0 0x2000>;
	compatible = "qcom,soundwire-v1.5.1";
	interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
	clocks = <&rxmacro>;
	clock-names = "iface";
	qcom,clock-stop-mode0;
	qcom,din-ports = <0>;
	qcom,dout-ports = <5>;

	qcom,ports-sinterval-low = /bits/ 8 <0x03 0x1F 0x1F 0x07 0x00>;
	qcom,ports-offset1 = /bits/ 8 <0x00 0x00 0x0B 0x01 0x00>;
	qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
	qcom,ports-hstart = /bits/ 8 <0xFF 0x03 0xFF 0xFF 0xFF>;
	qcom,ports-hstop = /bits/ 8 <0xFF 0x06 0xFF 0xFF 0xFF>;
	qcom,ports-word-length = /bits/ 8 <0x01 0x07 0x04 0xFF 0xFF>;
	qcom,ports-block-pack-mode = /bits/ 8 <0xFF 0x00 0x01 0xFF 0xFF>;
	qcom,ports-lane-control = /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
	qcom,ports-block-group-count = /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0x00>;

	#sound-dai-cells = <1>;
	#address-cells = <2>;
	#size-cells = <0>;
};
> properties that may or may not be valid. If this is intentional and 
> desired, this should still be captured somehow, e.g. in the bindings 
> documentation or in the code with a comment, no?

Yes, I agree with you on this, I should document this in bindings!

--srini


