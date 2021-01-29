Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9D8308C58
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhA2SXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:23:44 -0500
Received: from mail.v3.sk ([167.172.186.51]:56366 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232618AbhA2SXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:23:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 85EBAE070D;
        Fri, 29 Jan 2021 18:18:14 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8KncK9UMIgCb; Fri, 29 Jan 2021 18:18:13 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B144EE0B3F;
        Fri, 29 Jan 2021 18:18:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3xU-cvvDS_i2; Fri, 29 Jan 2021 18:18:13 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 47A41E0B3E;
        Fri, 29 Jan 2021 18:18:13 +0000 (UTC)
Date:   Fri, 29 Jan 2021 19:22:19 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     kostap@marvell.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, robh+dt@kernel.org, vkoul@kernel.org,
        kishon@ti.com, miquel.raynal@bootlin.com, mw@semihalf.com,
        jaz@semihalf.com, nadavh@marvell.com, stefanc@marvell.com,
        bpeled@marvell.com
Subject: Re: [PATCH 1/4] drivers: phy: add support for Armada CP110 UTMI PHY
Message-ID: <20210129182219.GA74013@demiurge.local>
References: <20210127112719.30632-1-kostap@marvell.com>
 <20210127112719.30632-2-kostap@marvell.com>
 <20210129092849.GA68955@demiurge.local>
 <20210129100713.GU1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129100713.GU1551@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 10:07:13AM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Jan 29, 2021 at 10:28:49AM +0100, Lubomir Rintel wrote:
> > > +	/*
> > > +	 * Setup PLL. 40MHz clock used to be the default, being 25MHz now.
> > > +	 * See the functional specification for details.
> > 
> > I tried to, couldn't find it. Perhaps you could elaborate more here, or
> > include a link in the header.
> 
> Marvell documents are generally not publically available. This is the
> case here.

In that case the "elaborate more" part applies, otherwise the comment
remains rather meaningless. Perhaps it wouldn't be too difficult to
clarify things with an extra sentence or two without revealing any
secrets.

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

Take care
Lubo
