Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE8F30AB5F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhBAPb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:31:26 -0500
Received: from foss.arm.com ([217.140.110.172]:33638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhBAPbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:31:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6B3F101E;
        Mon,  1 Feb 2021 07:30:17 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74E943F71A;
        Mon,  1 Feb 2021 07:30:15 -0800 (PST)
Date:   Mon, 1 Feb 2021 15:30:12 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        rppt@kernel.org, penberg@kernel.org, geert@linux-m68k.org,
        giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201153012.GC66060@C02TD0UTHF1T.local>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201143943.GA15399@p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201143943.GA15399@p4>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 01, 2021 at 02:39:46PM +0000, Giancarlo Ferrari wrote:
> On Mon, Feb 01, 2021 at 12:47:20PM +0000, Mark Rutland wrote:
> > On Mon, Feb 01, 2021 at 12:44:56AM +0000, Giancarlo Ferrari wrote:
> > > machine_kexec() need to set rw permission in text and rodata sections
> > > to assign some variables (e.g. kexec_start_address). To do that at
> > > the end (after flushing pdm in memory, etc.) it needs to invalidate
> > > TLB [section] entries.
> > 
> > It'd be worth noting explicitly that set_kernel_text_rw() alters
> > current->active_mm...
> > 
> > > If during the TLB invalidation an interrupt occours, which might cause
> > > a context switch, there is the risk to inject invalid TLBs, with ro
> > > permissions.
> > 
> > ... which is why if there's a context switch things can go wrong, since
> > active_mm isn't stable, and so it's possible that set_kernel_text_rw()
> > updates multiple tables, none of which might be the active table at the
> > point we try to make an access.
> 
> Maybe the behaviour causing issue is not completely clear to me, and I do
> apologize for that (moreover I haven't eougth debug capabilities).

I think we're in rough agreement that the issue is likely related to the
context switch, but our understanding of the specifics differs (and I
think we're missing a detail here).

> However, current-active_mm is switched among context switches. Correct ?

In some cases current->active_mm is not switched, and can be inherited
over a context switch. When switching to a user task, we always switch
to its mm (which becomes the active_mm), but when switching to a kthread
we retain the previous task's mm as the active_mm as part of the lazy
context switch.

So while a kthread is preemptible, its active_mm (and active ASID) can
change under its feet. That could happen anywhere while the task is
preemptible, e.g. in the middle of set_kernel_text_rw(), or
mid-modification to the kexec variables.

> So, in principle, the invalidation, if stopped, is carried on where it
> left.

That's true so long as all the processes we switch between share the
same leaf tables for the region we're altering. If not, then the lazy
context switch means that those tables can change under our feet.

I believe the tables mapping the kernel text are shared by all threads,
and if so this _should_ be true. Russell might be able to confirm that
or correct me if I have that wrong.

> I thought the issue was that the PageTable entry for the section 0x8010_0000
> is global, thus not indexed by ASID (Address Space ID). By the fact that each
> process has its own version of that entry, is the cause of the issue, as the
> schedule process might bringing a spurious entry (with ro permission) in the
> MMU cache.

The TLB invalidation performed under set_kernel_text_rw() affects all
ASIDs on the current CPU, so there shouldn't be any stale RO TLB entries
to hit unless the kthread is migrated to another CPU.

> If the entry is not global holds the ASID, and the issue cannot happen.

I don't think that's true, since switching to a different active_mm
would also change ASID, and we'd have no additional guarantee.

Thanks,
Mark.
