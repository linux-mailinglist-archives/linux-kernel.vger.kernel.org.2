Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD083BA4E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 22:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhGBVBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230377AbhGBVBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:01:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F4F1613EB;
        Fri,  2 Jul 2021 20:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625259551;
        bh=Ls60RX1571idIce45U8CLpSNiuxtIk6tUPerE3Q41Eo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FfUTkZL9BWNlcdfcEF60jjkt0s6tNk4MtpFj1RIiL2uFJ2Vqu1klVyqGcSYYMqYtf
         ONTmjqa8a38F/ExsbJuHgdCXaAbUu6WmfudZAHDu4gs4XWyoesOqmaKzXfjItu/2/4
         f3+X13KwtGS9MLqPfqPuIyikVBr+6RVYZQNLkhlRHTF/Gb5WTMhZUtkXC/OzVSEVVM
         FODHOtz1uFht9goJuP8negMV3VW/h387QRtYBlcA85oN+1MOHysk86CVmkhSNIDJK3
         /lAHMwDQDUg9EVDsSRZqJ5Tj/35NQqmGjZdWojO8k3BYoug65d/nxjOhVmh8fwQQ3M
         sxwOXeJUuM7Lg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFBinCAASQUB=cg5EFsBQ4jd3TvcCJzV1=sYJci4ibR7FjRcww@mail.gmail.com>
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com> <20210627223959.188139-3-martin.blumenstingl@googlemail.com> <20210701202540.GA1085600@roeck-us.net> <CAFBinCC2KB-_pOenpWPknCuHV+CCjhP5hqukSkwD3qwRe6OtQw@mail.gmail.com> <162518776607.3570193.14348711594242395887@swboyd.mtv.corp.google.com> <CAFBinCAASQUB=cg5EFsBQ4jd3TvcCJzV1=sYJci4ibR7FjRcww@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] clk: divider: Switch from .round_rate to .determine_rate by default
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, mturquette@baylibre.com,
        linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 02 Jul 2021 13:59:10 -0700
Message-ID: <162525955027.3570193.16463056788252699243@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-07-02 02:19:37)
> Hi Stephen,
>=20
> On Fri, Jul 2, 2021 at 3:02 AM Stephen Boyd <sboyd@kernel.org> wrote:
> [...]
> > My guess is that we have drivers copying the clk_ops from the
> > divider_ops structure and so they are copying over round_rate but not
> > determine_rate.
> I just learned something new - thanks for investigating this as well!
>=20
> $ git grep "clk_divider_ops\.round_rate" drivers/
> drivers/clk/bcm/clk-bcm2835.c:  return clk_divider_ops.round_rate(hw,
> rate, parent_rate);
> drivers/clk/clk-stm32f4.c:      return clk_divider_ops.round_rate(hw,
> rate, prate);
> drivers/clk/clk-stm32h7.c:      return clk_divider_ops.round_rate(hw,
> rate, prate);
> drivers/clk/clk-stm32mp1.c:             req->rate =3D
> clk_divider_ops.round_rate(hw, req->rate, &best_parent_rate);
> drivers/clk/imx/clk-divider-gate.c:     return
> clk_divider_ops.round_rate(hw, rate, prate);
> $ git grep "clk_divider_ro_ops\.round_rate" drivers/
> $
>=20
> Changing these over to use clk_divider_ops.determine_rate doesn't seem to=
o hard.
> The part that I am not sure about is how to organize the patches.
> 1) amend the changes to all relevant drivers (from above) to this patch
> 2) multiple patches:
> - adding .determine_rate to the default divider ops (but not removing
> .round_rate)
> - a single patch for each relevant driver (from above)
> - removing .round_rate from the default divider ops
>=20
> Another approach is to first create clk_divider_determine_rate() (as
> done here) and export it.
> Then I could have one individual patch for each relevant driver (from
> above) to use:
>   .determine_rate =3D clk_divider_determine_rate,
> Then finally I could remove clk_divider_round_rate() and switch over
> the default divider ops to .determine_rate as well.
>=20
> Which way do you prefer?
>=20

I'd prefer we leave round_rate assigned in clk_divider_ops and
clk_divider_ro_ops but then also assign the determine_rate function. We
have some duplication but that's OK. Then make individual patches to
migrate each driver over to the new clk op.

We could stack a final patch on top to remove the round_rate function
from clk divider.  Unfortunately, if some driver wants to use round_rate
then it will fail in interesting ways. Probably best to live with it
until we decide to drop round_rate entirely. Patches to convert all the
round_rate code over to determine_rate would be welcome in the meantime.
