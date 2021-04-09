Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B693598D7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhDIJKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhDIJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:09:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A92C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 02:09:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l123so3807768pfl.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iusrLEQTcxgLuvY/s0WkjYKt6ZUUkpVNI9Zo6gJ/N30=;
        b=O68a/KcucQSDWDD8wQ8Bj7qwbYXGgI5K8GIfKDi/vzuxYUsWXolfybaD7vIepwgiL8
         isBDlJDctz40NQAXetLu9AqpAZDNRd9I1Tzp/9Sngtwbkd9Ed91rAA/aDDhqTZdx6sdL
         dhz2eLVHMxVH7wexEeN2HD2ibws2yZUvywaOFf9Jv9hRVRVR/WUUJmQuLw4KDmnI7Wu2
         3spjaG0TCsWaZghBZz4NYwqkvDZCyI8LBK9luQytEEyCjWzC+PawPdF2J3utBQC4ERpV
         g2rMl0UIHEgUjqBE67Yg2tWoGeeTlqH2Yg1MaPTPw7djDZp2OntPrPSVknFQEt6lWitw
         vvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iusrLEQTcxgLuvY/s0WkjYKt6ZUUkpVNI9Zo6gJ/N30=;
        b=VVsYMGqB0YqV6tBgrvM7/YZ3QWibIAgRVn918Fr0jpf2guFc/zTs6P8EPHm7VGUl9e
         siIos3ySVgRZuC07BWUDFtCZtBS/1kWaO9cTPRwE9LImjnmPemfAj3qqiJcR6/t1c0v7
         pEXjp9o8LOzTGKkBBIMp1RHm0yq/Ut8iuy6H8eWVniHGfqHM7ffv1ozwlpBDTJYMTKNO
         b12yRjn+nh5Fv1tqBeCCd/4GC+dhuFIsqfV8uOXTWBgGhoEfTtnFj7ieKli36ir3It/Y
         2AzplSv4vcvN+oMQDdx3nIeLCtU/wKCBTMYeit0ZzysZkOs37bK+zKHko4ZoVd9cHw1c
         PXCQ==
X-Gm-Message-State: AOAM5334/ehNqOSls5wVEr8ZRwH1ft5FZXDPYjUWIeAcu8ZxEgiWsrqs
        b+s99TSGAVf2C1S0Q5EH07DQipnpJagUSPyNXlH+/Q==
X-Google-Smtp-Source: ABdhPJySq0thaQ409aIwg7KoCsn0wQzLlCiRV4ucUUW/t4VGrL8F7fn5WoPqBBSm85sIMioSg2m+itTcl+faCguh75A=
X-Received: by 2002:aa7:98c9:0:b029:242:18fc:562d with SMTP id
 e9-20020aa798c90000b029024218fc562dmr11196723pfm.39.1617959385055; Fri, 09
 Apr 2021 02:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210409050633.671223-1-yangyingliang@huawei.com>
In-Reply-To: <20210409050633.671223-1-yangyingliang@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 9 Apr 2021 11:09:34 +0200
Message-ID: <CAG3jFysyD4D+xsLjVEm9QRM_WLPE_7NDzV-89B8oSEwNHZ0pAw@mail.gmail.com>
Subject: Re: [PATCH -next] media: camss: ispif: Remove redundant dev_err call
 in msm_ispif_subdev_init()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Thanks for the patch.

On Fri, 9 Apr 2021 at 07:03, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/media/platform/qcom/camss/camss-ispif.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
> index a30e453de162..37611c8861da 100644
> --- a/drivers/media/platform/qcom/camss/camss-ispif.c
> +++ b/drivers/media/platform/qcom/camss/camss-ispif.c
> @@ -1145,17 +1145,13 @@ int msm_ispif_subdev_init(struct camss *camss,
>
>         r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[0]);
>         ispif->base = devm_ioremap_resource(dev, r);
> -       if (IS_ERR(ispif->base)) {
> -               dev_err(dev, "could not map memory\n");
> +       if (IS_ERR(ispif->base))
>                 return PTR_ERR(ispif->base);
> -       }
>
>         r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[1]);
>         ispif->base_clk_mux = devm_ioremap_resource(dev, r);
> -       if (IS_ERR(ispif->base_clk_mux)) {
> -               dev_err(dev, "could not map memory\n");
> +       if (IS_ERR(ispif->base_clk_mux))
>                 return PTR_ERR(ispif->base_clk_mux);
> -       }
>
>         /* Interrupt */
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
