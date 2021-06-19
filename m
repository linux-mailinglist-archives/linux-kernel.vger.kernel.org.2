Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C053AD6F9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 05:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhFSDXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 23:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235603AbhFSDXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 23:23:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DE7E600CD;
        Sat, 19 Jun 2021 03:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624072864;
        bh=8dMeG/3QAr21Ed5QXAbtYo9QmJItmXd3wn2qNtGhhmo=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=jT7+aspju1uaDO1mg+p2SDHZ52EdBmWqXQ+5W5Dbn8YI1CC6svu9anJrPzJ/aZhvj
         1/kki2n7IavtkWYnkcSkBArh9lb6G8FZGQOQ/i//EnH0k6zhOULKWqQjF52h/KuNjB
         4D2op8Sb0uhqCuUpVVd4P2K+f3IvGh6H08+a2naNx0E17/rvq6EMGcmddnoHIQIu9z
         iVTBFdFVNK/ilGJ6FxCJqb5RblHreIouwG89MjEpohSXqfEhmsGOpOCwAgkjURKoTX
         pZaAhU5zSWhFhzfSz5cq3Ex7oads2I77QUIRoTcjPqhe04paBfqC4B6C5aDGYHqKiG
         PzjpQcuXVrBGg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2842B27C0054;
        Fri, 18 Jun 2021 23:21:03 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Fri, 18 Jun 2021 23:21:03 -0400
X-ME-Sender: <xms:nWLNYFShUcmRHu4dTDp5Tg25iygooaIAxPmRG4CNamRkjuffFvCn1A>
    <xme:nWLNYOxEGejQ2ljF2M6rSBDVFbty9KuRrnJnJ_uv_EbGkhTXaDT9_T00sWKNtsVii
    FbUXkrQZpBYmB7Zf8s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefgedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepuefgueefveekhedvtdffgfekleehgfekheevteegieekgeehiedv
    fffgjeetudfhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:nWLNYK24nq8tWHRbchk7BMJtai6FE8boG4AhpGFvgBAccaWd5nj8lQ>
    <xmx:nWLNYNB73-qEhCMIjLKq7k_u_aRfSZS3pogVMecMNmb5DZ02FbzHXA>
    <xmx:nWLNYOhbaIopSgIWYGqd1nRvOJcHgFjWrAK9DKQMv5IqBam5rcxlkw>
    <xmx:n2LNYCjiTc5qitroBhtMyDWt_PiWyJ3hLGUO_xKmxi4ledPiM0U9W0rqQdo>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B450251C0060; Fri, 18 Jun 2021 23:21:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <a3dbe807-4ee0-44ea-a832-b21e04f25ee1@www.fastmail.com>
In-Reply-To: <1624070824.uyhrzf8zc7.astroid@bobo.none>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <1623911501.q97zemobmw.astroid@bobo.none>
 <5efaca70-35a0-1ce5-98ff-651a5f153a0a@kernel.org>
 <1624070824.uyhrzf8zc7.astroid@bobo.none>
Date:   Fri, 18 Jun 2021 20:20:41 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Nicholas Piggin" <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rik van Riel" <riel@surriel.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Jun 18, 2021, at 7:53 PM, Nicholas Piggin wrote:
> Excerpts from Andy Lutomirski's message of June 18, 2021 9:49 am:
> > On 6/16/21 11:51 PM, Nicholas Piggin wrote:
> >> Excerpts from Andy Lutomirski's message of June 17, 2021 3:32 pm:
> >>> On Wed, Jun 16, 2021, at 7:57 PM, Andy Lutomirski wrote:
> >>>>
> >>>>
> >>>> On Wed, Jun 16, 2021, at 6:37 PM, Nicholas Piggin wrote:
> >>>>> Excerpts from Andy Lutomirski's message of June 17, 2021 4:41 am=
:
> >>>>>> On 6/16/21 12:35 AM, Peter Zijlstra wrote:
> >>>>>>> On Wed, Jun 16, 2021 at 02:19:49PM +1000, Nicholas Piggin wrot=
e:
> >>>>>>>> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21=
 pm:
> >>>>>>>>> membarrier() needs a barrier after any CPU changes mm.  Ther=
e is currently
> >>>>>>>>> a comment explaining why this barrier probably exists in all=
 cases.  This
> >>>>>>>>> is very fragile -- any change to the relevant parts of the s=
cheduler
> >>>>>>>>> might get rid of these barriers, and it's not really clear t=
o me that
> >>>>>>>>> the barrier actually exists in all necessary cases.
> >>>>>>>>
> >>>>>>>> The comments and barriers in the mmdrop() hunks? I don't see =
what is=20
> >>>>>>>> fragile or maybe-buggy about this. The barrier definitely exi=
sts.
> >>>>>>>>
> >>>>>>>> And any change can change anything, that doesn't make it frag=
ile. My
> >>>>>>>> lazy tlb refcounting change avoids the mmdrop in some cases, =
but it
> >>>>>>>> replaces it with smp_mb for example.
> >>>>>>>
> >>>>>>> I'm with Nick again, on this. You're adding extra barriers for=
 no
> >>>>>>> discernible reason, that's not generally encouraged, seeing ho=
w extra
> >>>>>>> barriers is extra slow.
> >>>>>>>
> >>>>>>> Both mmdrop() itself, as well as the callsite have comments sa=
ying how
> >>>>>>> membarrier relies on the implied barrier, what's fragile about=
 that?
> >>>>>>>
> >>>>>>
> >>>>>> My real motivation is that mmgrab() and mmdrop() don't actually=
 need to
> >>>>>> be full barriers.  The current implementation has them being fu=
ll
> >>>>>> barriers, and the current implementation is quite slow.  So let=
's try
> >>>>>> that commit message again:
> >>>>>>
> >>>>>> membarrier() needs a barrier after any CPU changes mm.  There i=
s currently
> >>>>>> a comment explaining why this barrier probably exists in all ca=
ses. The
> >>>>>> logic is based on ensuring that the barrier exists on every con=
trol flow
> >>>>>> path through the scheduler.  It also relies on mmgrab() and mmd=
rop() being
> >>>>>> full barriers.
> >>>>>>
> >>>>>> mmgrab() and mmdrop() would be better if they were not full bar=
riers.  As a
> >>>>>> trivial optimization, mmgrab() could use a relaxed atomic and m=
mdrop()
> >>>>>> could use a release on architectures that have these operations=
.
> >>>>>
> >>>>> I'm not against the idea, I've looked at something similar befor=
e (not
> >>>>> for mmdrop but a different primitive). Also my lazy tlb shootdow=
n series=20
> >>>>> could possibly take advantage of this, I might cherry pick it an=
d test=20
> >>>>> performance :)
> >>>>>
> >>>>> I don't think it belongs in this series though. Should go togeth=
er with
> >>>>> something that takes advantage of it.
> >>>>
> >>>> I=E2=80=99m going to see if I can get hazard pointers into shape =
quickly.
> >>>
> >>> Here it is.  Not even boot tested!
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/com=
mit/?h=3Dsched/lazymm&id=3Decc3992c36cb88087df9c537e2326efb51c95e31
> >>>
> >>> Nick, I think you can accomplish much the same thing as your patch=
 by:
> >>>
> >>> #define for_each_possible_lazymm_cpu while (false)
> >>=20
> >> I'm not sure what you mean? For powerpc, other CPUs can be using th=
e mm=20
> >> as lazy at this point. I must be missing something.
> >=20
> > What I mean is: if you want to shoot down lazies instead of doing th=
e
> > hazard pointer trick to track them, you could do:
> >=20
> > #define for_each_possible_lazymm_cpu while (false)
> >=20
> > which would promise to the core code that you don't have any lazies =
left
> > by the time exit_mmap() is done.  You might need a new hook in
> > exit_mmap() depending on exactly how you implement the lazy shootdow=
n.
>=20
> Oh for configuring it away entirely. I'll have to see how it falls out=
,=20
> I suspect we'd want to just no-op that entire function and avoid the 2=
=20
> atomics if we are taking care of our lazy mms with shootdowns.

Do you mean the smp_store_release()?  On x86 and similar architectures, =
that=E2=80=99s almost free.  I=E2=80=99m also not convinced it needs to =
be a real release.

>=20
> The more important thing would be the context switch fast path, but ev=
en=20
> there, there's really no reason why the two approaches couldn't be mad=
e=20
> to both work with some careful helper functions or structuring of the=20=

> code.
>=20
> Thanks,
> Nick
>=20
