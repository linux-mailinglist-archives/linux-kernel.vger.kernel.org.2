Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26429424AEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbhJGAM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:12:28 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54686 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbhJGAMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:12:13 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C57DF9DC;
        Thu,  7 Oct 2021 02:10:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1633565415;
        bh=larLyxcmn+saBabnWqrpHg3AhMf8NdDp0lI84lrL9DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HxZZ5yYNOrCBDDjM02nPlHH+l+DodzLgVDAlus18uketUhMQdQJeTNaoyWqiTj3om
         fQtp47GSSMTi11/KuNZ541TorgWraU4Vwhj90Ofnj16uNSWld1hFPcdlD8XrysXao5
         rp81lulGGrDuJCfscVUD9xFNh1k2fr1lTUhPanMA=
Date:   Thu, 7 Oct 2021 03:10:06 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/6] phy: cdns-dphy: Add Rx support
Message-ID: <YV463gUvYauhDP/l@pendragon.ideasonboard.com>
References: <20210902185543.18875-1-p.yadav@ti.com>
 <20210902185543.18875-3-p.yadav@ti.com>
 <YUMa/ocoQ9l3JDe6@aptenodytes>
 <20210917172809.rjtf7ww7vjcfvey5@ti.com>
 <YVapVLnGfSBZCDTY@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVapVLnGfSBZCDTY@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Fri, Oct 01, 2021 at 11:53:16AM +0530, Vinod Koul wrote:
> On 17-09-21, 22:58, Pratyush Yadav wrote:
> > On 16/09/21 12:22PM, Paul Kocialkowski wrote:
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
> 
> > the clocks required are different, etc. So I think using a different 
> > compatible for Rx mode makes sense.
> 
> Is the underlaying IP not capable of both TX and RX and in the specific
> situations you are using it as TX and RX.
> 
> I am okay that default being TX but you can use Paul's approach of
> direction with this to make it better proposal


Given that the RX and TX implementations are very different (it's not a
matter of selecting a mode at runtime), I'm actually tempted to
recommend having two drivers, one for the RX PHY and one for the TX PHY.
This can only be done with two different compatible strings, which I
think would be a better approach.

It's unfortunate that the original compatible string didn't contain
"tx". We could rename it and keep the old one in the driver for backward
compatibility, making things cleaner going forward.

-- 
Regards,

Laurent Pinchart
