Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CFA3A3A29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 05:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhFKDPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 23:15:39 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:40679 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhFKDPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 23:15:38 -0400
Received: by mail-oi1-f176.google.com with SMTP id d19so369915oic.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 20:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IuIwozhJDFBL8hYQWz1odJcBCa+RpeJTeZARLZAL5rw=;
        b=feDGUBYSF8mhXnNrCO3pu5UqEeXg8+ZgGu9MbsgnN3NPgZ7OtlxTNPrBVlERSmW3F8
         uFRTpi7VO0JpXC7+0DHy4vp/FuU5N7F3Q/jY58D8GwwYJFTZRbU+6q9zbeH1pxpqerAi
         kjt46Gij+K77yPhwqcX2kA2sYJn5v/+MCYOvzniCBhVMYh5dVnOOFZKwYd94MrgaH9sq
         MwoSIJTe67Ja0snlVjezEzHDK72LDWjJtCWoK0llh99eUN3X4AL4RnO3C1JycQE+KbO2
         a93RhcW16jVqwSeRvGs5zjQz6XrnnhwsHw7MtkwIErALdua+kyaedMVi51a2ACxNnW6Y
         waQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IuIwozhJDFBL8hYQWz1odJcBCa+RpeJTeZARLZAL5rw=;
        b=LA1QBicI+HxfY6xV21cccxxoqJVnbhCHIAnoPE7IR2fYTq7aVO0oE8HjcOvPgX/a+I
         WisErIo4OzUeMveNjv5FJcseS/ltQGOC75uA/A0aFc+EVQ0C6hAxNSZaYmDK98O/+dFm
         MnZ5n1Ckw9w5Cm9CHbOZYwDfgB6eZRyWxzjSKC7+YgGBEPr2NPiSyGaNoj4nP57GQFwK
         pRYTxOYdQ1Y3veRJotHWNe3EMfeOXHaZy1/ihbwFLcHNUaFhSHhpSFdbbiGqHreS+xkj
         QjVSlTEztI77zBhX2XZTInCOm78HWpiEfFOvOplJKSStuwySqGsSsruUc/5cPjEo9x8p
         hgDg==
X-Gm-Message-State: AOAM532Cz5UKAWxQ5fIUWs2KZqZCWkjLvnWgD/GhQc/4KsZRkbAJhmOO
        +gtf9Gr0Pe48zYN66Pc+XLyfRbDHMCR2fg==
X-Google-Smtp-Source: ABdhPJwTPSimV69QldbgX5gVk7APTkm/h5irTaOpZBtys9egPnVnKvp24IdNGM4nk16+6GmSQpnwXQ==
X-Received: by 2002:aca:4343:: with SMTP id q64mr995636oia.33.1623381146277;
        Thu, 10 Jun 2021 20:12:26 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o2sm910030oom.26.2021.06.10.20.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 20:12:25 -0700 (PDT)
Date:   Thu, 10 Jun 2021 22:12:23 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: Re: [PATCH 6/8] arm64: dts: qcom: pmm8155au_1: Add base dts file
Message-ID: <YMLUl6G7TXOFi3A6@builder.lan>
References: <20210607113840.15435-1-bhupesh.sharma@linaro.org>
 <20210607113840.15435-7-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607113840.15435-7-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Jun 06:38 CDT 2021, Bhupesh Sharma wrote:

> Add base DTS file for pmm8155au_1 along with GPIOs, power-on, rtc and vadc
> nodes.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: bhupesh.linux@gmail.com
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi | 134 ++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi

As we describe our PMICs by including their definition to the top level
of the .dts I don't see any alternative to duplicating this as _1 and
_2. So let's go with this structure.

[..]
> +
> +&spmi_bus {
> +	pmm8155au_1_0: pmic@0 {

I don't think you need to give this a label.

> +		compatible = "qcom,pmm8155au-1", "qcom,spmi-pmic";

This is a "qcom,pmm8155au", "qcom,spmi-pmic", the labels are used to
differentiate the two instances.

> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
[..]
> +
> +		pmm8155au_1_gpios: gpio@c000 {
> +			compatible = "qcom,pmm8155au-1-gpio";

"qcom,pmm8155au-gpio"

> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pmic@1 {
> +		compatible = "qcom,pmm8155au-1", "qcom,spmi-pmic";

"qcom,pmm8155au"

Thanks,
Bjorn

> +		reg = <0x1 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
> -- 
> 2.31.1
> 
