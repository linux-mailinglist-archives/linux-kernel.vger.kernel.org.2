Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0979242E4CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 01:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhJNXkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 19:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhJNXky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 19:40:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88462610E8;
        Thu, 14 Oct 2021 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634254728;
        bh=aVqFZD1P3BnkHwqRQL+4JSpXieHqq3UKeC55NR53YzU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tHaFXsxQ+CrVSJGuJHB8wMU3gDUbkO0mAyi8FXACBuXgk9d7AC6voWY5UoghWgh4u
         ttSzBuC7VIDr/sML9Ha7inFNkWj/cp/MmkUnQCxl7foTxt7OccnoLrnzVMoPbpgtWA
         J+D3ULIIs4btDPMdeZzko+LqdKkmIisNSSvz4GYGxV17x1W2AXC9FAkJ9JY2xhRNsO
         BC4y4g0nHOqXl4UAbmBTIxLL3q3NwXFAOBIhoDRkps1ypYmM92KJ90j9olXKZDLLs1
         v8CFE9tWUQkrW+kfbPyepIY+mY1EXeMLwaScV4iO7otCnjyFggry9Oov0ny8+sYoEL
         n5DE2/li1N3XA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211012100132.17829-1-peng.fan@oss.nxp.com>
References: <20211012100132.17829-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] clk: imx: imx8ulp: set suppress_bind_attrs to true
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, abel.vesa@nxp.com,
        mturquette@baylibre.com, s.hauer@pengutronix.de
Date:   Thu, 14 Oct 2021 16:38:47 -0700
Message-ID: <163425472719.1688384.9750007922505848073@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2021-10-12 03:01:32)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Disable bind attributes, the clocks will not removed.

Great! Why?

>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8ulp.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
> index 6699437e17b8..8eb1af2d6429 100644
> --- a/drivers/clk/imx/clk-imx8ulp.c
> +++ b/drivers/clk/imx/clk-imx8ulp.c
> @@ -559,6 +559,7 @@ static struct platform_driver imx8ulp_clk_driver =3D {
>         .probe  =3D imx8ulp_clk_probe,
>         .driver =3D {
>                 .name           =3D KBUILD_MODNAME,
> +               .suppress_bind_attrs =3D true,
>                 .of_match_table =3D imx8ulp_clk_dt_ids,
>         },
>  };
