Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3FB32A38B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382232AbhCBJHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbhCBIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:51:34 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1ADC0617AA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:42:38 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id dx17so6093790ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 00:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agB1pi024Vr3XPHFnK8A8uxx+WSFW4Ss4wEt+UUGomA=;
        b=J2KxhfvYp/C4dNeiEuJ9uuzNtGkOnSWtZXhIKfyFPrvIRJ6Uz0nzrFUHlf/AJVfTX/
         pLADSL75J4ZVY+zeYfSOGPpkv9fP0XuJELCjv+CBzNjYyvbNqlvNEdO8o54dfEDtVYBf
         B8f+aY0ITlqdbI9sz70TTv+y26cx4W3D683xiB7w6RgFMzqfamj5eb16BuAy55JtBSXb
         dHUXhCpLl5GWmGLxuqBy+sAutKvDqQuvAKeG1lj97jpL5H7RzgzsMY62RMWRXHXy0Zc9
         6g2R/ewhXtTLFZtKya22iW6Hyt61B1lPKlWAWzZPyyeUvdmeh2YHExJZm3eape88OnIr
         0+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agB1pi024Vr3XPHFnK8A8uxx+WSFW4Ss4wEt+UUGomA=;
        b=dSGsRysr7CaKGfGXK0Z3q2KaNUdYIMJZedtgbbo3jO2i6tO0RFEX6HUcfHV9KHfM38
         RfPP0hmcMQ9p1D5E/grPu3Aum50b1dq+5rhgKJ1TUG+RNrAinFPjpcWg9ElKzO5keBsi
         n3GcvdCRuW+02g9KPwyfVz/hy65r0+qcoq8EaM+vU/FkyDovbQcb5kxuL6jSlw3hnDqn
         Nw1A8T1PEJcfyU8b+LA5ddB8yzsZxz/yoQgnlRbWV8AupPEH9y+oe32tY8ZHQqf/8l90
         CtMf/tQylagKMavX0zaaMnyzdynAkaFLdifC/1mlVvifCnIquVZCRe771z1dhMWPWaqZ
         ekxg==
X-Gm-Message-State: AOAM533qKbI1HIXCYPKZKtzAsgMMp9Pmx0OWZYdQxOmi42rJpZm1+daZ
        K/BVQht4vENk70u7oDo/zOI4i4fYMKNjPNq+/66byw==
X-Google-Smtp-Source: ABdhPJxrNudJeeR8IfVRpsk7slwS7VNf7SxzFv8Xp+r4FDzk4q5SXG33aC9jWsXdNCJ5zn9Z9QMi1b64BHGjO2kV73Q=
X-Received: by 2002:a17:906:3105:: with SMTP id 5mr20113035ejx.168.1614674557016;
 Tue, 02 Mar 2021 00:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20210302033323.25830-1-biao.huang@mediatek.com>
In-Reply-To: <20210302033323.25830-1-biao.huang@mediatek.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 2 Mar 2021 09:42:26 +0100
Message-ID: <CAMpxmJV_MmOrP1eKdcBsD2sjzC7p52vxBz+HE+yHDdr9RTujqQ@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: mtk-star-emac: fix wrong unmap in RX handling
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 4:33 AM Biao Huang <biao.huang@mediatek.com> wrote:
>
> mtk_star_dma_unmap_rx() should unmap the dma_addr of old skb rather than
> that of new skb.
> Assign new_dma_addr to desc_data.dma_addr after all handling of old skb
> ends to avoid unexpected receive side error.
>
> Fixes: f96e9641e92b ("net: ethernet: mtk-star-emac: fix error path in RX handling")
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_star_emac.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> index a8641a407c06..96d2891f1675 100644
> --- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
> +++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> @@ -1225,8 +1225,6 @@ static int mtk_star_receive_packet(struct mtk_star_priv *priv)
>                 goto push_new_skb;
>         }
>
> -       desc_data.dma_addr = new_dma_addr;
> -
>         /* We can't fail anymore at this point: it's safe to unmap the skb. */
>         mtk_star_dma_unmap_rx(priv, &desc_data);
>
> @@ -1236,6 +1234,9 @@ static int mtk_star_receive_packet(struct mtk_star_priv *priv)
>         desc_data.skb->dev = ndev;
>         netif_receive_skb(desc_data.skb);
>
> +       /* update dma_addr for new skb */
> +       desc_data.dma_addr = new_dma_addr;
> +
>  push_new_skb:
>         desc_data.len = skb_tailroom(new_skb);
>         desc_data.skb = new_skb;
> --
> 2.18.0
>

Thanks for spotting that. Maybe also update the commit so that it
says: "it's safe to unmap the old skb"? Would make the thing clearer
IMO.

In any case:

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Bartosz
