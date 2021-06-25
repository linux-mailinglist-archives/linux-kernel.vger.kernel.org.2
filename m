Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5513B4ADD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 01:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFYXYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 19:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhFYXYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 19:24:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F21906194B;
        Fri, 25 Jun 2021 23:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624663306;
        bh=E8jAfVUJB6TzVURJo+kpSr0AUCgn6UTEIehIezltKdU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=p8Xjhy+4yQgeG5YlTRv92TZvPhnNOzHG2MJCQuVZRpNwQ+DDA/Q0y6wDeuJxoEQ8n
         cxW/x8FrAO+mY7p6UPi+7MJPLrp/g7DIPIGovOSvdC/FL1vSEj67QrmU8mNC+HHLYL
         iU5Vdx0yn2Cvbh1yZzXJYB5Gt4dvz0vK+F/rGlJ+31OQ43Aq+yBLbDYegJzPS2U+xS
         Iv2Stau90rBjDJm3DUkHTjhNhJfQHUpBtNlrsbAfOs7QCSV1lhU7pR0a+8zA38OYYx
         L/t15ESoWoQgppBiEEEQ5R1QnUc2YSJmoGgXJFUhSNdGHSZcRj44bWm8iBxMfClcID
         Srp4xigOXk3Gg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210624121633.22179-2-rajan.vaja@xilinx.com>
References: <20210624121633.22179-1-rajan.vaja@xilinx.com> <20210624121633.22179-2-rajan.vaja@xilinx.com>
Subject: Re: [PATCH v5 1/4] clk: zynqmp: Use firmware specific common clock flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, kristo@kernel.org,
        lee.jones@linaro.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, quanyang.wang@windriver.com
Date:   Fri, 25 Jun 2021 16:21:43 -0700
Message-ID: <162466330370.3259633.11293469583164120084@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2021-06-24 05:16:30)
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index db8d0d7161ce..af06a195ec46 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -271,6 +271,34 @@ static int zynqmp_pm_clock_get_topology(u32 clock_id=
, u32 index,
>         return ret;
>  }
> =20
> +unsigned long zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag)
> +{
> +       unsigned long ccf_flag =3D 0;
> +
> +       if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_GATE)
> +               ccf_flag |=3D CLK_SET_RATE_GATE;
> +       if (zynqmp_flag & ZYNQMP_CLK_SET_PARENT_GATE)
> +               ccf_flag |=3D CLK_SET_PARENT_GATE;
> +       if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_PARENT)
> +               ccf_flag |=3D CLK_SET_RATE_PARENT;
> +       if (zynqmp_flag & ZYNQMP_CLK_IGNORE_UNUSED)
> +               ccf_flag |=3D CLK_IGNORE_UNUSED;
> +       if (zynqmp_flag & ZYNQMP_CLK_GET_RATE_NOCACHE)
> +               ccf_flag |=3D CLK_GET_RATE_NOCACHE;

Does the firmware really use all these flags? Ideally we get rid of the
above two.

> +       if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_NO_REPARENT)
> +               ccf_flag |=3D CLK_SET_RATE_NO_REPARENT;
> +       if (zynqmp_flag & ZYNQMP_CLK_GET_ACCURACY_NOCACHE)
> +               ccf_flag |=3D CLK_GET_ACCURACY_NOCACHE;
> +       if (zynqmp_flag & ZYNQMP_CLK_RECALC_NEW_RATES)
> +               ccf_flag |=3D CLK_RECALC_NEW_RATES;

And this one.

> +       if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_UNGATE)
> +               ccf_flag |=3D CLK_SET_RATE_UNGATE;
> +       if (zynqmp_flag & ZYNQMP_CLK_IS_CRITICAL)
> +               ccf_flag |=3D CLK_IS_CRITICAL;

And this one.

I worry that supporting all these flags will mean we can never get rid
of them. And we currently don't support setting critical via DT, which
is essentially another firmware interface like this one.

> +
> +       return ccf_flag;
> +}
> +
>  /**
>   * zynqmp_clk_register_fixed_factor() - Register fixed factor with the
>   *                                     clock framework
