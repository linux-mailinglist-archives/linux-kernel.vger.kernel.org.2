Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1519A3754AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhEFN0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhEFN0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:26:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3735613DA;
        Thu,  6 May 2021 13:25:51 +0000 (UTC)
Date:   Thu, 6 May 2021 09:25:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, mingo@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, zong.li@sifive.com,
        guoren@linux.alibaba.com, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] RISC-V: Don't check text_mutex during stop_machine
Message-ID: <20210506092550.6c2206b3@gandalf.local.home>
In-Reply-To: <20210506071041.417854-1-palmer@dabbelt.com>
References: <20210506071041.417854-1-palmer@dabbelt.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 May 2021 00:10:41 -0700
Palmer Dabbelt <palmer@dabbelt.com> wrote:

> ---
> In theory we should be able to avoid using stop_machine() with some
> clever code sequences, but that's too big of a change to be considered a
> fix.  I also can't find the text I thought was in the ISA manual about
> the allowed behaviors for concurrent modification of the instruction
> stream, so I might have just mis-remembered that.
> ---

I wonder if you could at least use break points, as some other archs do,
and what x86 does.

If you have this make believe machine code:

	00 00 00 00		nop

And you want to turn it into a call.

	aa 12 34 56		bl ftrace_caller

And if your architecture has a way to inject a break point on live code.
Let's call this FF for the break point code.

You can inject that first:

	FF 00 00 00

sync all CPUs where now all callers will hit this and jump to the break
point handler, which simply does:

	ip = ip + 4;
	return;

and returns back to the instruction after this nop/call.

Change the rest of the instruction.

	FF 12 34 56

sync all CPUs so that they all see this new instruction, but are still
triggering the break point.

Then finally remove the break point.

	aa 12 34 56

And you just switched from the nop to the call without using stop machine.

-- Steve
