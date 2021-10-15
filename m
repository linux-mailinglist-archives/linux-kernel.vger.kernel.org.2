Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936FA42FD65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 23:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbhJOV3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 17:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243057AbhJOV3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:29:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04C9660F36;
        Fri, 15 Oct 2021 21:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634333227;
        bh=dMAxjYXYMkKaHmAh6bSmJDsaAoZcAPf9FXj9DHK0xGc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qevXXEhpqVyvZ/n/fO7P9cQEp8zXn69UkBOSGTXaFmLGGCNwJqhxfW9luairtbPo6
         L2jZg5RgwFC5du9ZEUkPvLOJI7MyoduVbFl/fe1zOShqWbj4NxLS/ZSXZ3xOSuvhGF
         jVBWw5OTOd6bLOzQletvvUQf4gwRl24C4Li0D24XE1AVMCKUEmP4heSEVA+3Ldb/eo
         DIkR25++Uf64xWP2empoxfkpqu5p84U1acVIayy89C0uH/AxFwwRk4lhgh6znkKjOJ
         wyIQ0uGfuVvDKvJcJvitJpJU90yGMne/EkN75oKILmqkxWdRQAucWBlk0kYKi3qBIe
         aaWmzcyeJfo3w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211015120559.3515645-1-martin.blumenstingl@googlemail.com>
References: <163425193558.1688384.15520943968787313145@swboyd.mtv.corp.google.com> <20211015120559.3515645-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] clk: composite: Also consider .determine_rate for rate + mux composites
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     heiko@sntech.de, knaerzche@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        martin.blumenstingl@googlemail.com
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Oct 2021 14:27:05 -0700
Message-ID: <163433322577.1688384.5988903670868801272@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-10-15 05:05:59)
> Commit 69a00fb3d69706 ("clk: divider: Implement and wire up
> .determine_rate by default") switches clk_divider_ops to implement
> .determine_rate by default. This breaks composite clocks with multiple
> parents because clk-composite.c does not use the special handling for
> mux + divider combinations anymore (that was restricted to rate clocks
> which only implement .round_rate, but not .determine_rate).
>=20
> Alex reports:
>   This breaks lot of clocks for Rockchip which intensively uses
>   composites,  i.e. those clocks will always stay at the initial parent,
>   which in some cases  is the XTAL clock and I strongly guess it is the
>   same for other platforms,  which use composite clocks having more than
>   one parent (e.g. mediatek, ti ...)
>=20
>   Example (RK3399)
>   clk_sdio is set (initialized) with XTAL (24 MHz) as parent in u-boot.
>   It will always stay at this parent, even if the mmc driver sets a rate
>   of  200 MHz (fails, as the nature of things), which should switch it
>   to   any of its possible parent PLLs defined in
>   mux_pll_src_cpll_gpll_npll_ppll_upll_24m_p (see clk-rk3399.c)  - which
>   never happens.
>=20
> Restore the original behavior by changing the priority of the conditions
> inside clk-composite.c. Now the special rate + mux case (with rate_ops
> having a .round_rate - which is still the case for the default
> clk_divider_ops) is preferred over rate_ops which have .determine_rate
> defined (and not further considering the mux).
>=20
> Fixes: 69a00fb3d69706 ("clk: divider: Implement and wire up .determine_ra=
te by default")
> Reported-by: Alex Bee <knaerzche@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Re-sending this as inline patch instead of attaching it.
>=20
>  drivers/clk/clk-composite.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index 0506046a5f4b..510a9965633b 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -58,11 +58,8 @@ static int clk_composite_determine_rate(struct clk_hw =
*hw,
>         long rate;
>         int i;
> =20
> -       if (rate_hw && rate_ops && rate_ops->determine_rate) {
> -               __clk_hw_set_clk(rate_hw, hw);
> -               return rate_ops->determine_rate(rate_hw, req);
> -       } else if (rate_hw && rate_ops && rate_ops->round_rate &&
> -                  mux_hw && mux_ops && mux_ops->set_parent) {
> +       if (rate_hw && rate_ops && rate_ops->round_rate &&
> +           mux_hw && mux_ops && mux_ops->set_parent) {

What do we do if rate_ops and mux_ops only implement determine_rate? It
will fail right? We can't mesh them together in function. We should
probably fail to let the composite clk be registered if that happens.

>                 req->best_parent_hw =3D NULL;
> =20
>                 if (clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT) {
> @@ -107,6 +104,9 @@ static int clk_composite_determine_rate(struct clk_hw=
 *hw,
> =20
>                 req->rate =3D best_rate;
>                 return 0;
> +       } else if (rate_hw && rate_ops && rate_ops->determine_rate) {
> +               __clk_hw_set_clk(rate_hw, hw);
> +               return rate_ops->determine_rate(rate_hw, req);
>         } else if (mux_hw && mux_ops && mux_ops->determine_rate) {
>                 __clk_hw_set_clk(mux_hw, hw);
>                 return mux_ops->determine_rate(mux_hw, req);
> --=20
> 2.33.0
>
