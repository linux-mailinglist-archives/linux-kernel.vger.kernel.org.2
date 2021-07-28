Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FE83D87BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhG1GOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbhG1GOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:14:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5048CC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:14:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so8454607pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+eCPJolnjFD6s7o/D7/wCD8S3LJbNwZNkFAhDgmHNdg=;
        b=mR4Tt7DzUQaHNxHJQDGkFhLLLljZDCuHSLxVhBOpom3iS+QI99MjDfopHJ9XmURL/i
         bCugbreHHQ0xBU095vg6uHwXTSdQsTKtVFGvhxCtiLbvzN8yaKuepp0M9CeZxG8Nr3Zq
         /Qe7l6ARfY6A59sOduR69WOdWo96M4zLL4GRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+eCPJolnjFD6s7o/D7/wCD8S3LJbNwZNkFAhDgmHNdg=;
        b=LJy6EC0g3X2GoESAjCUx14gpVJMIrK5De/ST+7o8xGO14jCHyorhJ6GNkGYoH57qaR
         4uy5jKu5Vh/F9a/ogZdy3yXYGiQ2D/+y+F6XHFC3SozQIJNBBYq4SjFjmFEs4Yvcd3Gt
         fbLsJeDg2V6PQ5IPIvcvEw7nNFmOv5cL4CvSVCRDli28c4F54u5X3Dbb2IAggwquclxj
         tYKmbMWPRaoL4iuC8KcC1tUG1l1koenZl48wldFxh2+Hm7aWU4rPRoZYjcrfG2KgJH6a
         hMl7za7Jj1zCqdjFa2mQMZmRd4iWl5TpKY+RfKmqSGeEdqnnVaH/1ZR8lTkZYpHi9Geu
         jUgg==
X-Gm-Message-State: AOAM5326FB4rgz/QV+Hm875k3TbT+T/ub1DBvy/8lvquxK0OLgT8ikM2
        a7ONkjEKbx2ijxNfrzHjekAOS4iikMrpTv2kUn2rTw==
X-Google-Smtp-Source: ABdhPJzmByxKqYRSbuErkA4p8ANUorSkgXNNWkdhJmCqT7YsTx5hk209/4gRAztv7igdNUaEYtPZLsDig5mlURlglKQ=
X-Received: by 2002:a63:8f04:: with SMTP id n4mr26845226pgd.317.1627452868772;
 Tue, 27 Jul 2021 23:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210727023205.20319-1-chun-jie.chen@mediatek.com> <20210727023205.20319-3-chun-jie.chen@mediatek.com>
In-Reply-To: <20210727023205.20319-3-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 28 Jul 2021 14:14:17 +0800
Message-ID: <CAATdQgC-X6pijkgTBsWJJKp__J6N=7JNKHQJmOMvTAjivwPM5w@mail.gmail.com>
Subject: Re: [v6 2/2] arm64: dts: mediatek: Correct UART0 bus clock of MT8192
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 27, 2021 at 10:43 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> infra_uart0 clock is the real one what uart0 uses as bus clock.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index c7c7d4e017ae..9810f1d441da 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -327,7 +327,7 @@
>                                      "mediatek,mt6577-uart";
>                         reg = <0 0x11002000 0 0x1000>;
>                         interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>;
> -                       clocks = <&clk26m>, <&clk26m>;
> +                       clocks = <&clk26m>, <&infracfg CLK_INFRA_UART0>;
>                         clock-names = "baud", "bus";
>                         status = "disabled";
>                 };

There're many other nodes still having only clk26m. Will you update them too?

> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
