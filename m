Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD18A38F935
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 06:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhEYEHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 00:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhEYEHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 00:07:47 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F682C061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 21:06:18 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id c3so29073147oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 21:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ybb0Rjn6LAZQg4cEKA0v6b97wibERmiaV6NPZgANMOo=;
        b=jH4ERxqgRFMPae2s4f9MvoRGcL0LghRSEONXhM/5OztqvlZbrc+TILucrO0H7Tw4Nd
         QrgJ7xHirQoo6GbOHqREeszQPPafPh5E9KsxhOxk7M5t3V1oxuY+05BJupAP1s3AhpLK
         zNQ+roY+ZuymjCDkjQr19jrfNVmLX7gqQaxnD1Sgnyw4Np9eVPGpSyXlWZKQWD5ArcXh
         R/8JK1pQfiQLx3DMvcNu0yVRgfSTDmoHdNC+etPlhy6G0wgXUHnUb7Vv0onhzLdOMYv+
         7WICFtlkAH04FQZ8TeGvJY+EEW4lPg5h89yJmC3IFh18T8PZPmd4qylTU63GJoP4LRs+
         86Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ybb0Rjn6LAZQg4cEKA0v6b97wibERmiaV6NPZgANMOo=;
        b=Moknht9pnJrHzrnd5k31Gal4f1TYzhk+RR8EjehJZPFenkb2rjDI1FnTyjuAD50wH0
         Ronmho8JYOtDevsC9S8jh7C61gbW0rqwZd2qoAFAHt24ujbymzJBDAUO0E7ZawP3L2ym
         E7O5YJa2oshuvZwuzjEPf1/0f6eiFj1Iu5ZEEnns4LfEweJ/tgdK4APEew83rwYWUkkN
         1pb8hRXX4kYBuX7fI0mjpQ05cXAY87hN8W5t4T7nC+pQXziduSq1vWPJ2nhIadJXjVy8
         1ZJF5HMxFh/LowI+gxyZmPtw3Zqn2SUHrLoj5vgoIxzyNMrBs3CZvIZSMfqZ3YUTAjjC
         LeDQ==
X-Gm-Message-State: AOAM530Nwb0XDbRVS2x1gjHYUvVMlymkdRdO6zVOUMsUR0suzFxpSwxL
        rn9AceH0sL80v+d7rImbY9m5EQ==
X-Google-Smtp-Source: ABdhPJySknn88EkRCFhznHNTqELFEezy08ZdiZAHPKjDKaNPnCcaoRo+cEW0tZyNSYFRGJgHkIiblQ==
X-Received: by 2002:aca:2b17:: with SMTP id i23mr1486357oik.160.1621915577512;
        Mon, 24 May 2021 21:06:17 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l11sm3145920ooq.44.2021.05.24.21.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 21:06:17 -0700 (PDT)
Date:   Mon, 24 May 2021 23:06:15 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] mailbox: qcom-apcs: Add SM6125 compatible
Message-ID: <YKx3twDPcDmK9K8K@yoga>
References: <20210523212038.736445-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523212038.736445-1-martin.botka@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 23 May 16:20 CDT 2021, Martin Botka wrote:

> This commit adds compatible for the SM6125 SoC
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Please also submit a dt-bindings patch.

Regards,
Bjorn

> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
> Changes in V2:
> None
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index f25324d03842..57745a764d4c 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -57,6 +57,10 @@ static const struct qcom_apcs_ipc_data sdm660_apcs_data = {
>  	.offset = 8, .clk_name = NULL
>  };
>  
> +static const struct qcom_apcs_ipc_data sm6125_hmss_data = {
> +	.offset = 8, .clk_name = NULL
> +};
> +
>  static const struct qcom_apcs_ipc_data apps_shared_apcs_data = {
>  	.offset = 12, .clk_name = NULL
>  };
> @@ -166,6 +170,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>  	{ .compatible = "qcom,sc8180x-apss-shared", .data = &apps_shared_apcs_data },
>  	{ .compatible = "qcom,sdm660-apcs-hmss-global", .data = &sdm660_apcs_data },
>  	{ .compatible = "qcom,sdm845-apss-shared", .data = &apps_shared_apcs_data },
> +	{ .compatible = "qcom,sm6125-hmss-global", .data = &sm6125_hmss_data },
>  	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
>  	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
>  	{}
> -- 
> 2.31.1
> 
