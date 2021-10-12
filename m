Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A838A42A08C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhJLJGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbhJLJGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:06:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C50AC061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 02:04:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t2so64714305wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UwNILf/oluFUUL5PRUd2S4kE1LT5CdgyGEGUgX5bbxQ=;
        b=W6+2A3muXydBcHY/YF74R9Dh7MLGWONPA3LeeKLsKxiK1FD/dPcgXuStynOCL0/KsM
         4rHWc0ij/gMMghBussGkcCz1tQ9RIEAbQ0R31is7iooKjUj4dG9918VvbE/IZxdNFugB
         I9uXtMBGeUpQdz9qDmS588A6fge1rY7zFDa6M6+IgdCoLymzCByNymv7gbkbPgWJtg/2
         Pw+JbagwgQT6P3Fe65I9XHmGEMNFS12b7+R33ZxJ/SvPmH8eyP4ZCzxbq25itDhjs2u+
         Q1InWToDbUEWIR1RLik2xe0SJ+lsQMQPRvBTSC2GIlPEzeE1RoiHZ0eWUN8gcQJcs5dn
         rm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UwNILf/oluFUUL5PRUd2S4kE1LT5CdgyGEGUgX5bbxQ=;
        b=0vgZmfItNwASKfD3wYoUCIMvlbW3hS7e81dGSPKEuFKJxeq+Hx+DCs9jWEBGyl4Yli
         JkDMeulZ37M98dwJ/7TOk3yrSrkk6JM+HYM5Of2lRndjNWG2uiwoWec947dFPNHC72jX
         ErR7IBm1Yp2RlJT3wWld5ACaxj7rUNuzl6u5iuGZp1hOz1WvZe/RtniNgzXA7hTqZ2xL
         4QYwvjNzU1vfQ0IkgCLsL0PmHJ42E3r7CVll7Wpe0YuWkE7Gw5zFyN8DlCZGQdZHPsUj
         vNfgfeHZteySdtaVzc542af8oqb6KpXUVm1dwdX5PYPwu3/6Bw3IFhqK+NHSYDtonEwa
         efPQ==
X-Gm-Message-State: AOAM532ktHu30tjp976W+70DPp4+ews4/zNUH8EwxlI7++sCI3vHW8JG
        hA68uGpQajD6tUmq6q0E0SbwkA==
X-Google-Smtp-Source: ABdhPJwRzweIQF2jbPBf/OBl+c01b0VQ2tg2Le+bMbucYkda7/fJjKV7wd4vuvPXckxhCnHoc+8CsQ==
X-Received: by 2002:adf:fb44:: with SMTP id c4mr30838267wrs.179.1634029479152;
        Tue, 12 Oct 2021 02:04:39 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id c17sm9909734wrq.4.2021.10.12.02.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 02:04:38 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] ASoC: codecs: tx-macro: Update tx default values
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1633702144-19017-1-git-send-email-srivasam@codeaurora.org>
 <1633702144-19017-5-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9261e403-9cbf-d955-d555-1e9cbbdde3df@linaro.org>
Date:   Tue, 12 Oct 2021 10:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1633702144-19017-5-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2021 15:09, Srinivasa Rao Mandadapu wrote:
> Update mic control register default values to hardware reset values
> lpass sc7280.
> 
> Fixes: c39667ddcfc5 (ASoC: codecs: lpass-tx-macro: add support for lpass tx macro)

I dont think this should have fixes tag, as you are adding default 
values for sc7280.

with that fixed,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>   sound/soc/codecs/lpass-tx-macro.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
> index d472af1..6742405 100644
> --- a/sound/soc/codecs/lpass-tx-macro.c
> +++ b/sound/soc/codecs/lpass-tx-macro.c
> @@ -272,7 +272,7 @@ struct tx_macro {
>   
>   static const DECLARE_TLV_DB_SCALE(digital_gain, -8400, 100, -8400);
>   
> -static const struct reg_default tx_defaults[] = {
> +static struct reg_default tx_defaults[] = {
>   	/* TX Macro */
>   	{ CDC_TX_CLK_RST_CTRL_MCLK_CONTROL, 0x00 },
>   	{ CDC_TX_CLK_RST_CTRL_FS_CNT_CONTROL, 0x00 },
> @@ -1781,9 +1781,10 @@ static const struct snd_soc_component_driver tx_macro_component_drv = {
>   static int tx_macro_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>   	struct tx_macro *tx;
>   	void __iomem *base;
> -	int ret;
> +	int ret, reg;
>   
>   	tx = devm_kzalloc(dev, sizeof(*tx), GFP_KERNEL);
>   	if (!tx)
> @@ -1805,6 +1806,20 @@ static int tx_macro_probe(struct platform_device *pdev)
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
> +	/* Update defaults for lpass sc7280 */
> +	if (of_device_is_compatible(np, "qcom,sc7280-lpass-tx-macro")) {
> +		for (reg = 0; reg < ARRAY_SIZE(tx_defaults); reg++) {
> +			switch (tx_defaults[reg].reg) {
> +			case CDC_TX_TOP_CSR_SWR_AMIC0_CTL:
> +			case CDC_TX_TOP_CSR_SWR_AMIC1_CTL:
> +				tx_defaults[reg].def = 0x0E;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
> +
>   	tx->regmap = devm_regmap_init_mmio(dev, base, &tx_regmap_config);
>   
>   	dev_set_drvdata(dev, tx);
> 
