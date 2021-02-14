Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1495431B286
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 21:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhBNUtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 15:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhBNUtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 15:49:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DAB064E10;
        Sun, 14 Feb 2021 20:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613335701;
        bh=YCDgrMmMEQRKaIw3p1f9TDxO94Yx2dVNQ1+mCo/Ju2I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Cgbhi/lKIiv2sKGb6wTfEPgjH8dxoTn51df3rOt0+ph6mvQNabv6TRicNnbr2iQwZ
         6dH5FmlfPDQTjWT5j68DWyYUZ208ijSsrN3DqnGXEgeK8ZmAHA86hrFs90b4IORpkL
         8PhKpLwdJpBRsoQcnBKAviEAEvCAMfOCbxgHTsr1eUUjzVurxzcvhmRaGUuKaA+dFc
         WDG6/CNp2bKCcqnfaA2gUWXIgWBai+eJWgdOG8T69FTzgOD0JQI377hQCSS0tpPlD8
         Mux5KZrVCSa5dsJkOGZy1ymm9XRnpb0lsM4jUV8WSeQQmCnq3S22VCAkkgfpoBQqnL
         VL1GCrQJosh4w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210211052206.2955988-5-daniel@0x0f.com>
References: <20210211052206.2955988-1-daniel@0x0f.com> <20210211052206.2955988-5-daniel@0x0f.com>
Subject: Re: [PATCH v2 4/7] clk: mstar: MStar/SigmaStar MPLL driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
To:     Daniel Palmer <daniel@0x0f.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Sun, 14 Feb 2021 12:48:20 -0800
Message-ID: <161333570036.1254594.12678747655338761485@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Palmer (2021-02-10 21:22:03)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 85856cff506c..a29c15444d0e 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -379,6 +379,7 @@ source "drivers/clk/ingenic/Kconfig"
>  source "drivers/clk/keystone/Kconfig"
>  source "drivers/clk/mediatek/Kconfig"
>  source "drivers/clk/meson/Kconfig"
> +source "drivers/clk/mstar/Kconfig"
>  source "drivers/clk/mvebu/Kconfig"
>  source "drivers/clk/qcom/Kconfig"
>  source "drivers/clk/renesas/Kconfig"
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index dbdc590e7de3..7fed7e5944cd 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -95,6 +95,7 @@ obj-$(CONFIG_MACH_PIC32)              +=3D microchip/
>  ifeq ($(CONFIG_COMMON_CLK), y)
>  obj-$(CONFIG_ARCH_MMP)                 +=3D mmp/
>  endif
> +obj-$(CONFIG_ARCH_MSTARV7)             +=3D mstar/
>  obj-y                                  +=3D mvebu/
>  obj-$(CONFIG_ARCH_MXS)                 +=3D mxs/
>  obj-$(CONFIG_COMMON_CLK_NXP)           +=3D nxp/
> diff --git a/drivers/clk/mstar/Kconfig b/drivers/clk/mstar/Kconfig
> new file mode 100644
> index 000000000000..23765edde3af
> --- /dev/null
> +++ b/drivers/clk/mstar/Kconfig
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config MSTAR_MSC313_MPLL
> +       bool
> +       select REGMAP
> +       select REGMAP_MMIO

BTW, it would be nice to expose this driver to compile testing instead
of putting it behind ARCH_MSTARTV7. Can we have this patch?

---8<---
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 7fed7e5944cd..e5e23a44fbe9 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -95,7 +95,7 @@ obj-$(CONFIG_MACH_PIC32)		+=3D microchip/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+=3D mmp/
 endif
-obj-$(CONFIG_ARCH_MSTARV7)		+=3D mstar/
+obj-y					+=3D mstar/
 obj-y					+=3D mvebu/
 obj-$(CONFIG_ARCH_MXS)			+=3D mxs/
 obj-$(CONFIG_COMMON_CLK_NXP)		+=3D nxp/
diff --git a/drivers/clk/mstar/Kconfig b/drivers/clk/mstar/Kconfig
index 23765edde3af..adac76f60f3e 100644
--- a/drivers/clk/mstar/Kconfig
+++ b/drivers/clk/mstar/Kconfig
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config MSTAR_MSC313_MPLL
-	bool
-	select REGMAP
+	bool "MStar MPLL driver"
+	depends on ARCH_MSTARV7 || COMPILE_TEST
+	default ARCH_MSTARV7
 	select REGMAP_MMIO
