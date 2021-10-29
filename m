Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3187043F9F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJ2Jgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:36:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:27563 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhJ2Jgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635500053; x=1667036053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UA3mT5pGOwCaE2esRTHjdF4YdhrEwD31Y+BDYVHSjPc=;
  b=LKIuMt/EZRc++R79R19IWHXVXvQ6jIVdABCMRQS6HoEnSJaIF80c2gWj
   6JpFF0uz1eJofeCO/fQ5Jixb98NO/6jUf+AerMY5df+X9BIzKoMCiHfWe
   EtKbintIrkpUyK1cf7CbGaUjNp6EpV01lZfPhY+VB99oZIKGvroEMLAyT
   ugrzJKfo86IlcLL3o1jCYWVe53P33kHzklZZ7Q2kIoZM/eRtno8NbLmwt
   t3mXRniqba6Qtmh2dMeEIBkv+wDNZkfmx2boyXA8vyvb9SmF8viwKR9sh
   s5tsq5pbSadUkpfKrFwP0oQBUy5+AlhexL85+r0ZDp6gs7o8Wv4fbcVPg
   g==;
IronPort-SDR: Z58UCXVOAmV806wBgMO50/n0HZgZnw7G1JwQKLqIqeVHFwthiQt5BSlTkE6j+OPpzGmOqnYKZE
 BX3rzmXI32YiQ94NsCkLl+wCZg3vREV+VltPjcEW0v1ZY9m8ziURxvyhSuNMfl4twwOllq0qig
 w+Y1rn6zTkLBQfHdGfVpGf5rCZe+lPXjJvFUbbcwjGTtFWKcDluyqZm38HWopf88CYuFJEYD9p
 eQ50GtQnYK2JnwmkgRl1myG7cFYeFBTH05QsT+3r7Vv1YhBLNO0A4n3YB0Eco6CdVDGB/YNtEF
 V5YTuJ9SlKZjYmeOcgpMZtrZ
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="134776882"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2021 02:34:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Oct 2021 02:34:13 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 29 Oct 2021 02:34:12 -0700
Date:   Fri, 29 Oct 2021 11:35:56 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <mturquette@baylibre.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] clk: lan966x: Extend lan966x clock driver for
 clock gating support
Message-ID: <20211029093556.tdvroyommqi5xb6g@soft-dev3-1.localhost>
References: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
 <20211019084449.1411060-4-horatiu.vultur@microchip.com>
 <163548971798.15791.952778566228263608@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163548971798.15791.952778566228263608@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/28/2021 23:41, Stephen Boyd wrote:

Hi Stephen,

> 
> Quoting Horatiu Vultur (2021-10-19 01:44:49)
> > diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
> > index 19bec94e1551..40be47092a31 100644
> > --- a/drivers/clk/clk-lan966x.c
> > +++ b/drivers/clk/clk-lan966x.c
> > @@ -188,26 +202,64 @@ static struct clk_hw *lan966x_gck_clk_register(struct device *dev, int i)
> >         return &priv->hw;
> >  };
> >
> > +static int lan966x_gate_clk_register(struct device *dev,
> > +                                    struct clk_hw_onecell_data *hw_data,
> > +                                    void __iomem *gate_base)
> > +{
> > +       int i;
> > +
> > +       for (i = GCK_GATE_UHPHS; i < N_CLOCKS; ++i) {
> > +               int idx = i - GCK_GATE_UHPHS;
> > +
> > +               hw_data->hws[i] =
> > +                       clk_hw_register_gate(dev, clk_gate_desc[idx].name,
> 
> Use devm?

I couldn't find any devm_clk_hw_register_gate or something similar for
the gate.

> 
> > +                                            "lan966x", 0, base,
> > +                                            clk_gate_desc[idx].bit_idx,
> > +                                            0, &clk_gate_lock);
> > +
> > +               if (IS_ERR(hw_data->hws[i]))
> > +                       return dev_err_probe(dev, PTR_ERR(hw_data->hws[i]),
> > +                                            "failed to register %s clock\n",
> > +                                            clk_gate_desc[idx].name);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void lan966x_gate_clk_unregister(struct clk_hw_onecell_data *hw_data)
> > +{
> > +       int i;
> > +
> > +       for (i = GCK_GATE_UHPHS; i < N_CLOCKS; ++i)
> 
> for (int i =
> 
> should suffice

That would not work. I will get the error:
error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode

> 
> > +               if (!IS_ERR(hw_data->hws[i]))
> > +                       clk_hw_unregister(hw_data->hws[i]);
> > +}
> > +

-- 
/Horatiu
