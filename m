Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422873183F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 04:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBKD3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 22:29:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhBKD3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 22:29:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C62764EB9;
        Thu, 11 Feb 2021 03:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613014100;
        bh=O78AtTThyeCdbILAa36o9XWAr76NHGXzazjF1/S0oSY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=btcMP8v6NReE30J3g6e+hTeO9PgryoRSiv69lI15wd8a04nHt7hgINMKqwFJ5asXq
         c0Z5GkE+1HvdHyx/oCiPk4yES7oVKRao+SjIB3KipcKP942E/VUudViWLTNrwZotoc
         vQFkwdhCb/dElS/y0Qxj+M6bPp8/wBgNwK3HfSnPB1Ocl+ymW1DOsFZzvhr4DkjjEm
         bbDYdxpIkKzLTZCAlIPAO9KhxDjwxovaRrRBWjoxg6VCzbzc0PpK39qM4460fTQ1Qu
         VEkVxkEpPHqrJ34xAHMjEIleAzWQAwVAIRcFz9xaLsCkcM4P3tUdMLmH37lsVfiGFh
         qsELOitKtwbqw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210210184938.146124-1-colin.king@canonical.com>
References: <20210210184938.146124-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] soc: xilinx: vcu: remove deadcode on null divider check
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Colin King <colin.king@canonical.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Date:   Wed, 10 Feb 2021 19:28:18 -0800
Message-ID: <161301409895.1254594.6980739457487251623@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2021-02-10 10:49:38)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The pointer 'divider' has previously been null checked followed by
> a return, hence the subsequent null check is redundant deadcode
> that can be removed.  Clean up the code and remove it.
>=20
> Fixes: 9c789deea206 ("soc: xilinx: vcu: implement clock provider for outp=
ut clocks")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/clk/xilinx/xlnx_vcu.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
> index d66b1315114e..607936d7a413 100644
> --- a/drivers/clk/xilinx/xlnx_vcu.c
> +++ b/drivers/clk/xilinx/xlnx_vcu.c
> @@ -512,9 +512,6 @@ static void xvcu_clk_hw_unregister_leaf(struct clk_hw=
 *hw)
> =20
>         mux =3D clk_hw_get_parent(divider);
>         clk_hw_unregister_mux(mux);
> -       if (!divider)
> -               return;
> -

This code is pretty confusing. Waiting for m.tretter@pengutronix.de to
reply

>         clk_hw_unregister_divider(divider);
>  }
>
