Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB724519B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbhKOXZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244960AbhKOTSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:18:16 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026CC0F26E3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:06:38 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id be32so36452037oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sFvkJ0xnF4K+vbnVO+FKmYVSVMst7TllfULR0ZOdx/M=;
        b=SppVK3uidc4FcbZxeYAs1b5lKJqm0WkIrxKrwpOQy6HS0dlaMmq9lvl18cA+iTNWpB
         iw6ESa6CQhoYh4wkm8DZPVBNrDYJbeNJFORekW0V2Ti7fL7A6o3UMAdmK5j+aAQAki8h
         cSHJahxD9/5/rJGoXqcXs6SQ8H2TtsLL5rPGhDGp6U4eCy1Q3/rbpYBaIjWTQgaq+pS7
         Yxj7d+Nl9TKOnKHaa+mNDeZtvA0p/bh7giE+iLXMlGjWtKqxyBvkAfzyY182uftF6sje
         Sto5dZ3vqwu97h9AyXHqrVyRUfGZNrXepXYtIdunHuXc0fuXJRMZn3sD1JN9Bfm6uZVi
         7zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sFvkJ0xnF4K+vbnVO+FKmYVSVMst7TllfULR0ZOdx/M=;
        b=ueUu2q2OiYGNw3hzAGIgyHJv30kmrjkrgATigX+v646TPQWA2tGg4BOnwk48fvEdl/
         W592J0a2YRq9f+mTqZe7gLZNgkDuOfuwWBFwmSOGASldsMDjVPJLOfAyP1M6jtlTBkf/
         uitUWx8bh4d6qENyOaC4uphQKF1qYQnIAnbee7dc5nrPBOuamdBjpT1BlpYckdbZ/HY4
         R0wub00oF6p4mGkC7OBSO7/+dWN+ry2pIMVu7CCiwsWppqG9ZaYBW7b+egRKxEHglxSU
         /HvzCwsRAa8uivCfnD4/zYc8iD1fukDD2KO8PIvWyBLifUCc4zFuUlfvAyYrpOuBVf8f
         Hx3g==
X-Gm-Message-State: AOAM531YqKR777Z8Q+UkeTS3IfcCWIyYv9/auj4zz0Xfnrkny6Hc0jCf
        06Eb+eImndh03YcLLvAEzJWTbA==
X-Google-Smtp-Source: ABdhPJytMyQg5bgk78fP0ZPLeyB/TYqmc9sf+hPfZKfEIUD3MH29u33QMT/Q2Tva0/bwV7EMQpe0ew==
X-Received: by 2002:a05:6808:2186:: with SMTP id be6mr47966968oib.115.1636999597730;
        Mon, 15 Nov 2021 10:06:37 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bn41sm2646291oib.18.2021.11.15.10.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:06:37 -0800 (PST)
Date:   Mon, 15 Nov 2021 12:06:32 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        stephan@gerhold.net, Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v5 16/22] crypto: qce: core: Make clocks optional
Message-ID: <YZKhqJuFlRVeQkCc@builder.lan>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
 <20211110105922.217895-17-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110105922.217895-17-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10 Nov 04:59 CST 2021, Bhupesh Sharma wrote:

> From: Thara Gopinath <thara.gopinath@linaro.org>
> 
> On certain Snapdragon processors, the crypto engine clocks are enabled by
> default by security firmware and the driver need not/ should not handle the
> clocks. Make acquiring of all the clocks optional in crypto engine driver
> so that the driver initializes properly even if no clocks are specified in
> the dt.
> 

So on some Snapdragons we don't have clocks, on others failing to
specify the clock leads to hard-to-debug issues. Can we make the clk_get
calls conditional based on the compatible instead?

> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> [Massage the commit log]

It's a good habit to prefix these messages with your name, i.e.
[Bhupesh: Massaged the commit log]

Regards,
Bjorn

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/crypto/qce/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index dd2604f5ce6a..98784d63d78c 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -213,19 +213,19 @@ static int qce_crypto_probe(struct platform_device *pdev)
>  	if (IS_ERR(qce->mem_path))
>  		return PTR_ERR(qce->mem_path);
>  
> -	qce->core = devm_clk_get(qce->dev, "core");
> +	qce->core = devm_clk_get_optional(qce->dev, "core");
>  	if (IS_ERR(qce->core)) {
>  		ret = PTR_ERR(qce->core);
>  		goto err;
>  	}
>  
> -	qce->iface = devm_clk_get(qce->dev, "iface");
> +	qce->iface = devm_clk_get_optional(qce->dev, "iface");
>  	if (IS_ERR(qce->iface)) {
>  		ret = PTR_ERR(qce->iface);
>  		goto err;
>  	}
>  
> -	qce->bus = devm_clk_get(qce->dev, "bus");
> +	qce->bus = devm_clk_get_optional(qce->dev, "bus");
>  	if (IS_ERR(qce->bus)) {
>  		ret = PTR_ERR(qce->bus);
>  		goto err;
> -- 
> 2.31.1
> 
