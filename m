Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6C23C2949
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhGIS5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhGIS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:57:35 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675A8C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 11:54:50 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l21so13393388oig.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=alWK8UhcG5j0NYrZ2N3LAFnFLUJpDeSorrfCNFfxWEc=;
        b=BqQ374+AP3DPp6StkotcCsX5ZRqLlJ9+2tD3dKNTMJB/K/EEexu9oEoQwWL6Umohai
         v0u7Ajj77mcWYzRrcv/yR/J0Xuuq8ZcVSbpDb8hC7KicRwB610o/PCu6pi/kt87PlixN
         uCRHpP8NBr5L8856+JV4CL9U/huXH24173Zo/tq7KLa82nIRkDbmx1AVt5FvVbU5Scxg
         VcNJeH9u9lNX3JlnaAo2C16IGkoLnwAgd/ao5/Q5xlpwU/oAnxPVt7+m8Ub7u90iJYzs
         InDA5UfquXf1+/Wv8Fb77JErRg2d8GFzsWY36CrPPN+SNXvnvgt5qBrA/qTAcCpo0YVk
         2Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=alWK8UhcG5j0NYrZ2N3LAFnFLUJpDeSorrfCNFfxWEc=;
        b=EYa0LZiLsDwqCGsAUDUye9aZg7vE3ozGrL4jw8Qjl/BQAzqjJ+B/3+d9f/uM8fC69B
         OvPqfo0J9CkTrjcOA/baEc3wZoRv4o28KfnDFwSZDoN3MlYvdocBjOlMKc0kPIajlVsm
         l3PLMk81CLlDGdQzneryMq4e4brfbWOo7dl667and5SuRk7DLl82F9Gj5RIKSq8iqov/
         U62sAGQwtV5u+RnKgFpS02Oe4ZzC05yG9fqEGu8tdUFQM5xa5+lxnWKmOGo8sWgNWrH5
         nmSbofsNeCNR2r6GOktSSg4WFoYao4/uI2HwODmG+dTphMz44PlyQzL6md5fEAMkyRrc
         SVNw==
X-Gm-Message-State: AOAM533C8yljgnh94DaXDeQFwCKVw9Z/enp+7H2R6Y4fjrKU+XY12/z5
        0g5CuBOmwyulYAf88Hbkv+RkDg==
X-Google-Smtp-Source: ABdhPJw14/5kSkIdr3IjP+8vLf4bVfpeo6nDDsePe68pR7uZ6iiZ6rKwMfB404tOjXZFxXHsilS0HA==
X-Received: by 2002:aca:a9d2:: with SMTP id s201mr277404oie.171.1625856889851;
        Fri, 09 Jul 2021 11:54:49 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b11sm687012oti.30.2021.07.09.11.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:54:49 -0700 (PDT)
Date:   Fri, 9 Jul 2021 13:54:47 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx
 power domain
Message-ID: <YOibdx4zyXEbq64q@yoga>
References: <20210709173202.667820-1-dmitry.baryshkov@linaro.org>
 <20210709173202.667820-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709173202.667820-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Jul 12:31 CDT 2021, Dmitry Baryshkov wrote:

> On sm8250 dispcc requires MMCX power domain to be powered up before
> clock controller's registers become available. For now sm8250 was using
> external regulator driven by the power domain to describe this
> relationship. Switch into specifying power-domain and required opp-state
> directly.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml      | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> index 0cdf53f41f84..d5c4fed56b6e 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> @@ -55,6 +55,11 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  power-domains:
> +    description:
> +      A phandle and PM domain specifier for the MMCX power domain.
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -69,6 +74,7 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
>      clock-controller@af00000 {
>        compatible = "qcom,sm8250-dispcc";
>        reg = <0x0af00000 0x10000>;
> @@ -89,5 +95,6 @@ examples:
>        #clock-cells = <1>;
>        #reset-cells = <1>;
>        #power-domain-cells = <1>;
> +      power-domains = <&rpmhpd SM8250_MMCX>;
>      };
>  ...
> -- 
> 2.30.2
> 
