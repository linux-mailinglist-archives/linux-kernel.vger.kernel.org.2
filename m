Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE20B355E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 23:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbhDFVpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 17:45:53 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:33341 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhDFVpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 17:45:51 -0400
Received: by mail-oi1-f172.google.com with SMTP id w70so16732038oie.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 14:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyunIQmpMoQ2hJkQKW9e3iWhuiH99hCwIK89nVDwBeA=;
        b=jrcqA455OJk0/E/DNWtxVWrYPXnqT0JwCQpX4ftQ6CUyThYaKi5VNPu5H5mQ/bmJnv
         F/4JVGZErM2OA4BthFYrgxRQHrlgLVgIdL2R6P7boRA8ng3oH2yqmQwz5ooPH/tISL72
         ElUaquSk/Qo394qIYaK1Jp20j1k6gD5u0tZykis+MKRuVxTmpN/9Aaf9AeLjMZA7Rhmb
         NAzB5NCmqNoCCKQ+IuCzV9ygm6f+hMH4uIAfvPzho3V0O7S1/C8JKUjxsf7+Pi5R32nz
         uB+jVAN53YPN1QYwWfJW0Ow5XJ+7EGWXcPmSOv1+KgWvF0G4S9dNup7Xu/2t5wGnx6vy
         2nQg==
X-Gm-Message-State: AOAM531VyfSS3Rnm3LaAaBH8zd1czSahVWt3dMqjQW9AoyLEqRhFi/gN
        gxud5PX8tUCeLGPbpirgYy0wMBm+bDE=
X-Google-Smtp-Source: ABdhPJz8gCHhdfRSoULsVlkxICg1TxuaN3GwxI9BgrpcGMExYfLx5ldwI6BaHAM/9Y+WbKqWMAMxHQ==
X-Received: by 2002:aca:3c55:: with SMTP id j82mr4652738oia.76.1617745542135;
        Tue, 06 Apr 2021 14:45:42 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id l26sm4974496otd.21.2021.04.06.14.45.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 14:45:41 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso16089206otq.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 14:45:41 -0700 (PDT)
X-Received: by 2002:a05:6830:20da:: with SMTP id z26mr153933otq.74.1617745540947;
 Tue, 06 Apr 2021 14:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210312085822.12136-1-ran.wang_1@nxp.com>
In-Reply-To: <20210312085822.12136-1-ran.wang_1@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 6 Apr 2021 16:45:29 -0500
X-Gmail-Original-Message-ID: <CADRPPNRv_T9o=Kg4dCJ6jFPxOWMY24wgDXCzyTpz3oh_yL+4Tw@mail.gmail.com>
Message-ID: <CADRPPNRv_T9o=Kg4dCJ6jFPxOWMY24wgDXCzyTpz3oh_yL+4Tw@mail.gmail.com>
Subject: Re: [PATCH v6] soc: fsl: enable acpi support in RCPM driver
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, Peng Ma <peng.ma@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 2:56 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> From: Peng Ma <peng.ma@nxp.com>
>
> This patch enables ACPI support in RCPM driver.
>
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Change in v6:
>  - Remove copyright udpate to rebase on latest mainline
>
> Change in v5:
>  - Fix panic when dev->of_node is null
>
> Change in v4:
>  - Make commit subject more accurate
>  - Remove unrelated new blank line
>
> Change in v3:
>  - Add #ifdef CONFIG_ACPI for acpi_device_id
>  - Rename rcpm_acpi_imx_ids to rcpm_acpi_ids
>
> Change in v2:
>  - Update acpi_device_id to fix conflict with other driver
>
>  drivers/soc/fsl/rcpm.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
> index 4ace28cab314..7aa997b932d1 100644
> --- a/drivers/soc/fsl/rcpm.c
> +++ b/drivers/soc/fsl/rcpm.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <linux/kernel.h>
> +#include <linux/acpi.h>
>
>  #define RCPM_WAKEUP_CELL_MAX_SIZE      7
>
> @@ -78,10 +79,14 @@ static int rcpm_pm_prepare(struct device *dev)
>                                 "fsl,rcpm-wakeup", value,
>                                 rcpm->wakeup_cells + 1);
>
> -               /*  Wakeup source should refer to current rcpm device */
> -               if (ret || (np->phandle != value[0]))
> +               if (ret)
>                         continue;
>
> +               if (is_of_node(dev->fwnode))
> +                       /*  Should refer to current rcpm device */
> +                       if (np->phandle != value[0])
> +                               continue;

It looks like that we assume that in the ACPI scenario there will only
be one RCPM controller and all devices are controlled by this single
PM controller.  This probably is true for all existing SoCs with a
RCPM.  But since the driver tried to support multiple RCPMs, maybe we
should continue to support multiple RCPM controllers or at least
mention that in the comment.

> +
>                 /* Property "#fsl,rcpm-wakeup-cells" of rcpm node defines the
>                  * number of IPPDEXPCR register cells, and "fsl,rcpm-wakeup"
>                  * of wakeup source IP contains an integer array: <phandle to
> @@ -172,10 +177,19 @@ static const struct of_device_id rcpm_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rcpm_of_match);
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id rcpm_acpi_ids[] = {
> +       {"NXP0015",},
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, rcpm_acpi_ids);
> +#endif
> +
>  static struct platform_driver rcpm_driver = {
>         .driver = {
>                 .name = "rcpm",
>                 .of_match_table = rcpm_of_match,
> +               .acpi_match_table = ACPI_PTR(rcpm_acpi_ids),
>                 .pm     = &rcpm_pm_ops,
>         },
>         .probe = rcpm_probe,
> --
> 2.25.1
>
