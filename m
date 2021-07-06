Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CAE3BD577
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhGFMWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:22:14 -0400
Received: from foss.arm.com ([217.140.110.172]:39928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243070AbhGFMDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:03:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9D411FB;
        Tue,  6 Jul 2021 05:00:34 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.31.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B83D3F73B;
        Tue,  6 Jul 2021 05:00:33 -0700 (PDT)
Date:   Tue, 6 Jul 2021 13:00:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anatoly Pugachev <matorola@gmail.com>,
        Peter Zijlstra <peterz@lists.infradead.org>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Subject: Re: [sparc64] locking/atomic, kernel OOPS on running stress-ng
Message-ID: <20210706120030.GB69200@C02TD0UTHF1T.local>
References: <CADxRZqzcrnSMzy50T+kWb_mQVguWDCMu6RoXsCc+-fNDPYXbaw@mail.gmail.com>
 <20210705195638.GA53988@C02TD0UTHF1T.local>
 <20210706091104.GA69200@C02TD0UTHF1T.local>
 <CADxRZqxNdYBAs1daPJTAPKGeJx30D+v7xz87K2sB_dXYKdTrVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqxNdYBAs1daPJTAPKGeJx30D+v7xz87K2sB_dXYKdTrVg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 02:51:06PM +0300, Anatoly Pugachev wrote:
> On Tue, Jul 6, 2021 at 12:11 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > Fixes: ff5b4f1ed580c59d ("locking/atomic: sparc: move to ARCH_ATOMIC")
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reported-by: Anatoly Pugachev <matorola@gmail.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Peter Zijlstra <peterz@lists.infradead.org>
> > ---
> >  arch/sparc/include/asm/cmpxchg_64.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
> > index 8c39a9981187..12d00a42c0a3 100644
> > --- a/arch/sparc/include/asm/cmpxchg_64.h
> > +++ b/arch/sparc/include/asm/cmpxchg_64.h
> > @@ -201,7 +201,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
> >  #define arch_cmpxchg64_local(ptr, o, n)                                        \
> >    ({                                                                   \
> >         BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> > -       cmpxchg_local((ptr), (o), (n));                                 \
> > +       arch_cmpxchg_local((ptr), (o), (n));                                    \
> >    })
> >  #define arch_cmpxchg64(ptr, o, n)      arch_cmpxchg64_local((ptr), (o), (n))
> 
> 
> Mark, thanks, fixed...
> tested on git kernel 5.13.0-11788-g79160a603bdb-dirty (dirty - cause
> patch has been applied).

Great! Thanks for confirming.

Peter, are you happy to pick that (full commit in last mail), or should
I send a new copy?

Thanks,
Mark.
