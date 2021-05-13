Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3170337F124
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 04:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEMCKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 22:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhEMCKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 22:10:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04F0660FE9;
        Thu, 13 May 2021 02:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620871745;
        bh=VGw1fMdv7a1LyI1pnnicV4IuFjxiNwdg/mYbWWDFhHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cra+afcn4f04+Ui4+XAyl1MzvES37KAqkJocA6GKzLJcNHurLa02CD7gEnj0JR0X6
         v/o1/o3oukhhXGJIB0d4ggspmzvuoututtLhbjI2Y3g4OF3I42uw5LA0NDtL4AJcBb
         ECh1W5NDfGGu64DXkDsXrTjr7YUg+yGvkirWZK9MtNwcb1XtAOhX6LKQ9KNZ0GvQXf
         asMbA5yOQPeWUJZp2najeUon31au7gPkA/abtobbb7Nu1gKKTVjOpttt0OyOoGc5I8
         XD1GXTizzHkxkRJtOa7/Mt7nlh3iQkAPlQeQU/puVMYF6+fCuogGehC0ENouoKj3hO
         VVLPaSw983b7w==
Date:   Thu, 13 May 2021 10:09:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn: Add spba1 bus
Message-ID: <20210513020859.GI3425@dragon>
References: <20210406013344.124255-1-aford173@gmail.com>
 <20210511024604.GE3425@dragon>
 <CAHCN7xLFpL=9BF9M5gUA6sMhc2ZZMNz+GP0OLmLfpJAWdD7W-w@mail.gmail.com>
 <VE1PR04MB6688CD4AA4826EEEBBA2651689539@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <CAHCN7xJ5Hq6bRpEgE8Pi9VbQ_Kejy-sgKQsJ93pQEG3U_Wsu=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJ5Hq6bRpEgE8Pi9VbQ_Kejy-sgKQsJ93pQEG3U_Wsu=Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 09:48:38AM -0500, Adam Ford wrote:
> On Tue, May 11, 2021 at 7:20 AM Robin Gong <yibin.gong@nxp.com> wrote:
> >
> > On 2021/05/11 18:45 Adam Ford <aford173@gmail.com> wrote:
> > > > Also may I ask if you have a real use case for this bus node?
> > >
> > > The reference manual shows the SPBA bus tells the DMA controller which
> > > peripherals are associated with it.  Nearly all the i.MX boards use this.  The
> > > boards I support have Bluetooth devices connected to a UART running high
> > > speeds, and if the DMA driver isn't loaded, I can see a performance change.
> > Compare PIO with DMA on UART, but not w/o this  'spba bus node ' patch?
> >
> > > In fact, if the DMA firmware isn't loaded, I often get transfer errors.
> > UART use SDMA ROM firmware instead of RAM firmware, so it should work
> > even without sdma RAM firmware loaded.  Still curious what really happen in
> > your board without this patch.
> 
> What I am seeing is that at times, the HCI UART loading before the DMA
> firmware is loaded.
> 
> [   10.582037] Bluetooth: HCI UART driver ver 2.3
> [   10.586867] Bluetooth: HCI UART protocol H4 registered
> [   10.593566] imx-sdma 30bd0000.dma-controller: sdma firmware not ready!
> [   10.594548] Bluetooth: HCI UART protocol Broadcom registered
> [   10.600108] imx-uart 30860000.serial: We cannot prepare for the RX slave dma!
> 
> When I get the above message, the bluetooth chip I have throws
> timeouts and does not function.
> 
> [   10.615090] imx-sdma 302c0000.dma-controller: loaded firmware 4.5
> 
> Once the firmware is loaded, I can unload the HCI Uart driver and
> re-load Bluetooth works again.
> 
> Based on that, I've been having my system delay the loading of the
> Bluetooth modules until after the firmware is loaded, but this tells
> me there is a relationship between the DMA and UART.

Yeah, I can see how DMA firmware impacts your Bluetooth device, but do
not follow how this spba node change make a difference here.

Nevertheless, patches look good.  Applied, thanks.

Shawn
