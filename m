Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA98745314A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhKPLyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:54:01 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:35364 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbhKPLxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637063443; x=1668599443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i1b2J+jr9/cEXI1gGs8JEfqxkc51INl+52zhCG9XRRE=;
  b=p270CPA86rPTZUsZlPb/eXzV7QzGS4r77Lk0QENZnwuiiWNsZDUH92nn
   wj3Yylukq01ev5t9Ij3fUMezAS9qUZcMOs9BsqK3Qt/m1nUCCqZv4gdGg
   uv1IDyN3M1efrLZcbLsi3eTdBXcHJ4yBIEf6X5x2U0V6guYd9V0bCyLIl
   mEmF+M6Zos/VbCvuFQU+F9uS2+izCzAJknPfA0b4ua5YJh9RQxShrcnKm
   sB2JU7IZRgEPjwLGxOZZEBJKXIV6+I2Xpe6nRDxEFu3uFjJeWfVRBcpKX
   F1hLQz1z6L5nn2uhw4uAe6cEYqHZo+Ww6Phx6pnvsgbqbnYU0wbvIoGYy
   w==;
IronPort-SDR: 6BLFG/kzWU+9TdFx51b+S79rC0vLPNmp0s7BN1WwaQMcfGPweK240iWbIWoGEHUtcZ8NUHtDdS
 LZJIKZ+qbb0wwbeJ0JG8iSDSiE326I48pPShCIlEh4RK34sJuGa+X6kfO9OLKRyrt2d18S1Qhp
 FjnJZ1PJE8SQbamGwfd/fR4enYHjf13fK2BpmRscTe0YMnb4T/f1aR7DpR24aLLjPmbY37BSTV
 gmK+hZ3Sunq/q6ZhAc3PzKz8RNCDQnKT53ArVXpLSwzAYgj6TlKRHi5I8CHGnpRWXGKt4Sj4rB
 bejErPEcLAsEW7rfsyZwQkKM
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="136717777"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:50:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:50:42 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 16 Nov 2021 04:50:42 -0700
Date:   Tue, 16 Nov 2021 12:52:28 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <kishon@ti.com>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <alexandre.belloni@bootlin.com>, <kuba@kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resend v4 0/3] phy: Add driver for lan966x Serdes driver
Message-ID: <20211116115228.5qn4o3gkh26674rw@soft-dev3-1.localhost>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
 <20211116102151.k3evnn4f2rwsi5nk@soft-dev3-1.localhost>
 <YZOLyQPsgoOYJZch@matsya>
 <20211116105601.fauvfv2wzlmcf6jc@soft-dev3-1.localhost>
 <YZOZZv3NPq2C9NXu@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YZOZZv3NPq2C9NXu@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 11/16/2021 17:13, Vinod Koul wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 16-11-21, 11:56, Horatiu Vultur wrote:
> > The 11/16/2021 16:15, Vinod Koul wrote:
> > >
> > > On 16-11-21, 11:21, Horatiu Vultur wrote:
> > > > The 11/16/2021 11:08, Horatiu Vultur wrote:
> > > >
> > > > Hi Kison, Vinod,
> > > >
> > > > Can you let me know if you have more comments to this patch series?
> > > > Otherwise can you ack on it? Because I would like to have the patches
> > > > merged via netdev if that is OK for you.
> > >
> > > Any reason for merge thru netdev, there is no dependency and now with
> > > merge window closed, I can pick this up..
> >
> > Because I would like to send some patches for the lan966x network driver.
> > And these network patches depend on the serdes driver.
> 
> There cant be a compile time dependency... the network driver can use
> the phy apis.. I dont think it is required here... Did I miss something
> obvious?

You are right, there is no compile time dependency and the network
driver can use the PHY APIs.

But at runtime the network driver will need to configure the serdes
using the PHY API to be able to work properly.

> 
> --
> ~Vinod

-- 
/Horatiu
