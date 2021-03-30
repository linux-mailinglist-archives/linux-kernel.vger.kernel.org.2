Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF9E34E20D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhC3HWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhC3HWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:22:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9F9C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 00:22:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ay2so5685231plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 00:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ekLvPsX9lZUIkn2yGSnmapvhcNHkORTUb7Cp3XhA0KE=;
        b=VP7Ps6QrbWSpLEToYaVnwcSpSRATO12x8xq1sb79unDHfOlz7DzOOS7WVyPjYFuUY5
         nntbd1LiYOfTBnWLRAjRIEGPG/zAWVeyuWaLBtEH7CH24w++ej9altjkUO20GLFvvJ2T
         bj+wuAVWxFDSrMqDcDJs/1IHHl2ZqM26rwKylqsAoMYZvQaO5gbOP4gx3teSIiaH8SeM
         ueTum2qtazW4sUOPVbTcpffoTUnU4OjR+OWk4KB7iFrwDZFzIIOz9rbwrAHLs+7EgulS
         VxYl96hNW6iEemtQVtNzn8Mmfc45mZqI4Z/TF+gRfejCYgF2MuK/QmOMFYF/55XfpKFr
         QTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ekLvPsX9lZUIkn2yGSnmapvhcNHkORTUb7Cp3XhA0KE=;
        b=cKau462TeLYeVJExt6pxKislxQ9HbqVVuwz7/K1BvuS16I9SlgesrDEelb2LKbnmeO
         Ribmnq+b0YjdvJsBJQa32ksLDtayZetm87GGDxXIwVbdoQdAyS7SA7EwUigVyKHwI2yr
         05al2pgrysk0CN+TftPTnn14olJmB3DNKrNpEs6dFneJoLzDQnF6YIKrCVwXi9HK/hAy
         YBk4T/4GGhP4BGMpuLQW++aqYqwJ+ysITDPlbTbJBig9kHLeT3/4H9GbtxAoEAbDcjxE
         aVJcaD9OZTaXibXQ6bZWvJmXRvSJoUnQTzjaJZMOMmiZRsF6S22NmLZOZdeXma+kLfkN
         ySiA==
X-Gm-Message-State: AOAM531SfCbpjWwPeSRivjnpcmNXJzdQUfmfHbfbyJkyH4FpELFM1Dqj
        9KKCpCJ0kDZUHs9hvyTPmRgIrA==
X-Google-Smtp-Source: ABdhPJxarwd/qvRevJ1DRIjq2+UQ1lVWJFJE/sVilQtAkSoihXVavZRmJmp88tCQxdVM1rNAtyi99Q==
X-Received: by 2002:a17:902:e74e:b029:e5:bde4:2b80 with SMTP id p14-20020a170902e74eb02900e5bde42b80mr32351348plf.44.1617088927438;
        Tue, 30 Mar 2021 00:22:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.228])
        by smtp.gmail.com with ESMTPSA id e9sm17928789pgk.69.2021.03.30.00.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:22:07 -0700 (PDT)
Date:   Tue, 30 Mar 2021 15:22:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Hao Fang <fanghao11@huawei.com>
Cc:     jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH] mailbox: hisilicon: Use the correct HiSilicon copyright
Message-ID: <20210330072203.GA24255@leoy-ThinkPad-X240s>
References: <1617086920-15952-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617086920-15952-1-git-send-email-fanghao11@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 02:48:40PM +0800, Hao Fang wrote:
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to
> https://www.hisilicon.com/en/terms-of-use.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>

Though the kernel has tons of "Hisilicon", for this patch:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/mailbox/hi3660-mailbox.c | 4 ++--
>  drivers/mailbox/hi6220-mailbox.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
> index 53f4bc2..45c6d69 100644
> --- a/drivers/mailbox/hi3660-mailbox.c
> +++ b/drivers/mailbox/hi3660-mailbox.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2017-2018 Hisilicon Limited.
> +// Copyright (c) 2017-2018 HiSilicon Limited.
>  // Copyright (c) 2017-2018 Linaro Limited.
>  
>  #include <linux/bitops.h>
> @@ -297,5 +297,5 @@ static void __exit hi3660_mbox_exit(void)
>  module_exit(hi3660_mbox_exit);
>  
>  MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("Hisilicon Hi3660 Mailbox Controller");
> +MODULE_DESCRIPTION("HiSilicon Hi3660 Mailbox Controller");
>  MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
> diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
> index cc236ac..9fdc25e 100644
> --- a/drivers/mailbox/hi6220-mailbox.c
> +++ b/drivers/mailbox/hi6220-mailbox.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Hisilicon's Hi6220 mailbox driver
> + * HiSilicon's Hi6220 mailbox driver
>   *
> - * Copyright (c) 2015 Hisilicon Limited.
> + * Copyright (c) 2015 HiSilicon Limited.
>   * Copyright (c) 2015 Linaro Limited.
>   *
>   * Author: Leo Yan <leo.yan@linaro.org>
> -- 
> 2.8.1
> 
