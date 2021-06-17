Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C543AAB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 07:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhFQFes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 01:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhFQFeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 01:34:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D793D613DF;
        Thu, 17 Jun 2021 05:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623907959;
        bh=17mY8uulhVndheqRcx5OgpB9j7P+oGlGE8QxNKUfcy0=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=tUpRlzj1v4+E5IgbjYIIwxCAzwHW2mIjA1hoi39H0AbTkblAL2umRUVfJtB/F/I+/
         zuMfOgtQjZqZRrHUIja/6V1LWWieTHXM8ZNvgN5ko4SCuyyZqLHQgasR4QYwU5PNea
         cJiQ/KZjanCdfxKPRSW3cxK78GRHUhLgcp1Pow0wNE5xJyKjTBNJbyTACusU1kTx2O
         SUfh3c+Q/IXZAfNpl4ef9TqJXlfBQBnhDa7gacX+dzy9H9dQkLbvwR7/EU/U79tc3i
         ae1f9tkomIaaZdfAnlMRal/Zyl6QpvtGPKZFllq05Kz8HfjPl8POX4wtJS5x3/0esv
         WuzLjkWAUJurA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id EC26F27C0054;
        Thu, 17 Jun 2021 01:32:37 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Thu, 17 Jun 2021 01:32:37 -0400
X-ME-Sender: <xms:dd7KYHw4xnOseSIUg2a0fs-1fL1S8X85JA5uRupTPLfRn29Db4cBKA>
    <xme:dd7KYPSQa0Si0UV8TexR9guPX5xmo9fN2rrP_Hz0F3WaQyL2h_-qJKMEHkjcpNWgh
    AHtvtmigQcphH8zdJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeftddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepuefgueefveekhedvtdffgfekleehgfekheevteegieekgeehiedv
    fffgjeetudfhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:dd7KYBVIWPb4tEQdQE8KcR-DtXXhzY7DVW7Sj4K6-Tnt12hvXCw7AQ>
    <xmx:dd7KYBj7mCJCI_fqjPbfzNdgZb-HUXLiBGgHzx8WIPl3Av6mCpiREw>
    <xmx:dd7KYJA9HrMARep_kIRirKr8umf7iRNgOoBj8xAOe68ywZmsbgQ-Hw>
    <xmx:dd7KYDBAa1fuSoufTDI82M9PbtDZnqb9ybBcuQ4OzeC-wq6KD8fUsIQ48mc>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 60BB951C0060; Thu, 17 Jun 2021 01:32:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
In-Reply-To: <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
Date:   Wed, 16 Jun 2021 22:32:15 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Nicholas Piggin" <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rik van Riel" <riel@surriel.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021, at 7:57 PM, Andy Lutomirski wrote:
>=20
>=20
> On Wed, Jun 16, 2021, at 6:37 PM, Nicholas Piggin wrote:
> > Excerpts from Andy Lutomirski's message of June 17, 2021 4:41 am:
> > > On 6/16/21 12:35 AM, Peter Zijlstra wrote:
> > >> On Wed, Jun 16, 2021 at 02:19:49PM +1000, Nicholas Piggin wrote:
> > >>> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm=
:
> > >>>> membarrier() needs a barrier after any CPU changes mm.  There i=
s currently
> > >>>> a comment explaining why this barrier probably exists in all ca=
ses.  This
> > >>>> is very fragile -- any change to the relevant parts of the sche=
duler
> > >>>> might get rid of these barriers, and it's not really clear to m=
e that
> > >>>> the barrier actually exists in all necessary cases.
> > >>>
> > >>> The comments and barriers in the mmdrop() hunks? I don't see wha=
t is=20
> > >>> fragile or maybe-buggy about this. The barrier definitely exists=
.
> > >>>
> > >>> And any change can change anything, that doesn't make it fragile=
. My
> > >>> lazy tlb refcounting change avoids the mmdrop in some cases, but=
 it
> > >>> replaces it with smp_mb for example.
> > >>=20
> > >> I'm with Nick again, on this. You're adding extra barriers for no=

> > >> discernible reason, that's not generally encouraged, seeing how e=
xtra
> > >> barriers is extra slow.
> > >>=20
> > >> Both mmdrop() itself, as well as the callsite have comments sayin=
g how
> > >> membarrier relies on the implied barrier, what's fragile about th=
at?
> > >>=20
> > >=20
> > > My real motivation is that mmgrab() and mmdrop() don't actually ne=
ed to
> > > be full barriers.  The current implementation has them being full
> > > barriers, and the current implementation is quite slow.  So let's =
try
> > > that commit message again:
> > >=20
> > > membarrier() needs a barrier after any CPU changes mm.  There is c=
urrently
> > > a comment explaining why this barrier probably exists in all cases=
. The
> > > logic is based on ensuring that the barrier exists on every contro=
l flow
> > > path through the scheduler.  It also relies on mmgrab() and mmdrop=
() being
> > > full barriers.
> > >=20
> > > mmgrab() and mmdrop() would be better if they were not full barrie=
rs.  As a
> > > trivial optimization, mmgrab() could use a relaxed atomic and mmdr=
op()
> > > could use a release on architectures that have these operations.
> >=20
> > I'm not against the idea, I've looked at something similar before (n=
ot
> > for mmdrop but a different primitive). Also my lazy tlb shootdown se=
ries=20
> > could possibly take advantage of this, I might cherry pick it and te=
st=20
> > performance :)
> >=20
> > I don't think it belongs in this series though. Should go together w=
ith
> > something that takes advantage of it.
>=20
> I=E2=80=99m going to see if I can get hazard pointers into shape quick=
ly.

Here it is.  Not even boot tested!

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=
=3Dsched/lazymm&id=3Decc3992c36cb88087df9c537e2326efb51c95e31

Nick, I think you can accomplish much the same thing as your patch by:

#define for_each_possible_lazymm_cpu while (false)

although a more clever definition might be even more performant.

I would appreciate everyone's thoughts as to whether this scheme is sane=
.

Paul, I'm adding you for two reasons.  First, you seem to enjoy bizarre =
locking schemes.  Secondly, because maybe RCU could actually work here. =
 The basic idea is that we want to keep an mm_struct from being freed at=
 an inopportune time.  The problem with naively using RCU is that each C=
PU can use one single mm_struct while in an idle extended quiescent stat=
e (but not a user extended quiescent state).  So rcu_read_lock() is righ=
t out.  If RCU could understand this concept, then maybe it could help u=
s, but this seems a bit out of scope for RCU.

--Andy
