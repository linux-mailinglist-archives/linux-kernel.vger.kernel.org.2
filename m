Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B2743B788
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbhJZQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbhJZQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:50:12 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC14BC061243
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:47:48 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j10so14714483ilu.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YKwRxPBjph63txYkU/60zXWK4/WhUFpeAqg9AkQ4hnM=;
        b=Z9ToptDFzfh/mwbDivSN0t3grjkZ/mCL4ttDd6BrGK6Gt665J8VtTIu2PSSprYwIBc
         zxg7iBNLk+3xYL/OwS3wZpZ6CnUC4lS1sqSArz9R/Soal4ljp93MM317irp1totwKITO
         P+kwFix4j2veuUINrqKRyKDr5GDf/jKtrDqkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YKwRxPBjph63txYkU/60zXWK4/WhUFpeAqg9AkQ4hnM=;
        b=l6K2JwS1DU94oXzfWVRpA3rHwkzpDCF9/obTMTfrOKbn6TgN8Orcrw5k5mfVINOT/u
         4r/SseVw3K8qmRr9UvWDCAL7Jq7nVQZokc+dhUA/IHIDLAkAsmjafG3Ei5YDC7+NtnFp
         tBbOUVhhwM2d67vNpYN+fHCOsGiRMWbIm+jqf5Gq4MKNLbBD/3L7MJ/n0xOnqfdEB3t3
         EjtzaiJ1WJCOhNNmunKXhej8e/b+XIFf28jWmGciV6GHAOdO9ww2ZO5TeMJZEwSa1ybr
         1z9Ewhcl2THmk2Bz5Es94rOtH2ID2q+wXfXZqgHhAV0kwpw+HJBrsVAKxUPxAfojkpYa
         z9eQ==
X-Gm-Message-State: AOAM532vgmBk762KPFAQCIs4VS5ykf5shUEHK4YQkjAAymPx4WaEQWQ/
        gZ6w5j3VhLNC2aZx8fiGsJq65V8wAkimcA==
X-Google-Smtp-Source: ABdhPJz4MwNT6x0eqE/fwWtC2vUza4je3EDZG0CcQCInRJtS+XYPOqPxaxjQXvslMpA88wGXPHKtbQ==
X-Received: by 2002:a05:6e02:1a23:: with SMTP id g3mr4664396ile.103.1635266867924;
        Tue, 26 Oct 2021 09:47:47 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id s7sm11616003iow.31.2021.10.26.09.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:47:47 -0700 (PDT)
Subject: Re: [PATCH v2] dt-bindings: net: qcom,ipa: IPA does support up to two
 iommus
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211026163240.131052-1-david@ixit.cz>
From:   Alex Elder <elder@ieee.org>
Message-ID: <2de53575-af6e-5bb9-e7ad-5d924656867d@ieee.org>
Date:   Tue, 26 Oct 2021 11:47:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211026163240.131052-1-david@ixit.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 11:32 AM, David Heidelberg wrote:
> Fix warnings as:
> arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml: ipa@1e40000: iommus: [[21, 1504, 0], [21, 1506, 0]] is too long
> 	From schema: Documentation/devicetree/bindings/net/qcom,ipa.yaml
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

Looks good to me.  I'm not sure why the minItems is required,
unless it's to indicate that it must be at least 1 and can't
be missing.  But iommus is also stated to be required elsewhere
in the binding.

In the future, it's helpful to indicate the command you
used to produce the warning in your commit message.  And
furthermore, describing the problem (and not just including
the error message) is even more helpful.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   Documentation/devicetree/bindings/net/qcom,ipa.yaml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> index b8a0b392b24e..b86edf67ce62 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> @@ -64,7 +64,8 @@ properties:
>         - const: gsi
>   
>     iommus:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>   
>     clocks:
>       maxItems: 1
> 

