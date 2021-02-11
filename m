Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E133192CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBKTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:06:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhBKTF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:05:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7012164E6C;
        Thu, 11 Feb 2021 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613070315;
        bh=8kiRepUjNeVgukin7TwKjMbpmdvai9OE+G45svt4vIg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=a93R/82gY7D5m8xOkU/KHFaTjpv8x4alX0s0kgqDPvFY55ZWuEoc7LtergDH0gYVQ
         4x0JTgu0DJfXdQIBzs/AVz//3RqJZai0dPBxoLSzi8bXYw/QyRj9H8X/H3xlJpD+uX
         ps2UwybyEVYGPebwlKT/ROVQyvMGFLMZIBKksp68dMPH/ouEvcrIrOTNLxKRmZxbI/
         N19DJek89EdQAgC7bkvh5DR4/29KOoBFw5czdHkxgYrOlMrp1WP3C6okC9uU+vg9PV
         16Ucqf8z3a41+3B2510XhEsCEe2Q/ye328aXkWTJn7sQ4mJOoxumGeaWcQKzHh1olm
         uhYdilhVfKKOg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210211073906.GC30300@pengutronix.de>
References: <20210210184938.146124-1-colin.king@canonical.com> <161301409895.1254594.6980739457487251623@swboyd.mtv.corp.google.com> <20210211073906.GC30300@pengutronix.de>
Subject: Re: [PATCH][next] soc: xilinx: vcu: remove deadcode on null divider check
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Tretter <m.tretter@pengutronix.de>
Date:   Thu, 11 Feb 2021 11:05:14 -0800
Message-ID: <161307031421.1254594.40010291545314425@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Tretter (2021-02-10 23:39:06)
> On Wed, 10 Feb 2021 19:28:18 -0800, Stephen Boyd wrote:
> > Quoting Colin King (2021-02-10 10:49:38)
> > > From: Colin Ian King <colin.king@canonical.com>
> > >=20
> > > The pointer 'divider' has previously been null checked followed by
> > > a return, hence the subsequent null check is redundant deadcode
> > > that can be removed.  Clean up the code and remove it.
> > >=20
> > > Fixes: 9c789deea206 ("soc: xilinx: vcu: implement clock provider for =
output clocks")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/clk/xilinx/xlnx_vcu.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >=20
> > > diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_=
vcu.c
> > > index d66b1315114e..607936d7a413 100644
> > > --- a/drivers/clk/xilinx/xlnx_vcu.c
> > > +++ b/drivers/clk/xilinx/xlnx_vcu.c
> > > @@ -512,9 +512,6 @@ static void xvcu_clk_hw_unregister_leaf(struct cl=
k_hw *hw)
> > > =20
> > >         mux =3D clk_hw_get_parent(divider);
> > >         clk_hw_unregister_mux(mux);
> > > -       if (!divider)
> > > -               return;
> > > -
> >=20
> > This code is pretty confusing. Waiting for m.tretter@pengutronix.de to
> > reply
>=20
> Can you elaborate what you find confusing about this code. I would gladly=
 try
> to clarify and improve the code.

The fact that pointers are being checked and then bailing out of the
function early, vs. doing something if the pointer is non-NULL.

>=20
> What happens here is that the driver registers a mux -> divider -> gate c=
hain
> for each output clock, but only stores the gate clock. When unregistering=
 the
> clocks, the driver starts at the gate and walks up to the mux while
> unregistering the clocks.
>
