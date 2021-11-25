Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E7C45D413
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 06:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbhKYFTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 00:19:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231646AbhKYFRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 00:17:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E18A60FD9;
        Thu, 25 Nov 2021 05:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637817235;
        bh=GU6JgszEfSd7WhXm8ULpVRPGKfHeIqRiBnSpxytVmrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0d74j/sb8w9Nrtb2kLpdjdehAmwJ9h7QLNLAfpHZf1IXbo90S5/8k1/kQTGcnrYe
         VDe9oXsVpMwWkiI5hi1JxjlFkwFWnZ0s02u820166mjlvO5I8ssMRRKc5uR7NT5P4j
         NXxD7ShpVjAPRJZlpD+wsk0xtWl7CENxdXEba+NTzOzl4qkX+bU9e98gAge/g5bkgG
         bHp4lT+lfEBF7kAkFz8oLXsjMGgywFTEARaXk6j6XgpA1iLGJ/xQZgw3Sq0xEB/JiI
         b6RucuAPeU1CCWOWhpezTwSqBe+xYKXoHh5Ai9s/19KXcYUYf5ouBt0mnmMNdd0p2a
         6FIu6P1XYA04w==
Date:   Thu, 25 Nov 2021 10:43:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
        Liam Beguin <lvb@xiphos.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: ti: omap-usb2: Fix the kernel-doc style
Message-ID: <YZ8bj+q4jLXfMD3X@matsya>
References: <20211120061531.410771-1-vkoul@kernel.org>
 <20211120061531.410771-2-vkoul@kernel.org>
 <YZkum7CrX/51TpMx@shaak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZkum7CrX/51TpMx@shaak>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-21, 12:21, Liam Beguin wrote:
> Hi Vinod,
> 
> On Sat, Nov 20, 2021 at 11:45:31AM +0530, Vinod Koul wrote:
> > The documentation uses incorrect style, so fix that.
> > 
> > drivers/phy/ti/phy-omap-usb2.c:102: warning: Function parameter or member 'comparator' not described in 'omap_usb2_set_comparator'
> > 
> > While at it, use a single line for function description
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> > Changes in v2: use () for function names
> > 
> >  drivers/phy/ti/phy-omap-usb2.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
> > index ebceb1520ce8..3a505fe5715a 100644
> > --- a/drivers/phy/ti/phy-omap-usb2.c
> > +++ b/drivers/phy/ti/phy-omap-usb2.c
> > @@ -89,9 +89,9 @@ static inline void omap_usb_writel(void __iomem *addr, unsigned int offset,
> >  }
> >  
> >  /**
> > - * omap_usb2_set_comparator - links the comparator present in the system with
> > - *	this phy
> > - * @comparator - the companion phy(comparator) for this phy
> > + * omap_usb2_set_comparator() - links the comparator present in the system with this phy
> 
> My apologies for the noise, I just noticed your v2.

No worries :)
> 
> Reviewed-by: Liam Beguin <liambeguin@gmail.com>

Thanks

-- 
~Vinod
