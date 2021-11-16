Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA2E452F87
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhKPK5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:57:21 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:36404 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbhKPK5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637060058; x=1668596058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6p8b8jPiDl25t3SNlwqW1xWe288t0b87c/qI2szEEYo=;
  b=usGdguDp7xbBrMuMHhgbnrwYkK1C1twcWgcglwjE/7NbWkVZBZZZ8yxw
   N/mODUfSHsX+ELnKItucDqSdpKe93NTicrT1k8+ZA8CjNWP8c1Bg6sGfJ
   i+jbzrlvCFN4e+dFSBFLRk4BjBFSmPmzZDeQyx9GutYWMDMuOQq3OSw55
   BzVVEA4gKLmeYmSpRm5MvGLFzZiTxdJfNw+eLRjHSy5ey7oH2dGBLUL+a
   idUq/0KcaSpG68VEfLpulQbsGvxQxSiTC+myoLLEqMNyrJCsXckiiY9eA
   Jh8Uq6MgDuXiXPYexrnj4pe34132uESyyxVpE93DYJkShyd8ecu3pIjYb
   Q==;
IronPort-SDR: eeM1e3aec4XeYA2aIS/ahf2rUqdYVi90rpzLNM+u8izh+kTktBvixszzFFrktWUlnWnIsaWdOk
 3gvyWTAVQ4FzX0/e36FCZniSM6dxpdjVTAc03M/4nTLSuxHRqYd9JJnEl/WyOpeSZjdWGbx6We
 KRcWqq1LGdHZus6c8AJGVVJCgBrWeaiYpS0XwtX3mZc9ogkfSx17jqmOP18X0AEyd09r+1ApiT
 BME8LH1zgvAahJgIW3tAWj6dv+AWgqTKybhuT9FnA/lIO+7W1AfxelpQRwmLrARWxCQszRmUF1
 iGRpvGZxGcMuI0illY/ijE7h
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="139275682"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 03:54:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 03:54:15 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 16 Nov 2021 03:54:15 -0700
Date:   Tue, 16 Nov 2021 11:56:01 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <kishon@ti.com>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <alexandre.belloni@bootlin.com>, <kuba@kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resend v4 0/3] phy: Add driver for lan966x Serdes driver
Message-ID: <20211116105601.fauvfv2wzlmcf6jc@soft-dev3-1.localhost>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
 <20211116102151.k3evnn4f2rwsi5nk@soft-dev3-1.localhost>
 <YZOLyQPsgoOYJZch@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YZOLyQPsgoOYJZch@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 11/16/2021 16:15, Vinod Koul wrote:
> 
> On 16-11-21, 11:21, Horatiu Vultur wrote:
> > The 11/16/2021 11:08, Horatiu Vultur wrote:
> >
> > Hi Kison, Vinod,
> >
> > Can you let me know if you have more comments to this patch series?
> > Otherwise can you ack on it? Because I would like to have the patches
> > merged via netdev if that is OK for you.
> 
> Any reason for merge thru netdev, there is no dependency and now with
> merge window closed, I can pick this up..

Because I would like to send some patches for the lan966x network driver.
And these network patches depend on the serdes driver.

> 
> --
> ~Vinod

-- 
/Horatiu
