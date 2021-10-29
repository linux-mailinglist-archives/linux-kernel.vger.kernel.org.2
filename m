Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4688B43F765
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhJ2Go2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhJ2Go1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50FB0610E8;
        Fri, 29 Oct 2021 06:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635489719;
        bh=RqcDgWOw64d0pQuH853Ovh8UGaEQ5JIaYpuoL87dGGY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=M3uw2Y/Pb9Zd9tzeK/vEm4A3hEUCUptjov3lifcwStDhm0MoUnLJ+WyFXOaG3pXSQ
         d5caAP+YahWE5x+mlLhguArmyPlcMbZtpdUJqGn3AC3KpdJ8hbB+GpRsToQu+FRtnd
         SC9rLAHfF92MxUXmuv+fJKQUbzxAQ32BFQs7gip/xp8/0xtFMU1cYSNW0hJ6dPG5oT
         YgGdDSI16xq3liZlTmBiAW678BVWMZkfWeJm3CaRXtyUFQxB/V6sa6KE6Ao+QRLkXa
         7D/Auf7ZIITbLDFLd94vJyr4EbWUkDJ13kxMxsKzYSw99Fw1M32/uLUqDo29sV6QTd
         ggPZYDaVWVWdw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211019084449.1411060-4-horatiu.vultur@microchip.com>
References: <20211019084449.1411060-1-horatiu.vultur@microchip.com> <20211019084449.1411060-4-horatiu.vultur@microchip.com>
Subject: Re: [RFC PATCH 3/3] clk: lan966x: Extend lan966x clock driver for clock gating support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     nicolas.ferre@microchip.com, kavyasree.kotagiri@microchip.com,
        eugen.hristev@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Thu, 28 Oct 2021 23:41:57 -0700
Message-ID: <163548971798.15791.952778566228263608@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Horatiu Vultur (2021-10-19 01:44:49)
> diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
> index 19bec94e1551..40be47092a31 100644
> --- a/drivers/clk/clk-lan966x.c
> +++ b/drivers/clk/clk-lan966x.c
> @@ -188,26 +202,64 @@ static struct clk_hw *lan966x_gck_clk_register(stru=
ct device *dev, int i)
>         return &priv->hw;
>  };
> =20
> +static int lan966x_gate_clk_register(struct device *dev,
> +                                    struct clk_hw_onecell_data *hw_data,
> +                                    void __iomem *gate_base)
> +{
> +       int i;
> +
> +       for (i =3D GCK_GATE_UHPHS; i < N_CLOCKS; ++i) {
> +               int idx =3D i - GCK_GATE_UHPHS;
> +
> +               hw_data->hws[i] =3D
> +                       clk_hw_register_gate(dev, clk_gate_desc[idx].name,

Use devm?

> +                                            "lan966x", 0, base,
> +                                            clk_gate_desc[idx].bit_idx,
> +                                            0, &clk_gate_lock);
> +
> +               if (IS_ERR(hw_data->hws[i]))
> +                       return dev_err_probe(dev, PTR_ERR(hw_data->hws[i]=
),
> +                                            "failed to register %s clock=
\n",
> +                                            clk_gate_desc[idx].name);
> +       }
> +
> +       return 0;
> +}
> +
> +static void lan966x_gate_clk_unregister(struct clk_hw_onecell_data *hw_d=
ata)
> +{
> +       int i;
> +
> +       for (i =3D GCK_GATE_UHPHS; i < N_CLOCKS; ++i)

for (int i =3D=20

should suffice

> +               if (!IS_ERR(hw_data->hws[i]))
> +                       clk_hw_unregister(hw_data->hws[i]);
> +}
> +
