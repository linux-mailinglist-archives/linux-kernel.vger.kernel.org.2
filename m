Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8463140A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhBHUiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:38:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236163AbhBHTWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:22:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E960D64DC3;
        Mon,  8 Feb 2021 19:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612812083;
        bh=J+Toa4VghZj+wvqsaR/Th+yW7a2hvMnxN0zHE32Q8rs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IRJjB0RtouhXZNuT9YFz/9r3+iKLyeStKC52O+iBBcv8Tg0oZKDmrRHEXMQn9QdrF
         awbwFt5U7OIUkc9vjqLBVoqamdMw9oBL3No/PY21WQj1mU+XFgsHWXCeF0Y6xFj570
         NqtXT1qL50gf4yhlKw+S9g0hy5L4w0j1mnYsUUf9RTwjkq6sW/e1PM9RiEmkLBWv9d
         9HeBQ7bW81x0Cy10c2hSge2M27r8qNPdBSD8BJ1AFCtf9KIYJwaxWzwAgyX7Zq+zij
         2+vJrsqV2LU4I9nzXviMhjkbmSwwmL8tdl5ahza57mc+5sHUaDieEiJo7/xVYJtDz3
         GxvZoXLPLTkmg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210208121752.2255465-2-jernej.skrabec@siol.net>
References: <20210208121752.2255465-1-jernej.skrabec@siol.net> <20210208121752.2255465-2-jernej.skrabec@siol.net>
Subject: Re: [PATCH v2 1/5] clk: sunxi-ng: mp: fix parent rate change flag check
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, airlied@linux.ie, daniel@ffwll.ch,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Andre Heider <a.heider@gmail.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>, mripard@kernel.org,
        wens@csie.org
Date:   Mon, 08 Feb 2021 11:21:21 -0800
Message-ID: <161281208140.76967.6089044756544560133@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jernej Skrabec (2021-02-08 04:17:48)
> CLK_SET_RATE_PARENT flag is checked on parent clock instead of current
> one. Fix that.
>=20
> Fixes: 3f790433c3cb ("clk: sunxi-ng: Adjust MP clock parent rate when all=
owed")
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Andre Heider <a.heider@gmail.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu_mp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
> index fa4ecb915590..5f40be6d2dfd 100644
> --- a/drivers/clk/sunxi-ng/ccu_mp.c
> +++ b/drivers/clk/sunxi-ng/ccu_mp.c
> @@ -108,7 +108,7 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux=
_internal *mux,
>         max_m =3D cmp->m.max ?: 1 << cmp->m.width;
>         max_p =3D cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
> =20
> -       if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
> +       if (!(clk_hw_get_flags(&cmp->common.hw) & CLK_SET_RATE_PARENT)) {

This is also clk_hw_can_set_rate_parent()

>                 ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p=
);
>                 rate =3D *parent_rate / p / m;
>         } else {
