Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD9B382802
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhEQJRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbhEQJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:16:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE98C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:15:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so1730065wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f2cHJbnBekXvbg3p/dRwo5sJhCEHlHni5/IUvtFFKrw=;
        b=OtuGEnq8PvAPT3sGrixyuM3Z2KNtXzvEoJkjQL08MY0IW9vhggKGVoYLtYTS6qLNrb
         nIWJOjonKzZGYJc3wdjzYLUvhWafGGiXdFoySB5umesr04C9+6cfquJz1+n9sEI66jI/
         KGlK4ipqBxGYVzCd66XOTCVOk1oFdXiru3EfzR+K5Hr9RoT9/m5kDn2+X8tqxh9dcVG5
         H/BgtLKB1PYxBCwvzfum4/GqWtFZQl5amJI6XsJVdGsBH7g103LLrai/kvQKXBIE8Bb8
         9coUq80SXhvpUvFhxOqqzFTyrNj/5Q9+F5RxVopamH8IxQVJaFA+mDRQnEZWuMZc64Wg
         XhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f2cHJbnBekXvbg3p/dRwo5sJhCEHlHni5/IUvtFFKrw=;
        b=bCXxnJ88M6Rg5UJJNhy3PTQCTe0rY5/MdEZ3L6L1ItGcLvIs+IdV7x/+r3W9x47V9m
         atJSGRfjqnn0iYYXHPlDQjFdjwuW2P0H6UP+ZBMk+eXy9hJ7MY+pyW5KZK4sbO78Vp1O
         fV7e/K263CAHHa/i1PdqlYr3OtHDpHHRXkf+oUo2IchdQTTp1ofoYn/oKte12e66ezdU
         PWIeXftloiSWz2Lx+kBjAYU/VPkInm+KWcG4mY9H98Huy98lhDAxpKFbzqNs6ipCr6QP
         sHAWK04Rxavjqk4lCUsZy9lydV8KkqnXsS3KgGoTrRB6KEwbi7UvWe7DWqyb5eOO09Ih
         ohDw==
X-Gm-Message-State: AOAM532CfEoqlYcbCjy/ghE9Y8WeK9gfNho4LFxelx6IkQrR2w72VfJt
        79iS3rdy78W/7CGx1JDa5Ptv+g==
X-Google-Smtp-Source: ABdhPJyohuqRHJuh1BHyUY1B+IQm1ke6bNYROwDDue84DBAPR+VPmLpGhPo201SFDmU6Rlm6QFQ1+A==
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr8408155wmq.164.1621242903732;
        Mon, 17 May 2021 02:15:03 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id k20sm5466084wrc.1.2021.05.17.02.15.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 May 2021 02:15:03 -0700 (PDT)
Subject: Re: [PATCH] nvmem: sprd: Fix an error message
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        gregkh@linuxfoundation.org, freeman.liu@unisoc.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <5bc44aace2fe7e1c91d8b35c8fe31e7134ceab2c.1620406852.git.christophe.jaillet@wanadoo.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <edd0e50f-22f7-5a38-dd46-4a31909242a7@linaro.org>
Date:   Mon, 17 May 2021 10:15:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5bc44aace2fe7e1c91d8b35c8fe31e7134ceab2c.1620406852.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/05/2021 18:02, Christophe JAILLET wrote:
> 'ret' is known to be 0 here.
> The expected error status is stored in 'status', so use it instead.
> 
> Also change %d in %u, because status is an u32, not a int.
> 
> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied thanks,

--srini
>   drivers/nvmem/sprd-efuse.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
> index 5d394559edf2..e3e721d4c205 100644
> --- a/drivers/nvmem/sprd-efuse.c
> +++ b/drivers/nvmem/sprd-efuse.c
> @@ -234,7 +234,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
>   	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
>   	if (status) {
>   		dev_err(efuse->dev,
> -			"write error status %d of block %d\n", ret, blk);
> +			"write error status %u of block %d\n", status, blk);
>   
>   		writel(SPRD_EFUSE_ERR_CLR_MASK,
>   		       efuse->base + SPRD_EFUSE_ERR_CLR);
> 
