Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AC83BF90D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhGHLd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhGHLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:33:57 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF3AC061574;
        Thu,  8 Jul 2021 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bbyR1F16p1tRYPcUbpgTSalCf5u8zAJ9zT0uymCmpbc=; b=m6FT/x/yn/ggFqI2/qYAnOG4n
        wz+NoEdUVAljhki0NCx0tZdeWTvXee+fseVcY9KD/SxFf/Cbavfj4iowpUwpjJik3Kim2zzGW3Fjk
        tf6Afqbd3xXGNJg5tp7l7KqI0A5sI7MdIscjgmezPQDXClC4NuP/4Z8MGuJrLmubuH/e6e6gcNTZM
        eDgYoE98S3/wwyehe06l2LWfQyZuqfLmQ7NzzXGL6rsHxI0Xw2RchIlbljHVdn3d5DJt9G5y/l7J8
        Cz2MaiYrDBRW5Qs1ZvZ2idpXxrqxdTYz16e8619KUZpqfxCXqva46HduGQ5Jzmfl+ZhaRITwpy7OP
        a9ulDj9Dw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45864)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m1SFK-0000a0-Ao; Thu, 08 Jul 2021 12:31:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m1SFJ-0003qw-I3; Thu, 08 Jul 2021 12:31:09 +0100
Date:   Thu, 8 Jul 2021 12:31:09 +0100
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
Subject: Re: [PATCH v6 1/5] Documentation/bindings: phy: update references to
 cp11x
Message-ID: <20210708113109.GV22278@shell.armlinux.org.uk>
References: <20210708112528.3254-1-kostap@marvell.com>
 <20210708112528.3254-2-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708112528.3254-2-kostap@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 02:25:24PM +0300, kostap@marvell.com wrote:
> From: Grzegorz Jaszczyk <jaz@semihalf.com>
> 
> The cp11x references in dts has changed, reflect it in comphy
> documentation.
> 
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>

I don't think it's really necessary to reflect the syntactic sugar
that gets used to cope with the fact we have two CP11x dies in the
DT examples. They are exactly that - an example of the usage. They
don't need to reflect reality.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
