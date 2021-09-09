Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ABD40590A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243720AbhIIOaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbhIIOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:30:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4368EC00F61D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 06:19:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e23so3668516lfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zjCm2kqLmEkD1fYMpLfynjls4LWjCF1R/HM+9Gqf848=;
        b=OE15DtuTMThkONQn2QaW9vAJKJ4c5pWnECM8dh6t2F5lxkzOQeepKE0K4HmtgqZgjV
         MRkwgGmGmxUriL00OMiESoz55OF7Kg50LWHvTG1px0UFyDmtKcbVmx4Uoah1/qoJWO2i
         5p3ySfY5SwOR9I8JDePdifMsBy7MlP3+CHy2wNlJBPmtx9ai9DWrRxh430t8NpR+qkbV
         yJOIbzETKc40EIGF15R4XdOy/OgEfFhXtuJ/0bmufBPBzcG62lorQlBtuzSLqOVhO/bC
         loAS8P5S/d02dnIN04YJ10gffnzt8rv9c7Ey+vvL5DYUHVSyEqPETkva74sSJ0Pjk1j1
         /7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zjCm2kqLmEkD1fYMpLfynjls4LWjCF1R/HM+9Gqf848=;
        b=2S34Cl00XCuzx1VT1XT89zDvI8N4hjysx9HbzfQbEYR+GGY/8s7El4d1pVz6oWsbth
         oaX0DbJQZAeBN3b5Cg15AiFxA2qpkqE1G4HgvgCLmZRV/ub5Xw3b+dQQBJEEVGEjjzqB
         DdVq5Vjx1Wc0Lh82eXWP/VEYssJQLT2tzQjgY2OdS7YUn7oXCxbpkpNV3DkSH0A5cMka
         qtYFaKGTbm9Af1bZCrwleM34PLCdnqHW15DGA46c7rSyi/1o6ay1SbeqjsYTrj0zrYOM
         xVelID0I5HsAnwKKJ4zMMgRO5DkFeiD7jXyZGjvCznMuIuzI9mBx/m+SiNrMXK1jVlz1
         aGMA==
X-Gm-Message-State: AOAM533KpFRHGGJBEEvxIkS52OpPfsu67xmNW4JqKbOXidgcSvoRqToG
        p8gNMZ1fXpizQFZlNiPjyZ4q+w==
X-Google-Smtp-Source: ABdhPJw92+bv1tpDoZqXpouY2qicTHxeTcDi4tXjJ1yAhPRIT8shcSy3idYOKvLB9LMdigSvIPI8Hw==
X-Received: by 2002:a05:6512:b27:: with SMTP id w39mr2412730lfu.129.1631193549547;
        Thu, 09 Sep 2021 06:19:09 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d1sm200065lfl.5.2021.09.09.06.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 06:19:09 -0700 (PDT)
Subject: Re: [PATCH 3/7] arm64: dts: qcom: msm8998-xperia: Add support for
 wcn3990 Bluetooth
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        bjorn.andersson@linaro.org
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20210903180924.1006044-1-angelogioacchino.delregno@somainline.org>
 <20210903180924.1006044-3-angelogioacchino.delregno@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <7032cf3a-2469-3d66-bfde-9754dbac58b9@linaro.org>
Date:   Thu, 9 Sep 2021 16:19:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210903180924.1006044-3-angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2021 21:09, AngeloGioacchino Del Regno wrote:
> This platform uses the WCN3990 Bluetooth chip, reachable on UART-3.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi   | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> index 2fe53e4675d5..66b009ba72fe 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> @@ -179,6 +179,23 @@ &blsp1_i2c5_sleep {
>   	bias-disable;
>   };
>   
> +&blsp1_uart3 {
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l25a_3p3>;
> +		max-speed = <3200000>;
> +
> +		clocks = <&rpmcc RPM_SMD_RF_CLK2_PIN>;
> +	};
> +};

There is an ongoing proposal to rework wcn3990 (bt and wifi) bindings, 
so we might want to delay this a bit. Not a strict requirement, since 
the changes would be backwards-compatible.


-- 
With best wishes
Dmitry
