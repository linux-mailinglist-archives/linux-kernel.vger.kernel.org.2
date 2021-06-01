Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF6390ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhEZDUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhEZDUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:20:19 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B61C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:18:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so30676200otc.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YGXwzJCQFErYClb2EnipBLYblfsmIfhbELhVEOmEmTI=;
        b=K6Sk3jYxgjVXJwc6kE3n0cKeI+630QIrX7Qsi3cDGmmSDofGjKq7nIVYTBRW84i2aF
         KuBeM+UmCKKcuRHFm2EM1AW7/EUeOPXA1Ou5XMZ685QRXUm9w9DRNqfpdZ37LutxiqIm
         12XH0zEuHLsTfU5de9im+LqlehsXi3GJeaWz69kJCNWK+wrT1L/Tw2pKCMbkOHM3Ayrp
         Pqlsckjgb0m861r4ERzXGgbEr/wcPi1z8yi7IdA9PG1No+zMr81VBRWbJQuy2dx2Y1TJ
         EQ+zwT42emFO7YBl870ORbYFL7Ab9yjji2vYcDJnFmOOf+t6vhL+Sql7AxL4B+yIfATh
         jpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YGXwzJCQFErYClb2EnipBLYblfsmIfhbELhVEOmEmTI=;
        b=jllQFPupWZosQW1rcUGsiSWEsy8F85IL7W/eSo3fSjCrm/HFZGgQyUUbNGy8FUnlxO
         XOnBJpC8FFmskgx4XpDR0LxjHFtNbuYgkKRWblagqH5dMAHdGbvu6i+jRzo15Ho6owBu
         3vYSVE7mIeWZCsWVZjRAhLogE/BRlzqUvhPfvtKPN20fCBOMLh8TZxV+kpwpJGn25TH9
         mqiwdqeu04UP2ZcGngoDDZigu7Z9kmw8wSfKCCxiQiXMyz6hNjuPmgkogF+7BWE83HwD
         V30vKAWRXZxKvGp7llwQX8U+Vr37H0DUoOxGtgzjmbHsse0hiqrVzVVGuQCUzgOtVTGo
         aQ7g==
X-Gm-Message-State: AOAM531mtStFsCLSJ5NFlXPi9bAnP8InyloqVDn7kBW2YqL4kU0ADJZx
        G76buyUEChYq4AuR9J7Q9UNpjA==
X-Google-Smtp-Source: ABdhPJy08CENDuldrPgkLN1jUuH8g3uNtmHsp/QGWcMNofLQi2pyeFR8Qc1HHOHvxDhfY7QB+3n9xA==
X-Received: by 2002:a9d:405:: with SMTP id 5mr671179otc.9.1621999127563;
        Tue, 25 May 2021 20:18:47 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n11sm3768703otf.26.2021.05.25.20.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 20:18:47 -0700 (PDT)
Date:   Tue, 25 May 2021 22:18:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] arm64: dts: qcom: Add MSM8996v3.0 DTSI file
Message-ID: <YK2+FfLrt+8ODVHb@builder.lan>
References: <20210525200246.118323-1-konrad.dybcio@somainline.org>
 <20210525200246.118323-2-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525200246.118323-2-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 May 15:02 CDT 2021, Konrad Dybcio wrote:

> Add an overlay for MSM8996v3.0, which is a pre-final revision
> of the said SoC. It has some stark differences with regards to
> GPU, or more specifically its power delivery path. Oh, and of
> course a different msm-id.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
> new file mode 100644
> index 000000000000..b46f10b7413a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0

BSD license?

> +/*
> + * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
> + */
> +
> +#include "msm8996.dtsi"
> +
> + / {
> +	qcom,msm-id = <246 0x30000>;
> + };
> +
> + /*
> +  * This revision seems to have differ GPU CPR
> +  * parameters, GPU frequencies and some differences
> +  * when it comes to voltage delivery to.. once again
> +  * the GPU. Funnily enough, it's simpler to make it an
> +  * overlay on top of 3.1 (the final one) than vice versa.
> +  * The differences will show here as more and more
> +  * features get enabled upstream.
> +  */
> +
> +gpu_opp_table_3_0: gpu-opp-table-30 {

Unused for now?

Can you link it up this with the &gpu even if you don't enable it
for now?

Regards,
Bjorn

> +	compatible = "operating-points-v2";
> +
> +	opp-624000000 {
> +		opp-hz = /bits/ 64 <624000000>;
> +		opp-level = <7>;
> +	};
> +
> +	opp-560000000 {
> +		opp-hz = /bits/ 64 <560000000>;
> +		opp-level = <6>;
> +	};
> +
> +	opp-510000000 {
> +		opp-hz = /bits/ 64 <510000000>;
> +		opp-level = <5>;
> +	};
> +
> +	opp-401800000 {
> +		opp-hz = /bits/ 64 <401800000>;
> +		opp-level = <4>;
> +	};
> +
> +	opp-315000000 {
> +		opp-hz = /bits/ 64 <315000000>;
> +		opp-level = <3>;
> +	};
> +
> +	opp-214000000 {
> +		opp-hz = /bits/ 64 <214000000>;
> +		opp-level = <3>;
> +	};
> +
> +	opp-133000000 {
> +		opp-hz = /bits/ 64 <133000000>;
> +		opp-level = <3>;
> +	};
> +};
> -- 
> 2.31.1
> 
