Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A714736CAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbhD0SEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbhD0SEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:04:40 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A203C061574;
        Tue, 27 Apr 2021 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E7zb0oK3WjxUHxPQ/MvMrL1VfGxeoNA00qBLofYv7W8=; b=FrlrztJ1WNAkAfDrZuXxjpvtq
        PoOdbfxaFe4N5vi6/eA2wJPuQZNGs2b/oYKFHGtXcRDAO0wTPiaobXRSE8kIbZGGTRzubW9yGuYu4
        p05trRy9CsroIfNM8Ig7D6abiqyr1uUMi8egibQpoIV8/Ogw0IHJEwfR5QoAwNH9frxpNKuwrH2aE
        MEwL2J7JQOLY2ITNGhWV8Jr5pGazh6tOLDJorVFu9Ap9atJuwK3vL5yO3VSJTYXPykF2lnYB4xLcG
        5mSXlgZaG+WsJ5uSoBFwUoQdbGg5vLyTHAgR6pLb2e15pLSnF1gJL8c+rtxeBOGNWLFnPvJOIPhwB
        Ouc3pju9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52796)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lbS3v-0001pa-0i; Tue, 27 Apr 2021 19:03:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lbS3u-0004mx-Nj; Tue, 27 Apr 2021 19:03:54 +0100
Date:   Tue, 27 Apr 2021 19:03:54 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: <linux/clk.h>: correct clk_get_parent()
 documentation
Message-ID: <20210427180354.GV1463@shell.armlinux.org.uk>
References: <20210427031342.5333-1-rdunlap@infradead.org>
 <20210427093809.GU1463@shell.armlinux.org.uk>
 <9574eefa-84ed-8674-f575-be47d2a51a1c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9574eefa-84ed-8674-f575-be47d2a51a1c@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 10:07:04AM -0700, Randy Dunlap wrote:
> On 4/27/21 2:38 AM, Russell King - ARM Linux admin wrote:
> > On Mon, Apr 26, 2021 at 08:13:42PM -0700, Randy Dunlap wrote:
> >> Make the kernel-doc return value agree with both the stub implementation
> >> in <linux/clk.h> and the non-stub function in drivers/clk/clk.c.
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Russell King <linux@armlinux.org.uk>
> >> Cc: linux-clk@vger.kernel.org
> >> ---
> >> There are several drivers that call clk_get_parent() and use its
> >> return value as though it returns an ERR_PTR(). I am working on a
> >> patch series to fix those.
> > 
> > The whole premise of the CLK API is that:
> > 
> > - clk values that IS_ERR() returns true are errors
> > - clk values that IS_ERR() returns false are valid
> > 
> > and that is that - nice, simple, easy to understand. So the
> > documentation is correct. If clk_get_parent() needs to return an
> > error, it does so by returning an error-pointer, not by returning
> > NULL.
> 
> Hm, so the 6 drivers that do this are OK then, if
> clk_get_parent() returns NULL?
> 
> 
> 	parent = clk_get_parent(clk);
> 	if (IS_ERR(parent)) {
> 		dev_err(cpu_dev, "Cannot get parent clock for CPU0\n");
> 		clk_put(clk);
> 		return PTR_ERR(parent);
> 	}
> 
> 	/* Get parent CPU frequency */
> 	base_frequency =  clk_get_rate(parent);
> 
> boom?

As I say, the premise is that only clocks where IS_ERR(clk) is true
are an error. Everything else must be treated as an acceptable clock.

Sometimes the NULL clock is used for "I don't have a clock", and that
must not cause the API to go "boom".

In the case of the CCF implementation, clk_get_rate(NULL) will return
0.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
