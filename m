Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD5E3AA142
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhFPQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhFPQ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:29:41 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE26BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F5TJDNcYuwexDNPaj1QLfXcW7fCqnDUp/+WALb+M1fA=; b=N0MaDPZZn8Mid5Bfgk5en4V4t
        Bq+vQW6T4bUfgxk7B4CcYo9f9bC3wWtS6ZKnnDJonH5qph0TkrXbC+0HMb1B2hIphgUoeVTctyOpp
        7Ol/tQ4USebl7lu44JY/d4d+n7xTrdkGXY98xT4kGfyJI7e29xffOFx5LmQqzMtYrTXttnIL3TMA6
        i5H8B1ZmLiJFdTxBbhUVvj+p2dkbltnh1b87upmrNFDUD8WDyZvxZa3G6JKn1heoMLBOwqjPOtF8A
        iKxE2Tu+l2lABmCZaoK7udf3UfnlFFrdTwwJwvORqJtEJpzng0nlpGkV/BbG7pg9rX6660P3eFUUd
        HvWaE90RQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45076)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ltYNu-0007aI-QG; Wed, 16 Jun 2021 17:27:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ltYNo-0006BK-ES; Wed, 16 Jun 2021 17:27:16 +0100
Date:   Wed, 16 Jun 2021 17:27:16 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210616162716.GH22278@shell.armlinux.org.uk>
References: <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net>
 <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
 <20210616103446.GC22278@shell.armlinux.org.uk>
 <YMncQv1uT5QyQ84w@hirez.programming.kicks-ass.net>
 <20210616132226.GD22278@shell.armlinux.org.uk>
 <20210616150456.GC22433@arm.com>
 <20210616152326.GG22278@shell.armlinux.org.uk>
 <20210616154529.GD22433@arm.com>
 <20210616160050.GE22433@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616160050.GE22433@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 05:00:51PM +0100, Catalin Marinas wrote:
> On Wed, Jun 16, 2021 at 04:45:29PM +0100, Catalin Marinas wrote:
> > On Wed, Jun 16, 2021 at 04:23:26PM +0100, Russell King wrote:
> > > On Wed, Jun 16, 2021 at 04:04:56PM +0100, Catalin Marinas wrote:
> > > > The simpler fix for flush_icache_range() is to disable preemption, read
> > > > a word in a cacheline to force any dirty lines on another CPU to be
> > > > evicted and then issue the D-cache maintenance (for those cache lines
> > > > which are still dirty on the current CPU).
> > > 
> > > Is just reading sufficient? If so, why do we do a read-then-write in
> > > the MPCore DMA cache ops? Don't we need the write to force exclusive
> > > ownership? If we don't have exclusive ownership of the dirty line,
> > > how can we be sure to write it out of the caches?
> > 
> > For cleaning (which is the case for I/D coherency), we only need reading
> > since we are fine with clean lines being left in the D-cache on other
> > CPUs. For invalidation, we indeed need to force the exclusive ownership,
> > hence the write.
> 
> Ah, I'm not sure the I-cache is broadcast in hardware on ARM11MPCore
> either. So fixing the D side won't be sufficient.

The other question is... do we bother to fix this.

Arnd tells me that the current remaining ARM11MPCore users are:
- CNS3xxx (where there is some martinal interest in the Gateworks
  Laguna platform)
- Similar for OXNAS
- There used to be the Realview MPCore tile - I haven't turned that on
  in ages, and it may be that the 3V cell that backs up the encryption
  keys is dead so it may not even boot.
- Not sure about the story with QEMU - Arnd doesn't think there would
  be a problem there as it may not model caches.

So it seems to come down to a question about CNS3xxx and OXNAS. If
these aren't being used, maybe we can drop ARM11MPCore support and
the associated platforms?

Linus, Krzysztof, Neil, any input?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
