Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6573C3A3262
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhFJRnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhFJRnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:43:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A19C61181;
        Thu, 10 Jun 2021 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623346899;
        bh=0u44FGC7a3WziiHbQXDAv94V5GjTa76Zwoqq1R/GQjw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=shvP2bsedRa/2cISQn9YjvkvBzNfK1+DOwX24BdQsY/msUbHFudDXSaTCpZf0s9VT
         cVN/K/c1J8qzWZvkGVRPGH3qvnZ9w+TSPYZ4sHik6rbpEDGcXQDqskzydtC9Z/vG96
         sVwNijBS0/PLK83Zz2h9gxr4FRb14cKhxxbRMVhgTDuVA5sKGrhxcdvcPaoTiAUdAs
         Jn8DbSCniWqOllpiAjska/fEk4jJwnfnqnl1d8cOD2Z6nZZfEK4frRZyaW5ogs03bW
         FUDKty9KNZ1km4ycpAf3QNpMICQTBlJpA13fF4cyDxjkX94G91mEbB2ySTc3BjuDqK
         fmj421TqhldfQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1f59ed31-4a0e-9719-bf84-1fe4cdd6c57d@gmail.com>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com> <20210524122053.17155-2-chun-jie.chen@mediatek.com> <20210602171201.GA3566462@robh.at.kernel.org> <66e017401ab93aa02c5d2bbf11be9589b36649ac.camel@mediatek.com> <1f59ed31-4a0e-9719-bf84-1fe4cdd6c57d@gmail.com>
Subject: Re: [PATCH v9 01/22] dt-bindings: ARM: Mediatek: Add new document bindings of imp i2c wrapper controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
Date:   Thu, 10 Jun 2021 10:41:37 -0700
Message-ID: <162334689784.9598.2709970788186333494@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Brugger (2021-06-08 07:45:49)
>=20
>=20
> On 07/06/2021 07:20, Chun-Jie Chen wrote:
> > On Wed, 2021-06-02 at 12:12 -0500, Rob Herring wrote:
> >>> +
> >>> +description:
> >>> +  The Mediatek imp i2c wrapper controller provides functional
> >>> configurations and clocks to the system.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - mediatek,mt8192-imp_iic_wrap_c
> >>> +          - mediatek,mt8192-imp_iic_wrap_e
> >>> +          - mediatek,mt8192-imp_iic_wrap_s
> >>> +          - mediatek,mt8192-imp_iic_wrap_ws
> >>> +          - mediatek,mt8192-imp_iic_wrap_w
> >>> +          - mediatek,mt8192-imp_iic_wrap_n
> >>
> >> Looks to me like these are all the same h/w, but just have differing=20
> >> sets of clocks. That's not really a reason to have different=20
> >> compatibles.=20
> >>
> >> If you need to know what clocks are present, you can walk the DT for=20
> >> all 'clocks' properties matching this clock controller instance. Or
> >> use=20
> >> 'clock-indices' to define which ones are present.

Is the idea to use clock-indices and then list all the clock ids in
there and match them up at driver probe time to register the clocks
provided by the IO region? Feels like we'll do a lot of parsing at each
boot to match up structures and register clks with the clk framework.

If it's like other SoCs then the clk id maps to a hard macro for a type
of clk, and those hard macros have been glued together with other clks
and then partitioned into different IO regions to make up a clock
controller. Or maybe in this case, those clk hard macros have been
scattered into each IP block like SPI, i2c, uart, etc. so that the clock
controller doesn't really exist and merely the gates and rate control
(mux/divider) for the clk that's clocking some particular IP block all
live inside the IP wrapper. If it's this case then I hope there are a
bunch of PLLs that are fixed rate so that the i2c clk doesn't have to go
outside the wrapper to change frequency (of which there should be two
"standard" frequencies anyway).

> >>
> >> Rob
> >=20
> > Some module is divided to sub-modules which are designed in different
> > h/w blocks for different usage, and if we want to use the same
> > compatible to present these h/w blocks, we need to move the clock data
> > provided by these h/w blocks to dts, but we usually use different
> > compatible to get the h/w blocks data in
> > Mediatek's clock driver, so do you suggest to register clock provided
> > by different h/w blocks using same compatible?
> >=20
>=20
> The mapping of them is as following:
> imp_iic_wrap_c:  11007000
> imp_iic_wrap_e:  11cb1000
> imp_iic_wrap_s:  11d03000
> imp_iic_wrap_ws: 11d23000
> imp_iic_wrap_w:  11e01000
> imp_iic_wrap_n:  11f02000
>=20

Sure. What is their purpose though? Are they simply a bunch of different
i2c clks?
