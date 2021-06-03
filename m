Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D569399D4A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFCJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:00:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54950 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhFCJAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:00:16 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lojBL-0004B6-0N; Thu, 03 Jun 2021 10:58:27 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc:     robh+dt@kernel.org, kishon@ti.com, t.schramm@manjaro.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml
Date:   Thu, 03 Jun 2021 10:58:26 +0200
Message-ID: <3601774.Dhsi8hcfAM@diego>
In-Reply-To: <YLhukPL7jSx3+dBj@vkoul-mobl>
References: <20210601164800.7670-1-jbx6244@gmail.com> <20210601164800.7670-2-jbx6244@gmail.com> <YLhukPL7jSx3+dBj@vkoul-mobl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

Am Donnerstag, 3. Juni 2021, 07:54:24 CEST schrieb Vinod Koul:
> On 01-06-21, 18:47, Johan Jonker wrote:
> > The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"
> > in phy-provider.yaml has required "#phy-cells" for phy nodes.
> > The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
> > Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
> > notifications. Remove unneeded "#phy-cells" from parent node.
> > Also sort example.
> > 
> > make ARCH=arm dtbs_check
> > DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
> > phy/phy-provider.yaml
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml       | 11 +++--------
> >  Documentation/devicetree/bindings/soc/rockchip/grf.yaml       |  4 ++--
> 
> I dont have grf.yaml, I guess it would be easier to split this into two
> or apply this thru rockchip tree. If you prefer latter:
> 
> Acked-By: Vinod Koul <vkoul@kernel.org>

before we do any more rounds, I'll just do that with your Ack, thanks :-)


Heiko



