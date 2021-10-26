Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C6543AE73
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhJZJCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhJZJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:02:07 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF69C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0hA9F2izcUGC40cVRcQ0tDFSmX7Q4rUQYCuTHCJ3bRY=; b=PdauVmbTEfXxx4kHsYgM2RQder
        N6z0NcQjMHMvVUd6LgQwW33d+H0wc7sTVyuH0BM1b10/8DWcU7SPElHAMSoxvu3J4uoFGQacbBZJZ
        4oYjve/XFElbji/RX2Husw+iOvSt6/SdGDKR6/GGws/V65UrBxTJ/jO9JTMbOULpGwd+kV9fXIE6n
        IfyqMpeTjuvz7+DJzNlXVzNbv8rGNmO9J/+U8MqRveTpRoXAqxNv0kP2T2YlPmRFoSnm49CTMPT1x
        k8RPzU4HOuDhpLK1kgQyJyQudtzMtJY+JRTAXu3ChYoorzpjf3ErlqDsGI8LKgFmhaVlZloAsCNNJ
        flYKtvJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55302)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mfIIy-00055M-UU; Tue, 26 Oct 2021 09:59:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mfIIw-0006cF-L9; Tue, 26 Oct 2021 09:59:34 +0100
Date:   Tue, 26 Oct 2021 09:59:34 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     quanyang.wang@windriver.com, Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: add BUILD_BUG_ON to check if fixmap range spans
 multiple pmds
Message-ID: <YXfDdmrCynZk/QW8@shell.armlinux.org.uk>
References: <20211020054942.1608637-1-quanyang.wang@windriver.com>
 <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 11:44:31PM +0200, Linus Walleij wrote:
> On Wed, Oct 20, 2021 at 7:50 AM <quanyang.wang@windriver.com> wrote:
> 
> > From: Quanyang Wang <quanyang.wang@windriver.com>
> >
> > Not only the early fixmap range, but also the fixmap range should be
> > checked if it spans multiple pmds. When enabling CONFIG_DEBUG_HIGHMEM,
> > some systems which contain up to 16 CPUs will crash.
> >
> > Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> 
> Looks reasonable to me.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please submit this patch into Russell's patch tracker.

... and has totally broken what looks like _all_ ARM kernel builds. It
can not have been tested. Maybe it's uncovered a previously unknown
problem, but causing such a wide-range regression is disappointing.
I'm going to revert this commit.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
