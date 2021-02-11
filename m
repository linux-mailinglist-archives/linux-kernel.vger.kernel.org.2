Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62D0318927
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhBKLMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhBKKxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:53:09 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9FC06178B;
        Thu, 11 Feb 2021 02:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n2jv6riMUsox9J+M/vK0Ktetfs55I55iNexrJKgD5UI=; b=GdkBd1S457VLAefOmcvVtCYPb
        0trVpPOCxxVlSAJH1m6baoNepic+5tPjFwZCrjxLIphXOXuE27v8l9HHOlQAD+jYmVUAh/8P+9JWx
        ZcuI+HSuCPcTQ9EaUnWNHUX3AFxA6nIIt3HbNE+l1aHTqE8nQXuVhUZCENiMAQNcBIQ83yLIpz4C0
        NrG3bKPvVR2DoLeXjGbJTpHiUFCfuBWRMG8AVXz018Q0/zEC14/kxAYmueU/sYEKvdfoVwAsP0E9m
        pbFHSycBmmdg+a2W1lAZVWORmLxT/J7lsogxfGYU1ImmPEnEIJRQsZbPnoyjoQuj8owqrloMFuez0
        9KCcrC5fA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41984)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lA9aB-0005xo-Bm; Thu, 11 Feb 2021 10:52:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lA9aA-00060y-KL; Thu, 11 Feb 2021 10:52:22 +0000
Date:   Thu, 11 Feb 2021 10:52:22 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     kostap@marvell.com, Jon Nettleton <jon@solid-run.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, mw@semihalf.com, jaz@semihalf.com,
        nadavh@marvell.com, stefanc@marvell.com, bpeled@marvell.com
Subject: Re: [PATCH v2 01/12] fix: arm64: dts: replace wrong regulator on ap
 emmc
Message-ID: <20210211105222.GY1463@shell.armlinux.org.uk>
References: <20210210140949.32515-1-kostap@marvell.com>
 <20210210140949.32515-2-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210140949.32515-2-kostap@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 04:09:38PM +0200, kostap@marvell.com wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
> 
> Replace wrong regulator in AP0 eMMC definition on MacchiatoBIN
> board with 3.3V regulator.
> The MacchiatoBIN board has no 1.8V regulator connected to AP0
> eMMC (ap0_sdhci0) interface.

There seems to be some variability between Macchiatobin versions
according to the schematics.

The VDDO_H supply is connected to the eMMC VCCQ pins, and is also
connected to the AP_VDDO_H pins. It is wired to the 1.8V regulator
on rev 1.1 schematics, but hard-wired to the 3.3V regulator on
rev 1.3 schematics.

This needs clarification from SolidRun before the patch can be
accepted - was VDDO_H ever wired to the 1.8V regulator on production
hardware?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
