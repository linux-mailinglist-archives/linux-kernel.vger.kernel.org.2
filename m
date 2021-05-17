Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E938280B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbhEQJTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhEQJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:19:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C770C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:18:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so1517479wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IX9RZXfFga5iXe3mICM7KOM5tFlUzc3tRZqVFzUyLR4=;
        b=PjJKL/1udTlUp30HIiNAsKUkjZcr5AN8ovZL8d0SNZkEIk6gp6ys+I0Pr+IGjg0+EA
         K0tWzGtKzI/A4zOMBk5MlEqqN9i4vbGZNyYE2+/0+KTW+nOQf17IlU2YUx2jR5U9qhmq
         5Vmz7BFVkTft8RTIgCgyVosBY+/TA0Wkqw9kh4i3oCRHJKvPc7qbQK9xBEEv5X0iIaAL
         G59bx5PWRaevqSmHaySciCgXEJHuPjKOJDXG0Pt5zSndd4+N/m80jQTppPl7PxXxA6YQ
         NcIj4XxI8xLh/L840hAkuAZk23X+IVF3bgUJqL87nXuXv4q3luJJbVz3GlzxhJ2gOrd5
         LVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IX9RZXfFga5iXe3mICM7KOM5tFlUzc3tRZqVFzUyLR4=;
        b=NQiA8v3V/p64xCGfzCbkFCRrfpLdRQ98txElAlvUcmnMmmHu7DWSfVuffbqDyE//FU
         QtmIbd9Il9Fje1pemub8huAfUJeg+nXsQXfD+8aSlrCi3VItKFBUUPOGZaO5BScGjgbU
         jyab9CRr0gZD4pxOfU+5b8pIyR90EzSyPU3vXi+gosj3vTqWfiudYZCPzoUPKv/oEQ98
         rKmYFGR6f3ipSq8kQbh29YtzsBN4956iXNpWXOVdScWO3CG5t/3OMYecvXdWkdcZ29JX
         kmwtufCYQIv7mWlbs7AJsvQALLIsQhWvvnQJUm0wEUgsuD4BaIk5YZTs7sGS8MtZu3m+
         gFPA==
X-Gm-Message-State: AOAM533Vx71XtMZf3Tz3Bww7z8P1DO4FjjVTLpV4Yso86SUAr4mG+wIf
        WA736s/FH0D/t9FBCYKGkVYRPiRO4DXFiP+X
X-Google-Smtp-Source: ABdhPJxB7jeEwnXTieUCoUMFatB1OGox14Ekqq/eZZAD3PwXeXuelJ1qhm/jOlvS4van9g3I7yk8/A==
X-Received: by 2002:a1c:98c6:: with SMTP id a189mr4834155wme.178.1621243107107;
        Mon, 17 May 2021 02:18:27 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id s5sm15593242wrw.95.2021.05.17.02.18.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 May 2021 02:18:26 -0700 (PDT)
Subject: Re: [PATCH] nvmem: sunxi_sid: Set type to OTP
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210419015815.38910-1-samuel@sholland.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f71f9e50-6741-9352-4a72-1f82726945e4@linaro.org>
Date:   Mon, 17 May 2021 10:18:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210419015815.38910-1-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2021 02:58, Samuel Holland wrote:
> This device currently reports an "Unknown" type in sysfs.
> Since it is an eFuse hardware device, set its type to OTP.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---

Applied thanks,

--srini
>   drivers/nvmem/sunxi_sid.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index e26ef1bbf198..275b9155e473 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -142,6 +142,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
>   
>   	nvmem_cfg->dev = dev;
>   	nvmem_cfg->name = "sunxi-sid";
> +	nvmem_cfg->type = NVMEM_TYPE_OTP;
>   	nvmem_cfg->read_only = true;
>   	nvmem_cfg->size = cfg->size;
>   	nvmem_cfg->word_size = 1;
> 
