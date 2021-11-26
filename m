Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728ED45E7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358752AbhKZGik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:38:40 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:42720 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358953AbhKZGgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:36:38 -0500
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id DD5AD261B6F; Fri, 26 Nov 2021 07:33:24 +0100 (CET)
Date:   Fri, 26 Nov 2021 07:33:24 +0100
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Add DTs for all Apple M1 (t8103) devices
Message-ID: <20211126063324.GB28130@jannau.net>
References: <20211122225807.8105-1-j@jannau.net>
 <b38bb236-d739-4514-e79a-d7666ae23337@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38bb236-d739-4514-e79a-d7666ae23337@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

On 2021-11-26 14:39:16 +0900, Hector Martin wrote:
> On 23/11/2021 07.58, Janne Grunau wrote:
> > 
> > Janne Grunau (4):
> >    dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
> >    arm64: dts: apple: Add missing M1 (t8103) devices
> >    arm64: dts: apple: t8103: Add i2c nodes
> >    arm64: dts: apple: t8103: Add cd321x nodes
> > 
> >   .../devicetree/bindings/arm/apple.yaml        |  6 +-
> >   arch/arm64/boot/dts/apple/Makefile            |  4 +
> >   arch/arm64/boot/dts/apple/t8103-j274.dts      | 33 +------
> >   arch/arm64/boot/dts/apple/t8103-j293.dts      | 41 +++++++++
> >   arch/arm64/boot/dts/apple/t8103-j313.dts      | 33 +++++++
> >   arch/arm64/boot/dts/apple/t8103-j456.dts      | 59 ++++++++++++
> >   arch/arm64/boot/dts/apple/t8103-j457.dts      | 47 ++++++++++
> >   arch/arm64/boot/dts/apple/t8103-jxxx.dtsi     | 67 ++++++++++++++
> >   arch/arm64/boot/dts/apple/t8103.dtsi          | 92 +++++++++++++++++++
> >   9 files changed, 352 insertions(+), 30 deletions(-)
> >   create mode 100644 arch/arm64/boot/dts/apple/t8103-j293.dts
> >   create mode 100644 arch/arm64/boot/dts/apple/t8103-j313.dts
> >   create mode 100644 arch/arm64/boot/dts/apple/t8103-j456.dts
> >   create mode 100644 arch/arm64/boot/dts/apple/t8103-j457.dts
> >   create mode 100644 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> > 
> 
> Whole series is:
> 
> Tested-by: Hector Martin <marcan@marcan.st>
> 
> on j274, j313, j456.
> 
> Thanks! If you spin up a v4 with the minor comments addressed, I'll be happy
> to merge it :)

there is already a v4 with Sven's comments addressed at

https://lore.kernel.org/linux-arm-kernel/20211123224926.7722-1-j@jannau.net/

Jean-Marc Ranger notified me off-list of a typo in "arm64: dts: apple: 
t8103: Add cd321x nodes" commit messages: 'addiotional'.

I don't think it's worth spinning up a v5 for fixing that typo.

thanks,

Janne
