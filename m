Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836213AB26F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhFQLZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhFQLZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:25:30 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889FBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JXDXDLb/QIF75AJOX9ohvjSu+6uIrUNwcseh+WML+vw=; b=DM0LmQMgaAJK5lRc4d2fK8U23
        tmHTratjNX+m60IpRCKHGGrdqWzF9uDHt4aRdt6A9aBqKUXkldnAOsrmNonZacg58aKLcLAdwwnIS
        VQ8Og3KArTPSSYXvQC3+B1TVbxwT8FSGPd+XkEs7hYbE9/+I2aec7qh3JktHRNX6Dtam1Y8PqfJy8
        QzxohAc2YiO9sZVgN/7pGGmJBbauEjUif6qJEZ37AdDOsXLzuPjIuvrtJ630vI+LwWI6KkSNPTaJh
        5YkuuFUaSYjYjTkcQ+ghC/q+RtZ3XOYIhcCTB28TblZUEf9vbssjsYCKBFALJtARe985BMx92dZkQ
        gxvri/Fdg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45102)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ltq76-00009r-Qg; Thu, 17 Jun 2021 12:23:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ltq6z-0006xh-FC; Thu, 17 Jun 2021 12:23:05 +0100
Date:   Thu, 17 Jun 2021 12:23:05 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210617112305.GK22278@shell.armlinux.org.uk>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <20210617103524.GA82133@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617103524.GA82133@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:40:46AM +0100, Mark Rutland wrote:
> On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote:
> > On arm32, the only way to safely flush icache from usermode is to call
> > cacheflush(2).  This also handles any required pipeline flushes, so
> > membarrier's SYNC_CORE feature is useless on arm.  Remove it.
> 
> Unfortunately, it's a bit more complicated than that, and these days
> SYNC_CORE is equally necessary on arm as on arm64. This is something
> that changed in the architecture over time, but since ARMv7 we generally
> need both the cache maintenance *and* a context synchronization event
> (the latter must occur on the CPU which will execute the instructions).
> 
> If you look at the latest ARMv7-AR manual (ARM DDI 406C.d), section
> A3.5.4 "Concurrent modification and execution of instructions" covers
> this. That manual can be found at:
> 
> 	https://developer.arm.com/documentation/ddi0406/latest/

Looking at that, sys_cacheflush() meets this. The manual details a
series of cache maintenance calls in "step 1" that the modifying thread
must issue - this is exactly what sys_cacheflush() does. The same is
true for ARMv6, except the "ISB" terminology is replaced by a
"PrefetchFlush" terminology. (I checked DDI0100I).

"step 2" requires an ISB on the "other CPU" prior to executing that
code. As I understand it, in ARMv7, userspace can issue an ISB itself.

For ARMv6K, it doesn't have ISB, but instead has a CP15 instruction
for this that isn't availble to userspace. This is where we come to
the situation about ARM 11MPCore, and whether we continue to support
it or not.

So, I think we're completely fine with ARMv7 under 32-bit ARM kernels
as userspace has everything that's required. ARMv6K is a different
matter as we've already identified for several reasons.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
