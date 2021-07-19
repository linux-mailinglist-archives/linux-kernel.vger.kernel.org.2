Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC853CEDBC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386802AbhGSTjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385710AbhGSTHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:07:52 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A6DC061786
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:37:41 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id n187-20020a4a40c40000b029025e72bdf5d6so4761816ooa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mQSEq7q+wxePH17WHb+2Y12YcuWTNetJZSsUU2m7H7E=;
        b=N2B5cVOSFDnDhk7ZJikp57cYFtbff3OoOQABXLEuxfHd9w5r4YaazAcc8eRncMl+i9
         CdTXPuNSjfJ+fAwAqjqmLVQTUKmjxMrLtxadKzernVCPQvvZtMHw+PfN2YcVoFRpOJVn
         DO7kJXAMKW3uaCY8zg26hm+6/JN4SP0jKVMmYMwDnfqyuQw5+bpDBrJjC73C4be2Mazz
         ZrwERWVVJ3yvNk51DT0mBrWPRKdhmtqxpBsxxlEcsISSz7PLLV4MeZgq2wir9Dcz6etg
         xwTHQtPTxQMtjxgV1F5iZMxsUfm1ZThAV94QSeui+YSjZ+jd1hHx9N5U8/JBdGTb6QBW
         jvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mQSEq7q+wxePH17WHb+2Y12YcuWTNetJZSsUU2m7H7E=;
        b=WfV8XHeEq5ja/d5CK8p+FsHopVWbsW/HICt7ZPkNESXWPYU5owFPWGnlqG2S9QllKW
         bPER9je3wS4qLNc6Y2DGeKbHExy5FQewHEbhh1PWhL+tmzPr7t5ttgctQsKif8oQLdrj
         Y6eOO1yruPE+cVgzmq8kImoe7QO+V06cP39jIhT8ur5KhsuY43HJaWFyYcIeate4T5Np
         xCBFWkHSYNwQBnIjpqy4ZTOtcVOkMuI0vN50kPPTzPdxW+YMeZUhR5Duk50DcagHqcra
         71vNz3oAWn9iZM31x9RbXo399P/8aMgS/9XKo4rSKydfjvtDGVuUO15UsVCuq3danrgv
         Yzjw==
X-Gm-Message-State: AOAM530ZZTbrCqFREp7Kql6o1DlEIcZNqrRMqVxak9SIRc4nioD3+rFP
        mNn9wKyBVnuR3v7etxPKbrvRnA==
X-Google-Smtp-Source: ABdhPJyEgmEJXTA8pZhCE4A7kaDgxCC+tSYYlL5iU+L2BArlNQdV1CQLgfGgR5PaI1xtBZvOvuEvbQ==
X-Received: by 2002:a4a:e14f:: with SMTP id p15mr1215289oot.42.1626723899832;
        Mon, 19 Jul 2021 12:44:59 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v5sm1855606oor.33.2021.07.19.12.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:44:59 -0700 (PDT)
Date:   Mon, 19 Jul 2021 14:44:57 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, agross@kernel.org, ohad@wizery.com,
        mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        rishabhb@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH v3 02/13] dt-bindings: remoteproc: qcom: pas: Add QMP
 bindings
Message-ID: <YPXWOeq++TdwH1r4@yoga>
References: <1624560727-6870-1-git-send-email-sibis@codeaurora.org>
 <1624560727-6870-3-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624560727-6870-3-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 Jun 13:51 CDT 2021, Sibi Sankar wrote:

> Add Qualcomm Mailbox Protocol (QMP) binding to replace the power domains
> exposed by the AOSS QMP node.
> 

I think this would be a good opportunity to describe why you need to
make this change to the binding.

Regards,
Bjorn

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> v3:
>  * Misc. documentation fixes:
>   - Reduce power-domain maxItems due to load_state pd removal
>   - Combine compatibles where possible with the load_state pd removal
>   - Fixup the qcom,qmp ref to phandle type
> 
>  .../devicetree/bindings/remoteproc/qcom,adsp.yaml  | 62 +++++++++++-----------
>  1 file changed, 30 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> index 9ea05e608bc1..ad85617b43fa 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> @@ -75,11 +75,11 @@ properties:
>  
>    power-domains:
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 2
>  
>    power-domain-names:
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 2
>  
>    firmware-name:
>      $ref: /schemas/types.yaml#/definitions/string
> @@ -89,6 +89,10 @@ properties:
>      maxItems: 1
>      description: Reference to the reserved-memory for the Hexagon core
>  
> +  qcom,qmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the AOSS side-channel message RAM.
> +
>    qcom,smem-states:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: States used by the AP to signal the Hexagon core
> @@ -359,13 +363,11 @@ allOf:
>        properties:
>          power-domains:
>            items:
> -            - description: Load State power domain
>              - description: CX power domain
>              - description: MX power domain
>              - description: MSS power domain
>          power-domain-names:
>            items:
> -            - const: load_state
>              - const: cx
>              - const: mx
>              - const: mss
> @@ -381,43 +383,20 @@ allOf:
>        properties:
>          power-domains:
>            items:
> -            - description: Load State power domain
>              - description: CX power domain
> -        power-domain-names:
> -          items:
> -            - const: load_state
> -            - const: cx
>  
>    - if:
>        properties:
>          compatible:
>            contains:
>              enum:
> +              - qcom,sdx55-mpss-pas
>                - qcom,sm8150-mpss-pas
>                - qcom,sm8350-mpss-pas
>      then:
>        properties:
>          power-domains:
>            items:
> -            - description: Load State power domain
> -            - description: CX power domain
> -            - description: MSS power domain
> -        power-domain-names:
> -          items:
> -            - const: load_state
> -            - const: cx
> -            - const: mss
> -
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - qcom,sdx55-mpss-pas
> -    then:
> -      properties:
> -        power-domains:
> -          items:
>              - description: CX power domain
>              - description: MSS power domain
>          power-domain-names:
> @@ -439,12 +418,10 @@ allOf:
>        properties:
>          power-domains:
>            items:
> -            - description: Load State power domain
>              - description: LCX power domain
>              - description: LMX power domain
>          power-domain-names:
>            items:
> -            - const: load_state
>              - const: lcx
>              - const: lmx
>  
> @@ -458,12 +435,10 @@ allOf:
>        properties:
>          power-domains:
>            items:
> -            - description: Load State power domain
>              - description: CX power domain
>              - description: MXC power domain
>          power-domain-names:
>            items:
> -            - const: load_state
>              - const: cx
>              - const: mxc
>  
> @@ -499,6 +474,29 @@ allOf:
>              - const: mss_restart
>              - const: pdc_reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc7180-mpss-pas
> +              - qcom,sm8150-adsp-pas
> +              - qcom,sm8150-cdsp-pas
> +              - qcom,sm8150-mpss-pas
> +              - qcom,sm8150-slpi-pas
> +              - qcom,sm8250-adsp-pas
> +              - qcom,sm8250-cdsp-pas
> +              - qcom,sm8250-slpi-pas
> +              - qcom,sm8350-adsp-pas
> +              - qcom,sm8350-cdsp-pas
> +              - qcom,sm8350-mpss-pas
> +              - qcom,sm8350-slpi-pas
> +    then:
> +      properties:
> +        qcom,qmp:
> +          items:
> +            - description: Reference to the AOSS side-channel message RAM.
> +
>  examples:
>    - |
>      #include <dt-bindings/clock/qcom,rpmcc.h>
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
