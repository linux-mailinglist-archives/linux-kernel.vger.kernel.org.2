Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ECF398389
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhFBHtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFBHtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:49:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CE6261042;
        Wed,  2 Jun 2021 07:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622620086;
        bh=nYNnz0THp2276rJuXJQV6x29lBdkN0B8z+v4G8M3IHE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oT4elmBzdnADIjOljvqOOEwR9sEPwA04wKZDoZKqdTMA10wFpJAMWqKLr30iKRt4p
         vosBL87kKGa82Ql1+lR34RLCBZuSoAwd4cN4jy2oppmBG2C7XXhNYtmCn+whzh55yk
         mzohRNLhVvDSCWmoSJw9y78ICz5ai2hGZ1i4rmZKQ1uV/GFPcF0Snmsfp7qWrqT8Oz
         o3VyGiAr4XZHSbtgn1rWSxdQbTwSbX38twgQDgnaJNfggKl7NOOZi1CmjQT9zboum1
         HmCKfeq7fGApC5IbmFLUNYNTd3e/duNEa5J9tKdjqAqLUnMNVypoLxRBh09F26SHe2
         0GTSWcAoa2J+A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210514062234.3534615-1-yukuai3@huawei.com>
References: <20210514062234.3534615-1-yukuai3@huawei.com>
Subject: Re: [PATCH] clk: socfpga: remove set but not used variable 'rc'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
To:     Yu Kuai <yukuai3@huawei.com>, dinguyen@kernel.org,
        mturquette@baylibre.com, s.trumtrar@pengutronix.de
Date:   Wed, 02 Jun 2021 00:48:05 -0700
Message-ID: <162262008540.4130789.916741380026683860@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yu Kuai (2021-05-13 23:22:34)
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/clk/socfpga/clk-pll.c:83:6: warning: variable =E2=80=98rc=E2=80=
=99 set but
> not used [-Wunused-but-set-variable]
>=20
> The returned value of of_clk_add_provider() is never used, and so
> can be removed.
>=20
> Fixes: 97259e99bdc9 ("clk: socfpga: split clk code")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/clk/socfpga/clk-pll.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
> index dcb573d44034..127cc849c5ee 100644
> --- a/drivers/clk/socfpga/clk-pll.c
> +++ b/drivers/clk/socfpga/clk-pll.c
> @@ -80,7 +80,6 @@ static __init struct clk_hw *__socfpga_pll_init(struct =
device_node *node,
>         const char *parent_name[SOCFPGA_MAX_PARENTS];
>         struct clk_init_data init;
>         struct device_node *clkmgr_np;
> -       int rc;
>         int err;
> =20
>         of_property_read_u32(node, "reg", &reg);
> @@ -114,7 +113,7 @@ static __init struct clk_hw *__socfpga_pll_init(struc=
t device_node *node,
>                 kfree(pll_clk);
>                 return ERR_PTR(err);
>         }
> -       rc =3D of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
> +       of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);

Shouldn't we fail if of_clk_add_provider() fails? So return some sort of
error pointer and unwind allocations, etc.

>         return hw_clk;
>  }
>
