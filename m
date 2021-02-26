Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9003325E95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBZIE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:04:26 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58741 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhBZIES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614326658; x=1645862658;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DsAB6aiYDZ3bgkslJCKId+HjWbaUI76K1t+k4ZjB2TQ=;
  b=V691AaWjdU4AiMkGkvNKXeShDJOyVv91TvJ5tTGcU2oq6Jfcj/ThbNBt
   wzhkGF1BfgzYUD/fRkMKUtRB8o5NFlvp+2oiNA9WOL3N9qvq+z2FtCnEX
   hJ5HfCm900PK9vimpHDnJFdcITwUk+SlUWX+ZPShcCCSAMSahFT59GeRd
   0EPolnbAqMzVK3tt30ei14tKyVKEsjNoAlvqDTI/QC3Njch6Oo0hGm/Rg
   5ILMITD46CoEjok87tkTq2LNSEIMnGRY1Dyw1m1hO/C5oJcHyCXskxcTQ
   Usqmtld8vzWFdUbAgv0g3/qy8ahjRay4I9ME4QJBELS6WZERCVRJ4gs/t
   w==;
IronPort-SDR: qaprJXd/WHT+lyWz4aML0kB8JVH7uyptXHMyVMXdJMrbjpU6ldx+ikr6hF/3Vh4cwLMRtcYGsh
 fwojopqpMUEjj4eJ3liThlSw4ZIwUovKPeXl61pQXMCdxH/vsYDAkTEDMhJRF2GqDj/pA6KEex
 fCM9/2opn0w9pP1t52+lZhH4SDZaBfXp3h0PftPAQ2J+b16XWgL8Bpf5P7QQN6yX2Q/Ps2LHnb
 jfH7Md3qXxNVD/3EiGFrbu/KNqeNvOC1oksNm6fC9r0mO6Eu9Muj+hHHXIF3KQarGpeF1rcR1c
 mVk=
X-IronPort-AV: E=Sophos;i="5.81,207,1610434800"; 
   d="scan'208";a="45557285"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Feb 2021 01:02:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 01:02:54 -0700
Received: from tyr.hegelund-hansen.dk (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 26 Feb 2021 01:02:52 -0700
Message-ID: <1f33bcd26589c3a2fd85c195837bdc52c6ec6492.camel@microchip.com>
Subject: Re: [PATCH v6 2/3] reset: mchp: sparx5: add switch reset driver
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 26 Feb 2021 09:02:52 +0100
In-Reply-To: <YDgLTczzqTBCwEUY@piout.net>
References: <20210225095005.1510846-1-steen.hegelund@microchip.com>
         <20210225095005.1510846-3-steen.hegelund@microchip.com>
         <YDgLTczzqTBCwEUY@piout.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Thu, 2021-02-25 at 21:40 +0100, Alexandre Belloni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
> 
> Hello,
> 
> > 

...

> > +static int mchp_sparx5_map_io(struct platform_device *pdev, char
> > *name,
> > +                           struct regmap **target)
> > +{
> > +     struct resource *res;
> > +     struct regmap *map;
> > +     void __iomem *mem;
> > +
> > +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > name);
> > +     if (!res) {
> > +             dev_err(&pdev->dev, "No '%s' resource\n", name);
> > +             return -ENODEV;
> > +     }
> > +     mem = devm_ioremap(&pdev->dev, res->start, res->end - res-
> > >start + 1);
> > +     if (!mem) {
> > +             dev_err(&pdev->dev, "Could not map '%s' resource\n",
> > name);
> > +             return -ENXIO;
> > +     }
> 
> Someone is going to tell you to use
> devm_platform_get_and_ioremap_resource so it may as well be me ;)

Very nice.
Thanks for the info.  I will use that instead.

> 
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
BR
Steen

-=-=-=-=-=-=-=-=-=-=-=-=-=-=
steen.hegelund@microchip.com

