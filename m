Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9980D3C9CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbhGOKeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbhGOKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:34:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3D3C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:31:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j34so3383395wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uI5sHLv1X45o41P1ZNlIPZTo6K3CNNbzt4/8j7wHrLk=;
        b=lmeWxw8AKP2iBysQEh7Z2PubnYaxE2lkhrpjNnUE2kdpRe7+LnM8Fmql7GNKcRgT6D
         L4+Icg8PsIGa4cjqvjH03raTn8s2B7dYUPYq4l9pJVf1KPV96EegokF3mTAonWDMxeGL
         VkFkVhDaqbBGhU0ZWY+z/Ynpkqe/su5BTT/kvLF+/zHFipRiGsGCpI72O/pgb6S+B84/
         R5hWAaJj2+N5knNlfVuJm1foqFZp53MzatBLotjhUh4jpJeMJ5SO5RNifwq5qMrTdIc4
         WkdMaxTsS71oJsc4dNKM6sh25DmqrlS1u0gNQZuK1SbhJOk5Zq3u2LXL/k36OHbZFgag
         BO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uI5sHLv1X45o41P1ZNlIPZTo6K3CNNbzt4/8j7wHrLk=;
        b=n0dUgNX9nKnR/mDnDi4ZPH8hs+eGFRHUUhYdt9hi+5h3ZDt19u0DlCOj8j4XdnjFWm
         fQANYyj3wZ+niQr4lrgtkpf+qsCKzoCsQsRTe7BFZND7RFidCnK1dGVReDMg8ZM5I2gM
         elOnWbzC5fO3c5QJJ8ctF7AWdgkjrnjRzSeQFpqsOI5r/CuCrby0uVbLga9kStAAyhJ+
         /BB8280yL0iBQxmfkXXVRNaKIi8QFMlHfh68BP+D5YgpYFG91jF4AyXoMi6iLhBXGlHz
         Y/nGoFWeVP+znOX6XAJ5UrqDPeFqhWaAaO/4ORVCe7q2DcrZEVo7SlfFPni50iEoxmCp
         4iWg==
X-Gm-Message-State: AOAM533wQI7dOqLnCASd4/70uI/RGqmbXcC8OfQlVH4Cuo9rw4/PC1m1
        KNcmGmRXvoT3hQ+LYFhGk5nbNyqeeo+SDw==
X-Google-Smtp-Source: ABdhPJy4pUmyzRIiRTluwsc3ODTXdAbGA2QsRKTI7kS9+ycprB0a1iLCcrIuv2LgilRFneLaItVtHQ==
X-Received: by 2002:a05:600c:22d2:: with SMTP id 18mr3779099wmg.63.1626345111181;
        Thu, 15 Jul 2021 03:31:51 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id p2sm4505436wmg.6.2021.07.15.03.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 03:31:50 -0700 (PDT)
Subject: Re: [PATCH v2 05/16] ASoC: qcom: audioreach: add basic pkt alloc
 support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-6-srinivas.kandagatla@linaro.org>
 <58d6df8d-83ed-c716-81b2-e0927f58da6f@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e581be78-10cd-12e7-17df-c53c1b680473@linaro.org>
Date:   Thu, 15 Jul 2021 11:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <58d6df8d-83ed-c716-81b2-e0927f58da6f@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review Pierre,

On 14/07/2021 17:30, Pierre-Louis Bossart wrote:
> 
> 
> 
>> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
>> index cc7c1de2f1d9..721ea56b2cb5 100644
>> --- a/sound/soc/qcom/Kconfig
>> +++ b/sound/soc/qcom/Kconfig
>> @@ -103,6 +103,12 @@ config SND_SOC_QDSP6
>>   	 audio drivers. This includes q6asm, q6adm,
>>   	 q6afe interfaces to DSP using apr.
>>   
>> +config SND_SOC_QCOM_AUDIOREACH
>> +	tristate "SoC ALSA audio drives for Qualcomm AUDIOREACH"
> 
> typo: drivers?
> 
Will fix all the typos in next spin.


>> +static void *__audioreach_alloc_pkt(int payload_size, uint32_t opcode,
>> +				     uint32_t token, uint32_t src_port,
>> +				     uint32_t dest_port, bool has_cmd_hdr)
>> +{
>> +	struct apm_cmd_header *cmd_header;
>> +	struct gpr_pkt *pkt;
>> +	void *p;
>> +	int pkt_size = GPR_HDR_SIZE + payload_size;
>> +
>> +	if (has_cmd_hdr)
>> +		pkt_size += APM_CMD_HDR_SIZE;
>> +
>> +	p = kzalloc(pkt_size, GFP_ATOMIC);
> 
> is GFP_ATOMIC required? it's the same question really than my earlier one on spinlock_irqsave, it's rather hard to figure out in what context this code will run.

I had some spinlocks in this patch for compress offload cases, so had to 
make it ATOMIC. having said that we could avoid ATOMIC here.

> 
>> +	if (!p)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	pkt = p;
>> +	pkt->hdr.version = GPR_PKT_VER;
>> +	pkt->hdr.hdr_size = 6;
> 
> magic number. looks like a missing macro...

There is already a macro for this, GPR_PKT_HEADER_WORD_SIZE I should 
have used it.
> 
>> +	pkt->hdr.pkt_size = pkt_size;
>> +	pkt->hdr.dest_port = dest_port;
>> +	pkt->hdr.src_port = src_port;
>> +
>> +	pkt->hdr.dest_domain = GPR_DOMAIN_ID_ADSP;
>> +	pkt->hdr.src_domain = GPR_DOMAIN_ID_APPS;
>> +	pkt->hdr.token = token;
>> +	pkt->hdr.opcode = opcode;
>> +
>> +	if (has_cmd_hdr) {
>> +		p = p + GPR_HDR_SIZE;
>> +		cmd_header = p;
>> +		cmd_header->payload_size = payload_size;
>> +	}
>> +
>> +	return pkt;
>> +}
> 
