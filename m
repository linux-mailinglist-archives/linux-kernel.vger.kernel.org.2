Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7716630ABEF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhBAPvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhBAPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:51:05 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E05C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:50:25 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s7so14114532wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qH2QKnpkKtv2v7miYr/6O0hwnSs48bF9jSY/Wu7YY6U=;
        b=YyHaK4nxBs3RWREyZodtI2kE3kTl/JHASvlXuJxJ2Rxj0PtSlsmDLXsQmoHPVbxRZN
         WRJ0tfbyBt3G+M8wsY0kzL3L7OBVFEepkIHwV8YCjAHkwpP0eDACSesq9puzLzWNkt3e
         FVixlTQ21Yt45OTLNvWaE8+MxsGyz9x9h4d3jc2e4VDOH6wOlltM4Mwa4uxWME+MaLGa
         UkqAHXrM2bNXuHCJc+8nwYxxCU4hGiQwAthF0HBEA+606b9RzbF3iQucBXQloPpviTav
         jA96LxQ6hM/IN5gshgvO8AEMPQuVO0e5oBtERZQx3YDFw5m1fXlxr5NicHCczhwMS6TL
         5NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qH2QKnpkKtv2v7miYr/6O0hwnSs48bF9jSY/Wu7YY6U=;
        b=GDyUJtxo0ZFveiC13dBWiTML1FoOmBc576s8dveeGFFO8Xm7OlEtXILGxsqbw6NpPt
         x82UvxA27Am73SNaFggyqn6M3bkGx8/prPDMqPGNB7KPr3+4eh8n/+52mrckt7+n1MWc
         xTXdzO+Uc1y5rhZTVTpDh8AAUnbGXdXbR+UoqXh3GHIRKoDT9ug5BRFXNdRrU0oPYaNW
         wVGu6OEAOvZNeN1Zcsfwm3KVcbyDLo/28RtPej4W9AkDYopLsQAOIoyeL5oAQAG0fg8a
         XLAYFOBV460W1xMWITR8toTHh/DCLAhCr+Nh5XzGdrer6KQCYZmYlhK8BNoq9MikwWkA
         9dkQ==
X-Gm-Message-State: AOAM531tWwI+sgZqs7oS1p019Q9wCWpmMrMKg8IrnvK4m1S2R0MPehfr
        AvU8aXrCw9c0pXxaOTFoPjfkGuKP1Kau2A==
X-Google-Smtp-Source: ABdhPJx+fpVnGk/D6O8Vqf1D2v0j/tla3RgrDrTu+WQwxDYkaSaQWWoNEtHw8+WQT0Eo1z7hdT04aw==
X-Received: by 2002:adf:decb:: with SMTP id i11mr18519129wrn.78.1612194624190;
        Mon, 01 Feb 2021 07:50:24 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id b11sm26826114wrp.60.2021.02.01.07.50.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:50:23 -0800 (PST)
Subject: Re: [PATCH 1/6] soundwire: qcom: add support to missing transport
 params
To:     Vinod Koul <vkoul@kernel.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-2-srinivas.kandagatla@linaro.org>
 <20210201141345.GA2771@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c52aaad5-513a-8dee-bc5b-3bb5a4ffe18b@linaro.org>
Date:   Mon, 1 Feb 2021 15:50:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210201141345.GA2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 14:13, Vinod Koul wrote:
>> +
>> +	ret = of_property_read_u8_array(np, "qcom,ports-hstop", hstop, nports);
>> +	if (ret)
>> +		memset(hstop, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> why not memset the whole area here and then populate it..?

That is other way to do it!, I can do that in next spin!


--srini
>> +
>> +	ret = of_property_read_u8_array(np, "qcom,ports-word-length",
>> +					word_length, nports);
