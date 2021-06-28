Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0AE3B6687
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhF1QSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhF1QSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:18:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A066C061574;
        Mon, 28 Jun 2021 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AVS6wdnWgOLuiMtZUjGyWXos+iEGLYpsp9B+2iMmy1U=; b=u0sS8zoyGjUHUotlbA0+9HB4p
        4OXEh/9UjF/Wg+37pMDYZV6j13nPc/tC8rg/ZC7s3bCyK2XX71zq0t23x4b9HLZQ+3V7mCU6Z4iVn
        2qTY8jLv9lYHQr9wQZfWZxZ8GM0IUr3aIV3limdLFQEzIiqYbnhKH81CKX3U1vC8p/6S9NGg0DLr8
        pwL4gklHv3afK1PUMlggJ/f4H4g/+ojFKsztpi9j+58uDbIxU2F4QsQGNxpnrWv3gJPw//szxWDFX
        uFXsF/j2uoMlW9Ph1m+cQ4x0O7KAmAuWbKpQm+9s8v7N6aseagTPgKDfZ6Mp5MSQvdxhOTKEoskCp
        A4HgLqdLw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45434)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lxtvr-0003gw-Ei; Mon, 28 Jun 2021 17:16:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lxtvo-0001Bp-Vg; Mon, 28 Jun 2021 17:16:20 +0100
Date:   Mon, 28 Jun 2021 17:16:20 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: armada-3720-turris-mox: remove
 mrvl,i2c-fast-mode
Message-ID: <20210628161620.GB22278@shell.armlinux.org.uk>
References: <20210628121015.22660-1-pali@kernel.org>
 <20210628151229.25214-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210628151229.25214-1-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 05:12:29PM +0200, Pali Rohár wrote:
> Some SFP modules are not detected when i2c-fast-mode is enabled even when
> clock-frequency is already set to 100000. The I2C bus violates the timing
> specifications when run in fast mode. So disable fast mode on Turris Mox.

Yes. SFP module specification is 100kHz max on the I2C bus, which is
often forgotten about until someone runs into a problem.

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
