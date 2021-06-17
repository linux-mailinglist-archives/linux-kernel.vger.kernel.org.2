Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A873AA941
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 04:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFQDA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 23:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhFQDA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 23:00:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 419616102A;
        Thu, 17 Jun 2021 02:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623898699;
        bh=bIBZrweDay9LQzFP2yvtyfQ8zfOsTpcNUjojQFpzFV0=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=k4eyZMrg1O7umGMQrWM60kljALZxXGQgswKriLhQWDBLgy7Bs57z63quhJwgE9h53
         FoT+as3PM6EEIabHXHgQSBvQhgZzI94jbYL2XKvWi3WPJVy5KUyI5bcqTHltqK/SV2
         jznjfQI2Jk0Bo+GkswxkIflk+dW941xqZAz+Yh2WcTvdS0X0k7WVzTGQdj+oIwG3w5
         i9nxbxgZe5UjvwR6OFAANuOwyiC7EHrd0ue7yr5heqG86zkzbbK9E2zoKSZzV7IG3v
         XiyMmUncNzG7yUyFvqClWHu8WrdO4ZuMdm+3PZKXWO+TFKPYwm88z/fsnOp/H+Iisg
         CvKeyAcwxbReA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 48A9F27C0054;
        Wed, 16 Jun 2021 22:58:18 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Wed, 16 Jun 2021 22:58:18 -0400
X-ME-Sender: <xms:SbrKYCBeqG8pydUEWFrYfPI63g_c1BmVBVkDhg4kPu151OjJAbIBlg>
    <xme:SbrKYMjvtpzNM0DwjdSMd6qVKvxAa6fQThnOr6B0u2-drat8ms5i4a9BqEKLZdC8r
    sk3nKH6Ik1oqwkRqUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeftddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:SbrKYFkgEokPiO8ogStIQB97b0l9l6OyC-u6O6QWmMNjc61Vj0UDvQ>
    <xmx:SbrKYAwot-qMNhiL6wpx8naWDT0W7hp5JDje4wRuw9CHhpIWq8u8iw>
    <xmx:SbrKYHSZSg0g0SxBh2EcJNliqAV18hQ9kyR5P8WPJBoGP7QnJ_-Egw>
    <xmx:SrrKYILbzxmNPvJ1CsG6EtXQdQuIcfxlPdmwnRd0ICre2J5Gx5rtfJvmFec>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A939E51C0060; Wed, 16 Jun 2021 22:58:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
In-Reply-To: <1623893358.bbty474jyy.astroid@bobo.none>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
Date:   Wed, 16 Jun 2021 19:57:57 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Nicholas Piggin" <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Jun 16, 2021, at 6:37 PM, Nicholas Piggin wrote:
> Excerpts from Andy Lutomirski's message of June 17, 2021 4:41 am:
> > On 6/16/21 12:35 AM, Peter Zijlstra wrote:
> >> On Wed, Jun 16, 2021 at 02:19:49PM +1000, Nicholas Piggin wrote:
> >>> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
> >>>> membarrier() needs a barrier after any CPU changes mm.  There is =
currently
> >>>> a comment explaining why this barrier probably exists in all case=
s.  This
> >>>> is very fragile -- any change to the relevant parts of the schedu=
ler
> >>>> might get rid of these barriers, and it's not really clear to me =
that
> >>>> the barrier actually exists in all necessary cases.
> >>>
> >>> The comments and barriers in the mmdrop() hunks? I don't see what =
is=20
> >>> fragile or maybe-buggy about this. The barrier definitely exists.
> >>>
> >>> And any change can change anything, that doesn't make it fragile. =
My
> >>> lazy tlb refcounting change avoids the mmdrop in some cases, but i=
t
> >>> replaces it with smp_mb for example.
> >>=20
> >> I'm with Nick again, on this. You're adding extra barriers for no
> >> discernible reason, that's not generally encouraged, seeing how ext=
ra
> >> barriers is extra slow.
> >>=20
> >> Both mmdrop() itself, as well as the callsite have comments saying =
how
> >> membarrier relies on the implied barrier, what's fragile about that=
?
> >>=20
> >=20
> > My real motivation is that mmgrab() and mmdrop() don't actually need=
 to
> > be full barriers.  The current implementation has them being full
> > barriers, and the current implementation is quite slow.  So let's tr=
y
> > that commit message again:
> >=20
> > membarrier() needs a barrier after any CPU changes mm.  There is cur=
rently
> > a comment explaining why this barrier probably exists in all cases. =
The
> > logic is based on ensuring that the barrier exists on every control =
flow
> > path through the scheduler.  It also relies on mmgrab() and mmdrop()=
 being
> > full barriers.
> >=20
> > mmgrab() and mmdrop() would be better if they were not full barriers=
.  As a
> > trivial optimization, mmgrab() could use a relaxed atomic and mmdrop=
()
> > could use a release on architectures that have these operations.
>=20
> I'm not against the idea, I've looked at something similar before (not=

> for mmdrop but a different primitive). Also my lazy tlb shootdown seri=
es=20
> could possibly take advantage of this, I might cherry pick it and test=
=20
> performance :)
>=20
> I don't think it belongs in this series though. Should go together wit=
h
> something that takes advantage of it.

I=E2=80=99m going to see if I can get hazard pointers into shape quickly=
.

>=20
> Thanks,
> Nick
>=20
