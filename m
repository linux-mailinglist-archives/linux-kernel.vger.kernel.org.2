Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9D396956
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 23:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhEaVl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhEaVl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 17:41:28 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33922C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 14:39:48 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso5331731otu.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBAqPc0844PoWS3M7cf9GbxSOhoga0pQoriulkgqEfI=;
        b=VUhxW2pyepgF1UbJULY3i80Z7aTZ03X4+C9wxowTbK/qTQIQxtmmbv+6XpGF39gU8X
         SOJk8buqMEKMC0eiPr16TX7/g9SStnxfNL4m5MMTm95wa6cyDkvvXgx7P7DPjuwH+wyj
         6y+Afd4I5e96U3c19zRoSQmPaOuBEcjqfGIUZhbiWrT30DjRTUosV7J8Fq3sny0zilbe
         RQtX97qrgZ9okAs+v7ZSmepehw4RuilIzG5rA7uLUj42inWsaC2fXZIKFyzG7xIkAQCM
         O8BDOpr4mXJXNVLROiwbITssFmAeFOqK54Cr89PAsiwP5Ml3vbEj48LM0RNGxPNNDrXU
         hldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBAqPc0844PoWS3M7cf9GbxSOhoga0pQoriulkgqEfI=;
        b=nbXP8taecz1MKAsdxcJGECYjT1muZEHpzjEy2q6iyG7g79KK5Qd2XvbvJhObTgwJxc
         NwCvlQcFAk7RThejUEtPX/s5bllW1RLo0uu63UggOtXN7511ugbX7Td6xDOU2ln0qyvm
         yiaoWGbWZ/3SAN3/Q5pEmUCF+Nb9f+j7Vd2e3G+NJws4Q2zNX52rXvNsTxB90YLwKlQ7
         X22YIxJD5KmzM6EP2TqOB9xK9qu1rbB/SBrcgLniO3R1gdxIXcUDvPiJ8UkSo2MHp5ps
         7yLL8Uq2TqhxPPhsmJZlh0zNVKYrRLsL9pf5vISPhix63vVv104vehdpK4dZvs1YLuKc
         xdpQ==
X-Gm-Message-State: AOAM532dJO8v4WwiwDDf5OvylTfYfHYA+O8zMI81cw2mUGqdihfJzVI2
        26VFGcynpKcD1ZXw3EHwCD6QIfjHwKOfR7KmvTE=
X-Google-Smtp-Source: ABdhPJyjzicDYy8DtErVQRQGm+5j16c6SZMMwzcmDJRbeRntyIHK9Eht8sVCld0S38tB3hX9pMWfM4d+dX3FsATtJHY=
X-Received: by 2002:a9d:7a9:: with SMTP id 38mr9579203oto.362.1622497187649;
 Mon, 31 May 2021 14:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210531043502.2702645-1-hsinyi@chromium.org> <20210531043502.2702645-3-hsinyi@chromium.org>
In-Reply-To: <20210531043502.2702645-3-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 31 May 2021 23:39:35 +0200
Message-ID: <CAFqH_53DWQVRVHVr8EVSR6A2oVqC4_4VjkE6n77g5kfBaa2+4A@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: mt8183: remove syscon from smi_common node
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chun-jie.chen@mediatek.corp-partner.google.com,
        Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

(again without html, sorry for the noise)

Thank you for the patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dl., 31 de maig
2021 a les 6:36:
>
> We don't need to register smi_common as syscon. Also add required
> property power-domains for this node.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index c5e822b6b77a..e074c0d402ff 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1263,13 +1263,14 @@ larb0: larb@14017000 {
>                 };
>
>                 smi_common: smi@14019000 {
> -                       compatible = "mediatek,mt8183-smi-common", "syscon";
> +                       compatible = "mediatek,mt8183-smi-common";
>                         reg = <0 0x14019000 0 0x1000>;
>                         clocks = <&mmsys CLK_MM_SMI_COMMON>,
>                                  <&mmsys CLK_MM_SMI_COMMON>,
>                                  <&mmsys CLK_MM_GALS_COMM0>,
>                                  <&mmsys CLK_MM_GALS_COMM1>;
>                         clock-names = "apb", "smi", "gals0", "gals1";
> +                       power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
>                 };
>
>                 imgsys: syscon@15020000 {
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
