Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521943A9798
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhFPKhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhFPKhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:37:05 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A58AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s7U02JqFBNdgNwP8tr1DkJVVHjauc7uG5haj7To5L+Q=; b=k+fh13hwtRFLi6gpWI9F5+Zhv
        0+4VTHwF272UY9r0txiLErUGV7k+FaZN8hYwGehrDsmHtohiF3flW3cnjk5EZ48PL5MuHpT4QaXo1
        vSpLRowv6lTVE3kcaQ/B1pXzQ+KqzubpujnTQjikqDQDqN7t1biOn7Sd/fAlRp50kUzn+XUWevFDF
        fL3enxTLg3zsJDDWYLpEF8qhjX3ZJvhgT9qPXPKS1QuYFGG8H61abWMfq+JSf16pEk/zFSdWacPgY
        zw/DUbtGUNCa0JqbVnqyeaOPLM9mP3o1mhT6U+eAmwPgdZM7n3f8z/iV9V9E3y6xUkL7iAiY7zWBh
        0iVDmyHww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45060)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ltSsj-00073k-8J; Wed, 16 Jun 2021 11:34:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ltSsg-0005we-6W; Wed, 16 Jun 2021 11:34:46 +0100
Date:   Wed, 16 Jun 2021 11:34:46 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210616103446.GC22278@shell.armlinux.org.uk>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net>
 <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:20:06PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 16, 2021 at 12:16:27PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote:
> > > On arm32, the only way to safely flush icache from usermode is to call
> > > cacheflush(2).  This also handles any required pipeline flushes, so
> > > membarrier's SYNC_CORE feature is useless on arm.  Remove it.
> > 
> > So SYNC_CORE is there to help an architecture that needs to do something
> > per CPU. If I$ invalidation is broadcast and I$ invalidation also
> > triggers the flush of any uarch caches derived from it (if there are
> > any).
> 
> Incomplete sentence there: + then we don't need SYNC_CORE.
> 
> > Now arm_syscall() NR(cacheflush) seems to do flush_icache_user_range(),
> > which, if I read things right, end up in arch/arm/mm/*.S, but that
> > doesn't consider cache_ops_need_broadcast().
> > 
> > Will suggests that perhaps ARM 11MPCore might need this due to their I$
> > flush maybe not being broadcast

If it leaves other cores with incoherent I cache, then that's already
a problem for SMP cores, since there could be no guarantee that the
modifications made by one core will be visible to some other core that
ends up running that code - and there is little option for userspace to
work around that except by pinning the thread making the modifications
and subsequently executing the code to a core.

The same is also true of flush_icache_range() - which is used when
loading a kernel module. In the case Will is referring to, these alias
to the same code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
