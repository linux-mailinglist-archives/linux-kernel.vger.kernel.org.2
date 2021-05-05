Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1F374B73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 00:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhEEWoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 18:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhEEWoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 18:44:03 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A46C061342
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 15:43:06 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id v123so3110913ioe.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nC/IBifenONsVc9vMeQOv6acWNUTyGTY5GW7BiFudVU=;
        b=QTwl5lIsbomJ7O6sqqW0XuKaC294FKigV2q180wT8/EpZDQ5rcIHSvzKvJJ9pvv5uh
         z8U5ct8yLB3R1M0OSRpsKqceu4rkPpNu8pjcNWalCJJ+3ywEvO2XJWdSn8JGrlAPU0AZ
         0BR31oMd95JeJU0S52yIM+0UDTJLR3SW6tLKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nC/IBifenONsVc9vMeQOv6acWNUTyGTY5GW7BiFudVU=;
        b=av6WwiiRdgU7xeeDYtkz/LlseKsmMDZpJEPPZCqd3fNEG3sTXcntXQZU8cWe9Oj9KK
         juMOHOtRunWtBqiEwd2XMTeVz3kNR0NhURGYL2EvTctZxFxwGZHZzc61YsBCltFG83Mj
         wFw6rkUGwzl1DDXaG0knb2Fuu4EuP0xDDCCHOwPtQ2x8NyVnmH9EHlXoJDhIb2sdimks
         u+x8mSUyTnIxo+ldu8s9hWuztGByp5EotJSKlJ2T1qaJyl1WIpfYAR2j7bgy2OUoyqkQ
         bhE2nFMKP4EgrrZHbVn0lS5xI8oxNNm6uuJNeGWbYdWH44CuOE1KvnsP+0bY3dYkzqya
         S9wA==
X-Gm-Message-State: AOAM531aa0i33wvAeeEQensFRvRWVTgFPCE7C6ELhfd8uT2OGocEVTI4
        kQS9a36NrWuQj5JgakFtLPeZ3w==
X-Google-Smtp-Source: ABdhPJwH1Saq8jX1rR1EHdxjdr3/FrPENkPRN4qLVDh1v0pgfyJvQqISlSS9gdsIEnnh9Nv1VLrBPw==
X-Received: by 2002:a05:6638:1390:: with SMTP id w16mr865314jad.83.1620254586009;
        Wed, 05 May 2021 15:43:06 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id k13sm256084iop.24.2021.05.05.15.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 15:43:05 -0700 (PDT)
Subject: Re: [PATCH v1 6/7] dt-bindings: net: qcom-ipa: Document
 qcom,sc7180-ipa compatible
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, elder@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, davem@davemloft.net,
        kuba@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org
References: <20210211175015.200772-1-angelogioacchino.delregno@somainline.org>
 <20210211175015.200772-7-angelogioacchino.delregno@somainline.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <19151b65-5600-df8a-c25f-d46a096f068e@ieee.org>
Date:   Wed, 5 May 2021 17:43:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210211175015.200772-7-angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 11:50 AM, AngeloGioacchino Del Regno wrote:
> The driver supports SC7180, but the binding was not documented.
> Just add it.

This has been fixed upstream now.
   c3264fee72e7 dt-bindings: net: qcom,ipa: add some compatible strings

					-Alex

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>   Documentation/devicetree/bindings/net/qcom,ipa.yaml | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> index 8a2d12644675..b063c6c1077a 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> @@ -43,7 +43,11 @@ description:
>   
>   properties:
>     compatible:
> -    const: "qcom,sdm845-ipa"
> +    oneOf:
> +      - items:
> +          - enum:
> +              - "qcom,sdm845-ipa"
> +              - "qcom,sc7180-ipa"
>   
>     reg:
>       items:
> 

