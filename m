Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E53AB56C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhFQOJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhFQOI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:08:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9CDE6128B;
        Thu, 17 Jun 2021 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623938808;
        bh=USuNS66VwI9Dv2TF97Ch23upshZW3laFb5thOQmiS5I=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=HP9G5Cmithaedw7ZjqQwt9D7EP5IjN4Vkw0JZz5HUNnyo/YIERgzR72vovik6zBPf
         Loj9Co9AEPFh439dGun3u1skVv1GtH35fNPw6kexaLe4M9+pICx3+hxmcFqV4iol6b
         wFrfY3bcLCY7CrC5Udwjq8EsNr6PgYDDOFg9S6J/4k1cAkJkPlxxTPRhTa51wzQj+m
         eEx8lwF62p3ohEiu9aav+Cp+jGQ24Xr3hO09An6RUjowda5Q8RDKFfF7McsTlbgY/b
         TWy6O2BAAUXW1S5nuW2ZKKYLG+4IZ8uti+w4Uog9Hacs4f+eJ6ZieuDw47w+Kol1Ia
         lUqk/ZQ/qQz4Q==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id D6CE327C005A;
        Thu, 17 Jun 2021 10:06:46 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Thu, 17 Jun 2021 10:06:46 -0400
X-ME-Sender: <xms:9lbLYEhyieUILZXZGG3yDrzX8mFILEJ2COXqCbl7G7N9Iayn0UH3jQ>
    <xme:9lbLYNB0iErkXetn6gO-uzyNVe2-Fh6vRtHmMS-ert4ubnw8lYQNZFoWyVH7yF6go
    ePW40UxPG8zHcI_oNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefuddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeegjefghfdtledvfeegfeelvedtgfevkeeugfekffdvveeffeetieeh
    ueetveekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:9lbLYMH0LFxm1TWbCMB9i3U1FQtfJSLveCOVQl9JNA72bnb0aa5hoA>
    <xmx:9lbLYFQI2eeXbGhnn44yzLTDyve4sXwk52mhJoH88wD-6sgTk7qemA>
    <xmx:9lbLYBzIl3bdvkP90FgWmmvz02KXlWaCikxWMwJ3tw4k2IPb7Zu3pQ>
    <xmx:9lbLYAzTON4eaW64SZIiiO87cAbIgZmiliAZKI5tWhlBMa9ziBS-8yH-XLA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E7E1A51C0060; Thu, 17 Jun 2021 10:06:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <ad5ed13a-172d-4e13-b09f-0d04e3896eeb@www.fastmail.com>
In-Reply-To: <YMsSVH36QGrf7oKH@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
 <YMsSVH36QGrf7oKH@hirez.programming.kicks-ass.net>
Date:   Thu, 17 Jun 2021 07:06:24 -0700
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



On Thu, Jun 17, 2021, at 2:13 AM, Peter Zijlstra wrote:
> On Thu, Jun 17, 2021 at 11:08:03AM +0200, Peter Zijlstra wrote:
> > +static void mmdrop_lazy(struct rq *rq)
> > +{
> > +	struct mm_struct *old_mm;
> > +
> > +	if (likely(!READ_ONCE(rq->drop_mm)))
> > +		return;
> > +
> > +	/*
> > +	 * Slow path.  This only happens when we recently stopped using
> > +	 * an mm that is exiting.
> > +	 */
> > +	old_mm = xchg(&rq->drop_mm, NULL);
> > +	if (old_mm)
> > +		mmdrop(old_mm);
> > +}
> 
> AFAICT if we observe a !NULL value on the load, the xchg() *MUST* also
> see !NULL (although it might see a different !NULL value). So do we want
> to write it something like so instead?

Like so?

> 
> static void mmdrop_lazy(struct rq *rq)
> {
> 	struct mm_struct *old_mm;
> 
> 	if (likely(!READ_ONCE(rq->drop_mm)))
> 		return;
> 
> 	/*
> 	 * Slow path.  This only happens when we recently stopped using
> 	 * an mm that is exiting.

* This xchg is the only thing that can change rq->drop_mm from non-NULL to NULL, and
* multiple mmdrop_lazy() calls can't run concurrently on the same CPU.

> 	 */
> 	old_mm = xchg(&rq->drop_mm, NULL);
> 	if (WARN_ON_ONCE(!old_mm))
> 		return;
> 
> 	mmdrop(old_mm);
> }
> 

--Andy
