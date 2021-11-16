Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277DE453116
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhKPLrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:47:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235483AbhKPLqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:46:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71CEF633A7;
        Tue, 16 Nov 2021 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637063019;
        bh=o1JBPKCGWXJZZefm25NEXxuyxdUOXV5+XVYEGGp4c1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPyTBmyG5aCaRg26nwZduQUfNBTrVNFuF9GIsUbB9I12Ulen8QrIaH7V4jxJ6RfwM
         S558ejiHY31B2KOlH3G3SqjjwPu67jK8De09n4Al7+giCqNX3rGUzrUm+lUNEVXIx4
         53xDSDbPS7eaCxsGV0EFEOsFx23wVDPb4+AOh5x34DicmqrvB3U8vElutfer+SjNKW
         FVA/wRTWAv0aXxG4eq23rtC+RYHBAJtwC4BBpzoyGU2UkMoJjA7aLk2zqIuOgpsR9P
         SzD9GC3FSswh01tLebizJO4mofNetsvvoHGelTKzN6XD8XUT82595EX0SRuU+uT/JX
         V/G96o8Igmf3Q==
Date:   Tue, 16 Nov 2021 17:13:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, andrew@lunn.ch,
        alexandre.belloni@bootlin.com, kuba@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend v4 0/3] phy: Add driver for lan966x Serdes driver
Message-ID: <YZOZZv3NPq2C9NXu@matsya>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
 <20211116102151.k3evnn4f2rwsi5nk@soft-dev3-1.localhost>
 <YZOLyQPsgoOYJZch@matsya>
 <20211116105601.fauvfv2wzlmcf6jc@soft-dev3-1.localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116105601.fauvfv2wzlmcf6jc@soft-dev3-1.localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-21, 11:56, Horatiu Vultur wrote:
> The 11/16/2021 16:15, Vinod Koul wrote:
> > 
> > On 16-11-21, 11:21, Horatiu Vultur wrote:
> > > The 11/16/2021 11:08, Horatiu Vultur wrote:
> > >
> > > Hi Kison, Vinod,
> > >
> > > Can you let me know if you have more comments to this patch series?
> > > Otherwise can you ack on it? Because I would like to have the patches
> > > merged via netdev if that is OK for you.
> > 
> > Any reason for merge thru netdev, there is no dependency and now with
> > merge window closed, I can pick this up..
> 
> Because I would like to send some patches for the lan966x network driver.
> And these network patches depend on the serdes driver.

There cant be a compile time dependency... the network driver can use
the phy apis.. I dont think it is required here... Did I miss something
obvious?

-- 
~Vinod
