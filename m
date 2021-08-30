Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6F3FBD69
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbhH3UYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233129AbhH3UYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:24:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65B9460240;
        Mon, 30 Aug 2021 20:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630354990;
        bh=tn3qgzyY5hPJkn4IIVN5SAwUHdjKS1rYEATcvTAHc2Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q5xtsCTIUdFm8S1L9ZIUuu72RJMsGfHWl0/i378RewZigtMXy27H6RjIFxgA+mTWj
         YXJqzPkkuBtgwSeH/q+adJ2B4mgnNTIVFi56+W9Ww82X/HSK7VJLN24pzZGb7jllN9
         0OLKHyS4mFCtFBOBF5DA+3szQa8B83TCdV5MSkUW+kKfaZlj3dvLB7MyXqyEooSw/h
         fy18+FExj8WHppxiMToIatQ5YQYLTquadrmv7ase6RqP68UqPJmB6ZEzlcd1LGNNvm
         tcAAgtI47SuweI/7xeUKU9OTmHL9n0NBU+j5xY0P2yBh/zFwtV1LYzwbVGElNCIbKL
         FaIdzAYoax85Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3636D5C0566; Mon, 30 Aug 2021 13:23:10 -0700 (PDT)
Date:   Mon, 30 Aug 2021 13:23:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Akira Yokosawa <akiyks@gmail.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        xiehaocheng.cn@gmail.com, jiangong.han@windriver.com,
        Joel Fernandes <joel@joelfernandes.org>, jwi@linux.ibm.com,
        fishland@aliyun.com, Mark Brown <broonie@kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        yanfei.xu@windriver.com, zhouzhouyi@gmail.com
Subject: Re: [GIT PULL] RCU changes for v5.15
Message-ID: <20210830202310.GY4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210830041459.GA3067667@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wiVNCemfBsTvSLGBycu55ArJAponTYhBqO8fzApiKj1xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVNCemfBsTvSLGBycu55ArJAponTYhBqO8fzApiKj1xg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 12:54:19PM -0700, Linus Torvalds wrote:
> On Sun, Aug 29, 2021 at 9:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Please pull the latest RCU git tree from:
> 
> Pulled.
> 
> I do note that you are one of the few people I pull from that haven't
> converted to signed tags yet.
> 
> It's not technically a problem, since I trust the kernel.org
> repositories, but when I notice I try to gently push people to use
> signed tags even on kernel.org repositories. It's just a good idea.
> 
> So here's that gentle nudge.
> 
> I even have an old pgp key from you in my keyring, so I know you at
> some point had one. And making git use them really is not a log more
> than using "git tag -s" to create one, and pointing me at the tag
> instead of the branch name.

Very well, I will use a signed tag for my next pull request to you.

If you would like to check ahead of time, I have created a
signed test tag named test.2021.08.30a on
git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

							Thanx, Paul
