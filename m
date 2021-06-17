Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399523AB551
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhFQOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbhFQOGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:06:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52C5A611CA;
        Thu, 17 Jun 2021 14:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623938640;
        bh=7iMyIFiSoJXd3K14sBheP7uL6Rq2qTf2UHkmkhu2924=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=NhQTimeuQEnwr6Kl7WM4Tidnu+ngXruFZnSrnEEI1FsUNUyvaIn2gysfGMuFIWHWZ
         LfBd8hRKGaxLXsTjV5DG0VJFh6IKrjx84aMb8n2SXfLmjNj2xKdkDOhZcCun2wWEtv
         toprt7E23/8cF3mhMVcbm9Y8NxtD5dG6BzEbHSvAiJZMeiKYPstj6oAOjNYoi7Zhlj
         C2RgHWwJerbblUhskCAElnkzB3mdmtNnRv6JSOGbfuRJjMJqGMAqefocyGf2NlL5ob
         9RpnCevYGj6Rv0UZ9r5B1ZJH+65o1xEpua8iQUSIRVgmgXwYsKbRWb+PeWn7iOO88O
         Q7zanEUwrKIhw==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 659F027C0060;
        Thu, 17 Jun 2021 10:03:58 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Thu, 17 Jun 2021 10:03:58 -0400
X-ME-Sender: <xms:TVbLYP2WyuISm3JGhlrKTdXqVrVhuxbrhgKBr2RA3N7086aKysrnhw>
    <xme:TVbLYOGzG3PWQwwpoR25ce0GR_rjB_zC_4q6QPX9MLClK5kGczybU7jP9SUMbA-5a
    rP6MpjDxY65ii9vlzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefuddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeegjefghfdtledvfeegfeelvedtgfevkeeugfekffdvveeffeetieeh
    ueetveekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:TVbLYP4UNM_0jfxmulQ8MGM0tujcLFKwEPF_dOJN5KUJ7VErl-_Vyg>
    <xmx:TVbLYE2QFOdrAqSzL5rQUxwNr4lyT-amcnqc4-n28UJPwi-P2nG3fQ>
    <xmx:TVbLYCFjpuYEH0dvWEkfrgsstc7y3BMMzpbWzi_6kgYWa_0ToB9YEA>
    <xmx:TlbLYF34zUX80YNHWM-Co8BGbhoyn26wGQJRuMf1CWpdegmlwVv7Pkq3jac>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 64DEE51C0060; Thu, 17 Jun 2021 10:03:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <616a869c-fd19-4de8-b1c0-68e03955b1b0@www.fastmail.com>
In-Reply-To: <YMsVvsMRJ2yKf1WM@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
 <YMsVvsMRJ2yKf1WM@hirez.programming.kicks-ass.net>
Date:   Thu, 17 Jun 2021 07:03:36 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Nicholas Piggin" <npiggin@gmail.com>,
        "Rik van Riel" <riel@surriel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: =?UTF-8?Q?Re:_[RFC][PATCH]_sched:_Use_lightweight_hazard_pointers_to_gra?=
 =?UTF-8?Q?b_lazy_mms?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Jun 17, 2021, at 2:28 AM, Peter Zijlstra wrote:
> On Thu, Jun 17, 2021 at 11:08:03AM +0200, Peter Zijlstra wrote:
> 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index e595e77913eb..57415cca088c 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1104,6 +1104,8 @@ static inline void __mmput(struct mm_struct *mm)
> >  	}
> >  	if (mm->binfmt)
> >  		module_put(mm->binfmt->module);
> > +
> > +	mm_unlazy_mm_count(mm);
> >  	mmdrop(mm);
> >  }
> >  
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 8ac693d542f6..e102ec53c2f6 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -19,6 +19,7 @@
> 
> > +/*
> > + * This converts all lazy_mm references to mm to mm_count refcounts.  Our
> > + * caller holds an mm_count reference, so we don't need to worry about mm
> > + * being freed out from under us.
> > + */
> > +void mm_unlazy_mm_count(struct mm_struct *mm)
> > +{
> > +	unsigned int drop_count = num_possible_cpus();
> > +	int cpu;
> > +
> > +	/*
> > +	 * mm_users is zero, so no cpu will set its rq->lazy_mm to mm.
> > +	 */
> > +	WARN_ON_ONCE(atomic_read(&mm->mm_users) != 0);
> > +
> > +	/* Grab enough references for the rest of this function. */
> > +	atomic_add(drop_count, &mm->mm_count);
> 
> So that had me puzzled for a little while. Would something like this be
> a better comment?
> 
> 	/*
> 	 * Because this can race with mmdrop_lazy(), mm_count must be
> 	 * incremented before setting any rq->drop_mm value, otherwise
> 	 * it is possible to free mm early.
> 	 */

Nope, because the caller already did it.  It's an optimization, but maybe it's a poorly done optimization -- I'd rather do two atomic ops than many.

How about:

drop_count = 0;

...

if (!drop_count) {
   /* Collect lots of references.  We'll drop the ones we don't use. */
  drop_count = num_possible_cpus();
  atomic_inc(drop_count, &->mm_count);
}
drop_count--;

