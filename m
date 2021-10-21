Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EFF4369BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhJURvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhJURve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:51:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB6BA61251;
        Thu, 21 Oct 2021 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634838558;
        bh=971Dp8XXlkN81iFinRf4MvIWoZp9k1Gvl8mpn3B/FJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0SmXacw38IY46Rk14ueq7FjGmEv8PJXxLy0fjVD/gZqDGFeUgfgh3SKEv35gXVHq
         P0+LGyZG7If1VcoDILrzmcZ5Y8S/945OqoMYscHeXHlav+QOVgqTm+qE0ByODvyLf7
         wPoX91RrERqcRRelEGWzUBsHOBoPGzLnHw7509MKdTuInkYbY1YPRaiLPtSEyvaEFI
         nUYh8Tegr5WavWY8kE2n+sbmi+21G94MxpQfqFBDlCctrY5cHHG+XDvAWua1SgJTIi
         s9bZOk6uGMjXAAif5jbF6eqSPhjXd9kczDqgwqdFFG4/CWXvFHERPj0MSI6WX6OpVz
         jT+4u4dsg6YYQ==
Date:   Thu, 21 Oct 2021 23:19:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>, kishon@ti.com,
        robh+dt@kernel.org, andrew@lunn.ch, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] phy: Add lan966x ethernet serdes PHY driver
Message-ID: <YXGoGtbFeKa+TVk2@matsya>
References: <20211015123920.176782-1-horatiu.vultur@microchip.com>
 <20211015123920.176782-4-horatiu.vultur@microchip.com>
 <YW8HIHTCVgB+URJ5@matsya>
 <20211020091733.fxph2pq3xa3byvry@soft-dev3-1.localhost>
 <YXA3VVUGEjUR4HDC@matsya>
 <YXA6lZBTeA6aNxVD@piout.net>
 <YXEEcJHuEdFLPyCU@matsya>
 <20211021091032.ffaoncg5jjdwdeyg@soft-dev3-1.localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021091032.ffaoncg5jjdwdeyg@soft-dev3-1.localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-21, 11:10, Horatiu Vultur wrote:
> The 10/21/2021 11:40, Vinod Koul wrote:
> > 
> > On 20-10-21, 17:49, Alexandre Belloni wrote:
> > > On 20/10/2021 21:05:49+0530, Vinod Koul wrote:
> > > > > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > > >
> > > > > > Any reason why this is dual licensed, why not GPL only?
> > > > >
> > > > > No reason, I think I copy this from a different file.
> > > >
> > > > Please have a chat with your lawyers on the correct license this should
> > > > have!
> > > Dual GPL and MIT was Microsemi's policy, I'm not sure it carried over to
> > > Microchip.
> > 
> > That is why they need to talk to someone and decide what license
> > applies :)
> 
> I have changed it to be the same as the one on sparx5 because also
> sparx5 is a Microchip product. On sparx5 we used:
> 'SPDX-License-Identifier: GPL-2.0-or-later'

Has the code been copied/derived from somewhere/auto generated from
scripts/tools or entirely written by you?

-- 
~Vinod
