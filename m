Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A6040D7E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhIPKyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:54:02 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36258
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237292AbhIPKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:53:59 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AAEDE40260
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631789558;
        bh=4Lgdn0Ixo4EbM/31cJClCQJWWjH8/3D1avitifyopTc=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=KMoIjDlLhdEMs5JE3kO5P1k5c11sBEz7LrWCUXbztNSipnZADfb0fhItn1T0B5s0d
         eUP7fx89zxd+F0J83LovwUCIVBKVovvPmxt2GYLAy0ztatLWQkYRcNPa8bQufbImxB
         FBO704FbpqbZDt07uT7Eunz1nRtj2pap+BuIkYPil+oTCFXIhZbTScdKF3xCclodFe
         mdDyWR+fPsbhKFyEo3B6FEfAfyiCLhe2Z8CMaWCZ2IK9VmkKdYytt1/jyVCBg9L4zr
         tqNfAmpB9c3i7nQtfsCcAtUXHnjQDyd+WzoNFLU0pqzNF6YteBSbkd/irMhKwqgeYt
         xDD38ehX/agvg==
Received: by mail-ed1-f69.google.com with SMTP id j6-20020aa7de86000000b003d4ddaf2bf9so4981579edv.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Lgdn0Ixo4EbM/31cJClCQJWWjH8/3D1avitifyopTc=;
        b=gLylc8Xucbfoc9DMYtbETTZfKWwF9t0sgM1xYVWRNqyF/7jBE8DefAcL+RR7xqBfLI
         z6YZ1IjVByFjR5xBxn1061GT63SASA7VDkZ/COoegz9LE7MfK0eDhpSb5EkDTj6JIeSv
         8VpYVV4LAhVdUdy7nH+lFfNVU36foH0oSkFnHnWgEL+unU3rE1fvwGmg7omuy07ALL+N
         bLCTW62m9Z4c2amZenCDIaHFrfNv2dCEEHywIa4UrETGYJC9/v9w0rx8VNjU1wZd8XGD
         FYsTMJzp+gCgK3DppJfKeS2l7Jm3ttv7K8PtTy7gyue+kFnyRm/FoTfEBavcCw6uJL4s
         JzFw==
X-Gm-Message-State: AOAM532S2a3iEVp/c+fpGv3eNxOyGmZqKjeAsEy9xKMveBnad0slJa66
        flGZqDkkyzLwspSOAycgRITTE4B1rle3TsVy0OPDacwvF7GwcPRz59JpXhA14ZhSgiML145V8oL
        suColxPuaVeY9LXAviYtXWJUp550gh5rHmPNXqPQXoA==
X-Received: by 2002:a17:906:4413:: with SMTP id x19mr5475679ejo.234.1631789558220;
        Thu, 16 Sep 2021 03:52:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGfx6w0ppmn0HpLTJ+dsV03ZGRjBHau0aYhh2Ng8iIcPUHpQyfZSlfhi3RuYMMxWbYjlibTg==
X-Received: by 2002:a17:906:4413:: with SMTP id x19mr5475670ejo.234.1631789558079;
        Thu, 16 Sep 2021 03:52:38 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d16sm1244793edu.8.2021.09.16.03.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:52:37 -0700 (PDT)
Subject: Re: [PATCH] i2c: s3c2410: Delete unneeded variable: "ret"
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210916103718.29956-1-wangxiang@cdjrlc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0d1a0027-e74d-9f07-3b96-372b5ca14ae3@canonical.com>
Date:   Thu, 16 Sep 2021 12:52:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916103718.29956-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2021 12:37, Xiang wangx wrote:
> variable: "ret" defined but not used in function "i2c_s3c_irq_nextbyte"
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/i2c/busses/i2c-s3c2410.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index b49a1b170bb2..6df85b23156c 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -385,7 +385,6 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
>  {
>  	unsigned long tmp;
>  	unsigned char byte;
> -	int ret = 0;
>  
>  	switch (i2c->state) {
>  
> @@ -548,7 +547,7 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
>  	tmp &= ~S3C2410_IICCON_IRQPEND;
>  	writel(tmp, i2c->regs + S3C2410_IICCON);
>   out:
> -	return ret;
> +	return 0;

Change is okay but I would go step further - made the function return
void(). None of the callers check for return so no functionality is lost.


Best regards,
Krzysztof
