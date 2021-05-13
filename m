Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C46237F12D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 04:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhEMCNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 22:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhEMCN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 22:13:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE1E561412;
        Thu, 13 May 2021 02:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620871941;
        bh=QgoHavFjvdFVkg5O4nfKiBT0PrV385tfL3o9ywBzcZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNOu0izeiQs4veWStr5/7fxOp9ymO+ywBr0V9f0l65XzC8hO4dvscYD0ZRK42EkbU
         MOqKwtPXGT8d0Qdz874n5zrWBQFp4zHEcyziSqFFYpzZNR26YbM8dOXN+/imb+t6Hm
         GO1J9c0uyujT9R1J9a8eLXprkuD3IKGDvm0gplcu9HUqIXvxtagOuerjZkNu+HOlhd
         s0O24pgMQThyNkhAbSMTYau43Nrcnw4xxlw2zTVvU+FjA5z7xbwMHWQZN3iAKSLzrj
         045FpME41j3ipd52p+Ct+/3q3egwBG7PdcSub7BBSLhXwEFzPR6a5igkWJQgQ2unbH
         8xNCMGtP1Kduw==
Date:   Thu, 13 May 2021 10:12:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     Kornel Duleba <mindal@semihalf.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
Message-ID: <20210513021214.GJ3425@dragon>
References: <20210407123438.224551-1-mindal@semihalf.com>
 <20210511030658.GG3425@dragon>
 <AM0PR04MB67542D30A9424D455DB3ADD496539@AM0PR04MB6754.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB67542D30A9424D455DB3ADD496539@AM0PR04MB6754.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 09:48:22AM +0000, Claudiu Manoil wrote:
> >-----Original Message-----
> >From: Shawn Guo <shawnguo@kernel.org>
> >Sent: Tuesday, May 11, 2021 6:07 AM
> [...]
> >Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window
> >ranges
> >
> >+ Claudiu
> >
> >On Wed, Apr 07, 2021 at 02:34:38PM +0200, Kornel Duleba wrote:
> >> Currently all PCIE windows point to bus address 0x0, which does not match
> >> the values obtained from hardware during EA.
> >> Replace those values with CPU addresses, since in reality we
> >> have a 1:1 mapping between the two.
> >>
> >> Signed-off-by: Kornel Duleba <mindal@semihalf.com>
> >
> >Claudiu,
> >
> >Do you have any comment on this?
> >
> 
> Well, probing is still working with this change, I've just tested it.
> 
> PCI listing at boot time changes from:
> 
> pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 ranges:
> pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff -> 0x0000000000
> pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff -> 0x0000000000
> 
> to:
> 
> pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 ranges:
> pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff -> 0x01f8000000
> pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff -> 0x01f8160000
> 
> and looks reasonable.
> Adding Vladimir and Alex just in case.
> 
> Acked-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Thanks, Claudiu.

Kornel,

Do we need a Fixes tag for this patch?

Shawn
