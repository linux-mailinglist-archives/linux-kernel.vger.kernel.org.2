Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1EB453936
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 19:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbhKPSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 13:15:36 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47579 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbhKPSPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:15:35 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id EF86A40002;
        Tue, 16 Nov 2021 18:12:36 +0000 (UTC)
Date:   Tue, 16 Nov 2021 19:12:36 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Vinod Koul <vkoul@kernel.org>, kishon@ti.com, robh+dt@kernel.org,
        andrew@lunn.ch, kuba@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend v4 0/3] phy: Add driver for lan966x Serdes driver
Message-ID: <YZP0lPN+TCtBN8ic@piout.net>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
 <20211116102151.k3evnn4f2rwsi5nk@soft-dev3-1.localhost>
 <YZOLyQPsgoOYJZch@matsya>
 <20211116105601.fauvfv2wzlmcf6jc@soft-dev3-1.localhost>
 <YZOZZv3NPq2C9NXu@matsya>
 <20211116115228.5qn4o3gkh26674rw@soft-dev3-1.localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116115228.5qn4o3gkh26674rw@soft-dev3-1.localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 16/11/2021 12:52:28+0100, Horatiu Vultur wrote:
> The 11/16/2021 17:13, Vinod Koul wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 16-11-21, 11:56, Horatiu Vultur wrote:
> > > The 11/16/2021 16:15, Vinod Koul wrote:
> > > >
> > > > On 16-11-21, 11:21, Horatiu Vultur wrote:
> > > > > The 11/16/2021 11:08, Horatiu Vultur wrote:
> > > > >
> > > > > Hi Kison, Vinod,
> > > > >
> > > > > Can you let me know if you have more comments to this patch series?
> > > > > Otherwise can you ack on it? Because I would like to have the patches
> > > > > merged via netdev if that is OK for you.
> > > >
> > > > Any reason for merge thru netdev, there is no dependency and now with
> > > > merge window closed, I can pick this up..
> > >
> > > Because I would like to send some patches for the lan966x network driver.
> > > And these network patches depend on the serdes driver.
> > 
> > There cant be a compile time dependency... the network driver can use
> > the phy apis.. I dont think it is required here... Did I miss something
> > obvious?
> 
> You are right, there is no compile time dependency and the network
> driver can use the PHY APIs.
> 
> But at runtime the network driver will need to configure the serdes
> using the PHY API to be able to work properly.
> 

It is fine if it doesn't work at runtime with only one branch, both will
get merged in linux-next and you can test with that if necessary. I'll
let both series go through separate trees.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
