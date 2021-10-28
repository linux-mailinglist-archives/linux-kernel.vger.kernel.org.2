Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302BF43DAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 08:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhJ1GQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 02:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhJ1GQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 02:16:36 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3421C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:14:09 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d63so6695569iof.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/CaYgRMivi6E5IrdJQN3VhID0wrYip2MBmQLj5bzn8=;
        b=Aq2N80QZqWuk5rhmqD7SlSuHwXw7X5Xj9MYYbX+VkHfnnnJufBOqYb9gJF4OaEiYOR
         JuqCgXZnsw56MasCxD1UCPwBEADYf4FTAWs1ucK/j7eyDg4KLsC9VDX8pUg2LrTvIBMu
         LluBL6cpWjDIFC5cHIlQBEAbj2544NrYdVLsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/CaYgRMivi6E5IrdJQN3VhID0wrYip2MBmQLj5bzn8=;
        b=jlgkf4dEvZ+N1GorP3pgS8h1XfD1Z9eRPFi18hjLsuCGfz2FQ5qk/kjgbi04CE5ypj
         NjxE4V1CfHpASTh2Tzne/y36oqMr+0FDR3tJYy/MbLMEBB4YBuyqa/xTKZ9m5AZesxTs
         sYbv7UwRx8hB3fnSpmEBDUKmqJ3lGOW5fJHlGFv1HfyahidLLVNM8AsqNtiz7nB4lybg
         HPLXdbq9wmrULvSVlXib9JniOe3QRyldEqIu3e/0M8CiV7zN66CB9SLzRm+aZaNhBvL6
         wslvuc2c7FQKlp0bF0BmS9iQEDd8lkUKclnrHJ9I3iY8v9GP0RZ/+LKt0judxoiBaj9B
         zRyA==
X-Gm-Message-State: AOAM532WWHt+vbKiVb4Fl7iyL4OBOdBp/fw+ZgeKNj4bIAv+HOGjqJLQ
        BS/fXxeO8bUq8AbtI+Z1qCtklveQQ+aoYkzPgXvX2w==
X-Google-Smtp-Source: ABdhPJzC5EHSvYTWsmMZor72KBYkv+zsEBX+bmiCWVqdyiTSd1OU5sPmnEltvdTsr6xsiuVNtLUjnZF8GSWmTewNAHQ=
X-Received: by 2002:a02:954d:: with SMTP id y71mr1680582jah.83.1635401649146;
 Wed, 27 Oct 2021 23:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211028055056.26378-1-yong.wu@mediatek.com>
In-Reply-To: <20211028055056.26378-1-yong.wu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 28 Oct 2021 14:13:43 +0800
Message-ID: <CAJMQK-jCuH-EKd1snhtrkFEz0bFN1t8EvsF3Kjua-HVFa_3J9A@mail.gmail.com>
Subject: Re: [PATCH] memory: mtk-smi: Fix a null dereference for the ostd
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com, Ikjoon Jang <ikjn@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 1:51 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> We add the ostd setting for mt8195. It introduces a abort for the
> previous SoC which doesn't have ostd setting. This is the log:
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000080
> ...
> pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
> lr : mtk_smi_larb_resume+0x54/0x98
> ...
> Call trace:
>  mtk_smi_larb_config_port_gen2_general+0x64/0x130
>  pm_generic_runtime_resume+0x2c/0x48
>  __genpd_runtime_resume+0x30/0xa8
>  genpd_runtime_resume+0x94/0x2c8
>  __rpm_callback+0x44/0x150
>  rpm_callback+0x6c/0x78
>  rpm_resume+0x310/0x558
>  __pm_runtime_resume+0x3c/0x88
>
> In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
> if "larb->larb_gen->ostd" is null, the "larbostd" is the offset, it is
> also a valid value, thus, use the larb->larb_gen->ostd as the condition
> inside the "for" loop.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

After applying this patch, mt8183 is no longer crashing.

> ---
> Hi Krzysztof,
> Could you help review and conside this as a fix for the mt8195 patchset?
> The mt8195 patchset are not in mainline, thus, I don't know its sha-id,
> and don't add Fixes tag.
> Thanks
> ---
>  drivers/memory/mtk-smi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b883dcc0bbfa..0262a59a2d6e 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -257,7 +257,7 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
>         if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_SW_FLAG))
>                 writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base + SMI_LARB_SW_FLAG);
>
> -       for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd && !!larbostd[i]; i++)
> +       for (i = 0; i < SMI_LARB_PORT_NR_MAX && larb->larb_gen->ostd && !!larbostd[i]; i++)
>                 writel_relaxed(larbostd[i], larb->base + SMI_LARB_OSTDL_PORTx(i));
>
>         for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> --
> 2.18.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
