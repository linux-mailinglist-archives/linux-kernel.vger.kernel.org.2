Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569A0326452
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhBZOri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:47:36 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B049DC061574;
        Fri, 26 Feb 2021 06:46:55 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b145so6400706pfb.4;
        Fri, 26 Feb 2021 06:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/TYKTW6vMSX34Lo/QP5TakGrXtS+bClWHXgI2d5DqyQ=;
        b=L0lUCJp9XkmJVz3q6dE3tyoJFZkBu75c6aO0q/ToTIvSGxFld33n5Ki3ripOT3u172
         XML3Uh3pAWpgpEA5SHslYde+YTLM+HhfAc+uSzDMn//XeTA8+igF+1Zxt7/fpCm5v967
         H14LAaPaJs7qM8zITe3ua1sASnviAXJF+yAUCdGo/35muU+2RtPZxnUJHYwlJ2qT4v9m
         nJlEsmd8VFfLAXoOHVevS/9XkczHKlg/yR91T/uxSl1+MjpzCV/TRD7UBBsaNg4tT5Jw
         1S866zzQgslUPKpMk96TNC8y9tGjpS/rQQ/sZbotTvN0wbjc9uRP3ojXOCL+wZuTz4h3
         RUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/TYKTW6vMSX34Lo/QP5TakGrXtS+bClWHXgI2d5DqyQ=;
        b=HB5fth3S2JDdYhWtNWOGFMGzLD7KRGM2gevgfg9L+veseg9Y51qSLLAM7H+nnJOWTQ
         NtJE/uHGWUW/6gImayWudn0NK+JiSNIflHFKF7QIjAJh3A809Uyn60OWwmF+QGh3RDgl
         we12+jiRKYOZK0jfY8JFwcrmKwdRhZ7WFVlm///XBZsShg3vexEgAWgmmIWIaZADo34P
         ObdMTFIeps8D8MdJQxoNQT3G6LIQ5z2EF54YoyMdwNSi47c3Sfy7sL9TzwGdTjVxKvNp
         pkS8oZqmUyEwCpAkzxwz7yj0GyEIao5NBnNLOVAnnIG86Uv7BNvlccGB0/fCsBm6yiSo
         sY9g==
X-Gm-Message-State: AOAM530l1BPVT3QWIpfK2nxLJqVip60RkaLmf+bVom4JeSbSk3Szwi5t
        eu14vcPxOdfdChepZcY77Hc=
X-Google-Smtp-Source: ABdhPJzgzMzZw142DhrijVdDEDJdI5Lzi3mX1asOgEN3CNBuneOFmrwmJ+sgVNSX00IM18o9PxP0ag==
X-Received: by 2002:a62:2acf:0:b029:1ed:5dbb:717a with SMTP id q198-20020a622acf0000b02901ed5dbb717amr3632787pfq.39.1614350815072;
        Fri, 26 Feb 2021 06:46:55 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id r2sm9174176pgv.50.2021.02.26.06.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 06:46:54 -0800 (PST)
Subject: Re: [RFC 03/19] devfreq: imx-bus: Switch governor to powersave
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
 <1613750416-11901-4-git-send-email-abel.vesa@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <d953245b-ebac-30bb-1887-1b97b921bade@gmail.com>
Date:   Fri, 26 Feb 2021 23:46:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613750416-11901-4-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21. 2. 20. 오전 1:00, Abel Vesa wrote:
> By switching to powersave governor, we allow the imx-bus to always run
> at minimum rate needed by all the running masters.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>   drivers/devfreq/imx-bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index 4f38455ad742..1c0c92d0eb08 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -99,7 +99,7 @@ static int imx_bus_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct imx_bus *priv;
> -	const char *gov = DEVFREQ_GOV_USERSPACE;
> +	const char *gov = DEVFREQ_GOV_POWERSAVE;
>   	int ret;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
