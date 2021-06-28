Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C23B60CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 16:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhF1Oaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 10:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234007AbhF1O1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:27:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C11E60698;
        Mon, 28 Jun 2021 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624890290;
        bh=c5MK679mOjHLpOHG6MQsrwMfX+tA/4yywNUcdXWtzGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WS5oGI6Xd17YPBcFs+u3qPXze8YqzxsD6LD4C2inEedmiJF6omiV9G0X4065JAH3r
         CCiCHcRwmKJYmxat4Q7hLELs+6sqRH/WZ3T37Rq1cAwX9YKaL+QZptxGqGnX8WqSLP
         KpyLuBNqkqUy9Mn5SQwYqKH7IkYe41CuZhHRtvNGzP3smHpLfETcvmagrCjlIQg5ZM
         te1lEdQrtJuR1C13b80MSBcGuNd5YAQcRiZZyOPREDvzJKj6oJ2l9VzwPWVxYfvKtV
         qD1Z4HiRyKnyx8MKnjT7lwurMEJjzy4o5glpJOGH5KCJx7oM3upDJ4EGImNC5ovymi
         X6R+OJorv439A==
Date:   Mon, 28 Jun 2021 23:24:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kprobe/static_call: Restore missing
 static_call_text_reserved()
Message-Id: <20210628232447.540fe9d53f0d2011d6590379@kernel.org>
In-Reply-To: <YNmz4nvH84jzX1aB@hirez.programming.kicks-ass.net>
References: <20210628112409.233121975@infradead.org>
        <20210628113045.167127609@infradead.org>
        <YNmz4nvH84jzX1aB@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 13:34:58 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jun 28, 2021 at 01:24:12PM +0200, Peter Zijlstra wrote:
> > Restore two hunks from commit 6333e8f73b83 ("static_call: Avoid
> > kprobes on inline static_call()s") that went walkabout.
> > 
> > Fixes: 76d4acf22b48 ("Merge tag 'perf-kprobes-2020-12-14' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> 
> FWIW, it was a royal pain in the arse to find that commit...

I think if this is a fix, that fixes static_call introduction commit,
because anyway kprobes has to check the static_call site as a reserved
area for another self code modifying.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
