Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8A3AB511
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhFQNoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhFQNoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:44:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 373F86044F;
        Thu, 17 Jun 2021 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623937335;
        bh=ER7d5sPQnW+T/CnzclnTHVZx0n0xVI9HZDZP7tJJHwE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=I04Q/TnrAdrfLk1Pv6SgcwKIdBn5fgK2J/AygIAxrCPXF4dRyRhHHKQrWo315gFb0
         ikcLbmkT1QQHeNyfHZZuckLIrgPNyg+REO7WcYiZ3dC6CTxURHmXMEt5FDvKlr9lLi
         Fj3SbHyTkStgW2xsqxQ8tahl8jTeB9/I5M+7FUJpF4CCkuBmmowfpg6wJTJQEK+iUJ
         jUyfxilUKTZIvxZbFqGghT4azVDZJbqoYcU+tPj1yOc/xSj14Nt46igrs3O1k52/GW
         MpF+htPSPuSAvENSByATnLlMgJu1hamXLmTOWIL0FwzQexo5uiA1SRWqjfZBU6X5eN
         OR0P2dQ+1N6/w==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 48DFD27C005C;
        Thu, 17 Jun 2021 09:42:13 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Thu, 17 Jun 2021 09:42:13 -0400
X-ME-Sender: <xms:NFHLYL4zFAlU5zXdv0WXEesUZAWqSvcwoEMEbog-jFAfMnBwYccEig>
    <xme:NFHLYA7YNMPLyrBbOZWfQKnHntC35UzVTvOx4MrNx7JUDZ0AzbL3GJf4-r3pmgFeK
    k25GnOtaaRFB8n_Wm0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheeiveejjeehteefgfekudefgefhuedvueetheeggeegveeggeeh
    jefhieeuffdvnecuffhomhgrihhnpegrrhhmrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlhhuthhope
    epkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:NFHLYCfq5N8oJrocIW2HhJrWAfTAlr6Eq4l-BMeuZXhPZ0q__JB-2w>
    <xmx:NFHLYMIorvE6ijr7NWNAWL9xyZ617Uavk5IDappaPBc_VQYQgRzJaw>
    <xmx:NFHLYPJq4Wr9wzvVSZceu_8msTySu-IZCfU7FRLqrU_NyFHcE4xy-A>
    <xmx:NVHLYG-qTpTnoENort-4wbbgC6rTnMCD1dta6vNEdECxqb4Qo5qQFO3m8Ss5XeFO>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DB7D551C0062; Thu, 17 Jun 2021 09:42:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <394219d4-36a6-4e7f-a03c-8590551b099a@www.fastmail.com>
In-Reply-To: <20210617113349.GB82133@C02TD0UTHF1T.local>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <20210617103524.GA82133@C02TD0UTHF1T.local>
 <20210617112305.GK22278@shell.armlinux.org.uk>
 <20210617113349.GB82133@C02TD0UTHF1T.local>
Date:   Thu, 17 Jun 2021 06:41:41 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Mark Rutland" <mark.rutland@arm.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Jun 17, 2021, at 4:33 AM, Mark Rutland wrote:
> On Thu, Jun 17, 2021 at 12:23:05PM +0100, Russell King (Oracle) wrote:=

> > On Thu, Jun 17, 2021 at 11:40:46AM +0100, Mark Rutland wrote:
> > > On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote:
> > > > On arm32, the only way to safely flush icache from usermode is t=
o call
> > > > cacheflush(2).  This also handles any required pipeline flushes,=
 so
> > > > membarrier's SYNC_CORE feature is useless on arm.  Remove it.
> > >=20
> > > Unfortunately, it's a bit more complicated than that, and these da=
ys
> > > SYNC_CORE is equally necessary on arm as on arm64. This is somethi=
ng
> > > that changed in the architecture over time, but since ARMv7 we gen=
erally
> > > need both the cache maintenance *and* a context synchronization ev=
ent
> > > (the latter must occur on the CPU which will execute the instructi=
ons).
> > >=20
> > > If you look at the latest ARMv7-AR manual (ARM DDI 406C.d), sectio=
n
> > > A3.5.4 "Concurrent modification and execution of instructions" cov=
ers
> > > this. That manual can be found at:
> > >=20
> > > 	https://developer.arm.com/documentation/ddi0406/latest/
> >=20
> > Looking at that, sys_cacheflush() meets this. The manual details a
> > series of cache maintenance calls in "step 1" that the modifying thr=
ead
> > must issue - this is exactly what sys_cacheflush() does. The same is=

> > true for ARMv6, except the "ISB" terminology is replaced by a
> > "PrefetchFlush" terminology. (I checked DDI0100I).
> >=20
> > "step 2" requires an ISB on the "other CPU" prior to executing that
> > code. As I understand it, in ARMv7, userspace can issue an ISB itsel=
f.
> >=20
> > For ARMv6K, it doesn't have ISB, but instead has a CP15 instruction
> > for this that isn't availble to userspace. This is where we come to
> > the situation about ARM 11MPCore, and whether we continue to support=

> > it or not.
> >=20
> > So, I think we're completely fine with ARMv7 under 32-bit ARM kernel=
s
> > as userspace has everything that's required. ARMv6K is a different
> > matter as we've already identified for several reasons.
>=20
> Sure, and I agree we should not change cacheflush().
>=20
> The point of membarrier(SYNC_CORE) is that you can move the cost of th=
at
> ISB out of the fast-path in the executing thread(s) and into the
> slow-path on the thread which generated the code.
>=20
> So e.g. rather than an executing thread always having to do:
>=20
> 	LDR	<reg>, [<funcptr>]
> 	ISB	// in case funcptr was just updated
> 	BLR	<reg>
>=20
> ... you have the thread generating the code use membarrier(SYNC_CORE)
> prior to plublishing the funcptr, and the fast-path on all the executi=
ng
> threads can be:
>=20
> 	LDR	<reg> [<funcptr>]
> 	BLR	<reg>
>=20
> ... and thus I think we still want membarrier(SYNC_CORE) so that peopl=
e
> can do this, even if there are other means to achieve the same
> functionality.

I had the impression that sys_cacheflush() did that.  Am I wrong?

In any event, I=E2=80=99m even more convinced that no new SYNC_CORE arch=
es should be added. We need a new API that just does the right thing.=20
