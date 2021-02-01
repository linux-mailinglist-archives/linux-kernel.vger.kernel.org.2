Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA8D30AC01
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhBAPvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhBAPvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:51:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C576C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:50:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c4so14390959wru.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cAK4vIVBbU+Jp0USNyRNxG4jbh7NlGlG/eznvI/LP9w=;
        b=Opy0DmlFOQRXeOK3t/mO7tnNn976fIQx0Lq1vP6TuBtr6zYhMUjRUypHUnnz8ljMJ7
         eRbi5g9kRv2aImfPx31wgavX0cudZQYGwrZHVdBM0+9rPy2FTIjF3zVy2SB6le5RI9iU
         /R1Uqfu/NAxZ6ua4ZC53bkMz15cyFdDij2p+WviaLz1OoSWS/dx5Dpk8EZanCvKt//6b
         4axwTvarI6tpIbhXFlBJbo/b/6DesjCTG1yWSPhX9lfa93aEWFqZQhXHZv8kv7j12Y5P
         KOMPxj3fQvnWiIUZ0Ut2WYETjo7bZlqFogV1gVWv0c4mc9Pgp3zFbkqO+wMupPasbo0x
         Re8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cAK4vIVBbU+Jp0USNyRNxG4jbh7NlGlG/eznvI/LP9w=;
        b=TgoFoGTFaRMYSXr38KTWASEmvoxvbG0ih8Ja3Cm4OwaoyR4cAL2aKGIzBOdoLw5XTA
         14Cy/NeXhakibFafHWrz4GNsHLY4ZjzMAOE/6KvsMOoPrMj8zRNIpktTmNMdJ8m6KI5A
         afiLnLqOnm/6BZVWtBCprUvY3QmP8JE+4QsmjISKlspfuxy/Afas55t9NPxhk6uw7e/F
         xF+kwHxBBIvj3VJM3go5CBz6gDJJM1U5Z+aP/Wg/TkSarlRQTcOx02pyxbcKXkWysEgc
         wshxFHDy56Q98LtQoFr9tGyZjrUNyi0VyJm66otWANlhe93ZO/8c5uSovL1pdCjs10rp
         hlMQ==
X-Gm-Message-State: AOAM533G6E8kOg5+QrN45A+mng5x5Q7cEPUzlaa9+X3i+ZokTYZ5Xrtd
        yOGXPcoaVSzrWwMfOEyce9XTRw==
X-Google-Smtp-Source: ABdhPJzjFJi56q6RhBCr3OYMoyU2YsNfEwavxL8yzFcgorzJpPyTckDIgXFuY2O0M9eRlijRrnSnyg==
X-Received: by 2002:a5d:4f86:: with SMTP id d6mr19113800wru.246.1612194620054;
        Mon, 01 Feb 2021 07:50:20 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l11sm26391629wrt.23.2021.02.01.07.50.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:50:19 -0800 (PST)
Subject: Re: [PATCH 1/6] soundwire: qcom: add support to missing transport
 params
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-2-srinivas.kandagatla@linaro.org>
 <29eb1b75-d92f-9641-8181-1fe250b189ec@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3c801cef-0089-721d-d916-bf3eed060c6c@linaro.org>
Date:   Mon, 1 Feb 2021 15:50:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <29eb1b75-d92f-9641-8181-1fe250b189ec@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/01/2021 19:20, Pierre-Louis Bossart wrote:
> 
>>   struct qcom_swrm_port_config {
>>       u8 si;
>>       u8 off1;
>>       u8 off2;
>>       u8 bp_mode;
>> +    u8 hstart;
>> +    u8 hstop;
>> +    u8 word_length;
>> +    u8 bgp_count;
> 
> I couldn't figure out what 'bgp' was and had to search. Not sure how you 
> came up with this abbreviation of "qcom,ports-block-group-count". Adding 
> a comment wouldn't hurt.

I will rename this to blk_group_count which makes more sense!

> 
>> +    u8 lane_control;
> 
> Are you able to use lane_control != 0 ? I thought we were missing stuff 
> at the bus.c level?
Am not sure what is missing in bus.c but we do use lane_control for RX 
slave on WCD938x codec. This uses datalane 1 for HPH and lane0 for 
Compander/Class-H and other ports.

And it works!

--srini
> 
