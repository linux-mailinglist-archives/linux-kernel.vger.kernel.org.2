Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8A23264A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 16:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhBZPYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhBZPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:23:56 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1ACC061574;
        Fri, 26 Feb 2021 07:23:15 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id a4so6376547pgc.11;
        Fri, 26 Feb 2021 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QHXSVsXuKx/MuCcoIzA9gGr9Kr4SzJ4/NTJV4xdPiLE=;
        b=bg2stdC71+bgN8bhm92ZNYTejyoO/Gcm9LW4jOHsZ2ItE5nxs2BJnAiaSoBB+yaLx0
         qMz2FO5paUx9R+OdJLJDkwAkw99qmGwHnV7lCP5ZC78zgCdy+XDjOEhqPHe25NXwZEQL
         43hS5bYgP/onLPvgSaKObjgDKMRETB7fwPAEgHf0yRoVraHE2DO9c0gXmTpzwrsPyG7f
         U2Pvkcz66BhlEcNMCeBZICL2xQU48D5ZNBrbR30jQYevLfZzLEfWgsQ/46HMpdp5npHJ
         So18s9U6Wr5gz/JhiyuYdo/QyC4bObinEauEuwHJxauJTg0YGnWKJf+NgsuJ7tRAHKIz
         Xq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QHXSVsXuKx/MuCcoIzA9gGr9Kr4SzJ4/NTJV4xdPiLE=;
        b=rcqdKkKUZGexIH27+P2yNHTdS3V82bjdqE1JEDN2Jnpw01c10AYzcWmae0ptyUQmoR
         4ppuu0ROpNO6b1yrodxAU+vBQp6cjtiF5AYMytNhT94zOoEv+5wWYTS5CoWVh3iP4rlo
         Wb/VnnDOw1X8s3VoiGbHbRN8+DbjCnozkZghx3QLkN4KH4PwI4WdyCrvHfFYTjtVussQ
         jUsiTP6X49MwkUk8+6zir/Wb3cxNQVSwmf4eUdvGbZ414XTNSrc66ksIEy+QqmsVb4jm
         8N+/uhYBfpNEN+Ax7qk9hsf2SSh10ylxpB8tq4tpB7VoRKhvcMPU7zIucmTccm2/04au
         E1HQ==
X-Gm-Message-State: AOAM531H+U/zf5sYK1cDgMfSEEgvEfauLHLS3/Mr1qIB0DbGU5Bblwyr
        VgDSglbnbBOwQfOvSsuqVCo=
X-Google-Smtp-Source: ABdhPJzt8BF/doAkmZUR6YeiIzcrt84/ecWfGKljw82X+19oR9qeBhNWLtNCimzGQ+8smXNI/AMnIw==
X-Received: by 2002:a63:724a:: with SMTP id c10mr3377749pgn.124.1614352994989;
        Fri, 26 Feb 2021 07:23:14 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id s27sm8854875pgk.77.2021.02.26.07.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 07:23:14 -0800 (PST)
Subject: Re: [RFC 07/19] devfreq: imx8m-ddrc: Add late system sleep PM ops
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
 <1613750416-11901-8-git-send-email-abel.vesa@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <58c4b791-fe7c-6b34-0c13-9e41a6960c7f@gmail.com>
Date:   Sat, 27 Feb 2021 00:23:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613750416-11901-8-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21. 2. 20. 오전 1:00, Abel Vesa wrote:
> Seems that, in order to be able to resume from suspend, the dram rate
> needs to be the highest one available. Therefore, add the late system
> suspend/resume PM ops which set the highest rate on suspend and the
> latest one used before suspending on resume.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>   drivers/devfreq/imx8m-ddrc.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index 33de83acfd8b..04347dee781b 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -72,6 +72,8 @@ struct imx8m_ddrc {
>   	struct clk *dram_alt;
>   	struct clk *dram_apb;
>   
> +	unsigned long suspend_rate;
> +	unsigned long resume_rate;
>   	int freq_count;
>   	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];
>   };
> @@ -271,6 +273,22 @@ static int imx8m_ddrc_target(struct device *dev, unsigned long *freq, u32 flags)
>   	return ret;
>   }
>   
> +static int imx8m_ddrc_suspend(struct device *dev)
> +{
> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> +
> +	priv->resume_rate = clk_get_rate(priv->dram_core);
> +
> +	return imx8m_ddrc_target(dev, &priv->suspend_rate, 0);
> +}
> +
> +static int imx8m_ddrc_resume(struct device *dev)
> +{
> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> +
> +	return imx8m_ddrc_target(dev, &priv->resume_rate, 0);
> +}
> +
>   static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
>   {
>   	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> @@ -336,6 +354,9 @@ static int imx8m_ddrc_init_freq_info(struct device *dev)
>   
>   		if (dev_pm_opp_add(dev, freq->rate * 250000, 0))
>   			return -ENODEV;
> +
> +		if (index ==  0)
> +			priv->suspend_rate = freq->rate * 250000;
>   	}
>   
>   	return 0;
> @@ -412,10 +433,15 @@ static const struct of_device_id imx8m_ddrc_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, imx8m_ddrc_of_match);
>   
> +static const struct dev_pm_ops imx8m_ddrc_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx8m_ddrc_suspend, imx8m_ddrc_resume)
> +};

Are there any reason to use suspend_late instead of suspend?
Usually, it is enough to change the frequency on normal suspend() step.
The devfreq supports the 'opp-suspend' property[1]. If you keep the OPP 
entries on DT, you simply support your goal with 'opp-suspend'.

[1] 
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/opp/opp.txt#L156

> +
>   static struct platform_driver imx8m_ddrc_platdrv = {
>   	.probe		= imx8m_ddrc_probe,
>   	.driver = {
>   		.name	= "imx8m-ddrc-devfreq",
> +		.pm = &imx8m_ddrc_pm_ops,
>   		.of_match_table = of_match_ptr(imx8m_ddrc_of_match),
>   	},
>   };
> 
