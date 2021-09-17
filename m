Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2340FE94
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbhIQRXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240958AbhIQRXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:23:33 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70913C061574;
        Fri, 17 Sep 2021 10:22:11 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f22so19681524qkm.5;
        Fri, 17 Sep 2021 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DS0xP8xYymZ1tcfPZLEiyP7J8b0RQSNLGg9up/wgFeY=;
        b=SrbN5eLlNztZuh4yw27f1hAtJyF2l5jW3njLt0N93P3yN52pPJ6c1OMJJBdGzHut5o
         uKgG9JZ/LkoyyMwoEy0EJZ5236Afb0LcYeJIFL2BWNtJVwPMOxo+ibeTFjzHRQmKWrNy
         XpPirElPHqMP+6Flz7oNu3Z/VpIpji/dXZ/91r5HwgMcpyJmKg70mR77eP3LwsbsWtGm
         2QvKqDvlXUNEAJXX74skgnXSSkq+yc27i5vBx2q6rs2wM87wCfadiWk6QL0dvsVSAO/d
         /fe/GRlxVpB1MWoe82uPGLzpS9lP7HKHKs8UM9rXGtThEWWGQHE40rPy9T5ABlQ0C2kM
         xv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DS0xP8xYymZ1tcfPZLEiyP7J8b0RQSNLGg9up/wgFeY=;
        b=T22za9keax7qsz+uzGyrEhoztgFgy/yjcFFeC8jXMCgywc9I6D/y8yq8uyYG4wnfe7
         Uho2TS9H+8TGOJmeud4Rb8lmt2qQBfwtzEXXMIx7fWBb0+gtKLz0niQlLOrTYLJJfLAy
         okJ4ydji2GDNo7c5eluRqEGQCIrd0pm+bI5pVKNWfl58uNLQqHqNqHRWrU6Hi60QANfo
         j5D7mOZgKDC/ElqZG2EJFNbZjU2mbTPvHEO164G4jZM+dnPN1wAFSgoQAMtsKNYRhNlY
         DM1QcgbvU0qY8xjc/DB67ggmifLuHo/SooBb3jG8RpMonMgFcQRJ5iOwy8sM+XHkf3a3
         kKpg==
X-Gm-Message-State: AOAM530on/lIEUnFHCD9HX1rtdOekl+bvKtbmGA1gWkxeku+ek0hFSry
        mTEDRbEfWXY92EP76VezsOPZLr15+SOijd3eaFc=
X-Google-Smtp-Source: ABdhPJxkqBwHQrE1wq7rDENcFORhD2ldxq+J3AFnJcrg9sgfsAmwiUh2FPj62ppjmam3nRnhvxPWzWy86Dg8rtAi4/k=
X-Received: by 2002:a25:af8b:: with SMTP id g11mr16184618ybh.280.1631899330450;
 Fri, 17 Sep 2021 10:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210826123844.8464-1-yifeng.zhao@rock-chips.com>
In-Reply-To: <20210826123844.8464-1-yifeng.zhao@rock-chips.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 17 Sep 2021 13:21:58 -0400
Message-ID: <CAMdYzYpo4mRqMRSF=chp4PhL609FKv_b3HHa0+7=ph2C_DfvuA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3]
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 8:42 AM Yifeng Zhao <yifeng.zhao@rock-chips.com> wrote:
>
> Add Naneng combo PHY support for RK3568
>
> This phy can be used as pcie-phy, usb3-phy, sata-phy or sgmii-phy.

Good Afternoon,

Some feedback on this driver, for when you resend it to the mailing list.
I'm sending this against the cover letter since the mailing list
doesn't have the actual driver.

The driver doesn't work out of the box, you renamed the clocks but
missed one use point.
There's a lot of "magic numbers" that need to be defined.
Configuration could use some cleanup.
A parallel problem, if the PCIe phy fails to probe (because of the
aforementioned clock issue) the PCIe controller hard locks the board
during probe.

I look forward to version two.

Very Respectfully,
Peter Geis

>
>
>
> Yifeng Zhao (3):
>   dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
>   phy/rockchip: add naneng combo phy for RK3568
>   arm64: dts: rockchip: add naneng combo phy nodes for rk3568
>
>  .../phy/phy-rockchip-naneng-combphy.yaml      | 100 +++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  68 ++
>  drivers/phy/rockchip/Kconfig                  |   8 +
>  drivers/phy/rockchip/Makefile                 |   1 +
>  .../rockchip/phy-rockchip-naneng-combphy.c    | 646 ++++++++++++++++++
>  5 files changed, 823 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>
> --
> 2.17.1
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
