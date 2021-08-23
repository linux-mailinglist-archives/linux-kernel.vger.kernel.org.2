Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A833F4701
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbhHWI6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:58:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58996 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhHWI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:58:10 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17N8vDGO002694;
        Mon, 23 Aug 2021 03:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629709033;
        bh=WloqbnoEgD5ql7FAIG/QNvP+kEgv6SzH3rX8/cmaMwM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oJ3vKalrlrkfmdFJtoMkV/PpPiKQfUFgvp2hauydg3fQ5dg+YFYTReTUAC5pSKpwF
         QmQzcYmzV82yn6jJl90ZE7+YH240pooT/EV+70dpaGso/v3V4+i9CXX5Po9naQw2k3
         5kcW6hVIGp1oEjCqzPsQSoXRJJewOTnNqZjOeLTs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17N8vDHH021842
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Aug 2021 03:57:13 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 23
 Aug 2021 03:57:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 23 Aug 2021 03:57:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17N8vCp7095969;
        Mon, 23 Aug 2021 03:57:13 -0500
Date:   Mon, 23 Aug 2021 14:27:12 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v4 4/6] phy: dt-bindings: cdns,dphy: make clocks optional
Message-ID: <20210823085710.mr4iz3fop62efcyj@ti.com>
References: <20210820190346.18550-1-p.yadav@ti.com>
 <20210820190346.18550-5-p.yadav@ti.com>
 <YSL8mH8hd/PzyRRo@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YSL8mH8hd/PzyRRo@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/21 04:40AM, Laurent Pinchart wrote:
> Hi Pratyush,
> 
> Thank you for the patch.
> 
> On Sat, Aug 21, 2021 at 12:33:44AM +0530, Pratyush Yadav wrote:
> > The clocks are not used by the DPHY when used in Rx mode so make them
> > optional.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > 
> > ---
> > 
> > (no changes since v3)
> > 
> > Changes in v3:
> > - Add Rob's Ack.
> > 
> > Changes in v2:
> > - Re-order subject prefixes.
> > 
> >  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > index b90a58773bf2..3bb5be05e825 100644
> > --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > @@ -33,8 +33,6 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - clocks
> > -  - clock-names
> 
> Could you turn this into a conditional requirement based on the compat
> string, as the clocks are needed in the TX case ?

Ok, will do.

> 
> >    - "#phy-cells"
> >  
> >  additionalProperties: false
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
