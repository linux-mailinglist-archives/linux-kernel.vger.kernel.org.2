Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEF444DB94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 19:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhKKS21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 13:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbhKKS2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 13:28:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281BC061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 10:25:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o8so27525751edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 10:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txXLZF+9GfwagVnL9c9/R4fXHlgcGjXwIQ9SEznOgw0=;
        b=DsB69FvhZeAIbA18E5lHyHhIB+6y0QEHISA/MG0eDH6ZxBcMLGUWVQ73YJDeYYAuHw
         e6V86fgWC1PkbhMVTYclUPfSFPLWwo492vk1iDlCsBGyKY/2zadSes9BDcjIiMh/01rd
         LPCk0ucKKmeu6HPFTyXRbZ9bD/1Be5x3+UyrvsuuAv+XlPY+sXKphDeW2InKsrnoHSqe
         XgUh6JVC7DlIInCuCaKz0thozytIvWre7vRcqx25k4CO7zYNJR7ZjncGFTzqMMPWHlEu
         JQBbd/cULS7+E+9oGsIMEUZw5VX4IeNRzDW9pJqmZgopfUrOgBy6giZ0dNaaCDDd5gG5
         MGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txXLZF+9GfwagVnL9c9/R4fXHlgcGjXwIQ9SEznOgw0=;
        b=U8PiLh7chwLmCpyhFdbDDBcPVvNZdKhAIr5nsii17wHDnAox4DL5oapMJ60A68xG21
         tOx5NkCyoz/jNH5SKqqwmIPKGtq9dbLDpbOuEVGg68f4aFSiGaNSdlFGtBFIIM3fXF3R
         zjxoOUW8yvZINzKVi+yJfZhgPPpaGg/16KgKM8tIQICkotGSCwl4AJdDRpMzfqfpO5fK
         hri/p7tr5KqdvnVp36DfhS1NyC1eCKAJIVg/TizpPfjsd+NGLrNWTCo+/R1uGbJCcSOp
         9LmUOL5jPc7UUuvBVESb/pIDbr3DKeoregYLBoK9EUIkm7NbuNzyKZI8K0AE6rD4jGHp
         5xDw==
X-Gm-Message-State: AOAM533rvf7xUfAhZWdzX4k1Qz+aa3u0SvisXCSc5+gVLdvuPPPIYXb3
        4w9HvKzkMNxOOZFOS+ta53soHzhLbNBtNG1v9R6ylg==
X-Google-Smtp-Source: ABdhPJxFE9orYhB3+TLnpd1AnZFajEuUTnGFTtb8ntq5zjW336ZzFGuMzgIOFqm93IGf+xvcyleIp9lOGq1fKGp/DkU=
X-Received: by 2002:a05:6402:280d:: with SMTP id h13mr12768202ede.346.1636655124051;
 Thu, 11 Nov 2021 10:25:24 -0800 (PST)
MIME-Version: 1.0
References: <a4b8454f560b70cedf0e4d06275787f08d576ee5.1635964610.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a4b8454f560b70cedf0e4d06275787f08d576ee5.1635964610.git.christophe.jaillet@wanadoo.fr>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 11 Nov 2021 11:25:12 -0700
Message-ID: <CANLsYkxQu1Prfg64qqWF7fRMp_rVXoL6PG1trWaX8bSNnaiY4g@mail.gmail.com>
Subject: Re: [PATCH v2] coresight: Use devm_bitmap_zalloc when applicable
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Suzuki.Poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Wed, 3 Nov 2021 at 12:39, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'drvdata->chs.guaranteed' is a bitmap. So use 'devm_bitmap_kzalloc()' to
> simplify code, improve the semantic and avoid some open-coded arithmetic
> in allocator arguments.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1 --> v2: remove the 'guaranteed' variable to be even less verbose
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 58062a5a8238..bb14a3a8a921 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -856,13 +856,11 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  {
>         int ret;
>         void __iomem *base;
> -       unsigned long *guaranteed;
>         struct device *dev = &adev->dev;
>         struct coresight_platform_data *pdata = NULL;
>         struct stm_drvdata *drvdata;
>         struct resource *res = &adev->res;
>         struct resource ch_res;
> -       size_t bitmap_size;
>         struct coresight_desc desc = { 0 };
>
>         desc.name = coresight_alloc_device_name(&stm_devs, dev);
> @@ -904,12 +902,10 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>         else
>                 drvdata->numsp = stm_num_stimulus_port(drvdata);
>
> -       bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
> -
> -       guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);
> -       if (!guaranteed)
> +       drvdata->chs.guaranteed = devm_bitmap_zalloc(dev, drvdata->numsp,
> +                                                    GFP_KERNEL);
> +       if (!drvdata->chs.guaranteed)
>                 return -ENOMEM;
> -       drvdata->chs.guaranteed = guaranteed;

I will pick up this patch when -rc1 gets released.

Thanks,
Mathieu

>
>         spin_lock_init(&drvdata->spinlock);
>
> --
> 2.30.2
>
