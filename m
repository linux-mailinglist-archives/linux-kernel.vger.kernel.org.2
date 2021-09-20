Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3F6411574
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhITN0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhITN0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:26:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C079C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:24:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg28so38601753edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zHVonDiIKOidenYlcCsevl+U2ckQNMnx2NKq+Q4lJ+4=;
        b=xoT5NPcx8DInitXeB0UKu0hQHUwQU4lRfCwxIULDJvq+hMnb29LVCbXVnfaV9N530M
         l51cSknPG8z/139JGdnHTbOQjJm4hYfoy/5SspTk5SsrTLW4IheL14qbnSqZtkpxhDKU
         JHLMpNQmBEuLzpGeHRn16DIjkv/jdKnHMozXrSMQxpe8z4L5SXgLD1sI0mxMdNnK0epn
         Gh3G2xwHQ6HRMNoLmTUOSW8c8QnrUfJlOYmolUR2sLyX8QBNS5QSZ1aFwxhANjRooA6T
         G8RAOLIrpxifni7FmEG1xZRJuFMX/HjobycX+m8asCEKJnUs5v5YuYSTBmjuf13v0KX5
         Lyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zHVonDiIKOidenYlcCsevl+U2ckQNMnx2NKq+Q4lJ+4=;
        b=v/1ASTPJG2SdYyrgOCGrSfaG1enLi2+ONY41fFQt0RvGxSLu6iwkbmgexCyj/JLGOp
         yl+oyGSfRvo8WKuEFVR6RBhqA92gG0vLK6gwd+853oXjrNTIbmBnREJoMLKlCNceahng
         G8csU/ha5wGsNxViiGWIlzr0l8Kg7IdheYFkKd0d56kXWYzkDunpg+O9slnw+w7ZxnKE
         xNxI2IFTiDeVK97Bd05VoPWu+U9nD3cGRXbVGf24aVddho5Uz2U5HNyg+XCHa5Jw6+HO
         rkjy/TdIZ+2w6HnALqalKGzSh8WJyAQekF3YRVZotIgeJGwT3Tg9ivst7LNAsAkhTXtN
         qCYw==
X-Gm-Message-State: AOAM533cGkZA6pV6Xb0gsJi150smYFiHE6ASrWqbZ1XHbGt4FhSYi/iO
        rhf4ttZA/G6J8P4TvFQvfT7OmQ==
X-Google-Smtp-Source: ABdhPJwjGdIItEsvSqiN7t+4FGcgarp0izJCucyWEMUojF95CxEnksKLGxBDs+NwjN0Mcqwpp0YLeA==
X-Received: by 2002:a17:906:a18f:: with SMTP id s15mr29516593ejy.269.1632144292611;
        Mon, 20 Sep 2021 06:24:52 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 19sm3042079ejw.31.2021.09.20.06.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 06:24:52 -0700 (PDT)
Subject: Re: [PATCH 2/7] ASoC: qcom: dt-bindings: Add compatible names for
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
References: <1632123331-2425-1-git-send-email-srivasam@codeaurora.org>
 <1632123331-2425-3-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7c12126d-99a8-4572-6e95-b63131cae300@linaro.org>
Date:   Mon, 20 Sep 2021 14:24:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1632123331-2425-3-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/09/2021 08:35, Srinivasa Rao Mandadapu wrote:
> Update compatible names in va, wsa, rx and tx macro codes for lpass sc7280
> 
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
> index 443d556..a4e767e 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> @@ -11,7 +11,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: qcom,sm8250-lpass-rx-macro
> +    oneOf:
> +      - const: qcom,sm8250-lpass-rx-macro
> +      - const: qcom,sc7280-lpass-rx-macro
>   
Recently Rob did tree wide change to use enum instead of oneOf for below 
reason
"
'enum' is equivalent to 'oneOf' with a list of 'const' entries, but 
'enum' is more concise and yields better error messages."

So, can you move these to enums like:

enum:
   - qcom,sm8250-lpass-rx-macro
   - qcom,sc7280-lpass-rx-macro

--srini

>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
> index 6b5ca02..cdec478 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
> @@ -11,7 +11,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: qcom,sm8250-lpass-tx-macro
> +    oneOf:
> +      - const: qcom,sm8250-lpass-tx-macro
> +      - const: qcom,sc7280-lpass-tx-macro
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> index 679b49c..e15bc05 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> @@ -11,7 +11,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: qcom,sm8250-lpass-va-macro
> +    oneOf:
> +      - const: qcom,sm8250-lpass-va-macro
> +      - const: qcom,sc7280-lpass-va-macro
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
> index 435b019..2dcccb5 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
> @@ -11,7 +11,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: qcom,sm8250-lpass-wsa-macro
> +    oneOf:
> +      - const: qcom,sm8250-lpass-wsa-macro
> +      - const: qcom,sc7280-lpass-wsa-macro
>   
>     reg:
>       maxItems: 1
> 
