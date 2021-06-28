Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F55C3B6B98
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 01:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhF2ABk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 20:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhF2ABj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 20:01:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16B5C61A1D;
        Mon, 28 Jun 2021 23:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624924753;
        bh=xyvy++xT2M7pC/A5A4/smmf6HxRIsaviCNDI1HrEYH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MxVaSHFMSp98KnoIrREC2RnliUZpjOPlaqG0R3E+FvAUBmkwi8oKfN/cXMWHunJ1h
         o4vfuYdS//ZTCE5d+n3xfdDX54mShvY9Fs11ZvQA7dBYFY67TT3gcO0xndYd/J4jUB
         z+dYbHCykD4wcltG5bSebpH62tskxgwDmVcrQ6hsXWvS1zxQ2fOUdB7TeU7d7IYgrI
         sedttfNCPvrd95nmJ1N1nYj7WxFeGWB9B6VhH2VpOfCuIxlQ9h2wfyJtvvfI5dSdBN
         Sni9Azb6Nd6YEpf4HP9/slHPkLG1jFxEO3pyOBb2RKlQiyg6WfH9h+6jzTAfvf8Sl0
         7g4d4su5VRt3w==
Date:   Tue, 29 Jun 2021 08:59:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: selftest/ftrace: Add test results to "-h" help text to
 ftracetest
Message-Id: <20210629085910.5dbb704ed3e7001bc65f1e16@kernel.org>
In-Reply-To: <YNnl2YQcW05RR7kN@hirez.programming.kicks-ass.net>
References: <20210628095015.4b8b1cb9@oasis.local.home>
        <YNnl2YQcW05RR7kN@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 17:08:09 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jun 28, 2021 at 09:50:15AM -0400, Steven Rostedt wrote:
> > +echo "	UNRESOLVED	The test produced indeterminate results. (e.g. interrupted)"
> > +echo "	UNSUPPORTED	The test failed because of lack of feature."
> 
> So in my case I've seen both these as a result of .config fails.
> 
> Specifically test.d/kprobe/kprobe_module.tc returns exit_unresolved when
> it can't load the module (because it doesn't exist).

Since I defined these result code from DejaGnu (based on POSIX 1003.3) result,
I made such error (failed to load kernel module, which just gives a target
but is not an implementation of the tested feature) UNRESOLVED.

https://www.gnu.org/software/dejagnu/manual/A-POSIX-Conforming-Test-Framework.html
---
Here are some of the ways a test may wind up UNRESOLVED:
...
- The test was set up incorrectly.
---
My logic is that you are not correctly (compile and) install the target module,
so this is a setting issue.


> Also, would it be at all possible to, for both these options, always
> print the missing CONFIG_symbol ? The above test actually has an echo
> for it, but I've never seen the result of that appear.

That's a good idea :) Let me try to add depending CONFIG_ options for
each test cases.

Thank you, 

-- 
Masami Hiramatsu <mhiramat@kernel.org>
