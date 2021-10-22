Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5549E436ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 02:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhJVAgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 20:36:49 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:40590 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJVAgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:36:48 -0400
Received: by mail-qk1-f170.google.com with SMTP id x123so3175209qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 17:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pLuQaUGEsRYwpc0MMQlI/U5wBA+N3te0wyegZPV6Y4=;
        b=o9uinDQUofZUi/yBOsp6vK1OxN/wTG05vblHrIhnlr85llf5xv+W0A2FazmFjGkEqp
         +QFqqMve++WQaAZ9pk0iSYy/HROcjO/eju+ofl3hERkVcNLUFax5PRfavldIsuUQoI5K
         nzp+ukseI8K2YUsOYCJALNH34tU+S7kaiKOF9z0H24ZLWgZ+y2kq5FtNkNB1QjzPB04X
         FDmvroN1cVnqQKflrHKFQ0CHgyRsp7tcY+RDnqoD+lvvlSwd4fhQ+j9XWShCrudVGTVD
         wJWk6jSxuobLKTFnAOuyQyNYU6zWos6r9W5NDB/nrJX3/T2jxLSfmOqEw+BvwawWdWAW
         ttvQ==
X-Gm-Message-State: AOAM530TjRfip4jeW60jj4rfMXcZZ6+E8DWcUE04tYThvCUQXmAI5pwR
        fTyiMQFJ3lE8OvWjmgQloEM2AbG9gNw=
X-Google-Smtp-Source: ABdhPJzzM1Ledbv0qxrYEucY3AZ47g0/rINI3omHmADJ9O4BkxHk0E/FnCtdJTugacrvyEb4yE2whg==
X-Received: by 2002:a37:a307:: with SMTP id m7mr7502751qke.1.1634862870868;
        Thu, 21 Oct 2021 17:34:30 -0700 (PDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id h2sm3369930qkf.106.2021.10.21.17.34.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 17:34:30 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id h20so3029662qko.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 17:34:30 -0700 (PDT)
X-Received: by 2002:a37:db02:: with SMTP id e2mr7461283qki.436.1634862869999;
 Thu, 21 Oct 2021 17:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210908071631.660-1-caihuoqing@baidu.com>
In-Reply-To: <20210908071631.660-1-caihuoqing@baidu.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 21 Oct 2021 19:34:18 -0500
X-Gmail-Original-Message-ID: <CADRPPNSkyJxJSuRwgc4fGLPwTtsMC5YBy2yg7HN2WmGj2utdbA@mail.gmail.com>
Message-ID: <CADRPPNSkyJxJSuRwgc4fGLPwTtsMC5YBy2yg7HN2WmGj2utdbA@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: fsl: guts: Make use of the helper function devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 2:19 AM Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied for next.  Thanks.

> ---
>  drivers/soc/fsl/guts.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index d5e9a5f2c087..072473a16f4d 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -140,7 +140,6 @@ static int fsl_guts_probe(struct platform_device *pdev)
>  {
>         struct device_node *np = pdev->dev.of_node;
>         struct device *dev = &pdev->dev;
> -       struct resource *res;
>         const struct fsl_soc_die_attr *soc_die;
>         const char *machine;
>         u32 svr;
> @@ -152,8 +151,7 @@ static int fsl_guts_probe(struct platform_device *pdev)
>
>         guts->little_endian = of_property_read_bool(np, "little-endian");
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       guts->regs = devm_ioremap_resource(dev, res);
> +       guts->regs = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(guts->regs))
>                 return PTR_ERR(guts->regs);
>
> --
> 2.25.1
>
