Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7DA399A86
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFCGTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:19:47 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33570 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFCGTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:19:46 -0400
Received: by mail-ot1-f51.google.com with SMTP id q9-20020a9d66490000b02903c741e5b703so3656652otm.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=AORJO5loH8P1GCxBtXakps2SGxdj+XmHegIFz60ntSY=;
        b=m+a8Q1UpsGAwg2QV2ag3baMSuw4sbbIdKA/R3hm/N9Rbev/uihCBU+7ucdJCdo4I1B
         sN1FtF3Cn2NxdCrssZOG1BR3kj7NBLlERFQXgAB7OGtNUtF3rf9WinaAi86Z9EecPKOl
         Zp0/gqK7Ib3OXxPjeLHNnEAowBmn5c7TGgWq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=AORJO5loH8P1GCxBtXakps2SGxdj+XmHegIFz60ntSY=;
        b=Dhql+oPtobgr8xAwsz0QLZ1T3wabUBKbZLWxZ24rnv95Dt08Pz9KucpUmOXWEpG0AD
         Y/jVVmrcsS3S5b16EIe8aAmxVlNk/uRXSI8faQLwNg3bWqEUitzRAWUIfpp/EN4w8eFh
         9q9frCDtr8sztcv3c0zBgV1rsiwlMx7C3xK4ZXQAorJkRLdA0e2wavl4kJvPvIISFwwu
         BdXKLEvyFpzn16b+l7vEr7GH0ihh5fuw1HH999BKzCZTeHTOmQSP1vpAinkgSTEhDqUM
         Cl8nPUW4EZ0kNyWaqiTeEgX/mJmwqwss1ZmPEJteYeAKlOxRo4ctSJqlw3JM5iIH6MCy
         zbng==
X-Gm-Message-State: AOAM5318zazTDekvcqzNIu85pyfZ9Er4KXGfI4XZ3nEc2WKoLaOQxMTe
        j2TWO0aIsOHIGWgKrvanZpIzblbn9KR+iVK2/aHecQ==
X-Google-Smtp-Source: ABdhPJxyYLeIoldjWEenrhIDKjwGFGHgDtAWhmJTqgX+kVi9DQAsE9OwTaUuSW0wIJ7tz1YPkk2udKnCFrsX4wlP32g=
X-Received: by 2002:a9d:18e:: with SMTP id e14mr9745672ote.34.1622701022184;
 Wed, 02 Jun 2021 23:17:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Jun 2021 23:17:01 -0700
MIME-Version: 1.0
In-Reply-To: <20210603050530.15898-1-srivasam@codeaurora.org>
References: <20210603050530.15898-1-srivasam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 2 Jun 2021 23:17:01 -0700
Message-ID: <CAE-0n52CyZkRDForR7LumXL7Tcr=48UV7T-wxirMsxk7AJJsmg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: qcom: Fix for DMA interrupt clear reg overwriting
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, plai@codeaurora.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-06-02 22:05:30)
> This patch fixes the DMA interrupt registers overwriting

 $ git grep "This patch" -- Documentation/process

> issue in lpass platform interrupt handler.

Can you describe the issue more?

>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---

Any Fixes tag?

>  sound/soc/qcom/lpass-platform.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index 0df9481ea4c6..e02caa121fa4 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -650,7 +650,7 @@ static irqreturn_t lpass_dma_interrupt_handler(
>         struct lpass_variant *v = drvdata->variant;
>         irqreturn_t ret = IRQ_NONE;
>         int rv;
> -       unsigned int reg = 0, val = 0;
> +       unsigned int reg = 0, val = 0, val_clr = 0, val_mask = 0;

Why assign to 0 and then overwrite it?

>         struct regmap *map;
>         unsigned int dai_id = cpu_dai->driver->id;
>
> @@ -676,8 +676,9 @@ static irqreturn_t lpass_dma_interrupt_handler(
>         return -EINVAL;
>         }
>         if (interrupts & LPAIF_IRQ_PER(chan)) {
> -
> -               rv = regmap_write(map, reg, LPAIF_IRQ_PER(chan) | val);
> +               val_clr = (LPAIF_IRQ_PER(chan) | val);

Is the extra parenthesis useful?

> +               val_mask = LPAIF_IRQ_ALL(chan);
> +               rv = regmap_update_bits(map, reg, val_mask, val_clr);
>                 if (rv) {
>                         dev_err(soc_runtime->dev,
>                                 "error writing to irqclear reg: %d\n", rv);
