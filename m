Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C93966A1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhEaRPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhEaRNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:13:49 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F166C0431D6
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:20:49 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id c3so12578623oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vDiqLRd+stLKTmfiIZ/+t8l2ObZwO4uStCLNw0eONeE=;
        b=rU70Jx0Tu1AeMSbrsJZd6hMbh05hvmblGlAfJDjDlMe5amlLHOnvST+bRRQfrCw8EM
         Qd9842dMFMFcboy6jC5sh4EHSAwpKUMFaGFEiZ/MqIQXSi6Cd/Sxj9528wWwQNZQGh86
         PMTfUPSnjRvvOHJ/yWlvwqwpnlACKmVJm9uRhFakwPGsWz2EeD5EilKOTWZqUw5+STpt
         LXLA+C7PLvNQei6RRzAphgbWj8fXlJ5KGYGYCuhnGN1pLozPwju/y6JZCGGA08GzlWsG
         qFUMVrbvvub1htNg8R4mNhUsLusJiRcPm3C9vjGQ+br4/fjral4HpW6PUxt+di/q/PMr
         8UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vDiqLRd+stLKTmfiIZ/+t8l2ObZwO4uStCLNw0eONeE=;
        b=HVGsKc+rzTWjPBYZHD4tJAVq8RfWJh5Y5NkS7v9cxHSbR/Z2ux4/aoR91ViZN6Fszq
         4Zv9U2mZVct0JhRfXQQJdC1CZkBQ8MAfxyZu8Mc5IB64K0sQc7AcCMqJWPNwcMC+QsIn
         /5hA8PluCqw6xhENft1DwshRs13VgYPvowlRKB6SY6Jj7gRP5cjr9+7Ton3Soq7ns7I0
         dwGexM9W1StVhNVTbebur74QWFj7dHAyf4JGAmFCUmXeFrD/GQuGI+fN87j2eDQEGkkA
         RgrG0O1nImLd9t4yO5pOBEhP1HwBeYlOOL2dPf35cf3XZBDRR+ehxIsOOiX53O5ZbOdr
         B36g==
X-Gm-Message-State: AOAM533LR5ziUyVEaWaUX3LWqa80/i9k5U+6wE6ODwAWcofUtpc9TiUe
        2b2T+Xrm0FRK3HCyxKokmGHkyA==
X-Google-Smtp-Source: ABdhPJzhu+c+Yxt4w6fUwjAM0yhgeLolRS1rYyxRr79QpCWKidIOwuZM7AzmeDDTPazwIzKy1euv6w==
X-Received: by 2002:aca:d544:: with SMTP id m65mr14663728oig.73.1622474448489;
        Mon, 31 May 2021 08:20:48 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v19sm3186318otk.22.2021.05.31.08.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 08:20:48 -0700 (PDT)
Date:   Mon, 31 May 2021 10:20:46 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: Add PMI8996 DTSI file
Message-ID: <YLT+zsYBEAcLh+k7@builder.lan>
References: <20210527170409.667255-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527170409.667255-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27 May 12:04 CDT 2021, Konrad Dybcio wrote:

> PMI8996 is *almost* the same hardware as PMI8994, say for some annoyances:
> 
> - Boards equipped with PMI8996 now have to include pmic-id (which wasn't the case before)
> - Different qpnp-ibb-discharge-resistor value (will be addressed after LABIBB is introduced)
> - Different inhibit-derating-ua value (will be addressed after BCL is introduced)
> - Different ramp_up_step value (will be addressed after [if?] QPNP Flash LED is introduced)
> 

If I am to support a device that has a pmi8996, I will go

#include "pmi8996.dtsi"

and wonder why it didn't work.

But, I do see the validity in your argumentation in the previous
revision so I won't object. But I really would like you to describe in
the commit message why this is different from what people would expect
to find.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/pmi8996.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pmi8996.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmi8996.dtsi b/arch/arm64/boot/dts/qcom/pmi8996.dtsi
> new file mode 100644
> index 000000000000..31b47209e261
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmi8996.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0

And BSD please :)

Regards,
Bjorn

> +/*
> + * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
> + */
> +
> + /*
> +  * PMI8996 is a slight modification of PMI8994 with
> +  * some notable changes, like being the first PMIC
> +  * whose the bootloader has to check to continue booting
> +  * and a change to a LABIBB parameter.
> +  */
> +
> +/ {
> +	qcom,pmic-id = <0x20009 0x10013 0 0>;
> +};
> -- 
> 2.31.1
> 
