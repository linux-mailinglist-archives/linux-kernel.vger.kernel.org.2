Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA72330219
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 15:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCGOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 09:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhCGOaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 09:30:16 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D1C06174A;
        Sun,  7 Mar 2021 06:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xsfa9jRujYdnKBIUGSDMXc9MC+mwfFswtb0biyNkeSI=; b=j3LpT9FNZgliqiRDkO9V7aUok
        ZFybi0K8ZYzD3KP6jOIrqRR85c1/k++e6YMbhZVox7mtjYeJFErXu6cGVeb4kI4azSR18Ax3lCB9e
        S2D+JOFXkn+qCebBWuDR+wo5tRAqqY2ESR+zsA30maTicNIUMxNV9QU9smprFbaQm0dVS5UCjorRr
        qoa+MkRBwEAz8FT2DEdydMLAvJs9vHxlVDQRNEkUzxCHmnfs/nzak2KA4A0RuAXFxRQ4bZ3VvxB6S
        a7sYhNh0xdz4oAWyxLd8OtNmiAV4D7Jnza6vG/mIJBY17q7vmCqD+2EOqOGUmz+DrifJZmrCOYIZj
        UlvFJ6J0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49700)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lIuQA-0001FK-4C; Sun, 07 Mar 2021 14:30:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lIuQ9-0006Gf-Rx; Sun, 07 Mar 2021 14:30:13 +0000
Date:   Sun, 7 Mar 2021 14:30:13 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: Fix doc of clk_get_parent
Message-ID: <20210307143013.GE1463@shell.armlinux.org.uk>
References: <20210307140626.22699-1-paul@crapouillou.net>
 <20210307142701.GD1463@shell.armlinux.org.uk>
 <J8SLPQ.MXUB9SDIPWN13@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <J8SLPQ.MXUB9SDIPWN13@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 02:29:07PM +0000, Paul Cercueil wrote:
> Hi,
> 
> Le dim. 7 mars 2021 à 14:27, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> a écrit :
> > On Sun, Mar 07, 2021 at 02:06:26PM +0000, Paul Cercueil wrote:
> > >  On error, or when the passed parameter is NULL, the return value is
> > > NULL
> > >  and not a PTR_ERR()-encoded value.
> > 
> > No, the documentation is accurate. The CCF is just an implementation
> > of the API, the file you are modifying is the definitive API
> > documentation.
> 
> Well, then the code has to be fixed, because right now it returns NULL on
> error, since the 2.6 days.

And you consider NULL to be an error? A NULL clock isn't defined to be
an error by the API.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
