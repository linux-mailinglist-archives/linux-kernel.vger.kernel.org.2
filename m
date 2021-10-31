Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2086B440D8A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 10:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJaJEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 05:04:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17172 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhJaJEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 05:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635670904; x=1667206904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GF1M9lRgfv1qWAvis+/hrRXIO8JBr+hqe2AlP1qmu1I=;
  b=VgPNS8RkGB50cXsTW2C40P6kiANZZfE+idgwZzKKvdj4EQhx7hetINhM
   XkqWganpm3x3PPV6cLYTqU9g87L3UkmF8q/0PtodCXPd8pP0hWiJW/gMu
   xdLu4mfQiJ1HEMjRFa+eBcmNaNIE6uMnl+WHDR0E7NYHNBmIXKPwcY8IK
   ePx2m8WC6AEdbhmcGGWhztakc/mo9o1rrg79yGrSIi7syFODIEqG9HDE1
   UoEBS3sIpdc/esXqdASI6ih20xRDcP12LqtX5Pb5R6vqoiqv3k7eq29zL
   qzLAm/m6tDEViAEv9WCUux5soC8oZLpeULKcBzDI+/ux3vRIBXQg1cjDp
   g==;
IronPort-SDR: BBJbwG37SJ4KsKYtsh+iUseNBbJbn2VKE3VbDM0rFORC0t5us7wgp4QN8S82dsKNtGIWc5SL/O
 wSU9C2QyHWO4Hs5Ni88JCvVp44ukC7MT7hoA79QDZaXjReikIgpDxeCG00tEdsyy753HgxtahA
 bkECOQHc6F7NsLymBrCvJ84lf4xBfC0pAkrMaYa3/v4LtkgeEkjivoGyc1tW18gz9QRsxupmCK
 WywtNbRuVNspfUGuYwpCkNkgB/U83Y4dyb1hUVePNqW9RELhXqrWaWR1VAberMbnhiHsFj1sZK
 qoQjpJg6mrZ51kcjScURCbVs
X-IronPort-AV: E=Sophos;i="5.87,197,1631602800"; 
   d="scan'208";a="134941229"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Oct 2021 02:01:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 31 Oct 2021 02:01:42 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Sun, 31 Oct 2021 02:01:42 -0700
Date:   Sun, 31 Oct 2021 10:03:27 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <mturquette@baylibre.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] clk: lan966x: Extend lan966x clock driver for
 clock gating support
Message-ID: <20211031090327.z7nm67iinkwyblus@soft-dev3-1.localhost>
References: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
 <20211019084449.1411060-4-horatiu.vultur@microchip.com>
 <163548971798.15791.952778566228263608@swboyd.mtv.corp.google.com>
 <20211029093556.tdvroyommqi5xb6g@soft-dev3-1.localhost>
 <163555035420.15791.5764699436982333377@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163555035420.15791.5764699436982333377@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/29/2021 16:32, Stephen Boyd wrote:
> 
> Quoting Horatiu Vultur (2021-10-29 02:35:56)
> > The 10/28/2021 23:41, Stephen Boyd wrote:
> >
> > Hi Stephen,
> >
> > >
> > > Quoting Horatiu Vultur (2021-10-19 01:44:49)
> > > > diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
> > > > index 19bec94e1551..40be47092a31 100644
> > > > --- a/drivers/clk/clk-lan966x.c
> > > > +++ b/drivers/clk/clk-lan966x.c
> > > > @@ -188,26 +202,64 @@ static struct clk_hw *lan966x_gck_clk_register(struct device *dev, int i)
> > > >         return &priv->hw;
> > > >  };
> > > >
> > > > +static int lan966x_gate_clk_register(struct device *dev,
> > > > +                                    struct clk_hw_onecell_data *hw_data,
> > > > +                                    void __iomem *gate_base)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       for (i = GCK_GATE_UHPHS; i < N_CLOCKS; ++i) {
> > > > +               int idx = i - GCK_GATE_UHPHS;
> > > > +
> > > > +               hw_data->hws[i] =
> > > > +                       clk_hw_register_gate(dev, clk_gate_desc[idx].name,
> > >
> > > Use devm?
> >
> > I couldn't find any devm_clk_hw_register_gate or something similar for
> > the gate.
> 
> Add one?

Yes, I will do that.

> 
> >
> > >
> > > > +                                            "lan966x", 0, base,
> > > > +                                            clk_gate_desc[idx].bit_idx,
> > > > +                                            0, &clk_gate_lock);
> > > > +
> > > > +               if (IS_ERR(hw_data->hws[i]))
> > > > +                       return dev_err_probe(dev, PTR_ERR(hw_data->hws[i]),
> > > > +                                            "failed to register %s clock\n",
> > > > +                                            clk_gate_desc[idx].name);
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static void lan966x_gate_clk_unregister(struct clk_hw_onecell_data *hw_data)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       for (i = GCK_GATE_UHPHS; i < N_CLOCKS; ++i)
> > >
> > > for (int i =
> > >
> > > should suffice
> >
> > That would not work. I will get the error:
> > error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode
> 
> Ah ok

-- 
/Horatiu
