Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B793D7F24
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhG0UVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:21:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:52631 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232344AbhG0UUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:20:40 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 16RKDTXL032385;
        Tue, 27 Jul 2021 15:13:29 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 16RKDS4x032383;
        Tue, 27 Jul 2021 15:13:28 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 27 Jul 2021 15:13:28 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
Message-ID: <20210727201328.GY1583@gate.crashing.org>
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com> <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org> <YP+ZOx8BETgufxBS@kroah.com> <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com> <YP+ql3QFYnefR/Cf@kroah.com> <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com> <YQBJfAuMJhvd2TcJ@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQBJfAuMJhvd2TcJ@kroah.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 07:59:24PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 27, 2021 at 10:39:49AM -0700, Nick Desaulniers wrote:
> > I think warn_unused_result should only really be used for functions
> > where the return value should be used 100% of the time.
> 
> I too want a shiny new pony.
> 
> But here in the real world, sometimes you have functions that for 99% of
> the users, you do want them to check the return value, but when you use
> them in core code or startup code, you "know" you are safe to ignore the
> return value.
> 
> That is the case here.  We have other fun examples of where people have
> tried to add error handling to code that runs at boot that have actually
> introduced security errors and they justify it with "but you have to
> check error values!"
> 
> > If there are
> > cases where it's ok to not check the return value, consider not using
> > warn_unused_result on function declarations.
> 
> Ok, so what do you do when you have a function like this where 99.9% of
> the users need to check this?  Do I really need to write a wrapper
> function just for it so that I can use it "safely" in the core code
> instead?
> 
> Something like:
> 
> void do_safe_thing_and_ignore_the_world(...)
> {
> 	__unused int error;
> 
> 	error = do_thing(...);
> }
> 
> Or something else to get the compiler to be quiet about error being set
> and never used?

The simplest is to write
	if (do_thing()) {
		/* Nothing here, we can safely ignore the return value
		 * here, because of X and Y and I don't know, I have no
		 * idea actually why we can in this example.  Hopefully
		 * in real code people do have a good reason :-)
		 */
	}

which should work in *any* compiler, doesn't need any extension, is
quite elegant, and encourages documenting why we ignore the return
value here.


Segher
