Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E63730ACCB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBAQix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhBAQit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:38:49 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0151C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DiYAma/MBy6d/6tlWAVVUX9ISv3Qk+f30UuNARw1WNs=; b=fvEQCjgvdCcZe8Xne0Rfl02dV
        MvST6TvtR+1gQxy0FPmQi99pVXI//4AtDNmaKJl+5zDQt12hpXfY4qT4JarsgVtZtFpb6ytMMTRcS
        bxpZpuaBy4n9eOqVQU/3D3ODef721+pW2ovO3gNA6i7VYICbTK5MzC+nH+76vpcM2SVR4ujpbLII8
        3vpUnpt6bMuXpyN13XRqdjBqwLpTo1loOaDzoBJHQbkOQgtlhQUkW5fn65yVHNyNbtcoDDp5aFdyE
        s0G7sHLFK+xi8IlXevRPfNPS9aVZhxUo2W2igmToHkHsB87a3TERJLmOY1N3kakEl3HNkQtrcQRHe
        dyE0mUAZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37818)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l6cD1-0003VV-RR; Mon, 01 Feb 2021 16:37:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l6cD0-0002A0-U9; Mon, 01 Feb 2021 16:37:50 +0000
Date:   Mon, 1 Feb 2021 16:37:50 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>,
        linux-kernel@vger.kernel.org, penberg@kernel.org,
        geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, rppt@kernel.org,
        giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201163750.GI1463@shell.armlinux.org.uk>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201130344.GF1463@shell.armlinux.org.uk>
 <20210201135714.GB66060@C02TD0UTHF1T.local>
 <20210201160838.GH1463@shell.armlinux.org.uk>
 <20210201163240.GE66060@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201163240.GE66060@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 04:32:40PM +0000, Mark Rutland wrote:
> I reckon here we need:
> 
> 	__cpuc_flush_dcache_area(reboot_code_buffer,
> 				 relocate_new_kernel_size + sizeof(*data));
> 
> ... to make sure both the instructions and data are visible with the MMU
> off (since fncpy() only cleans to the PoU, not the PoC).

We don't. When soft_restart() turns the MMU off, and it calls
flush_cache_all() before and afterwards to ensure that all dirty lines
are pushed out.

The flushing to PoU in fncpy() is to cover other cases.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
