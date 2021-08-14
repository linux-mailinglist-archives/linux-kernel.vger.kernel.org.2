Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323F53EC39C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 17:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbhHNPjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 11:39:52 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50068 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238712AbhHNPjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 11:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=1FVmzTx1+dFGPqtEqX4b5WAiaXLKRbjed8t4YU9fKLQ=; b=zw
        mrWBmCVpqp86yTZUo1uVqd+0Y88MBHMKMTJGCqTMv6QwtlOxfop9QSl2OIHwF2ssBcMyltTjj9SRc
        uURTX8Bs4sOCgAW7IXnxUcP4kCbdSpZ/PUtLeyjb7/pwIjmzrcJKkT0ZqQ3khFsy5QkFimv4XOtUe
        uQnUd3MBrObg7kc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mEvkk-00052v-2v; Sat, 14 Aug 2021 17:39:18 +0200
Date:   Sat, 14 Aug 2021 17:39:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add 88F6825 model into list
Message-ID: <YRfjpjrCcLdIHLSc@lunn.ch>
References: <20210814124805.14568-1-pali@kernel.org>
 <YRfhOJttJlXRYSzL@lunn.ch>
 <20210814153307.vxun5jgy7ooeovgh@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210814153307.vxun5jgy7ooeovgh@pali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 05:33:07PM +0200, Pali Rohár wrote:
> On Saturday 14 August 2021 17:28:56 Andrew Lunn wrote:
> > On Sat, Aug 14, 2021 at 02:48:05PM +0200, Pali Rohár wrote:
> > > 88F6825 is just 88F6820 but without encryption acceleration hardware and is
> > > used e.g. in DTS file arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > 
> > > ---
> > > Depends on patch: https://lore.kernel.org/linux-doc/20210625215437.2156-1-pali@kernel.org/
> > > ---
> > >  Documentation/arm/marvell.rst | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> > > index 85169bc3f538..56bb592dbd0c 100644
> > > --- a/Documentation/arm/marvell.rst
> > > +++ b/Documentation/arm/marvell.rst
> > > @@ -140,6 +140,7 @@ EBU Armada family
> > >  	- 88F6821 Armada 382
> > >  	- 88F6W21 Armada 383
> > >  	- 88F6820 Armada 385
> > > +	- 88F6825
> > 
> > Hi Pali
> > 
> > Does it have the marketing name of Armada 385?
> 
> No, there is no marking. The only name in Marvell documents and also in
> DTS files and on wikis/internet is just 88F6825.
> 
> I found only this statement from Marvell:
> 
> "The 88F6825 device is a member of the ARMADA® 380, 385, and 388 Family
> of devices."

O.K, thanks

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
