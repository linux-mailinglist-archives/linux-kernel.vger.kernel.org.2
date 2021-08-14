Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433163EC3A7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbhHNPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 11:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238763AbhHNPo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 11:44:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 698D860F92;
        Sat, 14 Aug 2021 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628955868;
        bh=QII7/Obag25Xr03PZZ/pofMlG3w80AxigjvxgXiYhWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6r0v/32SlNA1mP8bma4MFg3tJJf7dmgZ6b3lGUdsVQQZcqsk88kB6ZSe8VmqG6p+
         e9KkyXwKgdh8aldiJvdKlzNMSU0XUmaD8uk96CoyhjKEf3/yj3mnBj2W9VU3+rGRrq
         QTwOiOmvk7v3ubFPWn7DPrx1qYMonz2sVHh3L+IeQz8TUazydFOC/kY97mKoiGtb8A
         1yHyM2wgpxuhjX1BQd7ILD8JmTsSTj0dVozKRdWh+lw4WNyJLhKKS6cGFcMSR6OoCm
         5+Ram7IsDyGeFMgerXcgNt68tWVod0GmMRMO9j7jn2evruXUpx33LQiIDcsXWfDonF
         FeHskXBx6uz4w==
Received: by pali.im (Postfix)
        id 27D4C9CA; Sat, 14 Aug 2021 17:44:26 +0200 (CEST)
Date:   Sat, 14 Aug 2021 17:44:25 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add 88F6825 model into list
Message-ID: <20210814154425.4rrelaju6lilzdju@pali>
References: <20210814124805.14568-1-pali@kernel.org>
 <YRfhOJttJlXRYSzL@lunn.ch>
 <20210814153307.vxun5jgy7ooeovgh@pali>
 <YRfjpjrCcLdIHLSc@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRfjpjrCcLdIHLSc@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 August 2021 17:39:18 Andrew Lunn wrote:
> On Sat, Aug 14, 2021 at 05:33:07PM +0200, Pali Rohár wrote:
> > On Saturday 14 August 2021 17:28:56 Andrew Lunn wrote:
> > > On Sat, Aug 14, 2021 at 02:48:05PM +0200, Pali Rohár wrote:
> > > > 88F6825 is just 88F6820 but without encryption acceleration hardware and is
> > > > used e.g. in DTS file arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > 
> > > > ---
> > > > Depends on patch: https://lore.kernel.org/linux-doc/20210625215437.2156-1-pali@kernel.org/
> > > > ---
> > > >  Documentation/arm/marvell.rst | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> > > > index 85169bc3f538..56bb592dbd0c 100644
> > > > --- a/Documentation/arm/marvell.rst
> > > > +++ b/Documentation/arm/marvell.rst
> > > > @@ -140,6 +140,7 @@ EBU Armada family
> > > >  	- 88F6821 Armada 382
> > > >  	- 88F6W21 Armada 383
> > > >  	- 88F6820 Armada 385
> > > > +	- 88F6825
> > > 
> > > Hi Pali
> > > 
> > > Does it have the marketing name of Armada 385?
> > 
> > No, there is no marking. The only name in Marvell documents and also in
> > DTS files and on wikis/internet is just 88F6825.
> > 
> > I found only this statement from Marvell:
> > 
> > "The 88F6825 device is a member of the ARMADA® 380, 385, and 388 Family
> > of devices."
> 
> O.K, thanks

Normally I do not care about such thing... but as kernel already
supports this SoC and also have DTS file for some device, it
indicates that it is in use and supported... so mentioning this SoC in
documentation is a good idea, even it does not have "code name".

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew
