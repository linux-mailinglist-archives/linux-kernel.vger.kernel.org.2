Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA33C885A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhGNQJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhGNQJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:09:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53733C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:06:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f9so3849044wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5BCcbn9sQ+2WAV1W0ddQFNY2Jjudynx3nG7rKfKPfQo=;
        b=tbY2A/9UW3C4IiWIJ8huqQaBpLgTqqMCWnsSI9Yb6YVa8YHk105tH7U8c3zP0+gD59
         r9GQdeoHepfM4iqU18ZxhBQQhEkpI0hBjjlsD61sH6QDxWevzhTShAG3vPqpoCIuQ1Dd
         s28UntLr4IFAgk0ueWI9rIFE2OqDXw0he049de17YTdBqrAufXo2i2NzV+TwYessfI4R
         RoJ2HxhMCIGNdErm2gNkE9UPGVCx5vNvoHGTkD5YrTzU4TzEumFHkzpwozeQHToT6mAy
         RbMvIkxHKa24tfbxFLjvq7XjzQyMrDzePSH7D0TFN7NmxnjkcUmlRzG5fJQytL5nWViV
         G5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5BCcbn9sQ+2WAV1W0ddQFNY2Jjudynx3nG7rKfKPfQo=;
        b=nKFlatapH4cRJ6++FqMRhflqIEGwhwpdndWenV1JqN3mQlzPbv4PIVlquZ2IdQyvvH
         yPT7OY/WCoQ5SLUYLdT3tsCKf0/b8bI71l7w9YHDO+rxHB4ajfjzoiFv8NiOdFfBe4V7
         eUgNiDeRxzHuaUOdFtPBqwA5jvRtuS92bSJEGaQyNT2KQhCNZGtZ3IHfrm8WGd0em50k
         JpYjQInTm+J82uT18TOz80mwY+EIBdvL2YK6o+74xZlmEWKg0jb/3BwSnYGoA5+hfeoB
         gc4sVf7u+hga5ma6kWu5ku7Z9XNPbC/f/QiP5dNeEHLtmYz0Ra994yivv0j+uGakK0mN
         vcxg==
X-Gm-Message-State: AOAM532dXhmhSAbUuL//tCRkdAOJR1tW8CiezVMLPj7hYNvLVwoik1NQ
        Sn/HU9er5pGnO2Mzfm821DQ=
X-Google-Smtp-Source: ABdhPJwzYyjjqqKap2uKHDPTnRIs3/bfB11QNMlRlx0gv5rzMeLxGz8oh8/kc9IR93MoEMXgDGwuTg==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr13961791wrj.359.1626278775885;
        Wed, 14 Jul 2021 09:06:15 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id z7sm3042060wrt.47.2021.07.14.09.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 09:06:15 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] soc: mediatek: add mtk-mutex support for mt8195
 vdosys0
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>, chunkuang.hu@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        fshao@google.com, nancy.lin@mediatek.com, singo.chang@mediatek.com
References: <20210710113819.5170-1-jason-jh.lin@mediatek.com>
 <20210710113819.5170-7-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <5685a1f2-c76d-853f-085d-e4e26ce03182@gmail.com>
Date:   Wed, 14 Jul 2021 18:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210710113819.5170-7-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/2021 13:38, jason-jh.lin wrote:
> Add mtk-mutex support for mt8195 vdosys0.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-mutex.c | 107 +++++++++++++++++++++++++++++--
>  1 file changed, 102 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index 2e4bcc300576..d74eb3f97f1d 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
[...]
>  struct mtk_mutex *mtk_mutex_get(struct device *dev)
>  {
>  	struct mtk_mutex_ctx *mtx = dev_get_drvdata(dev);
> @@ -507,6 +602,8 @@ static const struct of_device_id mutex_driver_dt_match[] = {
>  	  .data = &mt8173_mutex_driver_data},
>  	{ .compatible = "mediatek,mt8183-disp-mutex",
>  	  .data = &mt8183_mutex_driver_data},
> +	{ .compatible = "mediatek,mt8195-disp-mutex",
> +	  .data = &mt8195_mutex_driver_data},

Are we missing a binding description for that?

Regards,
Matthias
