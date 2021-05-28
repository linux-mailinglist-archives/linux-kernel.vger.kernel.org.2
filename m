Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3228F393EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhE1Iiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbhE1Iit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:38:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8725AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:37:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n4so2460718wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JIRtjIzGskNvRkjqhrSGu/TOKcOeVjAntp6g2x55agM=;
        b=eCxTTDpQelaF5VKo9Z6PrNKAhcprFauifycnFSy9xh8HbD4gtY1Sx/zf0hx5omPUss
         8SPVxKrdK9skGTnLhR9JZvM2fIaJpiSzL3T3HMJmXo/c7I899Wnw6cq2A12lgw7A6LUq
         HCZ7dnH7fxY9OtLhhhTKz/bS48DgPJRAHtpyMxDcBOq6jnd3mIXKFMQMWGD/A94G1Xe8
         emtBsERU2sR2W3YP4Z1REDHa+f6WM8kRwZVz4aY7g1e9Ic0SQal4TV65F2FM1oBG8wMJ
         ZHjCCzJa7aa86N0H6iI2xafaUIh6P7ylj3eYmb8CiqrxT11GlmVFdmWhs9yf2gM/1ZF4
         g7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JIRtjIzGskNvRkjqhrSGu/TOKcOeVjAntp6g2x55agM=;
        b=BnsNYCCCPk9cj+oRNT8FKwfVy1TKThcO9yvXSqF1/KDGg4pSjsQMb2+Dqnjv+CGrAM
         HNUirMGX+Qo4r++RHbC0L41kvodYSLwyJmxb8JdHMl8oK8AP0nZf1iiVyQ35B9l4acv3
         rFqUTgwxXetdsRQ+5v5niSVvAzHBQYGnARvhmj0vyMXc5N65SbHlwwsiiHQwJMU7LOM3
         p5tk++bS+tCU63PzePxLP4Yi3SFmp0zcupOKOqLnf1642LPqId3wS1GFZrVXn2gveVjl
         ku3Txk7rlgVrWxpXC1UbDhhvDDQkzoj3ybjIk10DbPDTZ1/DXW4QDSrqEAsPCij1zsFs
         +SKw==
X-Gm-Message-State: AOAM5308P3eSImxyj23B3azLBCkCncUeJpLdxq7P4zOLb74Fdq8xxYmo
        iZ9qxd69eXYJZ2XGGOSFOCLfAw==
X-Google-Smtp-Source: ABdhPJw5NKRu7nGRD7H482yIuy9oXYSyXuPAHcI//JL1z90goZosB5wAFGeCCxbxaIjvpuPgVRZLPA==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr7399883wrx.13.1622191033222;
        Fri, 28 May 2021 01:37:13 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 11sm6110413wmo.24.2021.05.28.01.37.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 May 2021 01:37:12 -0700 (PDT)
Subject: Re: [PATCH 4/5] ASoC: qcom: q6asm-dai: Constify static struct
 snd_compress_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Banajit Goswami <bgoswami@codeaurora.org>
References: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
 <20210526231013.46530-5-rikard.falkeborn@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bd8348e2-7af9-c868-50d0-e359a6a9fb52@linaro.org>
Date:   Fri, 28 May 2021 09:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210526231013.46530-5-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/05/2021 00:10, Rikard Falkeborn wrote:
> The snd_compress_ops structs are only stored in the compress_ops field
> of a snd_soc_component_driver struct, so make it const to allow the
> compiler to put it in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index 9766725c2916..5ff56a735419 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -1169,7 +1169,7 @@ static int q6asm_dai_compr_get_codec_caps(struct snd_soc_component *component,
>   	return 0;
>   }
>   
> -static struct snd_compress_ops q6asm_dai_compress_ops = {
> +static const struct snd_compress_ops q6asm_dai_compress_ops = {
>   	.open		= q6asm_dai_compr_open,
>   	.free		= q6asm_dai_compr_free,
>   	.set_params	= q6asm_dai_compr_set_params,
> 
