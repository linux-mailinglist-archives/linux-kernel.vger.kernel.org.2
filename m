Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01558332748
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhCINf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:35:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:43834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhCINf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:35:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0FA16AB8C;
        Tue,  9 Mar 2021 13:35:25 +0000 (UTC)
Date:   Tue, 9 Mar 2021 14:35:23 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: make STACKPROTECTOR_PER_TASK configurable.
Message-ID: <20210309133523.GX6564@kitsune.suse.cz>
References: <20210309123544.14040-1-msuchanek@suse.de>
 <CAK7LNAT+8mGunqXSPLHxhF1FTXQEzbAoKPY=48pBgtLbhcB0jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAT+8mGunqXSPLHxhF1FTXQEzbAoKPY=48pBgtLbhcB0jg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:22:36PM +0900, Masahiro Yamada wrote:
> On Tue, Mar 9, 2021 at 9:35 PM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > When using dummy-tools STACKPROTECTOR_PER_TASK is unconditionally
> > selected. This defeats the purpose of the all-enabled tool.
> >
> > Description copied from arm
> >
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> 
> 
> Could you explain what problem
> this patch is trying to solve?

The option cannot be disabled when compiler has the required capability.

Thanks

Michal
> 
> 
> > ---
> >  arch/arm64/Kconfig | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index a8ff7cd5f096..f59d391e31a4 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1549,9 +1549,20 @@ config RANDOMIZE_MODULE_REGION_FULL
> >  config CC_HAVE_STACKPROTECTOR_SYSREG
> >         def_bool $(cc-option,-mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0 -mstack-protector-guard-offset=0)
> >
> > +
> >  config STACKPROTECTOR_PER_TASK
> > -       def_bool y
> > +       bool "Use a unique stack canary value for each task"
> >         depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
> > +       default y
> > +       help
> > +         Due to the fact that GCC uses an ordinary symbol reference from
> > +         which to load the value of the stack canary, this value can only
> > +         change at reboot time on SMP systems, and all tasks running in the
> > +         kernel's address space are forced to use the same canary value for
> > +         the entire duration that the system is up.
> > +
> > +         Enable this option to switch to a different method that uses a
> > +         different canary value for each task.
> >
> >  endmenu
> >
> > --
> > 2.26.2
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
