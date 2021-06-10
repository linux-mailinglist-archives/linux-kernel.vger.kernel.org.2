Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E633A257E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFJHcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:32:52 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40494 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhFJHcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:32:51 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lrF9P-0002mW-8K; Thu, 10 Jun 2021 09:30:51 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, kishon@ti.com,
        t.schramm@manjaro.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: rockchip: drop unnecessary #phy-cells from grf.yaml
Date:   Thu, 10 Jun 2021 09:30:50 +0200
Message-ID: <11362049.qUNvkh4Gvn@diego>
In-Reply-To: <46289b3c-f804-624b-3c74-1989e57d0a7c@gmail.com>
References: <e7e09072-9cac-413e-dca2-e2a668c1807e@gmail.com> <20210607141845.3331910-1-heiko@sntech.de> <46289b3c-f804-624b-3c74-1989e57d0a7c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 7. Juni 2021, 17:37:06 CEST schrieb Johan Jonker:
> 
> On 6/7/21 4:18 PM, Heiko Stuebner wrote:
> > The recent yaml conversion of the grf and inno-usb2-phy bindings
> > left the #phy-cells in place in the main usb2phy node inside the
> > example in grf.yaml, causing new warnings.
> > 
> > Drop it to make the bindingcheck happy.
> > 
> > Fixes: e71ccdff376b ("dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml")
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> 
> > Like this I guess?
> 
> Hi Heiko,
> 
> When I apply this patch locally and give the command below the
> notifications are gone.
> 
> make ARCH=arm dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/soc/rockchip/grf.yaml

so I've applied the patch on top now in my tree.

Heiko



