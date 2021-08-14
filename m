Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21623EC393
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhHNPdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 11:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234654AbhHNPdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 11:33:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF6F761038;
        Sat, 14 Aug 2021 15:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628955190;
        bh=Vu7c+q16xCBmJetZKt4s19I/pNzV/5d/rx4XA7/YLyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdAlSsGL18mjz9+dOvWiW/8KyeZ1z6pyDtP9UIFRjr9ju4Xos9XEgWZjNqhYSfSMj
         VHAZlviX+LAZuyNJFzmDbe1qvPrgpfKDfh3iVAgc8KHW9QAKhZKxpR/A3EJrIGEUMH
         GKL2Lq+KjfECC1Ioy9Ai3s4Xct4R6fYPRR4Tz4ucPyAbGoVU8NCFNNQNNdVBNRwpPL
         PG1vhnBbYlqr7slp3OLFR2fseSIJ9WspsVKNNk3OTGo2qgTGIAobWsO9+cMmFHp9QW
         TeeIQeFZW8BeqmipyogtiYXI5ZAYjEU+HPabDvfSSUMcbp8/8pfYGDoGmIAv8DJdMD
         FfsX/0EuSMhyA==
Received: by pali.im (Postfix)
        id C826E9CA; Sat, 14 Aug 2021 17:33:07 +0200 (CEST)
Date:   Sat, 14 Aug 2021 17:33:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add 88F6825 model into list
Message-ID: <20210814153307.vxun5jgy7ooeovgh@pali>
References: <20210814124805.14568-1-pali@kernel.org>
 <YRfhOJttJlXRYSzL@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRfhOJttJlXRYSzL@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 August 2021 17:28:56 Andrew Lunn wrote:
> On Sat, Aug 14, 2021 at 02:48:05PM +0200, Pali Rohár wrote:
> > 88F6825 is just 88F6820 but without encryption acceleration hardware and is
> > used e.g. in DTS file arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > ---
> > Depends on patch: https://lore.kernel.org/linux-doc/20210625215437.2156-1-pali@kernel.org/
> > ---
> >  Documentation/arm/marvell.rst | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> > index 85169bc3f538..56bb592dbd0c 100644
> > --- a/Documentation/arm/marvell.rst
> > +++ b/Documentation/arm/marvell.rst
> > @@ -140,6 +140,7 @@ EBU Armada family
> >  	- 88F6821 Armada 382
> >  	- 88F6W21 Armada 383
> >  	- 88F6820 Armada 385
> > +	- 88F6825
> 
> Hi Pali
> 
> Does it have the marketing name of Armada 385?

No, there is no marking. The only name in Marvell documents and also in
DTS files and on wikis/internet is just 88F6825.

I found only this statement from Marvell:

"The 88F6825 device is a member of the ARMADA® 380, 385, and 388 Family
of devices."

> 
>      Andrew
