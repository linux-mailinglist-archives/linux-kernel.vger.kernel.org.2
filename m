Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1806B32648A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 16:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhBZPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBZPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:13:13 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446ACC06174A;
        Fri, 26 Feb 2021 07:12:33 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p5so5458708plo.4;
        Fri, 26 Feb 2021 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OpIyGBzoBd6MLrPLDZTlJu8redllCjYqsJySEq0aRr0=;
        b=Gq/ik7mtmJxM3De0wpzf9IPIlgAH+eM/ASvPGsfmHKPlBcheBxjSuzemIiDHsTTl89
         J761O+JTO6Iq9ymsicpFEw9RbvYPJ5eLAeotAfZG1N6LFAPjIwYkEhWoijgHnARGyo0j
         KtMvhhbO/gpSznTwjb+shOCfw7wuDLybWZfxGMjLPbmxmWv5AC7yWwC4ic67IxqYV2bk
         Li03jogRm0vcAA1AaVaVZoi44V6r/9U0SatG7OXUUBHy5ZykrgWKX5LD+ZzbszC/Zr+j
         bYxCIx/SKFe90hdNwqcCN62kN1MzdJCcPmsR/KLFeoQhpGcdWzdHcAgOl/ZTErRaLnBI
         5PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OpIyGBzoBd6MLrPLDZTlJu8redllCjYqsJySEq0aRr0=;
        b=j3zVTspdEmYEDgVz7XQvJmho9sbVcDqVNakY4nnjNTGOjuU0z0UuIEfTf9Axocsez4
         2DCrjxe9DK7vOm73H3ApR9KOKIXKBA1BiDtDlxr6fI8qOh6N+428vuIa1lAt0nvkoSD/
         mckx/xK+7SQL/BbT3XqRi2kaEGXafquKPfovpWLmHLbRLSPQtwtlsxMKXgZ/7eX/sSDi
         fdon52z0/c+4gMDKYssNh76zKFY87HDo1Ch+1E2FzjQ1+8NBQ7j8y9IOm6MWJgtOW9nr
         DIzr+1FeyvRoInRR6J0VX6pLamP4pUbzbdveYd0pFD255+JXxaQ2h41ZO4uF0QqOvc62
         s9xw==
X-Gm-Message-State: AOAM533RphLXEEgaprhBWkec346a064rMoRL1mZFd2cKhE0yglpwf4xB
        kjt9bycR/Rfa/wTGr5ALYWo=
X-Google-Smtp-Source: ABdhPJyNZ6JZHSDzMC9k34yewcgCLGyK6ej+AvpC7xQgVS7Ftwx7ibTmj8qMYnFIvJdYG9tRSZqFDg==
X-Received: by 2002:a17:90a:f82:: with SMTP id 2mr4030406pjz.196.1614352352701;
        Fri, 26 Feb 2021 07:12:32 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i10sm10650818pgo.75.2021.02.26.07.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 07:12:32 -0800 (PST)
Subject: Re: [RFC 06/19] devfreq: imx8m-ddrc: Use the opps acquired from EL3
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
 <1613750416-11901-7-git-send-email-abel.vesa@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <62dd9f7d-f767-01ee-87eb-bd0553b53417@gmail.com>
Date:   Sat, 27 Feb 2021 00:12:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613750416-11901-7-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21. 2. 20. 오전 1:00, Abel Vesa wrote:
> i.MX8M platforms get their dram OPPs from the EL3.
> We don't need to duplicate that in the kernel dram dts node.
> We should just trust the OPPs provided by the EL3.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>   drivers/devfreq/imx8m-ddrc.c | 49 ++----------------------------------
>   1 file changed, 2 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index 3a6c04ba4f2e..33de83acfd8b 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -333,38 +333,9 @@ static int imx8m_ddrc_init_freq_info(struct device *dev)
>   		if (freq->dram_core_parent_index == 2 &&
>   				freq->dram_alt_parent_index == 0)
>   			return -ENODEV;
> -	}
> -
> -	return 0;
> -}
> -
> -static int imx8m_ddrc_check_opps(struct device *dev)
> -{
> -	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> -	struct imx8m_ddrc_freq *freq_info;
> -	struct dev_pm_opp *opp;
> -	unsigned long freq;
> -	int i, opp_count;
> -
> -	/* Enumerate DT OPPs and disable those not supported by firmware */
> -	opp_count = dev_pm_opp_get_opp_count(dev);
> -	if (opp_count < 0)
> -		return opp_count;
> -	for (i = 0, freq = 0; i < opp_count; ++i, ++freq) {
> -		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> -		if (IS_ERR(opp)) {
> -			dev_err(dev, "Failed enumerating OPPs: %ld\n",
> -				PTR_ERR(opp));
> -			return PTR_ERR(opp);
> -		}
> -		dev_pm_opp_put(opp);
>   
> -		freq_info = imx8m_ddrc_find_freq(priv, freq);
> -		if (!freq_info) {
> -			dev_info(dev, "Disable unsupported OPP %luHz %luMT/s\n",
> -					freq, DIV_ROUND_CLOSEST(freq, 250000));
> -			dev_pm_opp_disable(dev, freq);
> -		}
> +		if (dev_pm_opp_add(dev, freq->rate * 250000, 0))
> +			return -ENODEV;
>   	}
>   
>   	return 0;
> @@ -372,7 +343,6 @@ static int imx8m_ddrc_check_opps(struct device *dev)
>   
>   static void imx8m_ddrc_exit(struct device *dev)
>   {
> -	dev_pm_opp_of_remove_table(dev);
>   }
>   
>   static int imx8m_ddrc_probe(struct platform_device *pdev)
> @@ -419,16 +389,6 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	ret = dev_pm_opp_of_add_table(dev);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to get OPP table\n");
> -		return ret;
> -	}
> -
> -	ret = imx8m_ddrc_check_opps(dev);
> -	if (ret < 0)
> -		goto err;

In the devfreq_add_device(), if devfreq->profile->freq_table is NULL,
set_freq_table() function fill out the devfreq->profile->freq_table by 
using the OPP information.

After this patch, devfreq->profile.freq_table is NULL and there are no 
any OPP entries for this device, I think that this driver cannot add 
devfreq device without any frequency information. Is it working without 
any device frequency information?

> -
>   	priv->profile.polling_ms = 1000;
>   	priv->profile.target = imx8m_ddrc_target;
>   	priv->profile.get_dev_status = imx8m_ddrc_get_dev_status;
> @@ -441,13 +401,8 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->devfreq)) {
>   		ret = PTR_ERR(priv->devfreq);
>   		dev_err(dev, "failed to add devfreq device: %d\n", ret);
> -		goto err;
>   	}
>   
> -	return 0;
> -
> -err:
> -	dev_pm_opp_of_remove_table(dev);
>   	return ret;
>   }
>   
> 
