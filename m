Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D453A1F85
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFIV7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhFIV7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:59:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01D98613E1;
        Wed,  9 Jun 2021 21:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623275833;
        bh=Nva9dJOIzou9W6SY4+kOJ674m0AeGwwgJ3pNhVOrx7I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=i4I51SNuWCD+R2TtKFIegvCs+kBz57AoLjDXnrWyiSWOmseunyJOYNVXiUa0M+WSq
         hf0PQiuW1LBw8pbY7jGgv1XcTEZtBntCUIJS+Srje9Ug7QkFYR1GQoJFolWIzZ1T/V
         Dy3hx8N0ADqdXsds7RFIbEKizEKLR8zPiSg6hVILOFLXjlOeiGrWypPWWiNmiRFi+v
         aIeApiKjp1W+BX+6e8aydLEuO6TB+AtN2mOIIhhImMXwNm55ZeAk3tZ1bGAtW9hMyI
         GX9pTezAXI9MnYcJdRqbjUOLqzsreq4g8RAAaZP9Ye+LhCJeXnrHG/iAIizoG/As3c
         SYsu7hXYDfMWA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210602084259.1267768-1-yukuai3@huawei.com>
References: <162262008540.4130789.916741380026683860@swboyd.mtv.corp.google.com> <20210602084259.1267768-1-yukuai3@huawei.com>
Subject: Re: [PATCH V2] clk: socfpga: err out if of_clk_add_provider() failed in __socfpga_pll_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
To:     Yu Kuai <yukuai3@huawei.com>, dinguyen@kernel.org,
        mturquette@baylibre.com
Date:   Wed, 09 Jun 2021 14:57:11 -0700
Message-ID: <162327583172.9598.16259717139406297542@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yu Kuai (2021-06-02 01:42:59)
> __socfpga_pll_init() should fail if of_clk_add_provider() failed.
> remove 'rc' in the meantime to avoid gcc
> '-Wunused-but-set-variable' warning.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---

Please don't send as in-reply-to previous patches. Makes it hard for me
to find them on the list.

> changes in V2:
>  - remove 'rc' and use err' instead of 'rc'
>  - err out if of_clk_add_provider() failed
>=20
>  drivers/clk/socfpga/clk-pll.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
> index dcb573d44034..5a9eec2eca80 100644
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
> @@ -110,12 +109,16 @@ static __init struct clk_hw *__socfpga_pll_init(str=
uct device_node *node,
>         hw_clk =3D &pll_clk->hw.hw;
> =20
>         err =3D clk_hw_register(NULL, hw_clk);
> -       if (err) {
> -               kfree(pll_clk);
> -               return ERR_PTR(err);
> -       }
> -       rc =3D of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
> +       if (err)
> +               goto err_out;
> +       err =3D of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
> +       if (err)

Now we don't unregister the clk on failure? Can you use
of_clk_add_hw_provider() as well? That would make this more modern. It
can be done as a followup patch to this one.

> +               goto err_out;
>         return hw_clk;
> +
> +err_out:
> +       kfree(pll_clk);
> +       return ERR_PTR(err);
>  }
