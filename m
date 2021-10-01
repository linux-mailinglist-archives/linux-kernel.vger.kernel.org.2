Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7F41E774
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 08:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352134AbhJAGZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 02:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230478AbhJAGZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 02:25:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C61061A57;
        Fri,  1 Oct 2021 06:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633069400;
        bh=vWqqxr539aef2V+4cScV97lUuywByujLgziy43fXUnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMcp2Tf4CCPiR0iR8tQvpVTgTKJ0K6YMxk/WLiah32A5njx5E2jeiNE7a+Km4sxY7
         BgNvTBSavBv1ys/RKaTC4hHv+zmf42aPhaQOmjgBa1m0k9KHQF7OVojqBsVj7iKTXT
         /pWwzTKyWF/IyS6X2lM95AUeWkvL6ZVQsYrTLs5SHVYqnWC1Sq3EzfdrspRD8Fe9Um
         dBq8KRyQElBVD4h1Vt+CQ+5JbV/8JQ94tFF5PVzFxRBG+d1FeIK2C8DdPOFiHnz6Qy
         CVrLrzKlO/Jce7yVdvTVryFM6NRX/02oLe2RuNEA+6RdXv7FKYXBbT73bkD7MXLRka
         aNDMXUrHift5Q==
Date:   Fri, 1 Oct 2021 11:53:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/6] phy: cdns-dphy: Add Rx support
Message-ID: <YVapVLnGfSBZCDTY@matsya>
References: <20210902185543.18875-1-p.yadav@ti.com>
 <20210902185543.18875-3-p.yadav@ti.com>
 <YUMa/ocoQ9l3JDe6@aptenodytes>
 <20210917172809.rjtf7ww7vjcfvey5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917172809.rjtf7ww7vjcfvey5@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

On 17-09-21, 22:58, Pratyush Yadav wrote:
> +Rob
> 
> On 16/09/21 12:22PM, Paul Kocialkowski wrote:
> > Hi,
> > 
> > On Fri 03 Sep 21, 00:25, Pratyush Yadav wrote:
> > > The Cadence DPHY can be used to receive image data over the CSI-2
> > > protocol. Add support for Rx mode. The programming sequence differs from
> > > the Tx mode so it is added as a separate set of hooks to isolate the two
> > > paths. The mode in which the DPHY has to be used is selected based on
> > > the compatible.
> > 
> > I just realized that I didn't follow-up on a previous revision on the debate
> > about using the phy sub-mode to distinguish between rx/tx.
> > 
> > I see that you've been using a dedicated compatible, but I'm not sure this is a
> > good fit either. My understanding is that the compatible should describe a group
> > of register-compatible revisions of a hardware component, not how the hardware
> > is used specifically. I guess the distinction between rx/tx falls under
> > the latter rather than the former.
> 
> I am not sure if that is the case. For example, we use "ti,am654-ospi" 
> for Cadence Quadspi controller. The default compatible, "cdns,qspi-nor", 
> only supports Quad SPI (4 lines). The "ti,am654-ospi" compatible also 
> supports Octal SPI (8 lines).

Those are hardware defaults right?

> In addition, I feel like the Rx DPHY is almost a different type of 
> device from a Tx DPHY. The programming sequence is completely different, 

Is that due to direction or something else..?

> the clocks required are different, etc. So I think using a different 
> compatible for Rx mode makes sense.

Is the underlaying IP not capable of both TX and RX and in the specific
situations you are using it as TX and RX.

I am okay that default being TX but you can use Paul's approach of
direction with this to make it better proposal

-- 
~Vinod
