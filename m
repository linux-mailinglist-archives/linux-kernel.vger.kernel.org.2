Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E36A391899
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhEZNU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhEZNU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:20:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2081EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AtyNGkK8eQQ4yETujkNMVRNzBw+u/5DNWTIq6k0iVNo=; b=HkQ97ZYa2u/HpSIixOgyTqLgU
        N81a37GEKox0QE4c9Ic6y88IPgXM/Fox8WCERAlzUnE4lbIEAU1gXqqsAsSYqXMNLNpVUJUIobJmB
        zAtOdg1Mt7Ky/4Zl6fZfY1Vzlc8nS6o/pCg1rWYvoNFGuQqAxiWSTodvcRBfRA0JLGiFBp1tM9jZa
        PExb1/6+lchstl7fOj8CV0vELRQzW2XZKetI7qbrbIUimjRj7uuyYUWTR29nUKR5a2dhOpbKRelMr
        umySRo0g9BaGm7iVHI1EYHa1LNIrkRcpR7mbwgSomU7EmCUo7m13QpVWMFI/U78u3qp9yAFFyvwKC
        WHLGNsUVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44374)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lltQz-0005e5-Mq; Wed, 26 May 2021 14:18:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lltQz-0002ps-Dl; Wed, 26 May 2021 14:18:53 +0100
Date:   Wed, 26 May 2021 14:18:53 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Data corruption on i.MX6 IPU in arm_copy_from_user()
Message-ID: <20210526131853.GE30436@shell.armlinux.org.uk>
References: <m3y2c1uchh.fsf@t19.piap.pl>
 <20210526100843.GD30436@shell.armlinux.org.uk>
 <m3r1htu19o.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3r1htu19o.fsf@t19.piap.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 02:29:07PM +0200, Krzysztof Hałasa wrote:
> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> 
> > Surely someone is not using copy_*_user() to copy data from userspace
> > direct to MMIO space... that would be crazy.
> 
> No, it's the other way around: reading MMIO mapped to userspace (mmap
> on /dev/mem) and copying it to simple kernel buffer (e.g. pipe buffer).
> I.e., the MMIO is the userspace here (thus copy_from_user()).

Ah. I think we assume copy_from_user() will be used on memory only and
not device mappings.

In any case, looking at the architecture reference manual, LDM is
permitted on device and strongly ordered mappings, and the memory
subsystem is required to decompose it into a series of 32-bit accesses.
So, it sounds to me like there could be a hardware bug in the buses/IPU
causing this.

Can you try using LDM directly inside the kernel and seeing what effect
it has when reading the IPU? A simple test module should be sufficient.
I suspect it'll show the same thing - basically, that using LDM to the
IPU is broken.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
