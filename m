Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBD93A39A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 04:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhFKCZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 22:25:45 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:36516 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhFKCZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 22:25:43 -0400
Received: by mail-qk1-f170.google.com with SMTP id i68so25956129qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 19:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTFlovwtrqxUOZ0WoQulGA+S/cNwfLiqBtlEH+BQzqQ=;
        b=nJCere7LOSrhMIfWD9e3SYHFAobt75P+qmj3bZ8wly9ssO30SIjc03f5DOKJZBgIrA
         E1CRT2L2mbWltL8t/yPOo1LFACAc56vOI2yhtRTYFHMnO1tlshUUAkMo/RCMCTWukNAx
         p4jf2YOSVxJkWYq/J1pj5v80b6kvfUsdHzounC04d8n6tv2dT5bTCioZqMeukW6Jhp5t
         vPA9GRhD2pNsr23B0/yiT1HF+mVB/J6gG4E9zuhEXGUvJbg4X4GdhE9/6hiWSmOihT1s
         tF9QNNLxQU4+YpiG3PxT4qDlp7LH/F1LjfsFcEu4eZh9EWvirF6S2KVBZMDC0Pf2mWZW
         tFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTFlovwtrqxUOZ0WoQulGA+S/cNwfLiqBtlEH+BQzqQ=;
        b=FbrMd/btpb1LCQQtZqbvHZa52Na4jB8nic7ALsdGnpJ/kteOKPxhdGSisErs74chaW
         5ZKRnNdzm0cXdAUedBDdgg2/vQkxmwo+UHylYyc7R/rfXbDrFWd782c4DmojKMK2xZXO
         xcJta1sKMvEc2Nb7lbirWJezq2ZH+qGjlIQFizHtnSQkWQqtrwiKGQRb+Pm0B3hC13qS
         QfpQAH+2mWQ2ISd+z4BR+htyToQA1OMaopBBihxqhfoY5BcW1mFyXpUzdhwRizsH+V5N
         +5YlOrhPvzcc+FV+MlbU7SnWf+xMqNpH7CBK6xvdJf3GXiQUTxpjHrFkY3CP129i1O2m
         4oqQ==
X-Gm-Message-State: AOAM533vQwpCf67h1g2E2c6NYncagn+c/May2Fuk1iw/UVASrVBTjfQ5
        zjvyRdWTdbItoPsO1CnOPFe3uz7RC5KfM/RwQiU=
X-Google-Smtp-Source: ABdhPJwVE3MlwWUimCYQvJayxGP7hU75ji8nembIFoLu6+sidUiX6/wx3tIsymXPfJaTimO7t79BV4a5rJbWDLVHbIc=
X-Received: by 2002:a37:af84:: with SMTP id y126mr1725374qke.450.1623378153832;
 Thu, 10 Jun 2021 19:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210610125052.1280-1-hbut_tan@163.com>
In-Reply-To: <20210610125052.1280-1-hbut_tan@163.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 11 Jun 2021 10:22:23 +0800
Message-ID: <CAA+D8AOHdArkc2mM--4yLLpGyEzfZb241MWj+10JjezXY_-UZw@mail.gmail.com>
Subject: Re: [PATCH] ASoC:fsl_easrc:Remove superfluous error message around platform_get_irq()
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

On Thu, Jun 10, 2021 at 8:52 PM Zhongjun Tan <hbut_tan@163.com> wrote:
>
> From: Tan Zhongjun <tanzhongjun@yulong.com>
>
> Clean up the check for irq.dev_err is superfluous as platform_get_irq()
> already prints an error.Remove curly braces to confirm to styling
> requirements.
>
> Signed-off-by: Tan Zhongjun <tanzhongjun@yulong.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

> ---
>  sound/soc/fsl/fsl_easrc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index b1765c7d3bcd..25747433916e 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1901,10 +1901,8 @@ static int fsl_easrc_probe(struct platform_device *pdev)
>         }
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(dev, "no irq for node %pOF\n", np);
> +       if (irq < 0)
>                 return irq;
> -       }
>
>         ret = devm_request_irq(&pdev->dev, irq, fsl_easrc_isr, 0,
>                                dev_name(dev), easrc);
> --
> 2.17.1
>
>
