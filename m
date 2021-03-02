Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13332A388
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382204AbhCBJHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241926AbhCBIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:51:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD47BC061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HsCRi/QTFjS1FdoH3Gjri7IOYgAetPwlfbAOJgIbFnM=; b=STKVXratUK9AxBgWywMgLHN5xu
        KGcWDRWMOyOt/Glm3hQNyWwzAnrOeJzM6jzWjBpCRQgGjTQ2yPJ7aD+Cv3w+ZXQkg03OtpHXWaNhd
        Dy2z8mWZL+oJm79jQYhgiqn43IBpLPDi4BOM6/7tbwFZ1T1Yu5Ep2OIVEh3RXNrb2BV44mDPA7zqe
        QqRQ+IpbzaAQTGJY3z2qWoMLUa+z8Yrsg8b3rGNUr8MRXoUOeDfzqlt8Zfob3JCnd9uB7FW9eFrwl
        WSCv0G3x9Z/cdPOFJMmeufytCqd9JR4ALRnLBqaabBewdhhZO2hRSPNTwZAdcVABplW8JFFVC8p5V
        07Hag4IQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lH0ay-00Gpay-Sn; Tue, 02 Mar 2021 08:41:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C21630011C;
        Tue,  2 Mar 2021 09:41:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 042382BBC85AF; Tue,  2 Mar 2021 09:41:31 +0100 (CET)
Date:   Tue, 2 Mar 2021 09:41:31 +0100
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
Message-ID: <YD36O5wCpSElA9Fi@hirez.programming.kicks-ass.net>
References: <161460768474.430263.18425867006584111900.stgit@devnote2>
 <161460769556.430263.12936080446789384938.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161460769556.430263.12936080446789384938.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 11:08:15PM +0900, Masami Hiramatsu wrote:
> Use int3 instead of debug trap exception for single-stepping the
> probed instructions. Some instructions which change the ip
> registers or modify IF flags are emulated because those are not
> able to be single-stepped by int3 or may allow the interrupt
> while single-stepping.
> 
> This actually changes the kprobes behavior.
> 
> - kprobes can not probe following instructions; int3, iret,
>   far jmp/call which get absolute address as immediate,
>   indirect far jmp/call, indirect near jmp/call with addressing
>   by memory (register-based indirect jmp/call are OK), and
>   vmcall/vmlaunch/vmresume/vmxoff.
> 
> - If the kprobe post_handler doesn't set before registering,
>   it may not be called in some case even if you set it afterwards.
>   (IOW, kprobe booster is enabled at registration, user can not
>    change it)
> 
> But both are rare issue, unsupported instructions will not be
> used in the kernel (or rarely used), and post_handlers are
> rarely used (I don't see it except for the test code).
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Very nice!

Aside of a few nits:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
