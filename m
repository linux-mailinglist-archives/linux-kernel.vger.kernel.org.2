Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E78A4390E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhJYILh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhJYILg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:11:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AFA360EE9;
        Mon, 25 Oct 2021 08:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635149355;
        bh=T1brRpvpLw2+XlgRvOtkbicK2toDWlCS9WW224wzFM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orxQ6mBy40d8vY1DbNZPCmd0g4wo4qhvO3pcnrFN99U3sOUY80AqARt7d4+rv7d/A
         16vMTuOhK52r39NtflnmomzWxZD3AazGD31Zss87vmUhNPvSwuxeJHoz8hUUHjbXdH
         3cdt42L+gPeK6BakfmUUoYJYGhT7R3TrjD/aOcts5Na1HZDRzQEcq3gmaXP44mqqd/
         M/I+vIfMqWB2IxjIoU+NmVc+IVfSJkqmQTaQ/fTL/a0+CSXJr30eGemSc+UyaebbTU
         0EuAvI1O+vtHzAo7/Yxp+fpA2nc7KAaoSLhDh+um1pXMNyAbK/LwiGKpY/QJH9xYTR
         9MgW97jLuQnjQ==
Date:   Mon, 25 Oct 2021 13:39:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/6] phy: cdns-dphy: Add Rx support
Message-ID: <YXZmJvebL4RuFxiQ@matsya>
References: <20210902185543.18875-1-p.yadav@ti.com>
 <20210902185543.18875-3-p.yadav@ti.com>
 <YUMa/ocoQ9l3JDe6@aptenodytes>
 <20210917172809.rjtf7ww7vjcfvey5@ti.com>
 <YVapVLnGfSBZCDTY@matsya>
 <YV463gUvYauhDP/l@pendragon.ideasonboard.com>
 <20211007121436.jkck2cue5zd3rys4@ti.com>
 <YWAdKTvYzF58oyU/@pendragon.ideasonboard.com>
 <YWA/2o/Df34VDcpp@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWA/2o/Df34VDcpp@aptenodytes>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-21, 14:55, Paul Kocialkowski wrote:
> Hi,
> 
> On Fri 08 Oct 21, 13:27, Laurent Pinchart wrote:
> > Hi Pratyush,
> > 
> > On Thu, Oct 07, 2021 at 05:44:38PM +0530, Pratyush Yadav wrote:
> > > On 07/10/21 03:10AM, Laurent Pinchart wrote:
> > > > On Fri, Oct 01, 2021 at 11:53:16AM +0530, Vinod Koul wrote:
> > > > > On 17-09-21, 22:58, Pratyush Yadav wrote:
> > > > > > On 16/09/21 12:22PM, Paul Kocialkowski wrote:
> > > > > > > On Fri 03 Sep 21, 00:25, Pratyush Yadav wrote:
> > > > > > > > The Cadence DPHY can be used to receive image data over the CSI-2
> > > > > > > > protocol. Add support for Rx mode. The programming sequence differs from
> > > > > > > > the Tx mode so it is added as a separate set of hooks to isolate the two
> > > > > > > > paths. The mode in which the DPHY has to be used is selected based on
> > > > > > > > the compatible.
> > > > > > > 
> > > > > > > I just realized that I didn't follow-up on a previous revision on the debate
> > > > > > > about using the phy sub-mode to distinguish between rx/tx.
> > > > > > > 
> > > > > > > I see that you've been using a dedicated compatible, but I'm not sure this is a
> > > > > > > good fit either. My understanding is that the compatible should describe a group
> > > > > > > of register-compatible revisions of a hardware component, not how the hardware
> > > > > > > is used specifically. I guess the distinction between rx/tx falls under
> > > > > > > the latter rather than the former.
> > > > > > 
> > > > > > I am not sure if that is the case. For example, we use "ti,am654-ospi" 
> > > > > > for Cadence Quadspi controller. The default compatible, "cdns,qspi-nor", 
> > > > > > only supports Quad SPI (4 lines). The "ti,am654-ospi" compatible also 
> > > > > > supports Octal SPI (8 lines).
> > > > > 
> > > > > Those are hardware defaults right?
> > > > > 
> > > > > > In addition, I feel like the Rx DPHY is almost a different type of 
> > > > > > device from a Tx DPHY. The programming sequence is completely different, 
> > > > > 
> > > > > Is that due to direction or something else..?
> > > > > 
> > > > > > the clocks required are different, etc. So I think using a different 
> > > > > > compatible for Rx mode makes sense.
> > > > > 
> > > > > Is the underlaying IP not capable of both TX and RX and in the specific
> > > > > situations you are using it as TX and RX.
> > > > > 
> > > > > I am okay that default being TX but you can use Paul's approach of
> > > > > direction with this to make it better proposal
> > > > 
> > > > 
> > > > Given that the RX and TX implementations are very different (it's not a
> > > > matter of selecting a mode at runtime), I'm actually tempted to
> > > > recommend having two drivers, one for the RX PHY and one for the TX PHY.
> > > > This can only be done with two different compatible strings, which I
> > > > think would be a better approach.
> > > 
> > > FWIW, I think having different drivers would certainly make things 
> > > easier to maintain.
> > 
> > I'm sorry for not having recommended this in the first place.
> > 
> > Any objection from anyone against going in this direction ?
> 
> So apparently there is not a single register that is shared between rx and tx
> and clocks are not the same either so it feels to me like a separate driver
> would be legit. This looks like two distinct IPs sharing the same base address.

Sorry for delay in getting back..

Okay lets have a different compatible and driver for this

-- 
~Vinod
