Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3273E54B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbhHJH6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbhHJH6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:58:46 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAFEC061796
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:58:24 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y4so14441040ilp.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mVZPY0yEuCZiQ/XlSPysqwgMRwGoFuxw2FRcr2Upjw=;
        b=n87+ADn6REp26HOZSbgheW02IxMmJA8AAkDFK6Q/uYlhjzlGTRkR0IAiO73oTPy5fD
         rZF+QUT4Q10j9gDx0pEIdthmY+ZZbvtAi1UPYm3aiVIMxwpsCJQAD4rV3eDVGBRM+Q/w
         XDZqhHNKWsqmjb0OHHZZgJZV0Jc7UItPnncoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mVZPY0yEuCZiQ/XlSPysqwgMRwGoFuxw2FRcr2Upjw=;
        b=ISlDpwiG9fOPC/6t3q1a/I86M92lVTjWTWdgYDsOgTp6A7/2jTXFqhPNOa7GFChKHh
         qyh0Imse5LkLb/VjaGUaJcV03xhxg+iavTKsDsNjQmTI511H5ILpXu4x6eQ7ud0kRisH
         hSZ6gJZqY5HDTnKzl1OHS/gxvyJhUI4eIP2l6BnqSZqkC47OI1bO3NXa7WhvePh/DmBx
         i1aKsaIDZnEofmNLTntZbq7bwRCYJMItqzBj+HZW5RlxTi4kTvU9+jEH84+8QeFv2CKX
         0o8VfOSMhEcTinCp7sKOeuGvoTSJLp5FmNe1ri35XiZcmzGZi3MwSdugzkFUkxi87c68
         pOTg==
X-Gm-Message-State: AOAM5324XlQFUyu/h0nbTMcvlHqk0OIg72wdrLN36Pd1WvQxu2o5pepK
        Lb/YpuC4AthMF9vlxylbslNzXmovj/C3ayIjJhSzvw==
X-Google-Smtp-Source: ABdhPJwouKs9MwjKH8QkjNK9MKYf33eJcgU78hqkYm2mQqdDRvL2nmAMyQpE+9sZLxPMGr7FsbpDt8gM2iMNa4f3a5s=
X-Received: by 2002:a05:6e02:1a83:: with SMTP id k3mr347831ilv.150.1628582303722;
 Tue, 10 Aug 2021 00:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210706100136.1205047-1-kansho@chromium.org>
In-Reply-To: <20210706100136.1205047-1-kansho@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 10 Aug 2021 15:57:57 +0800
Message-ID: <CAJMQK-jDNcDYcMY8tTxyVhbEP0g8z5E+cWc3Cu_gqr4fQaUmoQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64: dts: mt8183: Add kukui platform audio node
 to the device tree
To:     Kansho Nishida <kansho@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shunli Wang <shunli.wang@mediatek.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 6, 2021 at 6:01 PM Kansho Nishida <kansho@chromium.org> wrote:
>
>
> Hi Matthias,
>
> This patchset is the v3 patch!
>
> Regards,
> Kansho
>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

Tested on several mt8183 models

>
> Changes in v3:
> - Use audio-controller as the audio node instead.
>
> Changes in v2:
> - Changed to the dual license GPL + MIT.
>
> Kansho Nishida (2):
>   arm64: dts: mt8183: add audio node
>   arm64: dts: mt8183: add kukui platform audio node
>
>  arch/arm64/boot/dts/mediatek/mt6358.dtsi      |  1 +
>  .../mt8183-kukui-audio-da7219-max98357a.dtsi  | 13 +++
>  .../mt8183-kukui-audio-da7219-rt1015p.dtsi    | 13 +++
>  .../mediatek/mt8183-kukui-audio-da7219.dtsi   | 54 +++++++++++
>  .../mt8183-kukui-audio-max98357a.dtsi         | 13 +++
>  .../mediatek/mt8183-kukui-audio-rt1015p.dtsi  | 13 +++
>  ...mt8183-kukui-audio-ts3a227e-max98357a.dtsi | 13 +++
>  .../mt8183-kukui-audio-ts3a227e-rt1015p.dtsi  | 13 +++
>  .../mediatek/mt8183-kukui-audio-ts3a227e.dtsi | 32 +++++++
>  .../mediatek/mt8183-kukui-jacuzzi-burnet.dts  |  1 +
>  .../mediatek/mt8183-kukui-jacuzzi-damu.dts    |  1 +
>  .../mediatek/mt8183-kukui-jacuzzi-fennel.dtsi |  1 +
>  .../mt8183-kukui-jacuzzi-juniper-sku16.dts    |  1 +
>  .../mediatek/mt8183-kukui-jacuzzi-kappa.dts   |  1 +
>  .../mediatek/mt8183-kukui-jacuzzi-kenzo.dts   |  1 +
>  .../mt8183-kukui-jacuzzi-willow-sku0.dts      |  1 +
>  .../mt8183-kukui-jacuzzi-willow-sku1.dts      |  1 +
>  .../boot/dts/mediatek/mt8183-kukui-kakadu.dts |  1 +
>  .../dts/mediatek/mt8183-kukui-kodama.dtsi     |  1 +
>  .../boot/dts/mediatek/mt8183-kukui-krane.dtsi |  5 +
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 67 ++++++++++++-
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 94 ++++++++++++++++++-
>  22 files changed, 336 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-max98357a.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219-rt1015p.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-max98357a.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-rt1015p.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-max98357a.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e-rt1015p.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-ts3a227e.dtsi
>
> --
> 2.32.0.93.g670b81a890-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
