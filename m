Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A398F358A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhDHQxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHQxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:53:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A101C061760;
        Thu,  8 Apr 2021 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=upVcDolMNl5nqI5E1VMuEnokw7YJ/C7hcHq1oVyjJAc=; b=N/QfGisoTfPlo9Qj/HDvxFieAn
        dCW7TQbaT9sU+R43Nk7AwqRFeWoPQu/P2dqWJRxOzzQ995HROR+F7RPpFJ3o7bd97VN9E/xf2aXBD
        J4RTPNqJ30E2IHx5qZhXQbv3V7BQHkpILEj5Hm2aagOgxqlJT7BME6U9wfGOdytaqDSlidHpkvUOO
        k+M4o/0wIbhYiv9vWFKfDt/cPL7AjvsmhNecmEel2d57sTcZNe50WaH8SGYXmr4gUBxotrxK65ZT7
        JAKGjBLWOrHtc73rUwvfQdvXsosOIgpda5am61n3ZqU09cx1LunAnYOlZhfiwre7f+QQxNVdI03bU
        DlusU3rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXtD-00GY5I-E1; Thu, 08 Apr 2021 16:52:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13F4D300084;
        Thu,  8 Apr 2021 18:52:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCC59205F8642; Thu,  8 Apr 2021 18:52:18 +0200 (CEST)
Date:   Thu, 8 Apr 2021 18:52:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-toolchains@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org
Subject: static_branch/jump_label vs branch merging
Message-ID: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Given code like:

DEFINE_STATIC_KEY_FALSE(sched_schedstats);

#define   schedstat_enabled()		static_branch_unlikely(&sched_schedstats)
#define   schedstat_set(var, val)	do { if (schedstat_enabled()) { var = (val); } } while (0)
#define __schedstat_set(var, val)	do { var = (val); } while (0)

void foo(void)
{
	struct task_struct *p = current;

	schedstat_set(p->se.statistics.wait_start,  0);
	schedstat_set(p->se.statistics.sleep_start, 0);
	schedstat_set(p->se.statistics.block_start, 0);
}

Where the static_branch_unlikely() ends up being:

static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
{
	asm_volatile_goto("1:"
		".byte " __stringify(BYTES_NOP5) "\n\t"
		".pushsection __jump_table,  \"aw\" \n\t"
		_ASM_ALIGN "\n\t"
		".long 1b - ., %l[l_yes] - . \n\t"
		_ASM_PTR "%c0 + %c1 - .\n\t"
		".popsection \n\t"
		: :  "i" (key), "i" (branch) : : l_yes);

	return false;
l_yes:
	return true;
}

The compiler gives us code like:

000000000000a290 <foo>:
    a290:       65 48 8b 04 25 00 00 00 00      mov    %gs:0x0,%rax     a295: R_X86_64_32S      current_task
    a299:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
    a29e:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
    a2a3:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
    a2a8:       c3                      retq
    a2a9:       48 c7 80 28 01 00 00 00 00 00 00        movq   $0x0,0x128(%rax)
    a2b4:       eb e8                   jmp    a29e <foo+0xe>
    a2b6:       48 c7 80 58 01 00 00 00 00 00 00        movq   $0x0,0x158(%rax)
    a2c1:       eb e0                   jmp    a2a3 <foo+0x13>
    a2c3:       48 c7 80 70 01 00 00 00 00 00 00        movq   $0x0,0x170(%rax)
    a2ce:       c3                      retq


Now, in this case I can easily rewrite foo like:

void foo2(void)
{
	struct task_struct *p = current;

	if (schedstat_enabled()) {
		__schedstat_set(p->se.statistics.wait_start,  0);
		__schedstat_set(p->se.statistics.sleep_start, 0);
		__schedstat_set(p->se.statistics.block_start, 0);
	}
}

Which gives the far more reasonable:

000000000000a2d0 <foo2>:
    a2d0:       65 48 8b 04 25 00 00 00 00      mov    %gs:0x0,%rax     a2d5: R_X86_64_32S      current_task
    a2d9:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
    a2de:       c3                      retq
    a2df:       48 c7 80 28 01 00 00 00 00 00 00        movq   $0x0,0x128(%rax)
    a2ea:       48 c7 80 58 01 00 00 00 00 00 00        movq   $0x0,0x158(%rax)
    a2f5:       48 c7 80 70 01 00 00 00 00 00 00        movq   $0x0,0x170(%rax)
    a300:       c3                      retq

But I've found a few sites where this isn't so trivial.

Is there *any* way in which we can have the compiler recognise that the
asm_goto only depends on its arguments and have it merge the branches
itself?

I do realize that asm-goto being volatile this is a fairly huge ask, but
I figured I should at least raise the issue, if only to raise awareness.


