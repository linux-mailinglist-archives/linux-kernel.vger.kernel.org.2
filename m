Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727153A39BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 04:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhFKC3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 22:29:08 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]:43996 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhFKC3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 22:29:07 -0400
Received: by mail-qv1-f53.google.com with SMTP id e18so15792578qvm.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FsXY/TbSGUUDENZzS6CIpHdUvNAOKNKXgpKq5u4rXU=;
        b=I2eukykiphXFQViXcXYmNXYcayHQieCzV49bgZWYLDdkww6G3d2j0qfqzxreHlnYSI
         v/HEDSDf02kjpLsUckDsFqDTQoVG0g4s04oX/4cCJ+iN8hs/Ar1nRZ+2CaodIEbP/CQR
         fBL9nAbihtMYVpgNmymE0y4FaiGGHXBr5JQipolDQ9y1duTTcuOn1biEoOsaWsk4ts0H
         oBQkD6Wvsz/4nkbP9EEfgsDmbAwS0Voq6kY6jTBaCKZBdIGolFuD8IdP0ZJF3nvQq/sa
         zglPT+b/jLnTA8hkzYcjo6OcDop+++rp4rdNR5Tk3ceiqO8ntyN9mf6+Ae87R3jMbJI4
         +t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FsXY/TbSGUUDENZzS6CIpHdUvNAOKNKXgpKq5u4rXU=;
        b=K5u493EHcfy2PUoLVn+6/VSOijdluHYmSQd0uxkNbY6+gyvig9yghYS7XtnHjYaZHQ
         NCdWt0JtAn3Qv12Od4PACFFdqGPsScUcC9tbb5vQdmZaZFlVT1rxTKyPjK2MIT3iKbDp
         umIj4HVq11Hz8dYuavjN6QJvX6zHnIjEGbYFTF7WUW5ql23nT+76pmn/e4jK2cAnxPwK
         4l6YV+WTqWTqWQ1MHKaDSxdfHwpOYlB99yfy+BlPJRGY4emnBDfK64Scbzl9kiu5ybLO
         bd+vSa4abEypHDbWaRYNxRkWCbtWydmLXOYLsWhLl18Y1fUdVj2J4APJCHanRi26ft61
         3wYA==
X-Gm-Message-State: AOAM5318q+7WkXoGsnji8E2gXsUyH3ueGtzMIG99FWkwElVcHC3wrJs0
        3i5S0EksoSlzAIizY6vCKnrzmHuwbQWlmkqL71w=
X-Google-Smtp-Source: ABdhPJxT+CsEUPgmUbbvvdovqN50qvrZPZs4VXtBZa26L9aij/35ZW5rkX2cu6uMHZw3aT20weyVwPl2f64lDccacTM=
X-Received: by 2002:ad4:576c:: with SMTP id r12mr2699884qvx.28.1623378357051;
 Thu, 10 Jun 2021 19:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210610040037.1064-1-hbut_tan@163.com>
In-Reply-To: <20210610040037.1064-1-hbut_tan@163.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 11 Jun 2021 10:25:46 +0800
Message-ID: <CAA+D8AOseYcjf6erSObjkpAhZGJW0VGio-T91kFZ7q0f3PhQPA@mail.gmail.com>
Subject: Re: [PATCH] ASoC:fsl_spdif:Remove superfluous error message around platform_get_irq()
To:     Zhongjun Tan <hbut_tan@163.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tan Zhongjun <tanzhongjun@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:02 PM Zhongjun Tan <hbut_tan@163.com> wrote:
>
> From: Tan Zhongjun <tanzhongjun@yulong.com>
>
> The platform_get_irq() prints error message telling that interrupt is
> missing, hence there is no need to duplicated that message.
>
> Signed-off-by: Tan Zhongjun <tanzhongjun@yulong.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

> ---
>  sound/soc/fsl/fsl_spdif.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 2a76714eb8e6..29cefd459241 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1368,10 +1368,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>
>         for (i = 0; i < spdif_priv->soc->interrupts; i++) {
>                 irq = platform_get_irq(pdev, i);
> -               if (irq < 0) {
> -                       dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
> +               if (irq < 0)
>                         return irq;
> -               }
>
>                 ret = devm_request_irq(&pdev->dev, irq, spdif_isr, 0,
>                                        dev_name(&pdev->dev), spdif_priv);
> --
> 2.17.1
>
