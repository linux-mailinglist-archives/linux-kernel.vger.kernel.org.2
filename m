Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC41422EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbhJERB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbhJERB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:01:56 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F89C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 10:00:05 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c6-20020a9d2786000000b005471981d559so26654658otb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 10:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eT4QRWTiJcs1knqD0fms3lf+fPlsl7moqQX0wdYcY2M=;
        b=sLzQMGXP4lgmvW6RIos0qJsSgfnvDPNPlxKz2aHtLdzE6GdRTycaBnkCKNjXGOEDRC
         wrzfyJIZNmfz0HPapn33yfabQJTY5IZQNOzdjM3rXsVolGMtMpmAe40khV59mmixH6CM
         whbo3qoGSQxWG/UHNB169e90vg9khpC5JY1Zd12yJCa3tNsluVTzjHVdfKJG9eYENNBv
         U3gqZe+LI9wtybSg/larb2Nq2bMKax1sf1aWgwrR15QKY0l5h5ocm+Bgiskj6+NlZM4+
         nu8WfFDGDV1NaNMsyKV3rlECx6QgSz7avNXjrrpIoLoMdb7LttswJTUeRvkHjnV5qB2e
         Cymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eT4QRWTiJcs1knqD0fms3lf+fPlsl7moqQX0wdYcY2M=;
        b=Z6YVrXD58LzlcazO67SwxuEXXC4iNx7XF/sQH0yo3gR0mU1e5ysJOzoP8tcTxCaDlr
         5oIgrdqEz5gQVYEbpOdd2HghiHLdNWIl6xZi3Aj3JXzf3BcqH2AYa1j+ZEKXciDXbhA1
         zEgfZoyl2FwOU+iKvmVTdBdZ+19Na9grIpavqOlxv81h5KkHH4wxXW8dvCVm1iegVZS/
         IthzqSYstuy+DH7d82pxBHHtrs7zTFv88rIIr5voC0XTOhjCALWTIeM8ckZZDWd8TeLn
         gQVOZR1OMQbj8UVJuRE6beafptOwA5T8aq7H/jUdEEcwpwMDiQlYaflcOGBd9iRPT1/Z
         3VYg==
X-Gm-Message-State: AOAM530Nxvs2NnlZV+7ZxWBEmm9xP3CRFB4KddwFWBGbQx+ZsnJE/CsP
        3JeKkF5LUubQwtQPK1ryTeYYxg==
X-Google-Smtp-Source: ABdhPJxY2jmsRmi0yUIG27/p4uC6tH4JPn1TN2xDpW8nkkRfeciD9lUi6d1YiRKW4hjAqu6mxi4HeQ==
X-Received: by 2002:a05:6830:2906:: with SMTP id z6mr15861929otu.257.1633453205311;
        Tue, 05 Oct 2021 10:00:05 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id u2sm3664543otg.51.2021.10.05.10.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:00:04 -0700 (PDT)
Date:   Tue, 5 Oct 2021 10:01:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     agross@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org,
        Venkata Prasad Potturu <potturu@codeaurora.org>
Subject: Re: [PATCH] ASoC: qcom: soundwire: Enable soundwire bus clock for
 version 1.6
Message-ID: <YVyE+ytKVmOh85c3@ripper>
References: <1633105471-30928-1-git-send-email-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633105471-30928-1-git-send-email-srivasam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01 Oct 09:24 PDT 2021, Srinivasa Rao Mandadapu wrote:

> Add support for soundwire 1.6 version to gate RX/TX bus clock.
> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  drivers/soundwire/qcom.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 0ef79d6..599b3ed 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -127,6 +127,7 @@ struct qcom_swrm_ctrl {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	void __iomem *mmio;
> +	char __iomem *swrm_hctl_reg;
>  	struct completion broadcast;
>  	struct completion enumeration;
>  	struct work_struct slave_work;
> @@ -610,6 +611,12 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, ctrl->rows_index);
>  	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, ctrl->cols_index);
>  
> +	if (ctrl->swrm_hctl_reg) {
> +		val = ioread32(ctrl->swrm_hctl_reg);
> +		val &= 0xFFFFFFFD;

That's a tricky way of saying:

	val &= ~BIT(1);

That said, naming bit 1 is still a very good thing.

> +		iowrite32(val, ctrl->swrm_hctl_reg);
> +	}
> +
>  	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
>  
>  	/* Enable Auto enumeration */
> @@ -1200,7 +1207,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	struct qcom_swrm_ctrl *ctrl;
>  	const struct qcom_swrm_data *data;
>  	int ret;
> -	u32 val;
> +	int val, swrm_hctl_reg = 0;
>  
>  	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
>  	if (!ctrl)
> @@ -1251,6 +1258,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	ctrl->bus.port_ops = &qcom_swrm_port_ops;
>  	ctrl->bus.compute_params = &qcom_swrm_compute_params;
>  
> +	if (!of_property_read_u32(dev->of_node, "qcom,swrm-hctl-reg", &swrm_hctl_reg))
> +		ctrl->swrm_hctl_reg = devm_ioremap(&pdev->dev, swrm_hctl_reg, 0x4);

Nack.

You may not pull an address to a single register out of an undocumented
DT property and blindly ioremap that.

And you surely should check for errors here, to avoid magical errors
caused by this ioremap failing and your bit not being cleared.

Thanks,
Bjorn

> +
>  	ret = qcom_swrm_get_port_config(ctrl);
>  	if (ret)
>  		goto err_clk;
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
