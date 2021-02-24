Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC2D323AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhBXKkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbhBXKko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:40:44 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCBEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 02:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WMn5TcHWWe7SAyOco4vmuleRE5gtC1z+cxe5bn0dcO8=; b=dq8SfL/jmpFu0I06y6JWBO9ko
        ieZXijxI3AJ3VuN5GJlepO3YubxIWN8jfI95KliP7/JgA+aH4BHXmSAD3GQSV5vzbOYXjTvYn1lM4
        aPUVRBifieGHxHPbuez2ICgXsS6p/Q3XNfxnUWA+mlCnAdfdU9P5W8YhYfAmVyF6hLbnmo0B5PIJ0
        U1Ap8Lqy6hTi6PF9NoRYfmi80eHMIUS319egp9yOSxTtOP6FT9o0bnehlEuate8LgHoS7l1S5ift2
        +NrofKcbeELsCauWf389LRiUfy5da15qQsogIGNIZGERwtzHsyoYCbS4/hrnf6mAmtGhsfJ59pJs+
        mJ7dAUAnQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46646)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lEra5-0008Oa-SB; Wed, 24 Feb 2021 10:39:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lEra4-0003w6-Fh; Wed, 24 Feb 2021 10:39:44 +0000
Date:   Wed, 24 Feb 2021 10:39:44 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     liang wang <liang26812@gmail.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, geert@linux-m68k.org,
        penberg@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC]ARM: ftrace: pause/unpause function graph tracer in
 cpu_suspend()
Message-ID: <20210224103944.GQ1463@shell.armlinux.org.uk>
References: <1609738534-14369-1-git-send-email-liang26812@gmail.com>
 <CAG_0j0D9Vhc5F659ZrORLD4vh56MtGK8Zf4V1Ex3nXOjkLL1gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_0j0D9Vhc5F659ZrORLD4vh56MtGK8Zf4V1Ex3nXOjkLL1gg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 06:35:47PM +0800, liang wang wrote:
> Hi,all
> 
> ftrace function_graph tracer always cause kernel panic on my ARM device with
> multiple CPUs, I found a solution for the problem on ARM64, refers to
> the patch above,
> I was wondering why this bugfix on ARM64 hasn't been upstreamed to ARM,

Patches get applied to the ARM tree after they've been submitted to
the patch system. If they don't get submitted to the patch system,
then they get buried and forgotten.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
