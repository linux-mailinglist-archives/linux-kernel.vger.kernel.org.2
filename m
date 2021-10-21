Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECC3435DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJUJLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:11:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31105 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhJUJLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634807339; x=1666343339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifSk/ar9zle6TUfdbkckP9UIu6NSYDdpfvg1NVg6IEY=;
  b=xSucywZ+bRSSYGXDrE+l8kASEJj8B20ubz+PHpoIE+N9yty4V3GGYNZZ
   J6h4ws8SSCaDa73r8DjX3yESVSxYLIqKkaitR1kmrJEdoU4b7yvMKBIq8
   yUN0Z+RyJugyJcNjI4mlugdfzfKFz1BbLQbp9d03TzeN2qZBxvdJEusIE
   rJe4p1A4CVu4lj96UPLkrv8g6cWBcvpFaErT0KupGrcoKXgo+8gMVlj41
   3+OuKwcyyqQP5p2SgdkrrL/SHyNDkVYZJKs2Eqn3Kc0tG7mM6PmzByuEc
   9r77mKXDhlrG4hjJ5Kh1OtUIuk7n1MxRCUZfOM/4Iec1+0NBTOyclzg1b
   g==;
IronPort-SDR: JVbCpvZRb87y5B3+hQcJR9mpIloPKgR5W+Y63f1qMxj2U2HfrPxW4eTyI8nckMUySfUArqY+fU
 KuxFjJefqys1kFEnt98KgOfdP/PxBaWYUpzzwF+VrV5jaJZfftbcqrVTORJatab/TRRvIN1Y8b
 vmCGxjbd9krqOt0X7mV6YeCJr9wbLOIGPauLC532VAtFAHEHQUECGYqEUro1oFSvXfEumN5aX5
 l8MEpVrzqAhBaglz+JcZisBiWclBRI19fl7ZKMR0c31U3eesooTchuBORzF75cvwNe4S5JMFkR
 beDKoSW8EX1f9LGFeNFLLNHn
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; 
   d="scan'208";a="141184758"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Oct 2021 02:08:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 21 Oct 2021 02:08:58 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 21 Oct 2021 02:08:58 -0700
Date:   Thu, 21 Oct 2021 11:10:32 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] phy: Add lan966x ethernet serdes PHY driver
Message-ID: <20211021091032.ffaoncg5jjdwdeyg@soft-dev3-1.localhost>
References: <20211015123920.176782-1-horatiu.vultur@microchip.com>
 <20211015123920.176782-4-horatiu.vultur@microchip.com>
 <YW8HIHTCVgB+URJ5@matsya>
 <20211020091733.fxph2pq3xa3byvry@soft-dev3-1.localhost>
 <YXA3VVUGEjUR4HDC@matsya>
 <YXA6lZBTeA6aNxVD@piout.net>
 <YXEEcJHuEdFLPyCU@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YXEEcJHuEdFLPyCU@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/21/2021 11:40, Vinod Koul wrote:
> 
> On 20-10-21, 17:49, Alexandre Belloni wrote:
> > On 20/10/2021 21:05:49+0530, Vinod Koul wrote:
> > > > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > >
> > > > > Any reason why this is dual licensed, why not GPL only?
> > > >
> > > > No reason, I think I copy this from a different file.
> > >
> > > Please have a chat with your lawyers on the correct license this should
> > > have!
> > Dual GPL and MIT was Microsemi's policy, I'm not sure it carried over to
> > Microchip.
> 
> That is why they need to talk to someone and decide what license
> applies :)

I have changed it to be the same as the one on sparx5 because also
sparx5 is a Microchip product. On sparx5 we used:
'SPDX-License-Identifier: GPL-2.0-or-later'

> 
> --
> ~Vinod

-- 
/Horatiu
