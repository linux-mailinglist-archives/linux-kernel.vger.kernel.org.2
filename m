Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D328313F7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhBHTsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhBHSGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:06:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC43C0611C0
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 10:02:49 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d3so23613716lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gqu9h0id+w+7V6CVFEqbAEdHRrinmkebpGlAQt4kbuk=;
        b=jA1UPfg+UJfwwx/gmdzqUJAVbw0lGSuN7P95LjM5eq5iVa2lPpevInPm5bMpf+xC7G
         MFEPN8cWvWgADUDXFLQbZeOo36LnX+D+zsCQKx9AIfg9kDJ+KARC068fAB6FAvqyzX+V
         K/J0iyWgKrsCyxicsHz9W+dwCECmuoUD3mnASufrRFCixQClJgRjDyFDSViz2F06jhOy
         GKhwsLTYL9CrsuXB2qokSQxqaM66PVn1x6qAASmDaShfURMhzcibR1iamrwp9oO7xE8L
         ImccXINYxP94EJywNhhhcR642FqwpWbR7ylc+tCpgCsgE8c9Qkz49roiiBHtweEWxhS+
         tXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gqu9h0id+w+7V6CVFEqbAEdHRrinmkebpGlAQt4kbuk=;
        b=OqrrUTlg46z6kIyUUGmwMcbLJUtQRBRJ4YOqu6mPmcF4WSqs5ce09weFGOtrvwaK/p
         kkfNbak1kU3HswrbpSOxvwV1JfXb1mPT4uit54Dy0c3ZdWt5BWceC0c/bABeFesLg3hR
         7WBBF3pwNDSLHU7QSAi50vKGWx8yJaeTQU3SsNwa0CcJuP87PZj1xpBkXFQ0wdA5g5JV
         cDBmx9O8VozhkaZ69pKRN3zbn2kfWO22UGLZ12EQ5oiPAKI0kfvxAzlUJVQg5EQBk8Lt
         iiBeHIvkQPWXmxQ9N3Fz3y4BC4fnnO6C0wV6md1kpg6r6Z4MQ7llMo46MXN1w6T+wnZs
         B6eQ==
X-Gm-Message-State: AOAM533Y21QEMnZv839hSZ7EdLqj6Ohd30gBxAiCgbCCqq1vIYtwpzfE
        xbOM3BTiFZ5fn+JysUXTGZUc4g==
X-Google-Smtp-Source: ABdhPJzkc7zj1dm1sjw3sF4+OsY7b5tFhLS7Nrx2zUCg2F803d9cug2l2XpxACDUy8bxxZvlskPTIw==
X-Received: by 2002:a05:6512:3457:: with SMTP id j23mr7557472lfr.305.1612807368198;
        Mon, 08 Feb 2021 10:02:48 -0800 (PST)
Received: from [192.168.118.216] ([85.249.43.69])
        by smtp.gmail.com with ESMTPSA id v24sm671458ljg.27.2021.02.08.10.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 10:02:47 -0800 (PST)
Subject: Re: [PATCH v4 11/22] media: camss: Add support for CSIPHY hardware
 version Titan 170
To:     Robert Foss <robert.foss@linaro.org>, todor.too@gmail.com,
        agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
References: <20210205104414.299732-1-robert.foss@linaro.org>
 <20210205104414.299732-12-robert.foss@linaro.org>
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
Message-ID: <104e9dad-6819-119e-8f76-d83473374642@linaro.org>
Date:   Mon, 8 Feb 2021 21:02:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205104414.299732-12-robert.foss@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

Thank you for your patchset!

On 05.02.2021 13:44, Robert Foss wrote:
> Add register definitions for version 170 of the Titan architecture
> and implement support for the CSIPHY subdevice.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>   .../qcom/camss/camss-csiphy-3ph-1-0.c         | 182 ++++++++++++++++--
>   .../media/platform/qcom/camss/camss-csiphy.c  |  66 +++++--
>   drivers/media/platform/qcom/camss/camss.c     |  74 +++++++
>   3 files changed, 290 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index 97cb9de85031..148b8c50382c 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -47,6 +47,105 @@
>   #define CSIPHY_3PH_CMN_CSI_COMMON_CTRL6_SHOW_REV_ID	BIT(1)
>   #define CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(n)	(0x8b0 + 0x4 * (n))
>   
> +#define CSIPHY_DEFAULT_PARAMS            0
> +#define CSIPHY_LANE_ENABLE               1
> +#define CSIPHY_SETTLE_CNT_LOWER_BYTE     2
> +#define CSIPHY_SETTLE_CNT_HIGHER_BYTE    3
> +#define CSIPHY_DNP_PARAMS                4
> +#define CSIPHY_2PH_REGS                  5
> +#define CSIPHY_3PH_REGS                  6
> +
> +struct csiphy_reg_t {
> +	int32_t  reg_addr;
> +	int32_t  reg_data;
> +	int32_t  delay;
> +	uint32_t csiphy_param_type;
> +};
> +
> +static const struct
> +csiphy_reg_t lane_regs_sdm845[5][14] = {

<snip>

> @@ -208,6 +294,66 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
>   
>   	val = CSIPHY_3PH_LNn_MISC1_IS_CLKLANE;
>   	writel_relaxed(val, csiphy->base + CSIPHY_3PH_LNn_MISC1(l));
> +}
> +
> +static void csiphy_gen2_config_lanes(struct csiphy_device *csiphy,
> +				     u8 settle_cnt)
> +{
> +	int i, l;
> +	u32 val;
> +
> +	for (l = 0; l < 5; l++) {
> +		for (i = 0; i < 14; i++) {
> +			struct csiphy_reg_t *r = &lane_regs_sdm845[l][i];

- this line gives me a compilation warning :
warning: initialization discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
   306 |    struct csiphy_reg_t *r = &lane_regs_sdm845[l][i];

Change it to:
	const struct csiphy_reg_t *r = &lane_regs_sdm845[l][i];
?

Thanks,
Andrey
