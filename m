Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B9C413BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhIUVDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231592AbhIUVDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:03:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD6FB61159;
        Tue, 21 Sep 2021 21:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632258125;
        bh=lDwQzdXVgtBtV2xSS/Tbe8ndRTlTdXxGKtVsEMYWjM0=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=k7XBg+5Z5Omooz7EG3y4ErV2xS4y2PFh9/ZtJ67DEz3Pu4lTkq7bWXc3Uni17pDMS
         zKYu7Cd7EfnRJG9MXZkP6j8FU29F2ci5Z0XbxnWbp7wMgbNTh9ivB9Yick0PNpwXaC
         14H3kUR4/Wzzf1uEULxrOqZyyRsh7AOjmyCam+eS6ay/r1dePFMkX9DG25JMmD//eu
         goSUq0SLAcogJgzS3C1JiStVtO6pVpOmVYIwT2M4dBe+Jc+ANYPj0mMpz1vySkOoiy
         Eqm6oDvOJvOPAPVtWQ79ijUD1WOrWWo7i2uBhs1oAXej1KHtNe+jiZJF1TyRwsP3AI
         3hoo/DlN6W3/g==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9F55F27C0054;
        Tue, 21 Sep 2021 17:02:03 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Tue, 21 Sep 2021 17:02:03 -0400
X-ME-Sender: <xms:SkhKYT___25HHUyI2-xNjeCsjBXD1cMZIu30_GrHBwInI4fQ_xWr5w>
    <xme:SkhKYftjXHryenuG6M1Jp06TZHRt0FEWt6cABajwO_cGow4xGfQnMnzJA9m6lWKUw
    5REtQ4yGgjSvP8M8MU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeihedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:SkhKYRBs7ud_Y7yraVXqqaZhuinfWMmdGuaZRCiLNvwZAiqmOSffQA>
    <xmx:SkhKYffOPblAaFwqsBm66qntTP0n_XbgKJiScsJV3RJbW9NtevI1dg>
    <xmx:SkhKYYPNOqGp_sEWrn4Sbr_bRyn2NYqX8SnC7KZ2Jmh_pyX5jV5xig>
    <xmx:S0hKYVoe8hf7O_i_OocegQkWIwXqtRyWKYifvincCqiz4LI7nd6cFA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5D857A000E3; Tue, 21 Sep 2021 17:02:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1291-gc66fc0a3a2-fm-20210913.001-gc66fc0a3
Mime-Version: 1.0
Message-Id: <01288fc6-4525-48a5-8ab5-0c617fdbcfc9@www.fastmail.com>
In-Reply-To: <YUWPuPyBxR9OVtXS@hirez.programming.kicks-ass.net>
References: <202109151423.43604.linux@zary.sk>
 <202109162227.17415.linux@zary.sk>
 <20210916210509.GG4323@worktop.programming.kicks-ass.net>
 <202109171011.31916.linux@zary.sk>
 <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
 <CAHk-=wj_-bRjcJdXubdUUsTph+DH-5f77FmkbNCfFVYg=Td2zw@mail.gmail.com>
 <CAHk-=whsG4LfNJHjeprDn0iR=zRGBUBtSSgLep=MqbEb8yBuuA@mail.gmail.com>
 <YUWPuPyBxR9OVtXS@hirez.programming.kicks-ass.net>
Date:   Tue, 21 Sep 2021 14:01:40 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Ondrej Zary" <linux@zary.sk>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Sep 18, 2021, at 12:05 AM, Peter Zijlstra wrote:
> On Fri, Sep 17, 2021 at 03:24:51PM -0700, Linus Torvalds wrote:
>> On Fri, Sep 17, 2021 at 3:23 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> >
>> > I think the proper thing to do is perhaps something like
>> 
>> The alternative is to just ignore cs_abse entirely, and just use
>> "regs->ip", which makes this all even easier.
>> 
>> If somebody uses a code segment _and_ cli/sti, maybe they should just
>> get the SIGSEGV?
>
> I did a hatched job on fixup_ump_exception() which is why it looks like
> it does, that said...
>
> our case at hand mmap()'s BIOS code from /dev/mem and executes that, I
> don't think it does an LDT segment but it would be entirely in line with
> the level of hack we're looking at.
>
> Let me frob at this after breakfast and see if I can make it better.

The patch seems fine, but I have to ask: is this really worth fixing?

I suppose the log message could check if the computer comes from HP(E) and gently that the owner switch vendors.
