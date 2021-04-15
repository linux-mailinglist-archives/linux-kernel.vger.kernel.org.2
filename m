Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA483605D8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhDOJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhDOJes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:34:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2596DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:34:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d21so7105969edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iL+/YWRONOKDWm29EOJng2/4nOqHH8GQEwRgLaBED28=;
        b=PyHZ361hIf/uOGkKqd5o5jFCXr4+E4XU1FaT4zV1ZL2S9z4MyYU4K4iIUM7NS99Ojk
         eNyc2pToNFcDq84ytnRig615zEWE9pzalGdUu3STQXXDo/6v/r4QLNOGqSWUqSRrxq+d
         wYt91HCVtzngrBj8S/5iQexncyQi8JXEitLvEuKMIx9mn3tfszeycmVQ0orDatz5cYb/
         o3qHEJcGXRgwMThcb/LjECYv8iRI1R1KyJEzu2jeAv9wd3oTe5cBdKH2oM3VaeZoZ/UX
         NQst9E/9UvkVW/36JVcWKGBJHLTPe51uUcxn4WkDqgKPIlp6j3vDJbXu81we/pBfoRHJ
         C/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iL+/YWRONOKDWm29EOJng2/4nOqHH8GQEwRgLaBED28=;
        b=kgrADwQJS4MbTvd1DxAHfzpjTSAW6dSGtipK23ZKf1FLECFXRjSD4xVICvjnCcghXI
         YLdjV5hR8BmLx2vMnRYpmMxWiLdbuU8wRUQDGfgId9cHa9WvrmpnqAS1Pdt7G4hT1YzC
         XcivLs5gCikYflGSrMHa5Z1JSY9g3VTWE2EPmHjglgMqq5Bx8EiU1FfwEOzZPbLlysAR
         b7LfF6ZO725kC52ix4XAG8oZqDLbdQJuDhxElY8SSK8CH694ehQRImaDfWNx1Qa12oNO
         T+6n/p+c8t1ctSVxDijEGZDUUxieNBePZ+E/+r1lXuHsI9QfC1xpakAXIzi2dMziIVYM
         pH8A==
X-Gm-Message-State: AOAM5314C+WnZwfF+ZueZ9Z5F8S6fUt0n9lO01utuvhCjB2IPgtE4VGD
        7oW49Qelfa7B6oFgp3nKiaFw4yJKP9gnNw==
X-Google-Smtp-Source: ABdhPJzbzdr5JKHdphRKHk2aq73XSes8K8QhG5RTuhJNa/WuYZ0U0Pu7Omr9dZkxNIYDUYgqfBdGYw==
X-Received: by 2002:aa7:d688:: with SMTP id d8mr3034976edr.294.1618479262623;
        Thu, 15 Apr 2021 02:34:22 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n3sm1479849ejj.113.2021.04.15.02.34.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 02:34:22 -0700 (PDT)
Subject: Re: [PATCH] ASoC: codecs: wcd934x: Fix missing IRQF_ONESHOT as only
 threaded handler
To:     zhuguangqing83@gmail.com,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
References: <20210415073829.22750-1-zhuguangqing83@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <896527ac-0e94-b930-80ec-8c7ef669b149@linaro.org>
Date:   Thu, 15 Apr 2021 10:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210415073829.22750-1-zhuguangqing83@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/04/2021 08:38, zhuguangqing83@gmail.com wrote:
> From: Guangqing Zhu <zhuguangqing83@gmail.com>
> 
> Coccinelle noticed:
>    sound/soc/codecs/wcd934x.c:5041:7-32: ERROR: Threaded IRQ with no primary
> handler requested without IRQF_ONESHOT
> 
> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
> ---

Thanks for the patch,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   sound/soc/codecs/wcd934x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
> index 5fe403307b72..cddc49bbb7f6 100644
> --- a/sound/soc/codecs/wcd934x.c
> +++ b/sound/soc/codecs/wcd934x.c
> @@ -5040,7 +5040,7 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
>   
>   	ret = devm_request_threaded_irq(dev, irq, NULL,
>   					wcd934x_slim_irq_handler,
> -					IRQF_TRIGGER_RISING,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>   					"slim", wcd);
>   	if (ret) {
>   		dev_err(dev, "Failed to request slimbus irq\n");
> 
