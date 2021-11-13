Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D578C44F2B3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 12:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhKMLRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 06:17:15 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:54566 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235818AbhKMLRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 06:17:08 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Nov 2021 06:17:08 EST
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 4FA00261AB6; Sat, 13 Nov 2021 12:05:52 +0100 (CET)
Date:   Sat, 13 Nov 2021 12:05:52 +0100
From:   Janne Grunau <j@jannau.net>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: dwc3: Add role switch reset quirk for Apple
 DWC3
Message-ID: <20211113110552.GA10073@jannau.net>
References: <20211108170946.49689-1-sven@svenpeter.dev>
 <20211108170946.49689-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108170946.49689-2-sven@svenpeter.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-08 18:09:46 +0100, Sven Peter wrote:
> As mad as it sounds, the dwc3 controller present on Apple SoCs must be
> reset and reinitialized whenever a device is unplugged from the root port
> and triggers a role switch notification from the USB PD controller.
> 
> This is required for at least two reasons:
> 
>   - The USB2 D+/D- lines are connected through a stateful eUSB2 repeater
>     which in turn is controlled by a variant of the TI TPS6598x USB PD
>     chip. When the USB PD controller detects a hotplug event it resets
>     the eUSB2 repeater. Afterwards, no new device is recognized before
>     the DWC3 core and PHY are reset as well.
> 
>   - It's possible to completely break the dwc3 controller by switching
>     it to device mode and unplugging the cable at just the wrong time.
>     Even a CORESOFTRESET is not enough to allow new devices again.
>     The only workaround is to trigger a hard reset of the entire
>     dwc3 core. This also happens when running macOS on these
>     machines.

This patch is necessary and works on M1 Max (Macbook Pro 14" 2021).  
Tested with compatible = "apple,t6000,dwc3", "apple,dwc3", "snps,dwc3";.

Feel free to add

Tested-by: Janne Grunau <j@jannau.net>

Janne
