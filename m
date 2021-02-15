Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8752131C04F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhBORRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:17:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232571AbhBOQNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:13:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A75C764DEE;
        Mon, 15 Feb 2021 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613405582;
        bh=a9uwCBKNeFSR5bYXMjntrzv4ov5FwxtxfO/jd5FN3wY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dq/loXr5mDPaJrM8T9VahgDDoCYG+dIV4NY5v1Oct+jPIv8AOlYpTou2XSjWMrmMa
         j/+TomuidCXEdvLlZQF8RoK2PR9vKKPeNnM7Rso3t3x/iru3wf0/0BCwJx/21vVxCA
         BS4fHMHavOHQ57lPZgsgqkSCdN5i/gIOGc+39UDQ=
Date:   Mon, 15 Feb 2021 17:12:59 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stan Skowronek <stan@corellium.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 00/25] Apple M1 SoC platform bring-up
Message-ID: <YCqdi/5TSlbt0w/2@kroah.com>
References: <20210215121713.57687-1-marcan@marcan.st>
 <CAK8P3a1bXiWcieqTSZARN+to=J5RjC2cwbn_8ZOCYw2hhyyBYw@mail.gmail.com>
 <YCp1p1tRHF6OyR0C@kroah.com>
 <7c8bcf79-233b-7ea8-4fea-2fb29ca430ef@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8bcf79-233b-7ea8-4fea-2fb29ca430ef@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:57:27AM +0900, Hector Martin wrote:
> On 15/02/2021 22.22, gregkh wrote:
> > On Mon, Feb 15, 2021 at 01:57:39PM +0100, Arnd Bergmann wrote:
> > > (adding maintainers for the serial/irqchip/clocksource drivers and
> > > arch/arm64 to cc)
> > > 
> > > I would suggest merging it together as a series through the soc tree for
> > > v5.13, once each patch has been reviewed by the respective subsystem
> > > maintainers, with possible add-on patches on the same branch for
> > > additional drivers that may become ready during the 5.12-rc cycle.
> > > After the initial merge, driver patches will of course go through subsystem
> > > trees as normal.
> > > 
> > > Let me know if that works for everyone.
> > 
> > Sure, as long as the maintainers get to see the patches, I don't think
> > I've seen the serial ones at all...
> 
> Sorry, I figured Krzysztof would take a look at it first and I didn't want
> to spam too much. I'm still getting used to figuring out who to CC...

scripts/get_maintainer.pl is your friend.

> Do you want to take a look at v2, or wait for v3?

v3 is fine, I can't do anything until after 5.12-rc1 is out anyway.

thanks,

greg k-h
