Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11068453C19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 23:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhKPWHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 17:07:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31922 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhKPWHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 17:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637100250; x=1668636250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rx/13bF/6Q3rEmvkBsxSO5hcFOb0mDykR+WPgNyDP/o=;
  b=QDD7ajEv6kwCnN7PV7Elri8W9z29KpZlgWTN2LnerrsKXUYfl1FQNH9g
   orB3hgL4DRBevWI1WDv5cP7l2JN2PcUHmmVG0KYoeNHc6eSWo8La0RycO
   h9vkGZZFr7jWwyL7mjIguGrUzMrNSqiBuA1WjXND00WeQO6fvbTc49JYG
   wUMBdSJ1+3bcCzZgae8e9fjkICj1HFBjwiowxTui90dXaFiQvW7fJpP2S
   qj5Vk3pWTL6Qdor8TovnvTZ5OY2/QBybdEDg1vodmB3Vjbek7Ji7RtqOn
   usGAm8oOfGxbTG2/Tb2uPazVovADll1EAjVJNsxhw2GtvRK5YZtUH0pmv
   A==;
IronPort-SDR: fUkcPZPrJJZn8G8UKtM5Ng0a7pjArBarDEblODBTaZaGzVU+HpnZuodRu7jcH2GvZV8seeU5kv
 H/T6euq0LrhJO+vxJcbM6Xf3WBTSC8pw2HAhKyqhJwcxy9EV8UpB/sHjD+gL2PTCracEGW+/Sm
 At3iY4G22+znlUPY0emOpvB7hzCi57Sco12iK+RQFbw+LOwaVaRkd78noReFfwRQr2cArdYzs5
 U7jBWNUWm3sRgWcA0fPWPxkVHY8EOj7GujSWZ4wYbqMivhDoz4LJ+MYrCKfviK+Ld9qMi1Z0dM
 9ws3oExXxIgD35L4IZebY6Jj
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="143579219"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 15:04:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 15:04:08 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 16 Nov 2021 15:04:08 -0700
Date:   Tue, 16 Nov 2021 23:05:54 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Vinod Koul <vkoul@kernel.org>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <andrew@lunn.ch>, <kuba@kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resend v4 0/3] phy: Add driver for lan966x Serdes driver
Message-ID: <20211116220554.d3amfihujwua2sff@soft-dev3-1.localhost>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
 <20211116102151.k3evnn4f2rwsi5nk@soft-dev3-1.localhost>
 <YZOLyQPsgoOYJZch@matsya>
 <20211116105601.fauvfv2wzlmcf6jc@soft-dev3-1.localhost>
 <YZOZZv3NPq2C9NXu@matsya>
 <20211116115228.5qn4o3gkh26674rw@soft-dev3-1.localhost>
 <YZP0lPN+TCtBN8ic@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YZP0lPN+TCtBN8ic@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 11/16/2021 19:12, Alexandre Belloni wrote:
> 
> Hello,
> 
> On 16/11/2021 12:52:28+0100, Horatiu Vultur wrote:
> > The 11/16/2021 17:13, Vinod Koul wrote:
> > >
> > > On 16-11-21, 11:56, Horatiu Vultur wrote:
> > > > The 11/16/2021 16:15, Vinod Koul wrote:
> > > > >
> > > > > On 16-11-21, 11:21, Horatiu Vultur wrote:
> > > > > > The 11/16/2021 11:08, Horatiu Vultur wrote:
> > > > > >
> > > > > > Hi Kison, Vinod,
> > > > > >
> > > > > > Can you let me know if you have more comments to this patch series?
> > > > > > Otherwise can you ack on it? Because I would like to have the patches
> > > > > > merged via netdev if that is OK for you.
> > > > >
> > > > > Any reason for merge thru netdev, there is no dependency and now with
> > > > > merge window closed, I can pick this up..
> > > >
> > > > Because I would like to send some patches for the lan966x network driver.
> > > > And these network patches depend on the serdes driver.
> > >
> > > There cant be a compile time dependency... the network driver can use
> > > the phy apis.. I dont think it is required here... Did I miss something
> > > obvious?
> >
> > You are right, there is no compile time dependency and the network
> > driver can use the PHY APIs.
> >
> > But at runtime the network driver will need to configure the serdes
> > using the PHY API to be able to work properly.
> >
> 
> It is fine if it doesn't work at runtime with only one branch, both will
> get merged in linux-next and you can test with that if necessary. I'll
> let both series go through separate trees.

Ah.. sorry for all the confusion. I though they need to go through the
same tree.

So Vinod, if you think that the patch series is OK please take it in
your tree, otherwise let me know what comments you have.

> 
> 
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
/Horatiu
