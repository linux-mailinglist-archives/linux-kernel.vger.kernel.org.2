Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47C33AB5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhFQOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:18:27 -0400
Received: from mail.efficios.com ([167.114.26.124]:54884 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhFQOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:18:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 98BF933AEF8;
        Thu, 17 Jun 2021 10:16:14 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NQ5nwdb_CSGL; Thu, 17 Jun 2021 10:16:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 940CC33AEF7;
        Thu, 17 Jun 2021 10:16:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 940CC33AEF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1623939373;
        bh=PPPq0X6QUD3zkAKDaJYB0a4dhhEK2iuXQUmjCr94ufo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Tp6w/FWv/15PBsm+sZdeYHS2fGUFFDxva9d8Q43DW/PFsLMkGpEoAhtU5H4ys8LTy
         wdQds1SYsU0tW0Sv3/Esbm4SptIGscsIXbQfaj2lkEY42W5H2LxA0NI7hSOg/Tk0R8
         RuyJatVGwuM+3gSDUWA+2IX7j9/BHtwfexP+veVKe9KhQBLes6fLpcEv38p6y/8c7X
         sSRx5na+oQl3zvjKAoY7rELzuLwdK4qDfzcvfMwlbVoe8MyoBeQmM+bdg0u5Wje6Xy
         vd5EhWDcJXMMF0rFANM29DBE7EfdJMQmKodEQJyejT3EU2NRBEecWnLUkXf1jQqHJM
         iB+i559Gejy1g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eSxuNMgKD58p; Thu, 17 Jun 2021 10:16:13 -0400 (EDT)
Received: from localhost (unknown [192.222.236.144])
        by mail.efficios.com (Postfix) with ESMTPSA id 3B0FD33B0B7;
        Thu, 17 Jun 2021 10:16:13 -0400 (EDT)
Date:   Thu, 17 Jun 2021 10:16:12 -0400
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210617141612.GA18005@localhost>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <20210617103524.GA82133@C02TD0UTHF1T.local>
 <20210617112305.GK22278@shell.armlinux.org.uk>
 <20210617113349.GB82133@C02TD0UTHF1T.local>
 <394219d4-36a6-4e7f-a03c-8590551b099a@www.fastmail.com>
 <20210617135133.GA86101@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210617135133.GA86101@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-Jun-2021 02:51:33 PM, Mark Rutland wrote:
> On Thu, Jun 17, 2021 at 06:41:41AM -0700, Andy Lutomirski wrote:
> >=20
> >=20
> > On Thu, Jun 17, 2021, at 4:33 AM, Mark Rutland wrote:
> > > On Thu, Jun 17, 2021 at 12:23:05PM +0100, Russell King (Oracle) wro=
te:
> > > > On Thu, Jun 17, 2021 at 11:40:46AM +0100, Mark Rutland wrote:
> > > > > On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote=
:
> > > > > > On arm32, the only way to safely flush icache from usermode i=
s to call
> > > > > > cacheflush(2).  This also handles any required pipeline flush=
es, so
> > > > > > membarrier's SYNC_CORE feature is useless on arm.  Remove it.
> > > > >=20
> > > > > Unfortunately, it's a bit more complicated than that, and these=
 days
> > > > > SYNC_CORE is equally necessary on arm as on arm64. This is some=
thing
> > > > > that changed in the architecture over time, but since ARMv7 we =
generally
> > > > > need both the cache maintenance *and* a context synchronization=
 event
> > > > > (the latter must occur on the CPU which will execute the instru=
ctions).
> > > > >=20
> > > > > If you look at the latest ARMv7-AR manual (ARM DDI 406C.d), sec=
tion
> > > > > A3.5.4 "Concurrent modification and execution of instructions" =
covers
> > > > > this. That manual can be found at:
> > > > >=20
> > > > > 	https://developer.arm.com/documentation/ddi0406/latest/
> > > >=20
> > > > Looking at that, sys_cacheflush() meets this. The manual details =
a
> > > > series of cache maintenance calls in "step 1" that the modifying =
thread
> > > > must issue - this is exactly what sys_cacheflush() does. The same=
 is
> > > > true for ARMv6, except the "ISB" terminology is replaced by a
> > > > "PrefetchFlush" terminology. (I checked DDI0100I).
> > > >=20
> > > > "step 2" requires an ISB on the "other CPU" prior to executing th=
at
> > > > code. As I understand it, in ARMv7, userspace can issue an ISB it=
self.
> > > >=20
> > > > For ARMv6K, it doesn't have ISB, but instead has a CP15 instructi=
on
> > > > for this that isn't availble to userspace. This is where we come =
to
> > > > the situation about ARM 11MPCore, and whether we continue to supp=
ort
> > > > it or not.
> > > >=20
> > > > So, I think we're completely fine with ARMv7 under 32-bit ARM ker=
nels
> > > > as userspace has everything that's required. ARMv6K is a differen=
t
> > > > matter as we've already identified for several reasons.
> > >=20
> > > Sure, and I agree we should not change cacheflush().
> > >=20
> > > The point of membarrier(SYNC_CORE) is that you can move the cost of=
 that
> > > ISB out of the fast-path in the executing thread(s) and into the
> > > slow-path on the thread which generated the code.
> > >=20
> > > So e.g. rather than an executing thread always having to do:
> > >=20
> > > 	LDR	<reg>, [<funcptr>]
> > > 	ISB	// in case funcptr was just updated
> > > 	BLR	<reg>
> > >=20
> > > ... you have the thread generating the code use membarrier(SYNC_COR=
E)
> > > prior to plublishing the funcptr, and the fast-path on all the exec=
uting
> > > threads can be:
> > >=20
> > > 	LDR	<reg> [<funcptr>]
> > > 	BLR	<reg>
> > >=20
> > > ... and thus I think we still want membarrier(SYNC_CORE) so that pe=
ople
> > > can do this, even if there are other means to achieve the same
> > > functionality.
> >=20
> > I had the impression that sys_cacheflush() did that.  Am I wrong?
>=20
> Currently sys_cacheflush() doesn't do this, and IIUC it has never done
> remote context synchronization even for architectures that need that
> (e.g. x86 requiring a serializing instruction).
>=20
> > In any event, I=E2=80=99m even more convinced that no new SYNC_CORE a=
rches
> > should be added. We need a new API that just does the right thing.=20
>=20
> My intuition is the other way around, and that this is a gnereally
> useful thing for architectures that require context synchronization.
>=20
> It's not clear to me what "the right thing" would mean specifically, an=
d
> on architectures with userspace cache maintenance JITs can usually do
> the most optimal maintenance, and only need help for the context
> synchronization.

If I can attempt to summarize the current situation for ARMv7:

- In addition to the cache flushing on the core doing the code update,
  the architecture requires every core to perform a context synchronizing
  instruction before executing the updated code.

- sys_cacheflush() don't do this core sync on every core. It also takes a
  single address range as parameter.

- ARM, ARM64, powerpc, powerpc64, x86, x86-64 all currently handle the
  context synchronization requirement for updating user-space code on
  SMP with sys_membarrier SYNC_CORE. It's not, however, meant to replace
  explicit cache flushing operations if those are needed.

So removing membarrier SYNC_CORE from ARM would be a step backward here.
On ARMv7, the SYNC_CORE is needed _in addition_ to sys_cacheflush.

Adding a sync-core operation at the end of sys_cacheflush would be
inefficient for common GC use-cases where a rather large set of address
ranges are invalidated in one go: for this, we either want the GC to:

- Invoke sys_cacheflush for each targeted range, and then issue a single
  sys_membarrier SYNC_CORE, or

- Implement a new "sys_cacheflush_iov" which takes an iovec input. There
  I see that it could indeed invalidate all relevant cache lines *and*
  issue the SYNC_CORE at the end.

But shoehorning the SYNC_CORE in the pre-existing sys_cacheflush after
the fact seems like a bad idea.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
