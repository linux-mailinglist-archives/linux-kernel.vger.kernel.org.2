Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CE33A4180
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 13:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhFKL4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 07:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhFKL4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 07:56:53 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50FDC0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 04:54:41 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id t6so10474081qvp.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 04:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eUttRMHttOnDA7jK+Bhgw9VuVSK/sEPVdIVgBgNsUfs=;
        b=zmy+/sV0dMH5LMwC+7d9/al0x8cE++ECq+h/bjqm4xcyzk9G6t/NCaCwdSUBUHasYM
         eO9rQ8aEVtodfxoKOF4KByhJPY9kICmY8HE6JZ4uIO1u0rok7NIO1v3Z9kZhx4a9RJwZ
         vuSddBMUJIOYQomd8/RXY08TXJIT6QAkqTsdckp16Y4T3hWigoO6BMss0goRfoX7aSLF
         8ZNgu1F3hUs92PhyPmaP8P0igPjQo/RqCMM02gybNXsIttUsHorEctPS3kt8D5/rlHZs
         iAHSjhG5L1ciXEARjS5UkjLeusSQIhU2EPt8js2uYU0Cae4lRdHMKy1MB+4f7GB5FSPh
         ON7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eUttRMHttOnDA7jK+Bhgw9VuVSK/sEPVdIVgBgNsUfs=;
        b=MvNl3DWOQeKReAqGPs6op2duzsSC/YC77D/q3gSSatSXk9C7OTGUYY+rjVuJuLhL0p
         cIEljFHv/Z1eIhVb10NQa/M+vFowOHesbwmLQJh5ZxEU2GbQ2y4YjV5pCCTCN/RibLEl
         62TSTz3nLIMB/jgREPwTiIwIzm4HrTSCGYn9oXX+SSA+jPhXO79ZHwq5/ZC6XCoUOrE6
         Q8Ot+LnT+9HXQuNgFpeg3kgjcJo2/KQ0DlI05nyJsXiab28WqNx8ZwDHjLHg9M6SNZ0Y
         aGBZnNQq63/CZ2UxeSLWeIr2kfID5VPyp2nR8ILEUw0NrUA/YURinsRDxvGWMVH0qhUe
         jA3Q==
X-Gm-Message-State: AOAM531mnj28E0HDxQ1qzLd+mvpHTRR8SqxQZLjyTSXn0wASqhBSPaD6
        g83Cyt36c7Fcwkm2qn4INPlVjYDGOjGEvg==
X-Google-Smtp-Source: ABdhPJxSJd0To5ubHPmvv8nls7Sz7oTekBM+Y1G8i0qDOWkUIQmLdwfCWQUFmZM7z25U08+qoWJ8Iw==
X-Received: by 2002:ad4:4502:: with SMTP id k2mr4275389qvu.43.1623412480697;
        Fri, 11 Jun 2021 04:54:40 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id 137sm4220780qko.29.2021.06.11.04.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 04:54:40 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: thermal: tsens: Add sc8180x compatible
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210608201638.2136344-1-bjorn.andersson@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <22fdd7f8-87c1-6a0e-1fc6-8d7536d634a8@linaro.org>
Date:   Fri, 11 Jun 2021 07:54:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210608201638.2136344-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/21 4:16 PM, Bjorn Andersson wrote:
> The Qualcomm sc8180x platform has the usual tsens blocks, add compatible
> for this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Thara Gopinath <thara.gopinath@linaro.org>


-- 
Warm Regards
Thara

> ---
>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 0242fd91b622..fdd7c361104f 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -46,6 +46,7 @@ properties:
>                 - qcom,msm8996-tsens
>                 - qcom,msm8998-tsens
>                 - qcom,sc7180-tsens
> +              - qcom,sc8180x-tsens
>                 - qcom,sdm845-tsens
>                 - qcom,sm8150-tsens
>                 - qcom,sm8250-tsens
> 

