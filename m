Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517CA38830E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbhERXVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237815AbhERXVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:21:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBB6061059;
        Tue, 18 May 2021 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621380013;
        bh=AwH0YVAxJ9zD68qS2yu5RNzH4jRt80k+k9fn6Ttgrpg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LB8tvo8Ia7YYRkggSkKbiyiwcT5IzZT3u0KbNF3f48mvRZ6nTkiTHivR3AakfyI96
         6iycw/ap0mYOyTzyZWLKjNdhrfwcIMC/3jRPsIbPfvIyfiHKU1OtMVgSy7rYjR95ro
         HS25yOVmL2wB+ytb1P/wfkHr+Gq+nN1XbQHaiU7Ka76dkje2t5uRAxYoB6qQKgTYsh
         aBi2ddR5ie1MoTzjmzgoc/5NGf1nLT3XeB+44sQxWp/sxh1SvUmuXBybPqyfuKwByD
         JwPV/4KEg3kGluKIllXgakHy94AtVKTB1JLtRKZWiGgIgQFbTw6+BhepwGvm1l57EU
         e/0iDDeGlw4eQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B862D5C013C; Tue, 18 May 2021 16:20:12 -0700 (PDT)
Date:   Tue, 18 May 2021 16:20:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
Message-ID: <20210518232012.GA2976391@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210514140015.2944744-1-arnd@kernel.org>
 <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
 <20210514193657.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <534d9b03-6fb2-627a-399d-36e7127e19ff@kernel.org>
 <20210514201808.GO975577@paulmck-ThinkPad-P17-Gen-1>
 <CAK8P3a3O=DPgsXZpBxz+cPEHAzGaW+64GBDM4BMzAZQ+5w6Dow@mail.gmail.com>
 <YJ8BS9fs5qrtQIzg@elver.google.com>
 <20210515005550.GQ975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515005550.GQ975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 05:55:50PM -0700, Paul E. McKenney wrote:
> On Sat, May 15, 2021 at 01:01:31AM +0200, Marco Elver wrote:
> > On Fri, May 14, 2021 at 11:16PM +0200, Arnd Bergmann wrote:
> > > On Fri, May 14, 2021 at 10:18 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > On Fri, May 14, 2021 at 01:11:05PM -0700, Nathan Chancellor wrote:
> > > 
> > > > > You can see my response to Marco here:
> > > > >
> > > > > https://lore.kernel.org/r/ad7fa126-f371-5a24-1d80-27fe8f655b05@kernel.org/
> > > > >
> > > > > Maybe some improved wording might look like
> > > > >
> > > > > clang with CONFIG_LTO_CLANG points out that an initcall function should
> > > > > return an 'int' due to the changes made to the initcall macros in commit
> > > > > 3578ad11f3fb ("init: lto: fix PREL32 relocations"):
> > > >
> > > > OK, so the naive reading was correct, thank you!
> > > >
> > > > > ...
> > > > >
> > > > > Arnd, do you have any objections?
> > > >
> > > > In the meantime, here is what I have.  Please let me know of any needed
> > > > updates.
> > > >
> > > 
> > > Looks good to me, thanks for the improvements!
> > 
> > FWIW, this prompted me to see if I can convince the compiler to complain
> > in all configs. The below is what I came up with and will send once the
> > fix here has landed. Need to check a few other config+arch combinations
> > (allyesconfig with gcc on x86_64 is good).
> 
> Cool!
> 
> If I have not sent the pull request for Arnd's fix by Wednesday, please
> remind me.

Except that I was slow getting Miguel Ojeda's Reviewed-by applied.
I need to wait for -next to incorporate this change (hopefully by
tomorrow, Pacific Time), and then test this.  With luck, I will send
this Thursday, Pacific Time.

							Thanx, Paul
