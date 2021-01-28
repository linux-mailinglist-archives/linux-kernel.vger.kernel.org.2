Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AA43073B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhA1K0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhA1KZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:25:23 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5044C061574;
        Thu, 28 Jan 2021 02:24:41 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id g46so1281528ooi.9;
        Thu, 28 Jan 2021 02:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1z+Yu2fiQlavDIbv9fPx1NNOziGtX2cOyoTwpCpWQI=;
        b=MHD1CdFnmK00kxSnxryGxN7EuOz28GXa8gDugIWWKqB4bu29sYsgdBEO20Ik3ibTu6
         gy+vUfGHbC5IPeFzxq7DYJ8L1D4135+ZURvRtmdhllV/LSUxYO8kh4jZ5frnnFLBLS6z
         xXWAHil0XKu/RsMmMkRt0t+pRJoBfNe8/AyGWL8gHgBkrVFF4y8Rqkgd/KP9OAnZT1d4
         0j7oJi4cy74V4OhUvokWxX2xCM8RLtCnwwr3JdEecW//Vk56o3L3qFbRrLT1zAOjSlxY
         giq687DnX05W3NvZAbdLwIkAEPoClsexV3FsvPdT06rY/N5FU87xDPBL08j1o2G3Yk98
         A3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1z+Yu2fiQlavDIbv9fPx1NNOziGtX2cOyoTwpCpWQI=;
        b=eFrwof4QaVqMAMzmvWRq3PU4SqaTlSua8pOjtP1qVtcvClYe+Ifeg6AMV6W3meqz+X
         7qn9cz05KodB3JJh2I+LSw9Va0Ke6L8rZ4j+4qOD9gNSyVSDC+zts3D5Oz03K6bUc952
         2O8xim0kmVNwtjyJyV/3g1/l1jtAtfQK3fRVa5twKrAjJNUF/4ote+Jt5Un+l6YMrus3
         z76g8HuMfIHi8AI1BcPoI9xfgc3m5D4+BCaMLPAt9V3tgxo3upLh32AXzKr17G16ae/U
         gf8pvruS4WdYN156aEbxpX8pe+vNy4gaYFdTuQ1b3PA0xAeMAKxcRWsKaxoLklBZbs0X
         CE7A==
X-Gm-Message-State: AOAM531V0ORX5OYIuK2MQ9fyaOZMYKjgKUskRQG8Vry01CKsNXNs3hUs
        QMAYnEHNvIpYzBbQMjPXO846m2ciz8DKDES37rDVzeolNI9zMHFtRks=
X-Google-Smtp-Source: ABdhPJwUsgdluUwC0izmBpnoRmX0hPl6NAxZbuWCF3shpvrYsv4fn9VmR+tzaw+Uf6ovgJbADeSOCErOYZJGoRFA9H8=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr10870225ooj.15.1611829481208;
 Thu, 28 Jan 2021 02:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20210128072802.830971-1-hsinyi@chromium.org> <20210128072802.830971-2-hsinyi@chromium.org>
In-Reply-To: <20210128072802.830971-2-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 28 Jan 2021 11:24:29 +0100
Message-ID: <CAFqH_52xmsSsxqxkBO8d93Jezy4YZFxtpJ0BX9TVrCy6qao02A@mail.gmail.com>
Subject: Re: [PATCH v11 1/9] arm64: dts: mt8183: rename rdma fifo size
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for the patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dj., 28 de gen.
2021 a les 8:28:
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> property name must include only lowercase and '-'
>

This is a leftover while I forward ported the patch, the
rdma_fifo_size only existed on the downstream kernels, in mainline it
is with '-', so we should probably add the fixes tag here.

Fixes: 91f9c963ce79 ("arm64: dts: mt8183: Add display nodes for MT8183")

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5b782a4769e7e..6c84ccb709af6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1011,7 +1011,7 @@ rdma0: rdma@1400b000 {
>                         clocks = <&mmsys CLK_MM_DISP_RDMA0>;
>                         iommus = <&iommu M4U_PORT_DISP_RDMA0>;
>                         mediatek,larb = <&larb0>;
> -                       mediatek,rdma_fifo_size = <5120>;
> +                       mediatek,rdma-fifo-size = <5120>;
>                         mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
>                 };
>
> @@ -1023,7 +1023,7 @@ rdma1: rdma@1400c000 {
>                         clocks = <&mmsys CLK_MM_DISP_RDMA1>;
>                         iommus = <&iommu M4U_PORT_DISP_RDMA1>;
>                         mediatek,larb = <&larb0>;
> -                       mediatek,rdma_fifo_size = <2048>;
> +                       mediatek,rdma-fifo-size = <2048>;
>                         mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
>                 };
>
> --
> 2.30.0.280.ga3ce27912f-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
