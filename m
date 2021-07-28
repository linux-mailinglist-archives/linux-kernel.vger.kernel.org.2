Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB203D8642
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 05:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhG1Dvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 23:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhG1Dvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 23:51:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73BEC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 20:51:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f12so1440961ljn.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 20:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPiFfQJ2xtTLnyk6Fk4XG5GeGV4EVc1tB7y8d6OKc1k=;
        b=CMH3lDIxw0ApJq8MbTN7wpeHcbI0wKpG+rv+G9q7EMMsNfIYa7vfGBD/zFBcglKwY7
         0aikxbaN2vYUDBqiDcGTqfslu/fjCteLT40QMxNONyKvmnjjtnYJ+iXiMQobLSn0Oqgp
         qfveUsNA9LLalicPs0E33qz1lBrucqDUCI/OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPiFfQJ2xtTLnyk6Fk4XG5GeGV4EVc1tB7y8d6OKc1k=;
        b=hEBYJO73GUzJBO7DjECOc8zn4ssxOIjO0XfYncWCypV/AY8o8MBXFPzb4DvsgxioUl
         N3VkEoxRIbuyWVUceo/j30eyKFjp7romNZ/sMcrNRYnUVj2+qDIO9sKCTw/IP+4sYvX0
         Q7uK2vZFc4YQYiXNCJCrf1/0pfA1xs0UdSYf9wSuaUd2tFA4PZqiTPjdH8gInF0FNGfX
         faAJyziSkx5vonfvEvBpZx4WNzVDJ1XSyhryVwi66eTvNDHlr+vns0wPsK/217ZiUl61
         dxWav1OCa3jYBMZJm9nyMaEZZUuJqbdmslqVkw047HV4Ggg+T/WT1X/JBPIpBsFRIDZ3
         Wfrw==
X-Gm-Message-State: AOAM530O+WTx46FKshAdOX8B+f5/mdVRGgLtEuWHyNn8r//QLpAWizI1
        wZ3uvUbitjK8ZUDCDSdrTJz/EZQ9HEMN1xpmstEERg==
X-Google-Smtp-Source: ABdhPJzLWnYQVyj6OrEVmREn7Y+WP6t6ZFo2i0yfvhdDJ2Xe5swRDPGFoXEtohPBSMwNRt/CiJ6vviRwAgzc+JKy/As=
X-Received: by 2002:a2e:9215:: with SMTP id k21mr18526007ljg.91.1627444305147;
 Tue, 27 Jul 2021 20:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210727112208.2508675-1-hsinyi@chromium.org> <20210727112208.2508675-2-hsinyi@chromium.org>
In-Reply-To: <20210727112208.2508675-2-hsinyi@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 28 Jul 2021 11:51:34 +0800
Message-ID: <CAGXv+5Hua63GZ839kQEscAXBeKPYTv_63E2pYNBw4jXz1B_PWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mt8173: elm: Use aliases to mmc nodes
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The subject for this patch wasn't tagged with v3. This might cause some
issues with scripted tooling.

On Tue, Jul 27, 2021 at 7:22 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> fa2d0aa96941 ("mmc: core: Allow setting slot index via device tree alias")
> allows the use of aliases to number SD/MMC slots. This patch use aliases
> to mmc nodes so the partition name for eMMC and SD card will be consistent
> across boots.

Device trees are supposed to be a description of the hardware and
therefore should be implementation agnostic. The commit logs should be
the same, unless the implementation details influenced the changes made.

The MMC binding change already specified that aliases provide a way to
assign fixed mmcN indices, so the log should reference the binding
change commit instead.

ChenYu

> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> v2->v3: add more commit message.
> ---
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index 21452c51a20a8..d5a2cad39c9c7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -10,6 +10,12 @@
>  #include "mt8173.dtsi"
>
>  / {
> +       aliases {
> +               mmc0 = &mmc0;
> +               mmc1 = &mmc1;
> +               mmc2 = &mmc3;
> +       };
> +
>         memory@40000000 {
>                 device_type = "memory";
>                 reg = <0 0x40000000 0 0x80000000>;
> --
> 2.32.0.432.gabb21c7263-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
