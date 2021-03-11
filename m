Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE03375B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhCKO3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbhCKO3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:29:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A7DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:29:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso13316870wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/vz8gDl5MDjPbVH9KHrcAUmn27/O+atbsXWhS4lWsKY=;
        b=rkspiYjV9FNKkmFIzQEaFCJvgVJY7z8ZsTZNzkb2vVudwYf1iZ0zUDwnwWGoVg4N1X
         HxUrw8jG5SGEwXk5/Yye9e53FtYyUWdIdO5svT34ktoow03b1fWqVQAA2sN8mnGhfg67
         fqOW5xjGN+yZTy7qbosES/rU3GGiD8dLVrDPyZ6w+3bF1H+WIuMgALLEOY65ItSdmWWt
         aorWyhispmczKIoT5mXNjLZzLMAkD5GU4Jh4GaFRdENlKxRiX0oTpK4mXBmB9eBPxnxp
         qVMLQFdhUMLlqK6FpcybMfb662hWDbZ2YqjZMGfABVZh7IPv0wcOHudnCzZul4o64nbO
         ftCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/vz8gDl5MDjPbVH9KHrcAUmn27/O+atbsXWhS4lWsKY=;
        b=Qr8Zi7DQ0zr4PMdvif/TMdM7Cm5rvUCsOpiDigETqRgcrY6/bxF5j3aYFBy3J74DPq
         sr0ozPBoV4tEqlKyOTfAg2uoXKsCdryglFmCPm7e7oTkPBH8VuAtE5Gd9BkkVSjYnh/p
         mwKIZQMkGyDSaV3hTSHtM0UavzxltKJ7FJKCQtIR4ZTzJr7SzTgpHqXX8cD2SQvm1TSo
         GP6uF9nOFekHuScI5N1Dle2o1Ls7cI3YlJCDYfC6rfl7uCZ5RlpirbvbsykeSHUXlOPp
         +WsN1FCUQKsBs5gCDgNgoknitHNv9riQNx2I1swO8Y0OHjZFOU0szQgEjdNy79hdvhqC
         KkOw==
X-Gm-Message-State: AOAM530808A4re3Yq08g5c07SAeZnHMms6U1kMdTgmU1evSc6ukS7GWC
        MWjzPbI5mCSTPZG1FLwltYTkAw==
X-Google-Smtp-Source: ABdhPJz/f31hwubqZ9UY9m+xvMvxdfSlERJS3s8jXE1Y0O3cu/XJz/lC0iqov+wtSlX3rhWj4sLoIQ==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr8472110wmf.136.1615472961081;
        Thu, 11 Mar 2021 06:29:21 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id r11sm4295425wrm.26.2021.03.11.06.29.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:29:20 -0800 (PST)
Subject: Re: [PATCH v2 2/5] soundwire: qcom: update port map allocation bit
 mask
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
 <20210309141514.24744-3-srinivas.kandagatla@linaro.org>
 <50c83be0-8948-8450-4b91-d43cc97f8640@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7f13d7c1-b61a-fd19-92b7-99ccc957750c@linaro.org>
Date:   Thu, 11 Mar 2021 14:29:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <50c83be0-8948-8450-4b91-d43cc97f8640@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2021 15:55, Pierre-Louis Bossart wrote:
> 
> 
> On 3/9/21 8:15 AM, Srinivas Kandagatla wrote:
>> currently the internal bitmask used for allocating ports starts with 
>> offset 0.
>> This is bit confusing as data port numbers on Qualcomm controller are 
>> valid
>> from 1 to 14. So adjust this bit mask accordingly, this will also help 
>> while
>> adding static port map support.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/qcom.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 6d22df01f354..f4f1c5f2af0b 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -519,7 +519,7 @@ static void qcom_swrm_stream_free_ports(struct 
>> qcom_swrm_ctrl *ctrl,
>>               port_mask = &ctrl->din_port_mask;
>>           list_for_each_entry(p_rt, &m_rt->port_list, port_node)
>> -            clear_bit(p_rt->num - 1, port_mask);
>> +            clear_bit(p_rt->num, port_mask);
>>       }
>>       mutex_unlock(&ctrl->port_lock);
>> @@ -552,13 +552,13 @@ static int qcom_swrm_stream_alloc_ports(struct 
>> qcom_swrm_ctrl *ctrl,
>>               list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
>>                   /* Port numbers start from 1 - 14*/
>>                   pn = find_first_zero_bit(port_mask, maxport);
>> -                if (pn > (maxport - 1)) {
>> +                if (pn > (maxport)) {
> 
> nit-pick: useless parentheses

I agree, will remove this and address the other comment too in next spin!

--srini
> 
>>                       dev_err(ctrl->dev, "All ports busy\n");
>>                       ret = -EBUSY;
>>                       goto err;
>>                   }
>>                   set_bit(pn, port_mask);
>> -                pconfig[nports].num = pn + 1;
>> +                pconfig[nports].num = pn;
>>                   pconfig[nports].ch_mask = p_rt->ch_mask;
>>                   nports++;
>>               }
>> @@ -580,7 +580,7 @@ static int qcom_swrm_stream_alloc_ports(struct 
>> qcom_swrm_ctrl *ctrl,
>>   err:
>>       if (ret) {
>>           for (i = 0; i < nports; i++)
>> -            clear_bit(pconfig[i].num - 1, port_mask);
>> +            clear_bit(pconfig[i].num, port_mask);
>>       }
>>       mutex_unlock(&ctrl->port_lock);
>> @@ -754,6 +754,9 @@ static int qcom_swrm_get_port_config(struct 
>> qcom_swrm_ctrl *ctrl)
>>       ctrl->num_dout_ports = val;
>>       nports = ctrl->num_dout_ports + ctrl->num_din_ports;
>> +    /* port numbers are non zero, so mark port 0 */
> 
> mask?
> 
>> +    set_bit(0, &ctrl->dout_port_mask);
>> +    set_bit(0, &ctrl->din_port_mask);
>>       ret = of_property_read_u8_array(np, "qcom,ports-offset1",
>>                       off1, nports);
>>
