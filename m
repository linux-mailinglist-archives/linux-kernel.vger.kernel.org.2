Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44938BBEC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhEUBsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbhEUBsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:48:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 18:47:13 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id k4so7202302qkd.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 18:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m4x7lU1U7Nhzd1I5e57Naj6BhSC/JD8u6YQwuIwYouE=;
        b=Jv66ORDh/GUPU+ziJkeIfJao5g5k+Gn979a/+af8pXMgS21oiuBKVeO4JVq3HoYiXX
         ksOVdHjKYPObmYufYaKOZ3BO8dPeNT2g6q67R+Uw+RKO0r6ZYArypFy1dpGYkb8oi+QR
         afNiXzYbIjDyXa6gu2HD8bMwIFswPPj4dcA85oAyb1cExpDh4+K/suH2IU7cpS0SmJ19
         IFtUaoXDHHoBaSqGyzLIZGukGY2ZArBfIJ4RTZJJ341z4usaU7LXMGsx8cR9AX956ugM
         T3SmPW/qzHjW0M8W23cXKdOtX3s7eiC0muF4jv0B+ubcWj1Q8de5A3Fe+4yj9mLS5rAd
         qOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m4x7lU1U7Nhzd1I5e57Naj6BhSC/JD8u6YQwuIwYouE=;
        b=AkDaDekouqmoYlFdWgIcqGP7fqHixAg3VBbhjfQ0uzbdBAQv+Ie909HmnhjgCnqat0
         1Qvu0e25+aOgruX0cbgKxWw4scBziqe4vzE/Kx2LDSQ1lTNAaX8HNxnvMZ6H8OLehqW7
         5OD4mgYaLjcZrUrWfIsUNxJC3O3D92KnC+YD4tB1VKVVdz4U6Pk3rjGWjRQTFkPnvAB7
         QeUZ5ajIiGgDaMuooqBWFoCwq1XUbBx3aW5JLrMsspVJav0bWua0Z2WDZkUnY4Z9Ea84
         OHgEw7OEEMkgDi1uKnebOIr8r1VpyiBd3VsHPXGrCSqaYBRuKbLNCp7p37xbxBEkMdMr
         0nGg==
X-Gm-Message-State: AOAM533QVyroIA6H+6gH1FXxLtO2H/t4Oad1QB4YvtG3oX4MNOlvsMUy
        1L2Dlj5NMsFlgp4T3eQmZTAr2A==
X-Google-Smtp-Source: ABdhPJwsz3B6Ow0zdsob/uNRAg7KYoQSta4h9ulEkAfsBE/ikkwVlrzwDK+nX2qnpzqBReNRxCgSqQ==
X-Received: by 2002:a37:8b86:: with SMTP id n128mr7761986qkd.141.1621561632844;
        Thu, 20 May 2021 18:47:12 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id a14sm3356422qtj.57.2021.05.20.18.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 18:47:12 -0700 (PDT)
Subject: Re: [PATCH v3 07/17] arm64/dts: qcom: sdm845: Use RPMH_CE_CLK macro
 directly
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-8-bhupesh.sharma@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <ead0b21e-3cf3-e882-ebef-eecf2e0a0f8c@linaro.org>
Date:   Thu, 20 May 2021 21:47:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210519143700.27392-8-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/21 10:36 AM, Bhupesh Sharma wrote:
> In commit 3e482859f1ef ("dts: qcom: sdm845: Add dt entries
> to support crypto engine."), we decided to use the value indicated
> by constant RPMH_CE_CLK rather than using it directly.
> 
> Now that the same RPMH clock value might be used for other
> SoCs (in addition to sdm845), let's use the constant
> RPMH_CE_CLK to make sure that this dtsi is compatible with the
> other qcom ones.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bhupesh.linux@gmail.com
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>


Warm Regards
Thara

> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0a86fe71a66d..2ec4be930fd6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2316,7 +2316,7 @@ cryptobam: dma@1dc4000 {
>   			compatible = "qcom,bam-v1.7.0";
>   			reg = <0 0x01dc4000 0 0x24000>;
>   			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&rpmhcc 15>;
> +			clocks = <&rpmhcc RPMH_CE_CLK>;
>   			clock-names = "bam_clk";
>   			#dma-cells = <1>;
>   			qcom,ee = <0>;
> @@ -2332,7 +2332,7 @@ crypto: crypto@1dfa000 {
>   			reg = <0 0x01dfa000 0 0x6000>;
>   			clocks = <&gcc GCC_CE1_AHB_CLK>,
>   				 <&gcc GCC_CE1_AHB_CLK>,
> -				 <&rpmhcc 15>;
> +				 <&rpmhcc RPMH_CE_CLK>;
>   			clock-names = "iface", "bus", "core";
>   			dmas = <&cryptobam 6>, <&cryptobam 7>;
>   			dma-names = "rx", "tx";
> 


