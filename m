Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C719842A095
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhJLJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbhJLJHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:07:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41082C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 02:05:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o20so64507805wro.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 02:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wr/2NPJuS3pCGpcja/YdLD+ws/Bsmb2EvXsaz8P7nBk=;
        b=c7IxciNHtOvpD93/zJf8U7mD2WwzdWpgTLDmu07hiDi8Wfl4HHdL5aazSay0mgUrPd
         BWzDgu9hbnY2dGuy8OC0n3CwQ/ckOB/bp1oEq17L0WVFtWSNaCDnEglLBNyvWl/Kznaf
         ZPrfxdOfTlZkRlH1ShlbVnyxdcezK92VgTpHJfxf5P4h4MpN4PyHW7X5z3J57bFA3D/k
         0a7pM7AphUImc2xHdrzCi1W2mgUL4wUUI0l26dK0ui35nDLRs5y7lEuFuM+5GaQf1e/S
         TyoUmr5kGUgu3QJCDo0dmCtANxufQAL/hEbl51pzlD34dt9/RqbDdat9+jOUND9oGuVL
         Cbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wr/2NPJuS3pCGpcja/YdLD+ws/Bsmb2EvXsaz8P7nBk=;
        b=T64ME81SyzcsSP6rtiAFDmCIbxVet4EidpCk/vK5h9aseshNst1gu72Gi/iD88vcOL
         U4XEutQrcwIL0QPunG3l+CFITOAan30F742yt7a2XK3F/NdAFjtj6Wz9/9Ag9dksl6Dk
         JSFXDK4jfhElPsGyof8Rme+6R/XfbafMNmdRUQgo5abOq/fAvfeQdJ7hbC37S3zkjQkU
         DJ1rY67L+mJcm/e2deza5oPVYeTdZnZAwDEgBKHpOblE87rYj3yiUk6zeSrm5Kjha3Uy
         rm1ZwpCYorKrGPgApE2amV5OWGvidNjXlBpnCFyKpCkHfPU/bD2WgWDqUY/ruDRRpD+B
         f5DA==
X-Gm-Message-State: AOAM531IqSVw/Svh2tI9K3phXtVKguZUtlNajnh0oE1uEweti4E8xg1t
        80DKffLCKCKkxtMeifzrqsqrtw==
X-Google-Smtp-Source: ABdhPJzaM6vlGT8UtCZ7Hx0Ajh7TCVZxn9HXjngx99Nxx4cftOosPSp98BNwQTw4tPX0u8Kke6EvkQ==
X-Received: by 2002:adf:a34c:: with SMTP id d12mr30919653wrb.267.1634029527864;
        Tue, 12 Oct 2021 02:05:27 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id p8sm1892712wmg.15.2021.10.12.02.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 02:05:27 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] ASoC: qcom: Add compatible names in va,wsa,rx,tx
 codec drivers for sc7280
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1633702144-19017-1-git-send-email-srivasam@codeaurora.org>
 <1633702144-19017-2-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8886b174-f3d3-7bad-a2b9-ea7def2a36e4@linaro.org>
Date:   Tue, 12 Oct 2021 10:05:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1633702144-19017-2-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2021 15:09, Srinivasa Rao Mandadapu wrote:
> Add compatible names for sc7280 based targets in digital codec drivers
> va,wsa,rx and tx.
> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


>   sound/soc/codecs/lpass-rx-macro.c  | 1 +
>   sound/soc/codecs/lpass-tx-macro.c  | 1 +
>   sound/soc/codecs/lpass-va-macro.c  | 1 +
>   sound/soc/codecs/lpass-wsa-macro.c | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index 196b068..c2b9333 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -3577,6 +3577,7 @@ static int rx_macro_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id rx_macro_dt_match[] = {
> +	{ .compatible = "qcom,sc7280-lpass-rx-macro" },
>   	{ .compatible = "qcom,sm8250-lpass-rx-macro" },
>   	{ }
>   };
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index 27a0d5d..5dcae73 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -1843,6 +1843,7 @@ static int tx_macro_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id tx_macro_dt_match[] = {
> +	{ .compatible = "qcom,sc7280-lpass-tx-macro" },
>   	{ .compatible = "qcom,sm8250-lpass-tx-macro" },
>   	{ }
>   };
> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
> index 56c93f4..70f09b4 100644
> --- a/sound/soc/codecs/lpass-va-macro.c
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -1472,6 +1472,7 @@ static int va_macro_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id va_macro_dt_match[] = {
> +	{ .compatible = "qcom,sc7280-lpass-va-macro" },
>   	{ .compatible = "qcom,sm8250-lpass-va-macro" },
>   	{}
>   };
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index d3ac318..75baf8e 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -2445,6 +2445,7 @@ static int wsa_macro_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id wsa_macro_dt_match[] = {
> +	{.compatible = "qcom,sc7280-lpass-wsa-macro"},
>   	{.compatible = "qcom,sm8250-lpass-wsa-macro"},
>   	{}
>   };
> 
