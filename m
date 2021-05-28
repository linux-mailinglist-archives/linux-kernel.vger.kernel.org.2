Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA26C394445
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbhE1OhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhE1OhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:37:23 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC29C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R4ITbO2zQ8+lQSlzYrqLkEM0zhWRWfeQJIIZ5GiIeA8=; b=eo/JmWVlEvb6d7ZTxUyMeDveB
        k4g9KxD+wLtVzPfA8XlBRYVbAQYrXKqpVqeQSmBlOEOwYvIdaejXctscaVFmzPeMhz37UD3KJhVG8
        ZbPll31d6s0h19rEC9xTjyEjFxigmG+CbdkzAOF8+bn5WjIrH8KbPfzyohjFNdHyp71u+cnIF09Z9
        qLvgDmh0QtNdpIij93/nFNpotFyxnnBV2R8SIqQMO7u/NWCrkxXsQzI0Cv1g+sG083QQ4ihNnA/Io
        8irfy1kx20apIZc15THyTauPDvsQXDLvpqyFXe/nW7TYqOxpC5ofI0VgijwM+V4jdS8Bil4QCTlGU
        0aB1kHC+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44444)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lmdaU-000063-FN; Fri, 28 May 2021 15:35:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lmdaS-0004mG-TV; Fri, 28 May 2021 15:35:44 +0100
Date:   Fri, 28 May 2021 15:35:44 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Data corruption on i.MX6 IPU in arm_copy_from_user()
Message-ID: <20210528143544.GQ30436@shell.armlinux.org.uk>
References: <m3y2c1uchh.fsf@t19.piap.pl>
 <20210526100843.GD30436@shell.armlinux.org.uk>
 <m3r1htu19o.fsf@t19.piap.pl>
 <20210526131853.GE30436@shell.armlinux.org.uk>
 <m3h7intbub.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3h7intbub.fsf@t19.piap.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 12:02:52PM +0200, Krzysztof Hałasa wrote:
> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> 
> > In any case, looking at the architecture reference manual, LDM is
> > permitted on device and strongly ordered mappings, and the memory
> > subsystem is required to decompose it into a series of 32-bit accesses.
> > So, it sounds to me like there could be a hardware bug in the buses/IPU
> > causing this.
> 
> It seems so.
> 
> I modified the kernel IPU module a bit, initialized a bunch of IPU
> registers to known values (1..0xD). Results (from 1 to 13 IPU
> registers) obtained with different instructions:
> 
> readl(13 consecutive registers): CSI = 1 2 3 4 5 6 7 8 9 A B C D
> 1 = register #0 and so on - readl() results are obviously correct.
> 
> LDM1:  1 (not corrupted)
> LDM2:  1 3
> LDM3:  1 3 4
> LDM4:  2 3 4 4
> LDM5:  1 3 4 5 6
> LDM6:  1 3 4 5 6 7
> LDM7:  1 3 4 5 6 7 8
> LDM8:  2 3 4 5 6 7 8 8
> LDM9:  1 3 4 5 6 7 8 9 A
> LDM10: 1 3 4 5 6 7 8 9 A B
> LDM11: 1 3 4 5 6 7 8 9 A B C
> LDM12: 1 3 4 5 6 7 8 9 A B C D

That's rather sad, and does look very much like a hardware bug.

The question is what to do about it... there's Linus' "do not break
userspace" edict and that's exactly what this change has done. So I
suppose we're going to have to revert the change and put up with
everything being slightly slower on arm32 than it otherwise would
have been. That probably means we'll end up with almost every kernel
tree out there carrying a revert of the revert to work around the
fact that seemingly NXP broke their hardware - which itself is not
a good idea. I guess we're just going to have to put up with that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
