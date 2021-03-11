Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B65337A86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhCKRMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhCKRMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:12:12 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91383C061574;
        Thu, 11 Mar 2021 09:12:12 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ox4so32134677ejb.11;
        Thu, 11 Mar 2021 09:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b5TjaochUTiMPxwpTbo+xjqSMsNV0jAxUvKCcJjcwRA=;
        b=OYBoRjtCXTfLmfx6ivD5eII1IF8IH0xLcOKG1DuCAIg0hueLCUtQElSKJrgBVIP7Vr
         xSHKIV9RBpMTT7lbQGwYU7zjW4owhFrJ2PTXEmGd+YWcEmlh2KfMtsflbI3JVvLwWOGc
         JsAzuDFzguR0iFfHGxDdgvetp+qen9tyM/ivManF9i6aOVPNRVRAnr8oxdGnMoLaUDp1
         084HjOhHwOyJ0w0Gp+Y0IAvY0IiCw3nULmHFtwvHujEtp+cwS6f2PaIMN7j8QVIF+p/Z
         Vl+8RZEJf5rAjGrM9UXHqks3RxYib+NzOcWk9uRyzHyfOD4eIl9r8OSpa6VJ83wLlxOJ
         pNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b5TjaochUTiMPxwpTbo+xjqSMsNV0jAxUvKCcJjcwRA=;
        b=Py0UoH35OJ1Wgv8gri+pkjjNpuT8aBiPjdWdiVjq0AiiY5oxVVQ1EVAkqPaC4iTeGg
         3TZaNnFF3iDV5qjDhmpF6Ve6uLz+bft45imA2x+ZEi3SnSYi52blzkSeOIU+NxbndENO
         01Qfb5Wc6jdQdu1P8FGhkXS4gJbBbvNU2Zpmwu9cGZajqTm0D3uC4EvBoJqQ5Yh2mUAQ
         X0aahlbckDDcHe/pJ3VTHas9JikzECkXpw/yCy2URfivA2zFxmAkppqi/SOuX+iwFaYk
         OotLw/Ze+miSWL7aRETxoxDfxBZ7aONAXdS2PKN5M8tNhLImbKrkxE2eHMP3C9vJVYIg
         OWUg==
X-Gm-Message-State: AOAM531ykW6VFf11JUgQ4gCN/46BkTQtoEegBJIszQLi527PaXRewEQZ
        FQOoFLBgxp4IX9B4UrGGOb4=
X-Google-Smtp-Source: ABdhPJzdODWR5WS5XPQQ4NXISeWaRiOwYcIOTu5EMLCHzjIbLIPKE0fHr2rLlROYUdghs5D102novA==
X-Received: by 2002:a17:906:1182:: with SMTP id n2mr4163329eja.234.1615482731273;
        Thu, 11 Mar 2021 09:12:11 -0800 (PST)
Received: from BV030612LT ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id q1sm1567938ejt.65.2021.03.11.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:12:10 -0800 (PST)
Date:   Thu, 11 Mar 2021 19:12:08 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] mfd: Make symbol 'atc260x_i2c_of_match' static
Message-ID: <20210311171208.GB892053@BV030612LT>
References: <20210311131507.1902008-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311131507.1902008-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 01:15:07PM +0000, 'Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The sparse tool complains as follows:
> 
> drivers/mfd/atc260x-i2c.c:45:27: warning:
>  symbol 'atc260x_i2c_of_match' was not declared. Should it be static?
> 
> This symbol is not used outside of atc260x-i2c.c, so this
> commit marks it static.
> 
> Fixes: f7cb7fe34db9 ("mfd: Add MFD driver for ATC260x PMICs")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Thanks,
Cristi

> ---
>  drivers/mfd/atc260x-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/atc260x-i2c.c b/drivers/mfd/atc260x-i2c.c
> index 362005703367..5855efd09efc 100644
> --- a/drivers/mfd/atc260x-i2c.c
> +++ b/drivers/mfd/atc260x-i2c.c
> @@ -42,7 +42,7 @@ static int atc260x_i2c_probe(struct i2c_client *client,
>  	return atc260x_device_probe(atc260x);
>  }
>  
> -const struct of_device_id atc260x_i2c_of_match[] = {
> +static const struct of_device_id atc260x_i2c_of_match[] = {
>  	{ .compatible = "actions,atc2603c", .data = (void *)ATC2603C },
>  	{ .compatible = "actions,atc2609a", .data = (void *)ATC2609A },
>  	{ }
> 
