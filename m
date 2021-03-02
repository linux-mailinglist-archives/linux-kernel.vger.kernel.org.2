Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5532A7C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839593AbhCBQhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbhCBOLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:11:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8354DC061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 05:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EubBMfIVizTxskJSZHHLt40+i8CYcZ/ie+sARr952Mc=; b=soD3rL9r9fPNuyFKOCHKxq6JUQ
        t4RV205rxrd8sVeBNVJZ1kflhqO0cXAS5YPuVNg7qVBYVzKENLijoW8no3eJUuUK0EgYU3mJ8e4iL
        VwdR57WDfV8fN2njkrwVDk+SUi/MgQWewsZUP9RupFV1pQXntgpp+bTTUisu4Cbv5eLwNUd+9AQ/i
        J+BfEDfdYkW5VHlT0zl6AZnXNAjRQ8TkuZlpQLgvUQDvn0jNOV4p3t/FG8JBPzQwt5B7aEuuE47zz
        ltGY2XuYJ3XJ26G0blSCYrR67QDQDWY4JRVOjPieF8Yy/C9j2Whl/oS7geSINgUcxuDPosfU6ZmRP
        7GZnBOcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lH5XG-00HDmS-UG; Tue, 02 Mar 2021 13:58:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B83330018A;
        Tue,  2 Mar 2021 14:58:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13C692027C1AA; Tue,  2 Mar 2021 14:58:01 +0100 (CET)
Date:   Tue, 2 Mar 2021 14:58:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 1/1] x86/kprobes: Use int3 instead of debug trap for
 single-step
Message-ID: <YD5EaUKI8lswWPMq@hirez.programming.kicks-ass.net>
References: <161460768474.430263.18425867006584111900.stgit@devnote2>
 <161460769556.430263.12936080446789384938.stgit@devnote2>
 <YD36O5wCpSElA9Fi@hirez.programming.kicks-ass.net>
 <YD39U0sz+IjV60VE@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD39U0sz+IjV60VE@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 09:54:43AM +0100, Peter Zijlstra wrote:


> +static void kprobe_emulate_jcc(struct kprobe *p, struct pt_regs *regs)
> +{
> +	bool invert = p->ainsn.jcc.type & 1;
> +	bool match;
> +
> +	if (p->ainsn.jcc.type < 0xc) {
> +		match = regs->flags & jcc_mask[p->ainsn.jcc.type >> 1];
> +	} else {
> +		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
> +			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
> +		if (p->ainsn.jcc.type >= 0xe)
> +			match = match && (regs->flags & X86_EFLAGS_ZF);
> +	}
> +	__kprobe_emulate_jmp(p, regs, (match && !invert) || (!match && invert));

Also, isn't that: 'match ^ invert' ?

> +}
