Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F07358F34
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhDHVd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:33:27 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44633 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhDHVd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:33:26 -0400
Received: by mail-oi1-f174.google.com with SMTP id a8so3671900oic.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 14:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mySPQZAxeKxPZ6g7lCnXPm49GveuRCHUb1NT0KmJXUE=;
        b=lrwMW8K4VVCKuUAHiBiwJZNwOoLG0ZxnMwt4a5w9DEgwsY7PvkPwHcH/OiajwXqNX+
         9xKUBtnNkV3bWU/ULdwVQZkEbI8QyAtOEL8M1BNSmNkfOm7eVVaGi2Qu2S83eE6QoZCU
         qjE8CCapZDz6XpmPz61Y5gtXI/tyNMZxC3d4HF4XpMLbQgJ13O5poBFJIsykZ9xRm5Xg
         hhOD1I9ahavYSXchCvpZ90p6c7PYEOEduNspUeANOjrqoDgY0tF20jevA2S/KHA8jqUd
         qh4htY4POXa09L7DmAHifp5jSRry6C8jYoV14mbtwo2KEv7qmD1re9roaWDkxPPpBZmf
         WJvg==
X-Gm-Message-State: AOAM532QbPrVZeVVrt2R2MTXYxpm+fzfbC3/WwmxU1rWnO5L1G8M+7GN
        M0Gpwxe/x6e7svtQ3JCNPKlpN4MjUqA=
X-Google-Smtp-Source: ABdhPJyQnCbvQvdXkxL8cMb/DlpUJlQeOyKw5VP9QtI/zfjFwg+mEVnuhQBE3n8p0+CxTcJ2zXSUoA==
X-Received: by 2002:a54:4708:: with SMTP id k8mr7752421oik.22.1617917594426;
        Thu, 08 Apr 2021 14:33:14 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id a7sm135107ooo.30.2021.04.08.14.33.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 14:33:14 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id n8so3666643oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 14:33:13 -0700 (PDT)
X-Received: by 2002:aca:3456:: with SMTP id b83mr7828412oia.51.1617917593399;
 Thu, 08 Apr 2021 14:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210408030353.37193-1-ran.wang_1@nxp.com>
In-Reply-To: <20210408030353.37193-1-ran.wang_1@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 8 Apr 2021 16:33:02 -0500
X-Gmail-Original-Message-ID: <CADRPPNR4_rmPPrQ2mhVY1zqShTm4vdg_v4iAUt_gxdo7jmOg5Q@mail.gmail.com>
Message-ID: <CADRPPNR4_rmPPrQ2mhVY1zqShTm4vdg_v4iAUt_gxdo7jmOg5Q@mail.gmail.com>
Subject: Re: [PATCH v7] soc: fsl: enable acpi support in RCPM driver
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

On Wed, Apr 7, 2021 at 9:58 PM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> From: Peng Ma <peng.ma@nxp.com>
>
> This patch enables ACPI support in RCPM driver.
>
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Applied for next.  Thanks.

> ---
> Change in v7:
>  - Update comment for checking RCPM node which refferred to
>
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
>  drivers/soc/fsl/rcpm.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
> index 4ace28cab314..90d3f4060b0c 100644
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
> @@ -78,10 +79,20 @@ static int rcpm_pm_prepare(struct device *dev)
>                                 "fsl,rcpm-wakeup", value,
>                                 rcpm->wakeup_cells + 1);
>
> -               /*  Wakeup source should refer to current rcpm device */
> -               if (ret || (np->phandle != value[0]))
> +               if (ret)
>                         continue;
>
> +               /*
> +                * For DT mode, would handle devices with "fsl,rcpm-wakeup"
> +                * pointing to the current RCPM node.
> +                *
> +                * For ACPI mode, currently we assume there is only one
> +                * RCPM controller existing.
> +                */
> +               if (is_of_node(dev->fwnode))
> +                       if (np->phandle != value[0])
> +                               continue;
> +
>                 /* Property "#fsl,rcpm-wakeup-cells" of rcpm node defines the
>                  * number of IPPDEXPCR register cells, and "fsl,rcpm-wakeup"
>                  * of wakeup source IP contains an integer array: <phandle to
> @@ -172,10 +183,19 @@ static const struct of_device_id rcpm_of_match[] = {
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
