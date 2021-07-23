Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9E3D3CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhGWPM5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jul 2021 11:12:57 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:55297 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhGWPMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:12:47 -0400
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 779FE1BF20A;
        Fri, 23 Jul 2021 15:53:16 +0000 (UTC)
Date:   Fri, 23 Jul 2021 17:53:15 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/3] regmap: add regmap using ARM SMCCC
Message-ID: <20210723175315.3eb149c7@fixe.home>
In-Reply-To: <20210723144317.GF5221@sirena.org.uk>
References: <20210723135239.388325-1-clement.leger@bootlin.com>
        <20210723135239.388325-2-clement.leger@bootlin.com>
        <20210723144317.GF5221@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Le Fri, 23 Jul 2021 15:43:18 +0100,
Mark Brown <broonie@kernel.org> a écrit :

> On Fri, Jul 23, 2021 at 03:52:37PM +0200, Clément Léger wrote:
> 
> > When running under secure monitor control, some controllers can be
> > placed in secure world and their access is thus not possible from
> > normal world. However, these controllers frequently contain
> > registers than are needed by the normal world for a few specific
> > operations.  
> 
> > This patch adds a regmap where registers are accessed using SMCs.
> > The secure monitor is then responsible to allow or deny access to
> > the requested registers.  
> 
> I can't see any SMC specification for this interface?  Frankly I have
> some very substantial concerns about the use case for this over
> exposing the functionality of whatever device the SMC is gating
> access to through SMC interfaces specific to that functionality.

This would require to modify drivers to check if the access should be
done using SMCs, parse the device tree to find appropriate SMC ids for
each functionality, add dependencies in KConfig on
HAVE_ARM_SMCCC_DISCOVERY, and do SMC calls instead of regmap access.
I'm not saying this is not the way to go but this is clearly more
intrusive than keeping the existing syscon support.

> Exposing raw access to a (presumed?) subset of whatever device
> functionality feels like the wrong abstraction level to be working at
> and like an invitation to system integrators to do things that are
> going to get them into trouble down the line.

Indeed, access is reduced to a subset of registers offset which are
checked by the TEE.

> 
> If the end user really is just twiddling a few bits here and there I'd
> expect those functionality specific services to be pretty simple to
> do, slightly more effort on the secure monitor side but a lot safer.

The SMC id is supposed to be unique for a given device. The TEE check is
merely a register offset check and a value check. But I agree that the
attack surface is larger than with a SMC targeted for a single
functionality though.

> If there is a use case for passing through an entire device for some
> reason (ran out of controllers or something?) then I think we
> probably want an abstraction at the bus level so we don't need to add
> custom support to every device that we want to pass through and it's
> clear what's going on.

In our use case, only a few registers located in a secure controller
is needed to be done. We don't have a use case for an entire device
access.

Clément

