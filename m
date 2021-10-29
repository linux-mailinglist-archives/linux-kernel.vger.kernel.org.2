Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532874405CC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 01:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhJ2XfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 19:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhJ2XfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 19:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F8DB60F22;
        Fri, 29 Oct 2021 23:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635550355;
        bh=vyVEh6v445rr413CWAfasLJDPyL5NbZjpPiYYTtbQ1E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YkbMGWEuQeqGRnwu9YA+q/NfXDQWQBzJfBbDBwUYNaopG7F23xyAlRWQsowumdCQT
         0JCAokXWdLZZwsdOe24rYIdyJrtwbOs3qpPXzuXMz9J59op/8/5Seiqjsoj8NhllxS
         AUaooCQ/4vtSGpTsSoCStV0ON3ZcuTvDWpT9N5oSoYY+ckdpXmiKxmNmHTzi6Nvq/G
         qCptrRcv+qBRKFCvuwnLKnixPPgsEa2IqzkmoeOFggmful4hpI9PLtUh1oyMtRoxxH
         R0odkkUh0hl9VRfFPA2Z58RUt8eQSZ9/fayV4R+J5q+/qEIoiMayNcAzOZROFC+oAP
         EmtucHcERH53g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211029093556.tdvroyommqi5xb6g@soft-dev3-1.localhost>
References: <20211019084449.1411060-1-horatiu.vultur@microchip.com> <20211019084449.1411060-4-horatiu.vultur@microchip.com> <163548971798.15791.952778566228263608@swboyd.mtv.corp.google.com> <20211029093556.tdvroyommqi5xb6g@soft-dev3-1.localhost>
Subject: Re: [RFC PATCH 3/3] clk: lan966x: Extend lan966x clock driver for clock gating support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, kavyasree.kotagiri@microchip.com,
        eugen.hristev@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Date:   Fri, 29 Oct 2021 16:32:34 -0700
Message-ID: <163555035420.15791.5764699436982333377@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Horatiu Vultur (2021-10-29 02:35:56)
> The 10/28/2021 23:41, Stephen Boyd wrote:
>=20
> Hi Stephen,
>=20
> >=20
> > Quoting Horatiu Vultur (2021-10-19 01:44:49)
> > > diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
> > > index 19bec94e1551..40be47092a31 100644
> > > --- a/drivers/clk/clk-lan966x.c
> > > +++ b/drivers/clk/clk-lan966x.c
> > > @@ -188,26 +202,64 @@ static struct clk_hw *lan966x_gck_clk_register(=
struct device *dev, int i)
> > >         return &priv->hw;
> > >  };
> > >
> > > +static int lan966x_gate_clk_register(struct device *dev,
> > > +                                    struct clk_hw_onecell_data *hw_d=
ata,
> > > +                                    void __iomem *gate_base)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i =3D GCK_GATE_UHPHS; i < N_CLOCKS; ++i) {
> > > +               int idx =3D i - GCK_GATE_UHPHS;
> > > +
> > > +               hw_data->hws[i] =3D
> > > +                       clk_hw_register_gate(dev, clk_gate_desc[idx].=
name,
> >=20
> > Use devm?
>=20
> I couldn't find any devm_clk_hw_register_gate or something similar for
> the gate.

Add one?

>=20
> >=20
> > > +                                            "lan966x", 0, base,
> > > +                                            clk_gate_desc[idx].bit_i=
dx,
> > > +                                            0, &clk_gate_lock);
> > > +
> > > +               if (IS_ERR(hw_data->hws[i]))
> > > +                       return dev_err_probe(dev, PTR_ERR(hw_data->hw=
s[i]),
> > > +                                            "failed to register %s c=
lock\n",
> > > +                                            clk_gate_desc[idx].name);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void lan966x_gate_clk_unregister(struct clk_hw_onecell_data *=
hw_data)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i =3D GCK_GATE_UHPHS; i < N_CLOCKS; ++i)
> >=20
> > for (int i =3D
> >=20
> > should suffice
>=20
> That would not work. I will get the error:
> error: =E2=80=98for=E2=80=99 loop initial declarations are only allowed i=
n C99 or C11 mode

Ah ok
