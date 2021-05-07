Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A608E3768FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhEGQmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbhEGQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:41:55 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B81C061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 09:40:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i190so7955257pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xRZozbSj5JJlMuUTe4lrInslxUwcTfAxWixBF52Viac=;
        b=EMrqt6SUvfHfueDNpj4rhhcf7h3ymIg9mcsONtu9G1cyzBoAh9w1NCnu1jyzSxyrd6
         f80AmRhbDW5Ge3jIvHS7uln4f4b9Y56ccCCJT8PmdKw/GlcAs6fmX/dXiBySeJSdcdUC
         2yN1o3CtgC0FiWLmyn0XkQ3aX5tlHYewXF2ws8iHDghmd6KSTQ6ka6QQbSe0p03rltlb
         jaZrwODYnwVw1RYFrZghXDIHZjWHy2NEK6oawVOzvFM0pjTV1I3tN1tck/KLo8Cl1pM4
         75vVN4LaHvTmdha7+EIcogC6yTQIuwgDvXmX9cNbgi8u2acfu6qzPrent4iHKzRHOyKV
         ktUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xRZozbSj5JJlMuUTe4lrInslxUwcTfAxWixBF52Viac=;
        b=O3VKPB+kTkR7EQWvVASSCggt8kTBr7zrGZAIcsdzxmfdxv+yvCEwrhxaDcmA43NxfI
         VD2uqTZgIBaKOUkJqSyhdfHB8T9xZHKjPd4mL8obCaRzeEjL5Mb4NxhWmLDJLR/3CewD
         OYvMH4zA2SMoS+SqMZ89SbSACuTcHk0yiVrBxYHPtbY0iFdWz42yYFLvxDrAyMNM1jDH
         0foD/Do+qch6f6IkNWQD1oYPuewdjg1a2CRoKv5Px8GTlMI90tKgDHlvejaU++E+8vh5
         wbMLboG3jOKGUysDoQGMzcz7qTJILGBNnafgrHDNowfDMFR3olTYwTO5K6WgBJn/z6B1
         Teaw==
X-Gm-Message-State: AOAM531BLrA+mr/64Ot5lsrq2RFV6d1CDu15J7afxF40vzJ3/n1dWcC+
        ey452oqIUT5HNklHB4pB9VgW
X-Google-Smtp-Source: ABdhPJzpnyq5HBH9yW+K1RZjCshQrJhcCi6hFFjInm/x5r/TkeXI4BPclZezomnm+Gg/394YWPxCyw==
X-Received: by 2002:aa7:88c9:0:b029:2ab:aea7:e761 with SMTP id k9-20020aa788c90000b02902abaea7e761mr2082866pff.71.1620405653157;
        Fri, 07 May 2021 09:40:53 -0700 (PDT)
Received: from thinkpad ([2409:4072:e94:6cb6:4728:f123:8d88:45e9])
        by smtp.gmail.com with ESMTPSA id z7sm2868984pfb.93.2021.05.07.09.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:40:52 -0700 (PDT)
Date:   Fri, 7 May 2021 22:10:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/3] remoteproc: qcom: pas: Use the same init resources
 for MSM8996 and MSM8998
Message-ID: <20210507164045.GA3622@thinkpad>
References: <zbAB2sceYHmsYeraZUi4YUKL7lgFMu13w3vHQQYUQ4@cp3-web-020.plabs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zbAB2sceYHmsYeraZUi4YUKL7lgFMu13w3vHQQYUQ4@cp3-web-020.plabs.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 09:18:04PM +0000, Yassine Oudjana wrote:
> The init resources for MSM8996 are missing power domains, and adding them
> makes the resources identical to the MSM8998 ones. Remove slpi_resource_init
> and use MSM8998 resources for both chips.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index b921fc26cd04..b1e613187c68 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -689,17 +689,6 @@ static const struct adsp_data mpss_resource_init = {
>  	.ssctl_id = 0x12,
>  };
>  
> -static const struct adsp_data slpi_resource_init = {
> -		.crash_reason_smem = 424,
> -		.firmware_name = "slpi.mdt",
> -		.pas_id = 12,
> -		.has_aggre2_clk = true,
> -		.auto_boot = true,
> -		.ssr_name = "dsps",
> -		.sysmon_name = "slpi",
> -		.ssctl_id = 0x16,
> -};
> -
>  static const struct adsp_data sm8150_slpi_resource = {
>  		.crash_reason_smem = 424,
>  		.firmware_name = "slpi.mdt",
> @@ -803,8 +792,8 @@ static const struct adsp_data sdx55_mpss_resource = {
>  
>  static const struct of_device_id adsp_of_match[] = {
>  	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
> -	{ .compatible = "qcom,msm8996-adsp-pil", .data = &adsp_resource_init},
> -	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
> +	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8998_adsp_resource},
> +	{ .compatible = "qcom,msm8996-slpi-pil", .data = &msm8998_slpi_resource},

NACK.

I see that the "slpi_resource_init" and "msm8998_{slpi/adsp}_resource" are
completely different, even the firmware name. How can you get it to work?

Thanks,
Mani

>  	{ .compatible = "qcom,msm8998-adsp-pas", .data = &msm8998_adsp_resource},
>  	{ .compatible = "qcom,msm8998-slpi-pas", .data = &msm8998_slpi_resource},
>  	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
> -- 
> 2.31.1
> 
> 
