Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10178436EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 02:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhJVAjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 20:39:51 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]:35458 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhJVAjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:39:49 -0400
Received: by mail-qv1-f47.google.com with SMTP id a16so1538095qvm.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 17:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8cCGwIM+MEipkZPPkMbL/O4ATGbMjxLb4ByRgUs5DA=;
        b=Pqj9CkCj8Um/Uq6/E8bZchkM2kFXByYCAU9a13chVECBgNsO4TcXpQDSCUdHKss8aE
         cF8/e3MkZCzu956X+Tv++jRKXtAmsZ6miepoSwi4iqMupyi3aXJYCicrXbtH+p6xx8tb
         ZyRTQWFCCygIV/dMoTVGBRyzSOMggjz68yv+1ylAOo5C7VtKgWybB+mGxMRva/RvqWbg
         Z25RbPxfyOebvbfT5q435IAH4RfJy+o1H/3OQLKSXSF1dpB0eDn7WLTyhH/TITvGGVQQ
         Pe3W7TUFmqa5rWyI6ajGTN8yk/8ErCvKeihkvvAxQlhQ5H6Zb1c7fy7c9zIDkznNVZKI
         aaMg==
X-Gm-Message-State: AOAM533dgL4sr/ySYnVRrL4b+S+wSGyeWsKFO/te95v/smlNuZHtCASu
        xi4VXx2ZXjiAy3LnxdehgKuprDqosBU=
X-Google-Smtp-Source: ABdhPJyFqSL9fNJV+JVDU7GYhEJvVykuzJmdCVZod6vf9hUv9/HkuTKJxWd/cTE/QjcxPTuiC2ec6Q==
X-Received: by 2002:a05:6214:5086:: with SMTP id kk6mr8432174qvb.63.1634863052175;
        Thu, 21 Oct 2021 17:37:32 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id s189sm3309420qka.100.2021.10.21.17.37.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 17:37:32 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id g17so2164712qtk.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 17:37:31 -0700 (PDT)
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr9593942qtr.118.1634863051346;
 Thu, 21 Oct 2021 17:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210908071631.660-1-caihuoqing@baidu.com> <20210908071631.660-2-caihuoqing@baidu.com>
In-Reply-To: <20210908071631.660-2-caihuoqing@baidu.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 21 Oct 2021 19:37:20 -0500
X-Gmail-Original-Message-ID: <CADRPPNT-ZGsn_04J8tLuyACqpdtSE0b8qg0dC7jPgTZcMhx26g@mail.gmail.com>
Message-ID: <CADRPPNT-ZGsn_04J8tLuyACqpdtSE0b8qg0dC7jPgTZcMhx26g@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: fsl: rcpm: Make use of the helper function devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 2:20 AM Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied for next.  Thanks.

> ---
>  drivers/soc/fsl/rcpm.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
> index 90d3f4060b0c..3d0cae30c769 100644
> --- a/drivers/soc/fsl/rcpm.c
> +++ b/drivers/soc/fsl/rcpm.c
> @@ -146,7 +146,6 @@ static const struct dev_pm_ops rcpm_pm_ops = {
>  static int rcpm_probe(struct platform_device *pdev)
>  {
>         struct device   *dev = &pdev->dev;
> -       struct resource *r;
>         struct rcpm     *rcpm;
>         int ret;
>
> @@ -154,11 +153,7 @@ static int rcpm_probe(struct platform_device *pdev)
>         if (!rcpm)
>                 return -ENOMEM;
>
> -       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!r)
> -               return -ENODEV;
> -
> -       rcpm->ippdexpcr_base = devm_ioremap_resource(&pdev->dev, r);
> +       rcpm->ippdexpcr_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(rcpm->ippdexpcr_base)) {
>                 ret =  PTR_ERR(rcpm->ippdexpcr_base);
>                 return ret;
> --
> 2.25.1
>
