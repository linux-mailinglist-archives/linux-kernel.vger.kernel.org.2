Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC43C14A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhGHNuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhGHNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:50:06 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0E9C061574;
        Thu,  8 Jul 2021 06:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1onv7D7UfHyZd8wp8ojsjToOmTb+gozwlqpKz22PFwA=; b=TpZkE+0BQeQej1Agy5fZqyTFT
        hFSYwtGsK8Pl+xngd8lz79GnwL+3yN0X+W+qtFrhv+pJFh8XZlBfSZuIBUCUkcn/IiKtdPYXJQMtx
        HMs/fl7rkKdoPTLQuJt4psYINCtusbYYLmROGLujLQMGzhzSIFHGo7lBZAs0pKDgBkxQZN/+db2V4
        t+Cafd1TchDzzeDobP+gzHLGTXklXgsDW/faAZsdni5GlC0svTdFPk+UUfYlUXdapHTEF7b1ul3HQ
        VLcyNW8Ti3U1KRU3mpIABO7RaBFtDydNHcb1eNMyLFrHyC1QPWsOfw8PsCOE+gOIz7btAG7bPnDVM
        9/d2T69mA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45872)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m1UN0-0000jh-7e; Thu, 08 Jul 2021 14:47:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m1UMw-0003wE-ER; Thu, 08 Jul 2021 14:47:10 +0100
Date:   Thu, 8 Jul 2021 14:47:10 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     kostap@marvell.com
Cc:     miquel.raynal@bootlin.com, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, vladimir.vid@sartura.hr,
        luka.kovacic@sartura.hr, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mw@semihalf.com,
        jaz@semihalf.com, nadavh@marvell.com, stefanc@marvell.com,
        bpeled@marvell.com
Subject: Re: [PATCH v7 5/5] arch/arm64: dts: change 10gbase-kr to 10gbase-r
 in Armada
Message-ID: <20210708134710.GW22278@shell.armlinux.org.uk>
References: <20210708124612.30742-1-kostap@marvell.com>
 <20210708124612.30742-6-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708124612.30742-6-kostap@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 03:46:12PM +0300, kostap@marvell.com wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
> 
> Change all 10G port modes in Armada family device trees from
> 10gbase-kr to 10gbase-r
> 
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> Suggested-by: Russell King <linux@armlinux.org.uk>

Please change the "suggested-by" to:
Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
