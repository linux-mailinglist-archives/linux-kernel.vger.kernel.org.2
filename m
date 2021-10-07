Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD514252D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbhJGMRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:17:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48178 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241135AbhJGMQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:16:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 197CEew5110477;
        Thu, 7 Oct 2021 07:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633608880;
        bh=j6adkrGlMOpYlmjotVznItdFpUqevVwAnoGcm4wqQig=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DclmbGZVt7L9NxqWwXuV4C3/T+BbXENXCwuBUsExLT1jZKjbrjkza4Gu/xeY3wWhQ
         O3w4Xz17VCyDqkPSC3NQ/45snQXNSl3FiJNY54z9IDS5OKMAwpkostllmAfLtDzDn2
         Cw+bN39D1ywxTjXU6FQXnl5zYpJJiVJjamEP0Gu4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 197CEelh108154
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Oct 2021 07:14:40 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Oct 2021 07:14:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Oct 2021 07:14:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 197CEdxL100865;
        Thu, 7 Oct 2021 07:14:40 -0500
Date:   Thu, 7 Oct 2021 17:44:38 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v5 2/6] phy: cdns-dphy: Add Rx support
Message-ID: <20211007121436.jkck2cue5zd3rys4@ti.com>
References: <20210902185543.18875-1-p.yadav@ti.com>
 <20210902185543.18875-3-p.yadav@ti.com>
 <YUMa/ocoQ9l3JDe6@aptenodytes>
 <20210917172809.rjtf7ww7vjcfvey5@ti.com>
 <YVapVLnGfSBZCDTY@matsya>
 <YV463gUvYauhDP/l@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YV463gUvYauhDP/l@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/21 03:10AM, Laurent Pinchart wrote:
> Hi Vinod,
> 
> On Fri, Oct 01, 2021 at 11:53:16AM +0530, Vinod Koul wrote:
> > On 17-09-21, 22:58, Pratyush Yadav wrote:
> > > On 16/09/21 12:22PM, Paul Kocialkowski wrote:
> > > > On Fri 03 Sep 21, 00:25, Pratyush Yadav wrote:
> > > > > The Cadence DPHY can be used to receive image data over the CSI-2
> > > > > protocol. Add support for Rx mode. The programming sequence differs from
> > > > > the Tx mode so it is added as a separate set of hooks to isolate the two
> > > > > paths. The mode in which the DPHY has to be used is selected based on
> > > > > the compatible.
> > > > 
> > > > I just realized that I didn't follow-up on a previous revision on the debate
> > > > about using the phy sub-mode to distinguish between rx/tx.
> > > > 
> > > > I see that you've been using a dedicated compatible, but I'm not sure this is a
> > > > good fit either. My understanding is that the compatible should describe a group
> > > > of register-compatible revisions of a hardware component, not how the hardware
> > > > is used specifically. I guess the distinction between rx/tx falls under
> > > > the latter rather than the former.
> > > 
> > > I am not sure if that is the case. For example, we use "ti,am654-ospi" 
> > > for Cadence Quadspi controller. The default compatible, "cdns,qspi-nor", 
> > > only supports Quad SPI (4 lines). The "ti,am654-ospi" compatible also 
> > > supports Octal SPI (8 lines).
> > 
> > Those are hardware defaults right?
> > 
> > > In addition, I feel like the Rx DPHY is almost a different type of 
> > > device from a Tx DPHY. The programming sequence is completely different, 
> > 
> > Is that due to direction or something else..?
> > 
> > > the clocks required are different, etc. So I think using a different 
> > > compatible for Rx mode makes sense.
> > 
> > Is the underlaying IP not capable of both TX and RX and in the specific
> > situations you are using it as TX and RX.
> > 
> > I am okay that default being TX but you can use Paul's approach of
> > direction with this to make it better proposal
> 
> 
> Given that the RX and TX implementations are very different (it's not a
> matter of selecting a mode at runtime), I'm actually tempted to
> recommend having two drivers, one for the RX PHY and one for the TX PHY.
> This can only be done with two different compatible strings, which I
> think would be a better approach.

FWIW, I think having different drivers would certainly make things 
easier to maintain.

> 
> It's unfortunate that the original compatible string didn't contain
> "tx". We could rename it and keep the old one in the driver for backward
> compatibility, making things cleaner going forward.
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
