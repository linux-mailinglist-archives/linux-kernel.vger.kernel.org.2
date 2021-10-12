Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF5B42A089
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhJLJGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbhJLJGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:06:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFAAC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 02:04:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so64734240wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 02:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nM9ryI+c+NLtTNUZo2AiWUoKoEPFgkQ1TAdM3Mn2iis=;
        b=OUCqqoYliTYGu9oksn4qZr2MyPWixyHxjPTni2yDBH1kmgpybP40V9gCaPPdkiIr7u
         PkPxey9VPJZ/TNZS3NiV2AzsmP736DOYJKF8jYVVCsnIwNS3liD1B2gqbNrpyK2YGzto
         K43oDQU9dxwfR7PVP2cfjhMeILXRQ4bRPoa40Fhgg+IMULk5UksDqwKgdupIdkEGftqm
         DxRbmQRRSvQzD+ZQRH6D4+AyVbI6CFd2NdISUClrRDtOk2Cm1eTq9OUbznMi9wz3lcam
         qg7afqFWap7t4DqaiVhLN2ib5AOttDy/YQoMDnggEodqWiZgYxUv6Xw8VxsOYEtvNMrH
         uq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nM9ryI+c+NLtTNUZo2AiWUoKoEPFgkQ1TAdM3Mn2iis=;
        b=DhhMdLYBIDHnn6Y7vyOcOm68NwE2Ak2hHTb88yZa/gV3FSVaOy0EVjurQCR8n3RlY3
         dm8oNsNzBQKDhkxDOIHdOjS9JYZle4lddyoBAVozomJ0xRXd2xIfEiJ+cCyFMTyQ0diq
         b9v6GeW7zw8ZDntVQ2UgsCeOyA4b2im9UISNonh3GVH1aCbIzH7mwrPe1rU1osUtCXOa
         nYkpbFeocVvIxMEwcJK7deNzUGb7hRt5d/HpCKQDE6evd6+j2IlgqvGqYAdE5J+1GmNw
         DvodYT3y5P3F/LMaJUoQ4S0ostcFMid48kAX+XJFbyMAi7bF2NYJ8s5Ncp6W9v0hpWbk
         D6ew==
X-Gm-Message-State: AOAM533g3wOD7jwQiUoX/P+SI1O+bkNjh1+SP+/q8nuhVKCk1JRYtc74
        Xa4UabChBUzIJyzOprAOrAKgsw==
X-Google-Smtp-Source: ABdhPJzldmhbBry7GuAupyMrQ6kcGWOkrHsnOW8VChM5aqK1EEGJqirPQaDdD4vD8TnhCDjQXD0xLg==
X-Received: by 2002:a7b:c114:: with SMTP id w20mr4093213wmi.143.1634029470271;
        Tue, 12 Oct 2021 02:04:30 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id b19sm1987114wmb.1.2021.10.12.02.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 02:04:29 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] ASoC: qcom: dt-bindings: Add compatible names for
 lpass sc7280 digital codecs
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
 <1633702144-19017-3-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8e042343-a40e-d00f-31a8-8368160329e4@linaro.org>
Date:   Tue, 12 Oct 2021 10:04:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1633702144-19017-3-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2021 15:09, Srinivasa Rao Mandadapu wrote:
> Update compatible names in va, wsa, rx and tx macro codes for lpass sc7280
> 

TBH, I was also expecting the clks that are mandatory for sc7280 in this 
binding patch.

I think we need this and this will allow us to validate on the dt-entries.



--srini
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>   Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml  | 4 +++-
>   Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml  | 4 +++-
>   Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml  | 4 +++-
>   Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml | 4 +++-
>   4 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> index 443d556..bc762b3 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> @@ -11,7 +11,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: qcom,sm8250-lpass-rx-macro
> +    enum:
> +      - qcom,sc7280-lpass-rx-macro
> +      - qcom,sm8250-lpass-rx-macro
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
> index 6b5ca02..74f5386 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
> @@ -11,7 +11,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: qcom,sm8250-lpass-tx-macro
> +    enum:
> +      - qcom,sc7280-lpass-tx-macro
> +      - qcom,sm8250-lpass-tx-macro
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> index 679b49c..99f2c36 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> @@ -11,7 +11,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: qcom,sm8250-lpass-va-macro
> +    enum:
> +      - qcom,sc7280-lpass-va-macro
> +      - qcom,sm8250-lpass-va-macro
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
> index 435b019..13cdb8a 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
> @@ -11,7 +11,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: qcom,sm8250-lpass-wsa-macro
> +    enum:
> +      - qcom,sc7280-lpass-wsa-macro
> +      - qcom,sm8250-lpass-wsa-macro
>   
>     reg:
>       maxItems: 1
> 
