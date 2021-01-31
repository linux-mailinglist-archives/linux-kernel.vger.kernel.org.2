Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53143309D45
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhAaPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhAaPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 10:00:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDF4C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 06:59:41 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m2so10489090wmm.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 06:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4aT46G28vzJoBnX9iiIsaSmCpy5np56jMcrWEDGLCgE=;
        b=l5xX7oJCpwybk0kKJpimqxdg3LRZpkUJWSp/E7BeQlQ5bb6VBusuSES6Oi5uIQdb+3
         kX294KdrgrolGoqHznPX48lDQXaEMqqU25rMh/IHyCJsUFK/4NTzKpxn7vvMGMLHtFT3
         gKHqTu3Pcn25xaH7dvMXEXrFa/X0szN+jZqeAkI1M5gN4mGqk2gy63C/kEZ9VyDI/feg
         IILmyk4b86JQZ/QRUVR44AeDh80pLFU4IzjF6Dyu4uQGaZduERzk65MCjXYTycbn197L
         jb9XSGU5YeWvRd2LePDf+/u+FWiPq3ZaeiqogyqU9XpxjpWNMlEOKYHfpe90d0Z/7F5f
         yjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4aT46G28vzJoBnX9iiIsaSmCpy5np56jMcrWEDGLCgE=;
        b=miZGnq6MK5NbxMEBBvKwQ3fGZ8PLsi0SFzmtdsrdDLQqDsYKSp00b96eYXpqMJ/kMC
         R1nisWh6JoGcxWqcVn8o35veQ7wii29u3Pu1vCx3Cy3LmQsU2AQ2WTudvo75ormAWA7V
         2xRX0TgDD91UE71Bv4xWEAr7lKkSQJoULZLaAonb/B/kue/nzhpkauijEyKFr86NB8c6
         4IqBpPKRDuvoaNJCaRBxuJ8lzyvWbKkF0dp5VJC0fSyhIKOfkK/DBeQ3FW3fOuUr2/El
         2IeE9ov2kVZ2B2Haol47BHwKuvFUiWyToxhydkWiI7ASL6HE39g/S+vRGoI+y0zwAMju
         EsGw==
X-Gm-Message-State: AOAM530gPUk7AVxWiVBEAkzpLIDJzeqnuKCPxaQu3HF1pBC8910hH0px
        H/yjcHUMmFP+621CYTNuaktpiwi282kP79hC
X-Google-Smtp-Source: ABdhPJxH9y0L+8UHG7ALoVCnNf478ueZoH4sFRLVR6hzynO+RgpUih7R5yZbnRlVyxw5ZpZqf6DGZw==
X-Received: by 2002:a1c:e146:: with SMTP id y67mr7643190wmg.55.1612105180308;
        Sun, 31 Jan 2021 06:59:40 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id y67sm18886083wmg.47.2021.01.31.06.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 06:59:39 -0800 (PST)
Subject: Re: [PATCH] soc: mediatek: pm-domains: Don't print an error if child
 domain is deferred
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, drinkcat@chromium.org,
        hsinyi@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210113213012.67643-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <60cb2364-7bc5-61da-c4e4-878fa7327776@gmail.com>
Date:   Sun, 31 Jan 2021 15:59:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210113213012.67643-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/01/2021 22:30, Enric Balletbo i Serra wrote:
> Child domains can be deferred by the core because one of its resources
> is not available yet, in such case, it will print an error, but
> later it will succeed to probe. Fix that using the dev_err_probe()
> function so it only prints an error on a real error.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.11-next/soc

Thanks

> ---
> 
>  drivers/soc/mediatek/mtk-pm-domains.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index ae255aa7b1a9..8055fb019ba6 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -480,8 +480,8 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
>  
>  		child_pd = scpsys_add_one_domain(scpsys, child);
>  		if (IS_ERR(child_pd)) {
> -			ret = PTR_ERR(child_pd);
> -			dev_err(scpsys->dev, "%pOF: failed to get child domain id\n", child);
> +			dev_err_probe(scpsys->dev, PTR_ERR(child_pd),
> +				      "%pOF: failed to get child domain id\n", child);
>  			goto err_put_node;
>  		}
>  
> 
