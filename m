Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710DB37A555
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhEKK6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhEKK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:58:33 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B5C061760
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:57:26 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id c21so9958041vso.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEQRKJa7cSEPR3H7obV91/0E5nqv+bxRi8QEuCEiOnY=;
        b=MNxyAal8ydQkOrtj6ANTTQB9MJcc/+ZiIIuBuZlqXtJKMuRxP1XJ1AxBVCZAydYPHP
         TfIV6W1plR2LEVvg8nndLXy2MMH72QLhVKVyz7lyUu32fJZcINlsOi4FJ/l7rPxeT1UY
         pczRs0Meyf/gxCFGRrbS6cfWDbzV4bFbmQeJZ5fxboRWCYkEy0LEOfTx7x1oC+BI3fR3
         pGNRd5Xm9PFWBpz79V8o2nL0DxVwUWYR6fSVkxHNju+uVUG1BGDjvrraK80lAJoGEubA
         bhxQIPGgntK4PgEcQ6xufTJ+6pKyB4iE1Y+PRhsPzJcIdWWX1t55jgCy+Q1bTUt+y99r
         ynRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEQRKJa7cSEPR3H7obV91/0E5nqv+bxRi8QEuCEiOnY=;
        b=pq3HyGIQxh9BFWWygJzFZYAN4BqQ7TXcx2wJEViVTXUZ6mA3dsIcVVCNdX3+DPqC/i
         UBu4Z9jEklUtLHqxSIPBN4VcysQ+er6hGfgAJuFjgnVnaB5jdZ1WdqjBk6zsPdJ6FygS
         +akKslhQat8krI8cLFiaBblTPLUm9ZZmCZEwfNgRUopsIZ8IXe1qaCotI8oAtYb03vVB
         C2emtl7u+jxNLgd6ZxjdkuTYG7r2MkB4yAx7peTgOvb5wzW1+d7LSR/5Y9Aus6Cdx9cv
         zJikFattXFq428PgeiRoMUrjL7D1bhNW8DyWX8IOyLCDcMHVq+VdhG0rCKo/eugagTuu
         RiZA==
X-Gm-Message-State: AOAM531GT6xNmBHtWZJXeQ4ZjNaVKvnb6EsJ5DUUWsuq77DoXjXR1dMO
        bNhFIVw+dBF1g0wMPccs7gsH5ewjysBT1fJJFlGqXA==
X-Google-Smtp-Source: ABdhPJy8jF96CF37y9uxnKbpf60ehHZUV00s8557//l4WAOdTfJX4+5BkiKCoH3G5uOzgCysmD446p8DJvtiKuAFhJA=
X-Received: by 2002:a67:f60e:: with SMTP id k14mr25254376vso.48.1620730646016;
 Tue, 11 May 2021 03:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210508020321.1677-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210508020321.1677-1-thunder.leizhen@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:49 +0200
Message-ID: <CAPDyKFpuPw8EKpZKW5eBb1MS2mzhZ06Jn8AvmdaS0CY8S4Av4g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: usdhi6rol0: fix error return code in usdhi6_probe()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Chris Ball <chris@printf.net>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021 at 04:04, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
>
> Fixes: 75fa9ea6e3c0 ("mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO host controller")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/usdhi6rol0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 615f3d008af1..b9b79b1089a0 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1801,6 +1801,7 @@ static int usdhi6_probe(struct platform_device *pdev)
>
>         version = usdhi6_read(host, USDHI6_VERSION);
>         if ((version & 0xfff) != 0xa0d) {
> +               ret = -EPERM;
>                 dev_err(dev, "Version not recognized %x\n", version);
>                 goto e_clk_off;
>         }
> --
> 2.25.1
>
>
