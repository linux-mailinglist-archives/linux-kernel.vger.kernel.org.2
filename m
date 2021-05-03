Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725E43713E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 12:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhECK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 06:59:23 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:51020 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbhECK7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 06:59:22 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 143Akm0o036864;
        Mon, 3 May 2021 18:46:48 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from aspeedtech.com (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 18:58:27 +0800
Date:   Mon, 3 May 2021 18:58:19 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>
CC:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: aspeed: ast2600evb: Add timing-phase
 property for eMMC controller
Message-ID: <20210503105819.GC12520@aspeedtech.com>
References: <20210503014336.20256-1-steven_lee@aspeedtech.com>
 <20210503014336.20256-3-steven_lee@aspeedtech.com>
 <f237a53e-ad61-469a-a19f-8a1e52c6cfba@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <f237a53e-ad61-469a-a19f-8a1e52c6cfba@www.fastmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 143Akm0o036864
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 05/03/2021 13:07, Andrew Jeffery wrote:
> Hi Steven,
> 
> On Mon, 3 May 2021, at 11:13, Steven Lee wrote:
> > Set eMMC input clock phase to 3, which is more stable on AST2600 EVBs.
> > 
> > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > ---
> >  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts 
> > b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > index 2772796e215e..7a93317e27dc 100644
> > --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > @@ -102,6 +102,7 @@
> >  
> >  &emmc_controller {
> >  	status = "okay";
> > +	timing-phase = <0x300FF>;
> 
> Please use the existing binding for phase corrections. The existing 
> binding is already supported by the driver (added in v5.12).
> 

Hi Andrew,

Thanks for the review.
I will add the following settings from aspeed-bmc-ibm-rainier.dts
instead of adding timing-phase in device tree.

        clk-phase-mmc-hs200 = <N> <N>;

> Andrew
