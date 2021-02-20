Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8C320709
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 21:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBTURC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 15:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhBTURA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 15:17:00 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40C2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 12:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=upZ8Hi4SrGTAXw2AiRnKj2Xcx7KnfIWcZkYICu1X0tI=; b=HaBZgCpzFwXrt091ZYpM94EyO
        PvCdbIo3E/XWMJ47bay/UzfkbkLwrzMH1mbygSjGYPwVBHWzdtX08TCChee/mWOfbt8wQkJRBYbyZ
        dDb3mVRrato5kac4uCCmg3a7YXc0mCbQ4ssT8oTI+JBkLEu4Qyij30nYuFjjbbuJdNxkvjAsVT/2p
        9n2ENng6t5mUdpCvRF+2lr789mGyOKImSHM8Cm6oUOIKd27TdneoI7toM96gi1tRt0gl23dsAtRD6
        MMbOcm8Nl+gFQjqirhStORCTOdmnWe1SIqKYDtNfWpaBzUajfxGOskzT2C16cMmfnCaGdk6jiKnkk
        rPsgzw4UA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45988)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lDYfo-000590-Ir; Sat, 20 Feb 2021 20:16:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lDYfm-0000LL-3t; Sat, 20 Feb 2021 20:16:14 +0000
Date:   Sat, 20 Feb 2021 20:16:14 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Pitre <nico@fluxnic.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4] arm: OABI compat: fix build when EPOLL is not enabled
Message-ID: <20210220201613.GM1463@shell.armlinux.org.uk>
References: <20210220184748.30647-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220184748.30647-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 10:47:48AM -0800, Randy Dunlap wrote:
> ---
> KernelVersion: v5.11
> I don't know what format is used for KernelVersion.
> This patch applies to any Linux kernel v5.x and probably even older.

I normally ask for it to be the kernel version (without git) that the
patch was generated against, so if there's problems applying it, I
can try a bit harder to apply it (such as checking out that version
and applying it there, and then merging the result.)

It's original purpose was when I was maintaining the 2.4 and 2.5/2.6
kernel trees at the same time - it was critical to know which tree
people wanted their patch applied to.

Note that the patch system email parser can cope with the tag
appearing almost anywhere in the email - either the message header
or the body of the email, except intermingling with the patch itself.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
