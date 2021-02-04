Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E1830F16A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhBDLAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbhBDLAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:00:23 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0AAC061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 02:59:43 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id l27so2797896qki.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 02:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lPpt1zKsfxioM+InYMsFlKI9UHzElWsHUVjSA2Fi07A=;
        b=n/RVXHuFHBWjdzBNXn8SQCGQlpcw52+XpWJmq92Aixn1w5zETuSL2+E1S8l8m5asdN
         UMmHVL3/vplybvbea9+k7WYLH210psTAVYrl3m+ZPS7PchMkmnJiT/YPDF1IGRKgUiZk
         8Q0HK/jbVr52/n6IDNK8SbzNKgcE0J9It1+w+0e4nmTMcnP/fbzBiI/JBCXGTaPm8jTB
         NdAv4EsYZcL+AdrQ19/am1J6+CitTdcW6YaOtYkCCSypGDq/i0924XkqsjcuvqrmKTPi
         gPdZEvo9CdnoObgxC3PPVT+3oTDqeuXB28YyPrmwoG2wm+K+ceXiWjPpyCi/iW+wJdqP
         70Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPpt1zKsfxioM+InYMsFlKI9UHzElWsHUVjSA2Fi07A=;
        b=GOlvylmCQbP9TmAn/zhLTPUvOvsoBOSxJHbqgNYGgwPaS+pdnggNtIEeGRTskcLTII
         TH0Fz5NbNqHZrtPpDzWis/9tUKnNE7vUX3TYIDmiy1pJg7pJH/WY+7+Mxo7y+fRp0LsQ
         REW3I31jgpJ0hdRYNEJaOtrRz+sFn1Mx59WbWtZPrYR41nKR4C6H1PUMJj0gjEzki1nP
         KaI+CnHuMGTxrVLPFPrQ+44xeOVbn2BxoGgBLZjCOcen2VaDYnqVGfp9E6MpgU13bL6b
         LLFwU96tOX6t/rnd4ssg8qydUOmmkhbFZhEhr6Ib6wP4P040oZR+8GzOqRRkf4LkEubF
         ZIYQ==
X-Gm-Message-State: AOAM53252T71gh8Ccpn3NtIx+Nv15vGwuv0UJ0LTDWREIPD5D79XPq8C
        +l/rPa5GGhkUlfsPzy8YqQ3ZAjI0mmID+8uRXjbP3SXTQmo=
X-Google-Smtp-Source: ABdhPJyZcMszXUDqRJU6y71xhdWORQZSu0y6BmXarfXjTLU9wTdxMn57NjtKn0VfEu2mxkqEHp7r7Z8Pi3DpwPcyrRI=
X-Received: by 2002:a37:4d8e:: with SMTP id a136mr6503623qkb.317.1612436382917;
 Thu, 04 Feb 2021 02:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20210204081819.892660-1-zhang.lyra@gmail.com>
In-Reply-To: <20210204081819.892660-1-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 4 Feb 2021 18:59:37 +0800
Message-ID: <CADBw62qRZ77FM7S=ss3urJ+sB_P3VSYKt2hf6cWiPk8WPoo5-A@mail.gmail.com>
Subject: Re: [PATCH] mailbox: sprd: correct definition of SPRD_OUTBOX_FIFO_FULL
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Magnum Shan <magnum.shan@unisoc.com>,
        Haidong Yao <haidong.yao@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 4:18 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Magnum Shan <magnum.shan@unisoc.com>
>
> According to the specification, bit[2] represents SPRD_OUTBOX_FIFO_FULL,
> not bit[0], so correct it.
>
> Fixes: ca27fc26cd22 ("mailbox: sprd: Add Spreadtrum mailbox driver")
> Signed-off-by: Magnum Shan <magnum.shan@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/mailbox/sprd-mailbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
> index f6fab24ae8a9..4c325301a2fe 100644
> --- a/drivers/mailbox/sprd-mailbox.c
> +++ b/drivers/mailbox/sprd-mailbox.c
> @@ -35,7 +35,7 @@
>  #define SPRD_MBOX_IRQ_CLR                      BIT(0)
>
>  /* Bit and mask definiation for outbox's SPRD_MBOX_FIFO_STS register */
> -#define SPRD_OUTBOX_FIFO_FULL                  BIT(0)
> +#define SPRD_OUTBOX_FIFO_FULL                  BIT(2)
>  #define SPRD_OUTBOX_FIFO_WR_SHIFT              16
>  #define SPRD_OUTBOX_FIFO_RD_SHIFT              24
>  #define SPRD_OUTBOX_FIFO_POS_MASK              GENMASK(7, 0)
> --
> 2.25.1
>


-- 
Baolin Wang
