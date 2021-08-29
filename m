Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B583FA89C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 06:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhH2EPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 00:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhH2EPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 00:15:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E981060E08;
        Sun, 29 Aug 2021 04:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630210498;
        bh=Qg4wsLXlDpD1zwmlBbHXRGxiCepR2RCY/C5RXovTJYE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=F79Es4jWcaSofx0PWWTDpkY2/fviRSgxhnhtqTkbECFjzGoClSTyA+a9oEQ577Fp8
         fZNx0nYTVEKngO+QSmLnLseUouai/6IK4LPYpnqaXUwsHtm5SiknPrQTeTGYpd3uLd
         Ua2pJArM3EZn/jtl3OnrA91tQsO1RWYQSE4fDa8xfeHx7Mehi7PyK4ioiqzLcRf0Zw
         yY8emlBZKjUfgAekSdJlix2KEC8hoV5kW9M3GskpDUGiqbNRYtfuVz7jZS/Z//EQ9Q
         09fpczCiJOVZ8/G745i57GM4Jp7POE8mXodFz4zLXlWYspBhBeJVJR8s2tnxOuT+YB
         aHCsx0S1WSJhw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210813032429.14715-4-miles.chen@mediatek.com>
References: <20210813032429.14715-1-miles.chen@mediatek.com> <20210813032429.14715-4-miles.chen@mediatek.com>
Subject: Re: [RESEND PATCH 3/4] clk: mediatek: support COMMON_CLK_MT6779 module build
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Miles Chen <miles.chen@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Date:   Sat, 28 Aug 2021 21:14:56 -0700
Message-ID: <163021049667.2676726.10138202396240942833@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2021-08-12 20:24:28)
> diff --git a/drivers/clk/mediatek/clk-mt6779-aud.c b/drivers/clk/mediatek=
/clk-mt6779-aud.c
> index 11b209f95e25..439c0bc94b73 100644
> --- a/drivers/clk/mediatek/clk-mt6779-aud.c
> +++ b/drivers/clk/mediatek/clk-mt6779-aud.c
> @@ -4,6 +4,7 @@
>   * Author: Wendell Lin <wendell.lin@mediatek.com>
>   */
> =20
> +#include <linux/module.h>
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -115,3 +116,4 @@ static struct platform_driver clk_mt6779_aud_drv =3D {
>  };
> =20
>  builtin_platform_driver(clk_mt6779_aud_drv);
> +MODULE_LICENSE("GPL");

How does this work? builtin_platform_driver() means that it's not
modular code. Shouldn't that be module_platform_driver()? Have you tried
loading and unloading the module?
