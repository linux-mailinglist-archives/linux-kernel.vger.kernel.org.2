Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CCA42C0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhJMNFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhJMNFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:05:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82713C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:03:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i24so11313948lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xmuT9xeRK5cWZopfiSt9NYASECgS6H526juk6qVcf6Y=;
        b=bhJtNTVffPAWj3bWjiyg1XNff6CIL0ethU3UFC+Jd+DnHtjxo12nSgxlfLMmmb6CPt
         siEVuT7n0M4u8v4qcz4WNWm8Yfd/YzZeOLnsOchW4hKrVaj7R0OUhLEUfGYtuaNI02WK
         abSOrX2NC4EWixZcDM+o3bppZLQ/R7QU2Eh4UPimpYHre7QK548w506afrux9NaaCWXa
         gRzT2jeQvxsedaYFV+dsnHcOAWdO0bEKzac8MQ4PMICcz2CaRDoLX8C9cYExZ3qvOypr
         upUpsABkjHNmyEMFPmGOyJlgKdYkz6fnZ/nFlYqblT5iQrm+JhGsGcRaqlnldpcfMqWj
         dM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xmuT9xeRK5cWZopfiSt9NYASECgS6H526juk6qVcf6Y=;
        b=gEisYPiPlM/JlIrIVQj3x7oM6Jhx6YkOBua9mpBQa/bgNDyfxd4J2FIJ0IgeQkVZbL
         C4ip2fKUfrioQdRsd8mjguXH/HuNPlxT76luG2qdLC3q0J3CY9l7ax8vzZCTUNpzvRGD
         nWeYkB3SwTpItfKHwwr4HNGb8iLzPUHW75nBOmRnLpnnJeuGt42cR6x4MCUyVSIZZvXL
         xm2lt/r3RiXpyPkQB3nUasOsaKIHQOOFusbUe27a50Unh+4aG0XVrH4rRHcEfqzhN8a4
         ThVf6ddcG2juqiw2tQi+yf0J0PW5KetnAZJOIFrqxgn71L6iYwIs/W29XAv6i309Vz99
         rUFg==
X-Gm-Message-State: AOAM533Gc1QdB8O+/ma1qtzuvZzkp91yN/sjZSdBxYG81gthrE3Dp7Os
        ruEFKxKYBWtuNTvP368JVDmxNg==
X-Google-Smtp-Source: ABdhPJzpH/vyOQKE8IJaZ0pUUxvPYUM/9nVGmH5nItOlKHI44htq3EZ0V+Qcw7jafbjgP3CLvou04g==
X-Received: by 2002:a2e:a584:: with SMTP id m4mr14952888ljp.489.1634130183009;
        Wed, 13 Oct 2021 06:03:03 -0700 (PDT)
Received: from [192.168.1.102] (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id q1sm1328352lfg.18.2021.10.13.06.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 06:03:02 -0700 (PDT)
Subject: Re: [PATCH v4 05/20] dt-bindings: qcom-bam: Add 'interconnects' &
 'interconnect-names' to optional properties
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
 <20211013105541.68045-6-bhupesh.sharma@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <6d325686-461a-b321-148c-0142933a29e4@linaro.org>
Date:   Wed, 13 Oct 2021 16:03:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20211013105541.68045-6-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 10/13/21 1:55 PM, Bhupesh Sharma wrote:
> Add new optional properties - 'interconnects' and
> 'interconnect-names' to the device-tree binding documentation for
> qcom-bam DMA IP.
> 
> These properties describe the interconnect path between bam and main
> memory and the interconnect type respectively.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> index 32b47e3b7769..602e68df971f 100644
> --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
> @@ -45,6 +45,14 @@ properties:
>       const: 1
>       description: The single cell represents the channel index.
>   
> +  interconnects:
> +    maxItems: 1
> +    description: |

here I have the same comment about the set literal style of the
multi-line description, which is one-line, likely the specifier
is not needed...

> +      Interconnect path between bam and main memory.
> +
> +  interconnect-names:
> +    const: memory
> +
>     qcom,ee:
>       $ref: /schemas/types.yaml#/definitions/uint32
>       description:
> 

--
Best wishes,
Vladimir
