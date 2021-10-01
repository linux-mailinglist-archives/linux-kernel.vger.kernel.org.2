Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE141E8B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352681AbhJAIJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 04:09:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54592 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352629AbhJAIJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 04:09:53 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19187pM1037544;
        Fri, 1 Oct 2021 03:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633075671;
        bh=02HFq9shx1CP3eM+WRt/rKuUcya0lp5fR5fw5zRHBx4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=R8JL8wrtWHhnkB6F1QGVOrRtf1MJkZ2eS/IN2pUROPbhLJLzxV/1pk6u3N8qYD8Xg
         0W1tawCIFSxHV5parfR5y6cX9TN0mmJKt5Anrj4ZnKnZxo/x9VLmrnVCVU32q3YXc6
         392EScJQd/oo0gX4gIvL+0/szZdLb7KWYDZfkB20=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19187pq3076502
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Oct 2021 03:07:51 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 1
 Oct 2021 03:07:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 1 Oct 2021 03:07:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19187out092472;
        Fri, 1 Oct 2021 03:07:51 -0500
Date:   Fri, 1 Oct 2021 13:37:50 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v5 2/6] phy: cdns-dphy: Add Rx support
Message-ID: <20211001080748.nr2gzredoqtqj4xx@ti.com>
References: <20210902185543.18875-1-p.yadav@ti.com>
 <20210902185543.18875-3-p.yadav@ti.com>
 <YUMa/ocoQ9l3JDe6@aptenodytes>
 <20210917172809.rjtf7ww7vjcfvey5@ti.com>
 <YVapVLnGfSBZCDTY@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YVapVLnGfSBZCDTY@matsya>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/21 11:53AM, Vinod Koul wrote:
> Hi Pratyush,
> 
> On 17-09-21, 22:58, Pratyush Yadav wrote:
> > +Rob
> > 
> > On 16/09/21 12:22PM, Paul Kocialkowski wrote:
> > > Hi,
> > > 
> > > On Fri 03 Sep 21, 00:25, Pratyush Yadav wrote:
> > > > The Cadence DPHY can be used to receive image data over the CSI-2
> > > > protocol. Add support for Rx mode. The programming sequence differs from
> > > > the Tx mode so it is added as a separate set of hooks to isolate the two
> > > > paths. The mode in which the DPHY has to be used is selected based on
> > > > the compatible.
> > > 
> > > I just realized that I didn't follow-up on a previous revision on the debate
> > > about using the phy sub-mode to distinguish between rx/tx.
> > > 
> > > I see that you've been using a dedicated compatible, but I'm not sure this is a
> > > good fit either. My understanding is that the compatible should describe a group
> > > of register-compatible revisions of a hardware component, not how the hardware
> > > is used specifically. I guess the distinction between rx/tx falls under
> > > the latter rather than the former.
> > 
> > I am not sure if that is the case. For example, we use "ti,am654-ospi" 
> > for Cadence Quadspi controller. The default compatible, "cdns,qspi-nor", 
> > only supports Quad SPI (4 lines). The "ti,am654-ospi" compatible also 
> > supports Octal SPI (8 lines).
> 
> Those are hardware defaults right?
> 
> > In addition, I feel like the Rx DPHY is almost a different type of 
> > device from a Tx DPHY. The programming sequence is completely different, 
> 
> Is that due to direction or something else..?

Yes, it is due to direction. Different settings need to be applied for 
Rx mode.

> 
> > the clocks required are different, etc. So I think using a different 
> > compatible for Rx mode makes sense.
> 
> Is the underlaying IP not capable of both TX and RX and in the specific
> situations you are using it as TX and RX.

Any instance of the underlying IP can only either be TX or RX, it can't 
do both.

> 
> I am okay that default being TX but you can use Paul's approach of
> direction with this to make it better proposal

Ok, will update this patch then.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
