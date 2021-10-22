Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F64436ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 02:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhJVA3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 20:29:13 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:43588 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhJVA3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:29:12 -0400
Received: by mail-qt1-f179.google.com with SMTP id r17so2129478qtx.10;
        Thu, 21 Oct 2021 17:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnL8LEaWnSsWA9HfguV8dZWptDtYCS/c4aEJvvgRowc=;
        b=xvZ1aKPlRC2VhsexDgLd6S7Izt5/TLSMUzlNoEYlw1cSf6iq/EVyCQCxiw6OpYpPPU
         n8Bz9bhmpSLJB0ot10WlWnymUAj/LxHzcVwZExDY7s6fPsVXdOsHbpVf/OidSvv5Hosd
         oQfimZPjQuaDW8Tdlk8xaxsgx0cE+6vysG6CqynWJgw9yQCfo7AHJt6chnSuol0xBihZ
         jYYHjpJ5+a3PO5kt3bPacjLV5W1ug67Kgxlp7AeHSCG1YWtNfIfrhQ3ZTO3bkUJt9Ig6
         uw7Bfg/IG1TqKB+qUuxSOtJWjnxKTaKwaj5VyIb39KHLdR+ko5NQHT+4OsxKbwR3jqDq
         uoBw==
X-Gm-Message-State: AOAM5334pP8n6haho/+Nb5Xr0Er1BkGhWfdgKe3A9HGUDBSdfcIlVVv7
        de2huhOtYL26DRXF6ZNvv16+mUV4oME=
X-Google-Smtp-Source: ABdhPJwTkwVfVTOjzil2JYfRrKD8dEvrimjDlw75MEcwTbEa/T9j1YBmZMJ9RPtIvoP2yfXDPhWn9w==
X-Received: by 2002:ac8:7d87:: with SMTP id c7mr672070qtd.413.1634862415456;
        Thu, 21 Oct 2021 17:26:55 -0700 (PDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id b127sm3312121qkg.42.2021.10.21.17.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 17:26:55 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id bp7so3035451qkb.12;
        Thu, 21 Oct 2021 17:26:54 -0700 (PDT)
X-Received: by 2002:a37:bd7:: with SMTP id 206mr7129325qkl.297.1634862414371;
 Thu, 21 Oct 2021 17:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <b12e8c5c5d6ab3061d9504de8fbaefcad6bbc385.1629321668.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b12e8c5c5d6ab3061d9504de8fbaefcad6bbc385.1629321668.git.christophe.jaillet@wanadoo.fr>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 21 Oct 2021 19:26:42 -0500
X-Gmail-Original-Message-ID: <CADRPPNTHKuV9eernJS6ZV_+i-xtPXHQnS64GSx=ubwWE+nbLYw@mail.gmail.com>
Message-ID: <CADRPPNTHKuV9eernJS6ZV_+i-xtPXHQnS64GSx=ubwWE+nbLYw@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: guts: Fix a resource leak in the error handling
 path of 'fsl_guts_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 4:23 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If an error occurs after 'of_find_node_by_path()', the reference taken for
> 'root' will never be released and some memory will leak.

Thanks for finding this.  This truly is a problem.

>
> Instead of adding an error handling path and modifying all the
> 'return -SOMETHING' into 'goto errorpath', use 'devm_add_action_or_reset()'
> to release the reference when needed.
>
> Simplify the remove function accordingly.
>
> As an extra benefit, the 'root' global variable can now be removed as well.
>
> Fixes: 3c0d64e867ed ("soc: fsl: guts: reuse machine name from device tree")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  drivers/soc/fsl/guts.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index d5e9a5f2c087..4d9476c7b87c 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -28,7 +28,6 @@ struct fsl_soc_die_attr {
>  static struct guts *guts;
>  static struct soc_device_attribute soc_dev_attr;
>  static struct soc_device *soc_dev;
> -static struct device_node *root;
>
>
>  /* SoC die attribute definition for QorIQ platform */
> @@ -136,14 +135,23 @@ static u32 fsl_guts_get_svr(void)
>         return svr;
>  }
>
> +static void fsl_guts_put_root(void *data)
> +{
> +       struct device_node *root = data;
> +
> +       of_node_put(root);
> +}
> +
>  static int fsl_guts_probe(struct platform_device *pdev)
>  {
>         struct device_node *np = pdev->dev.of_node;
>         struct device *dev = &pdev->dev;
> +       struct device_node *root;
>         struct resource *res;
>         const struct fsl_soc_die_attr *soc_die;
>         const char *machine;
>         u32 svr;
> +       int ret;
>
>         /* Initialize guts */
>         guts = devm_kzalloc(dev, sizeof(*guts), GFP_KERNEL);
> @@ -159,6 +167,10 @@ static int fsl_guts_probe(struct platform_device *pdev)
>
>         /* Register soc device */
>         root = of_find_node_by_path("/");
> +       ret = devm_add_action_or_reset(dev, fsl_guts_put_root, root);
> +       if (ret)
> +               return ret;

We probably only need to hold the reference when we do get "machine"
from the device tree, otherwise we can put it directly.

Or maybe we just maintain a local copy of string machine which means
we can release the reference right away?

> +
>         if (of_property_read_string(root, "model", &machine))
>                 of_property_read_string_index(root, "compatible", 0, &machine);
>         if (machine)
> @@ -197,7 +209,7 @@ static int fsl_guts_probe(struct platform_device *pdev)
>  static int fsl_guts_remove(struct platform_device *dev)
>  {
>         soc_device_unregister(soc_dev);
> -       of_node_put(root);
> +
>         return 0;
>  }
>
> --
> 2.30.2
>
