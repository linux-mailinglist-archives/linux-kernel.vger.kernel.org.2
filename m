Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AD039DD30
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhFGNBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:01:30 -0400
Received: from foss.arm.com ([217.140.110.172]:32774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhFGNB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:01:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E11BE12FC;
        Mon,  7 Jun 2021 05:59:37 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3213F694;
        Mon,  7 Jun 2021 05:59:36 -0700 (PDT)
Date:   Mon, 7 Jun 2021 13:59:27 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 14/17] arm64: dts: allwinner: Add Allwinner H616
 .dtsi file
Message-ID: <20210607135927.65e98fc8@slackpad.fritz.box>
In-Reply-To: <20210524120220.j73xwq7n5qbaxs4r@gilmour>
References: <20210519104152.21119-1-andre.przywara@arm.com>
        <20210519104152.21119-15-andre.przywara@arm.com>
        <20210524120220.j73xwq7n5qbaxs4r@gilmour>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 14:02:20 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

> Hi,
> 
> On Wed, May 19, 2021 at 11:41:49AM +0100, Andre Przywara wrote:
> > This (relatively) new SoC is similar to the H6, but drops the (broken)
> > PCIe support and the USB 3.0 controller. It also gets the management
> > controller removed, which in turn removes *some*, but not all of the
> > devices formerly dedicated to the ARISC (CPUS).
> > And while there is still the extra sunxi interrupt controller, the
> > package lacks the corresponding NMI pin, so no interrupts for the PMIC.
> > 
> > USB is a bit tricky: host controller 0, 1 and 3 depend on some help from
> > controller and PHY 2, so we need to include one reset line and one
> > clock gate from HCI 2 into every other HCI node, plus need some nasty
> > quirk.
> > 
> > The reserved memory node is actually handled by Trusted Firmware now,
> > but U-Boot fails to propagate this to a separately loaded DTB, so we
> > keep it in here for now, until U-Boot learns to do this properly.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>  
> 
> As far as I can see, the IOMMU hasn't changed between the H6 and the
> H616, so it would be worth enabling

I would rather not include anything that can't be tested at this point.
IIUC the IOMMU is still only for the video devices, which I omitted at
all so far - the display engine definitely needs code changes (Jernej
has something in the making).
So I'd like to wait for the IOMMU nodes till we get DE or VE support.

Cheers,
Andre
