Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0966630AC05
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhBAPwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhBAPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:51:44 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21B6C061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:50:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o5so3405566wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9SQRjueWaKmSSazcBA8yDI55u3K41q7hZM11WC1U8Ik=;
        b=mTKjnoJugjcXR3sKFULi+p9zfv/Th63Paq4Oq+Kkz/A6W6SNSz6miH0NykGwY111Fo
         ht/kLHAf6HpEd2Q8L1TfvUKVAKrmaezO15bKWUS7G6lSBjGeLfm8p5uI3UWssnqO07dc
         u9eFYxco7bWXUulvtxM2HFlgDd/nac0SYOYdZtxb711hhIdLpd5aOXNLyInT93oGx6iL
         382PyA2w5qmbabY27r8GdTDrjm/XjlvQxg1plS0V11joAHd+8IfWI1ndCnRDm89ZqXeW
         t3lVF+Q19zXwTHxFwzYC5bfhVXaO8SQxrXbjROn8Z0cgr2cJTR8DkH3qCeKGWVuEvGZG
         oucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9SQRjueWaKmSSazcBA8yDI55u3K41q7hZM11WC1U8Ik=;
        b=Y41HJzOLyWpOghoF2rxMOUevrNqO90jpkiVj9GdTZNjezYzHA8AKiNGNpAOHMnyvms
         pBcJR3bAKcXrTq5LorUrglTQngz498nhxUPQjvC0xuPAQlXJ4brD9d3CttCGvdzv1o7r
         c6VjeqNmW9DiE4QbgfFixUrqAB3696eFuJ/YcqPrv6ZO4mlXnR16ovNEO2T7GvXvaRKF
         8WQIkxxEb17t+0oWJ/METk6ea5UxCtziNpuwzl14oH5ObD/ADuQMxXGrPZnsH1zc4g0q
         snvIcQm80CqCGNmDaBGnYg6J8MbRKgV9QaCQRraZ4G1N/CyCkw4EsSlAj2L4kdlOctxh
         fiGw==
X-Gm-Message-State: AOAM533pICWb8p3F42perI5I/3NpqcpaKfrBxMsWUAaxPhXazK7zIy6E
        D5vIrtiGEHpYS40/MAdIh0V6Vg==
X-Google-Smtp-Source: ABdhPJx9ocHG2qdEixxtdblxCEnXXx8oNiCtR+emo6iZ2yc1eaNp7dchIjWPaNrutZ5z2nz9whFZgQ==
X-Received: by 2002:a1c:de54:: with SMTP id v81mr7898989wmg.181.1612194637773;
        Mon, 01 Feb 2021 07:50:37 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id s23sm5872363wmc.29.2021.02.01.07.50.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:50:37 -0800 (PST)
Subject: Re: [PATCH 4/6] soundwire: qcom: start the clock during
 initialization
To:     Vinod Koul <vkoul@kernel.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-5-srinivas.kandagatla@linaro.org>
 <20210201142134.GC2771@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bdedf84c-68fd-767d-8b3b-5a6ba03e03d8@linaro.org>
Date:   Mon, 1 Feb 2021 15:50:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210201142134.GC2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 14:21, Vinod Koul wrote:
> On 29-01-21, 17:32, Srinivas Kandagatla wrote:
>> Start the clock during initialization.
> 
> A detailed log please, which clock..? Also how do older controllers work
> w/o this clk

By default this is ON, however depending on that is not really reliable!

Explicitly enabling this will make things clear when we add clk pause 
feature for this driver!

--srini
> 
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/qcom.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 3669bac11a32..83df15d83935 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -47,6 +47,8 @@
>>   #define SWRM_MCP_FRAME_CTRL_BANK_ADDR(m)		(0x101C + 0x40 * (m))
>>   #define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK			GENMASK(2, 0)
>>   #define SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK			GENMASK(7, 3)
>> +#define SWRM_MCP_BUS_CTRL					0x1044
>> +#define SWRM_MCP_BUS_CLK_START					BIT(1)
>>   #define SWRM_MCP_CFG_ADDR					0x1048
>>   #define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK		GENMASK(21, 17)
>>   #define SWRM_DEF_CMD_NO_PINGS					0x1f
>> @@ -345,6 +347,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>>   	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
>>   	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
>>   
>> +	ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
>>   	/* Configure number of retries of a read/write cmd */
>>   	if (ctrl->version_major == 1 && ctrl->version_minor >= 5 &&
>>   	    ctrl->version_step >= 1) {
>> -- 
>> 2.21.0
> 
