Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A4B3375B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhCKO3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbhCKO3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:29:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06609C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:29:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b18so2092242wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zz2dzqsYyuv4TG4XCyNaaaDqLyEogy9K3vM+/DJNeRQ=;
        b=d7z3RFx3RJumtimxNkd0yjwUe21UkXeHpFlxmEyXTAGKRy8ycK2VCXbqQA+jrutbDR
         b9My3exvIlqKO1M7XfqrxvZdzlTAOKAxP45TYmhKugVNSXIu7teyiLvNF4J/uTXsB4BG
         ODBmTzmqv4b5xrlvpKFlyW7ebtsA0Ufz455EUTtP7D+cyoCX9SLWYkUET6zpB3NQJS6T
         W2oucydzmeIzYj0DMRjc6gL/2cpDNrubM6XrmUlcGGE2BIubzxflDF/dthhJQqurHnjh
         KWUApFL2tn7JBY7qYcuUZWD1270CDg3VMdmJvaQ3e0pKkKmvl+S5jdU5PTanMz5EIIat
         Okhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zz2dzqsYyuv4TG4XCyNaaaDqLyEogy9K3vM+/DJNeRQ=;
        b=lsVQwlMlHtfkRHdaCTJUg74DFMiPquj+YSJUU67Yv06YcAI+jFnBbGJ0ixtDzZTudB
         FMUuLUmBBn1PLUB52pMYyWQHKktkSAoc/7ZYYirhzDkdgtmV/6W4aolu9w2dJcIFKrlN
         aRRdasb+xRW95kzyXAPlMgKxFC936+f4Sp6r+ljHCaaj7uc5PmlRzqTz7SRZo5qrYstF
         caEtf94awvQ1eVDyAwCmEcM5EGdKAb7KUcXgH/MhaCyTwiEaRedvgcQiqMgraCT40J9Q
         D8yAV5/GynD+IXNE+vMVdGsVXbJDS2iBCfmL0eb+DoWX7eSimFkQV/OXuFuh3IrOtwIA
         9UNg==
X-Gm-Message-State: AOAM531Dc3SIqnXtqaxOq7oaiav9Dz6WZ1HzXOD21k+AqmQgxLXVbwoJ
        VCsHljejWOH0W2u/fA3lSlN8dQ==
X-Google-Smtp-Source: ABdhPJzzQG2F9CZpV0ycA0fwL9GxCT0yySRfeLze4eWRwL+TtvM0nFwZG2SdHshnogSGL/UvJfWsGQ==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr8966893wrw.355.1615472955686;
        Thu, 11 Mar 2021 06:29:15 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id h20sm3764829wmp.38.2021.03.11.06.29.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:29:15 -0800 (PST)
Subject: Re: [PATCH v2 3/5] soundwire: qcom: add static port map support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
 <20210309141514.24744-4-srinivas.kandagatla@linaro.org>
 <cc812a5b-c3c3-bb46-f2fe-3e0a14cf0524@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <508f875f-6fed-9bfc-5f3e-297e4c21ec29@linaro.org>
Date:   Thu, 11 Mar 2021 14:29:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cc812a5b-c3c3-bb46-f2fe-3e0a14cf0524@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2021 16:10, Pierre-Louis Bossart wrote:
> 
> 
> 
>>       list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
>> @@ -473,8 +475,13 @@ static int qcom_swrm_compute_params(struct 
>> sdw_bus *bus)
>>           }
>>           list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
>> +            slave = s_rt->slave;
>>               list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
>> -                pcfg = &ctrl->pconfig[i];
>> +                m_port = slave->m_port_map[_rtp->num - 1];
>> +                if (m_port)
>> +                    pcfg = &ctrl->pconfig[m_port - 1];
>> +                else
>> +                    pcfg = &ctrl->pconfig[i];
> 
> Maybe add a short comment on port allocation, I had to think a bit to 
> figure out why the -1 was required on both peripheral and manager but it 
> is not below [1]

I agree, will add some comment here to explain the offsets correctly!

--srini

> 
>>                   p_rt->transport_params.port_num = p_rt->num;
>>                   p_rt->transport_params.sample_interval =
>>                       pcfg->si + 1;
>> @@ -535,8 +542,10 @@ static int qcom_swrm_stream_alloc_ports(struct 
>> qcom_swrm_ctrl *ctrl,
>>       struct sdw_master_runtime *m_rt;
>>       struct sdw_slave_runtime *s_rt;
>>       struct sdw_port_runtime *p_rt;
>> +    struct sdw_slave *slave;
>>       unsigned long *port_mask;
>>       int i, maxport, pn, nports = 0, ret = 0;
>> +    unsigned int m_port;
>>       mutex_lock(&ctrl->port_lock);
>>       list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>> @@ -549,9 +558,15 @@ static int qcom_swrm_stream_alloc_ports(struct 
>> qcom_swrm_ctrl *ctrl,
>>           }
>>           list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
>> +            slave = s_rt->slave;
>>               list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
>> +                m_port = slave->m_port_map[p_rt->num - 1];
>>                   /* Port numbers start from 1 - 14*/
>> -                pn = find_first_zero_bit(port_mask, maxport);
>> +                if (m_port)
>> +                    pn = m_port;
>> +                else
>> +                    pn = find_first_zero_bit(port_mask, maxport);
> 
> [1]
> 
>> +
>>                   if (pn > (maxport)) {
>>                       dev_err(ctrl->dev, "All ports busy\n");
>>                       ret = -EBUSY;
>>
