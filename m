Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88303E96E7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 19:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhHKRhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 13:37:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38672 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhHKRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 13:37:06 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BHaXqS066293;
        Wed, 11 Aug 2021 12:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628703393;
        bh=koHOYMd3d54ErCB2QIMgjsSyIsfpTXR12oRVDmM0CQI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=TVRvh+ba2DClIx7rkBokgHjhGu87O7rf2h2WdB11e0gQ8kz586rIYf/kQ2UDx6Usf
         uevzzZTCNBWN6LmdueWQeQE0N1gulKkIU8n3bMWgagdoAc5bz5Bo9JBn4EXwFYRQ1s
         w5MPkhuK/AeRkWY7Zl95Ed3OLs3W6lo+UipHQI+s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BHaXWN014969
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 12:36:33 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 12:36:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 12:36:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BHaWlY013939;
        Wed, 11 Aug 2021 12:36:32 -0500
Date:   Wed, 11 Aug 2021 23:06:31 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v3 1/7] phy: Distinguish between Rx and Tx for MIPI D-PHY
 with submodes
Message-ID: <20210811173629.gse5qmzezlh2ua7g@ti.com>
References: <20210624184108.21312-1-p.yadav@ti.com>
 <20210624184108.21312-2-p.yadav@ti.com>
 <YQ0Y4ueALPNEAoMI@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YQ0Y4ueALPNEAoMI@aptenodytes>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/21 01:11PM, Paul Kocialkowski wrote:
> Hi,
> 
> On Fri 25 Jun 21, 00:11, Pratyush Yadav wrote:
> > From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > 
> > As some D-PHY controllers support both Rx and Tx mode, we need a way for
> > users to explicitly request one or the other. For instance, Rx mode can
> > be used along with MIPI CSI-2 while Tx mode can be used with MIPI DSI.
> > 
> > Introduce new MIPI D-PHY PHY submodes to use with PHY_MODE_MIPI_DPHY.
> > The default (zero value) is kept to Tx so only the rkisp1 driver, which
> > uses D-PHY in Rx mode, needs to be adapted.
> 
> After some thinking and discussions, it appears that using the submode is
> probably not the best way to distinguish between rx and tx. This is because
> rx/tx is more of a specification of the hardware component than a run-time
> descision. Indeed the D-PHY blocks are usually dedicated to an associated
> controller (DSI or CSI-2) and thus each instance is either meant for tx or
> rx use.

Ok. IIRC Laurent also brought this point up earlier as well. At that 
time I took the allwinner DPHY as an example of a DPHY that can run in 
both modes.

The Cadence DPHY also supports both Rx and Tx modes but I don't know if 
both can be implemented at the same time, if that would even make any 
sense.

> 
> As a result I will be using the allwinner,direction string property in
> device-tree instead of the submode, with values of either "rx" or "tx".
> I suppose you can do something similar if you agree it makes more sense.

Wouldn't a different compatible a better idea?

> 
> Cheers,
> 
> Paul
>  
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> > 
> > (no changes since v1)
> > 
> >  include/linux/phy/phy-mipi-dphy.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/include/linux/phy/phy-mipi-dphy.h b/include/linux/phy/phy-mipi-dphy.h
> > index a877ffee845d..0f57ef46a8b5 100644
> > --- a/include/linux/phy/phy-mipi-dphy.h
> > +++ b/include/linux/phy/phy-mipi-dphy.h
> > @@ -6,6 +6,19 @@
> >  #ifndef __PHY_MIPI_DPHY_H_
> >  #define __PHY_MIPI_DPHY_H_
> >  
> > +/**
> > + * enum phy_mipi_dphy_submode - MIPI D-PHY sub-mode
> > + *
> > + * A MIPI D-PHY can be used to transmit or receive data.
> > + * Since some controllers can support both, the direction to enable is specified
> > + * with the PHY sub-mode. Transmit is assumed by default with phy_set_mode.
> > + */
> > +
> > +enum phy_mipi_dphy_submode {
> > +	PHY_MIPI_DPHY_SUBMODE_TX = 0,
> > +	PHY_MIPI_DPHY_SUBMODE_RX,
> > +};
> > +
> >  /**
> >   * struct phy_configure_opts_mipi_dphy - MIPI D-PHY configuration set
> >   *
> > -- 
> > 2.30.0
> > 
> 
> -- 
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com



-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
