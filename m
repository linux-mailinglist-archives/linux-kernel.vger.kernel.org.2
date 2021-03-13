Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9460333A19D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 23:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhCMWZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 17:25:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234753AbhCMWZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 17:25:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BA0E64EC9;
        Sat, 13 Mar 2021 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615674316;
        bh=XNgqaZ2i3/Zjc4Q3m1D1qEEm/vTGTGwUoIYDh1YUMx4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VvS7SMUhIcP5DmSLkgLps5Ohia0lLPsz77zbFIk3XrvkVYiEPHBT1DqRACuwnF26y
         RO9O8Mi9zGLMIDe2esJfAAlZMjUcwg8QsI8MGyexqtUNT6Vr/Yur5NNFO72lbkHckx
         v2JRpwd4EHYq+CqcZAAYlpXUzj5Tbrr9k8Iq3HOczddpzgWOgGOczAeuFisWNbJfJI
         9MSFU71NOWA+yIHk7Z7AksXNpmI8pDl7HumYSEJmI+zLmzkkSAbQ03apJVZ0U+0rFh
         pc7+OBsOwNwUogvOR94nkUa53IchUwZc9vmBbqah78+ISFv10Qqmr9QXj5RQoy5JaU
         pF9ZQ8ehXr/Zg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210301064749.10392-5-zhangqing@rock-chips.com>
References: <20210301064749.10392-1-zhangqing@rock-chips.com> <20210301064749.10392-5-zhangqing@rock-chips.com>
Subject: Re: [PATCH v3 4/4] clk: rockchip: add clock controller for rk3568
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Sat, 13 Mar 2021 14:25:15 -0800
Message-ID: <161567431517.1478170.18210364268176534887@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elaine Zhang (2021-02-28 22:47:49)
> Add the clock tree definition for the new rk3568 SoC.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/clk/rockchip/Kconfig      |    7 +
>  drivers/clk/rockchip/Makefile     |    1 +
>  drivers/clk/rockchip/clk-rk3568.c | 1726 +++++++++++++++++++++++++++++
>  drivers/clk/rockchip/clk.h        |   30 +-
>  4 files changed, 1763 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/rockchip/clk-rk3568.c
>=20
> diff --git a/drivers/clk/rockchip/Kconfig b/drivers/clk/rockchip/Kconfig
> index effd05032e85..2e31901f4213 100644
> --- a/drivers/clk/rockchip/Kconfig
> +++ b/drivers/clk/rockchip/Kconfig
> @@ -85,4 +85,11 @@ config CLK_RK3399
>         default y
>         help
>           Build the driver for RK3399 Clock Driver.
> +
> +config CLK_RK3568
> +       tristate "Rockchip RK3568 clock controller support"
> +       depends on (ARM64 || COMPILE_TEST)

Drop parenthesis please.

> +       default y
> +       help
> +         Build the driver for RK3568 Clock Driver.
>  endif
> diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk=
-rk3568.c
> new file mode 100644
> index 000000000000..60913aa91897
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-rk3568.c
> @@ -0,0 +1,1726 @@
[...]
> +};
> +builtin_platform_driver_probe(clk_rk3568_driver, clk_rk3568_probe);
> +
> +MODULE_DESCRIPTION("Rockchip RK3568 Clock Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:clk-rk3568");

I think module alias does nothing?
