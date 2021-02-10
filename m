Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC7316B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhBJQlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbhBJQgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:36:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9FAC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:36:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z6so3264422wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dJWwIn95fkjVmdNIde3hKcGGMjn5Wwv8KTig7GF7OVU=;
        b=ULvifx9v0cCjJ1rNgJHMruA5UhIjmgS/NKoMCqDjLupHNV7vXpZTSC2U4Y1KKm8J66
         wu/aRnluEY2aGdUgEffNixgeWUdK+6Kh11xjoea7yihuVhI6w5P2AerBPS7Xoj/ZmG8A
         QZhg5Tqb3zZiq9M+DApbYWtmg9tDNXNuTVGLU1xBCxp8gAiSXh9euaZXNiT2NJkNA30D
         xKGd+o9QWARs2wmqcrG2jbkTmR1jIlvSK48loENv0BMQykry4lfroo5ngVeThOFOwVUP
         GF3TskiR9Z8nF8peiPtkUYqSUVuc3v4lSNpbTnE4fibzIP9TsnqhI0suxfHlbUUoGjKR
         1slA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dJWwIn95fkjVmdNIde3hKcGGMjn5Wwv8KTig7GF7OVU=;
        b=q9ievy7xRAzOaZjrm78ym70c0gr62+TUTtWF62w4mAsIGkJMk+sCA1clRqaPAaX/S4
         83p62K1yT2RMA7IAMagfG3guce3r7vCscsQbPe1LeVmw25rHf4mT0ZYLS1KJlsoCUBIp
         skSurlPsCI+M3uNbauOP457rI/O0xK5mUekGErQ0KK+UVRDVXTxlX/gm6co1MTfWIqbN
         uLSZFwRBBVsZaqjzRLqBpj6vNt1WK/cW3aJn0nkIQsHF4NBufyF8o1CkuLxzSgkNSJMJ
         GMGqfLJNxywbgaZUFV87xCKXf6bNAYbDY7dxHviVziLfy4anb0qKxGttvSUvQ38cnSAn
         yJEQ==
X-Gm-Message-State: AOAM533D4+31sA1/EsBqJ2vxABU+57EKTavMGPUnopWrkFJpcoj6YSv2
        r4pvjH4zW4YPKibo9r7DIiWWZGtW+6mwKw==
X-Google-Smtp-Source: ABdhPJzr7IW/hbC9tQT2gTrGopt1SMfMp9nJ78JQ/e22s7nkGneMsRHhmMDKAuo/t3jAP8hMURKjMA==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr4674457wrd.118.1612974968764;
        Wed, 10 Feb 2021 08:36:08 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id k205sm3211507wmf.23.2021.02.10.08.36.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 08:36:07 -0800 (PST)
Subject: Re: [PATCH] misc: fastrpc: fix incorrect usage of dma_map_sgtable
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210208200401.31100-1-jonathan@marek.ca>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <046e2bf1-3a7f-8f6e-cf87-797af3e72d23@linaro.org>
Date:   Wed, 10 Feb 2021 16:36:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210208200401.31100-1-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2021 20:04, Jonathan Marek wrote:
> dma_map_sgtable() returns 0 on success, which is the opposite of what this
> code was doing.
> 
> Fixes: 7cd7edb89437 ("misc: fastrpc: fix common struct sg_table related issues")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   drivers/misc/fastrpc.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 70eb5ed942d0..f12e909034ac 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -520,12 +520,13 @@ fastrpc_map_dma_buf(struct dma_buf_attachment *attachment,
>   {
>   	struct fastrpc_dma_buf_attachment *a = attachment->priv;
>   	struct sg_table *table;
> +	int ret;
>   
>   	table = &a->sgt;
>   
> -	if (!dma_map_sgtable(attachment->dev, table, dir, 0))
> -		return ERR_PTR(-ENOMEM);
> -
> +	ret = dma_map_sgtable(attachment->dev, table, dir, 0);
> +	if (ret)
> +		table = ERR_PTR(ret);
>   	return table;
>   }
>   
> 
