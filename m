Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446613060E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhA0QVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbhA0QVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:21:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nBcpASb27oQxfuFk5lVfYG4x+m1rqZPFVsvQOkOivLA=; b=FQTizSnHOm3XLzHqjaTTX75HWm
        +3U6QR9Dk0JxzPj0afcHdIxAtWXI7CPaA8OfOysWmgWVkFpbIQtR0qvbR9O6tYN7hPa0VdTX4IeX5
        JUfb205Szb5TEuCvAW3IqedFNbrXB+oHhblG78JiAC1/4MjmNzSnLOfRtKEHNVEmf104DjIYf9+ap
        NO3DIPpKN8UWpWJLZzW/mLZtmmvK/5SSFQFrRJyZH47iitkxX5cMAs1EmhXa4gzo11oLlQ9fiDTBP
        NVEMMcAy7uB0m9nsqQ/x3k6YaEUgvNNS0Houe4QU2Ec6U7Vrdh+ZBIbSeeCSbAFredL3+gr/2EzeD
        bM98gaAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4nX7-007Dxb-NU; Wed, 27 Jan 2021 16:19:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D91E1300DB4;
        Wed, 27 Jan 2021 17:19:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C41D32D1C66FC; Wed, 27 Jan 2021 17:19:02 +0100 (CET)
Date:   Wed, 27 Jan 2021 17:19:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        rostedt@goodmis.org, jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <YBGSdtnKIL3kryos@hirez.programming.kicks-ass.net>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
 <20210126235730.lgfa2uida5se5urn@treble>
 <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
 <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
 <20210127155914.jfmr4jay47yck5h5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127155914.jfmr4jay47yck5h5@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:59:14AM -0600, Josh Poimboeuf wrote:
> On Wed, Jan 27, 2021 at 12:27:09PM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 27, 2021 at 10:13:47AM +0100, Peter Zijlstra wrote:
> > > On Tue, Jan 26, 2021 at 05:57:30PM -0600, Josh Poimboeuf wrote:
> > 
> > > > Well, I hate it, but I'm not sure I have any better ideas.  It should be
> > > > possible to use kallsyms, instead of the rb-tree/register nonsense.  Not
> > > > sure about the performance impact though.  Might be a good reason to
> > > > speed up kallsyms!
> > > 
> > > Oh right, let me see if I can make that work.
> > 
> > Something like so compiles.. but it does make the whole thing depend on
> > KALLSYMS_ALL, which is somewhat yuck.
> > 
> > Also, kallsyms_lookup_name() is horrible, but not trivial to fix because
> > of that compression scheme used.
> 
> The KALLSYMS_ALL dependency doesn't bother me personally but I assume
> some of the tinyconfig folks might not appreciate it being on
> permanently.

I suppose this ought to cure the _ALL thing.

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 7ecd2ccba531..83586cc4d954 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -260,6 +260,12 @@ static int symbol_valid(const struct sym_entry *s)
 {
 	const char *name = sym_name(s);
 
+	/*
+	 * Always emit __SCK__ symbols for static_call_add_module().
+	 */
+	if (!strncmp(name, "__SCK__", 7))
+		return 1;
+
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
