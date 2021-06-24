Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3F93B31CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhFXO4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhFXO4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:56:43 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5627E60C3E;
        Thu, 24 Jun 2021 14:54:24 +0000 (UTC)
Date:   Thu, 24 Jun 2021 10:54:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <kernel-hardening@lists.openwall.com>, <ying.xue@windriver.com>,
        <ps-ccm-rr@windriver.com>
Subject: Re: [PATCH] seq_buf: let seq_buf_putmem_hex support len larger than
 8
Message-ID: <20210624105422.5c8aaf4d@oasis.local.home>
In-Reply-To: <20210624131646.17878-1-yun.zhou@windriver.com>
References: <20210624131646.17878-1-yun.zhou@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 21:16:46 +0800
Yun Zhou <yun.zhou@windriver.com> wrote:

> I guess the original intention of seq_buf_putmem_hex is to dump the raw

A little background, this was originally introduced in 2008:

 5e3ca0ec76fce ("ftrace: introduce the "hex" output method")

And commit ad0a3b68114e8 ("trace: add build-time check to avoid overrunning hex buffer")

changed HEX_CHARS from a hardcoded 17 to a way to decided what the max
long is.

 #define HEX_CHARS              (MAX_MEMHEX_BYTES*2 + 1)


> memory to seq_buf according to 64 bits integer number. It tries to output
> numbers in reverse, with the high bits in the front and the low bits in
> the back. If the length of the raw memory is equal to 8, e.g.
> "01 23 45 67 89 ab cd ef" in memory, it will be dumped as "efcdab8967452301".

Note, it only does that for little endian machines.

> 
> But if the length of the raw memory is larger than 8, the first value of
> start_len will larger than 8, than seq_buf will save the last data, not
> the eighth one, e.g. "01 23 45 67 89 ab cd ef 11" in memory, it will be
> dumped as "11efcdab8967452301". I think it is not the original
> intention of the function.
> 
> More seriously, if the length of the raw memory is larger than 9, the
> start_len will be larger than 9, then hex will overflow, and the stack will be
> corrupted. I do not kown if it can be exploited by hacker. But I am sure
> it will cause kernel panic when the length of memory is more than 32 bytes.
> 
> [  448.551471] Unable to handle kernel paging request at virtual address 3438376c
> [  448.558678] pgd = 6eaf278e
> [  448.561376] [3438376c] *pgd=00000000
> [  448.564945] Internal error: Oops: 5 [#2] PREEMPT ARM
> [  448.569899] Modules linked in:
> [  448.572951] CPU: 0 PID: 368 Comm: cat Tainted: G        W        4.18.40-yocto-standard #18
> [  448.581374] Hardware name: Xilinx Zynq Platform
> [  448.585901] PC is at trace_seq_putmem_hex+0x6c/0x84
> [  448.590768] LR is at 0x20643032
> [  448.593901] pc : [<c009a85c>]    lr : [<20643032>]    psr: 60000093
> [  448.600159] sp : d980dc08  ip : 00000020  fp : c05f58cc
> [  448.605375] r10: c05e5f30  r9 : 00000031  r8 : 00000000
> [  448.610584] r7 : 20643032  r6 : 37663666  r5 : 36343730  r4 : 34383764
> [  448.617103] r3 : 00001000  r2 : 00000042  r1 : d980dc00  r0 : 00000000
> ...
> [  448.907962] [<c009a85c>] (trace_seq_putmem_hex) from [<c010b008>] (trace_raw_output_write+0x58/0x9c)
> [  448.917094] [<c010b008>] (trace_raw_output_write) from [<c00964c0>] (print_trace_line+0x144/0x3e8)
> [  448.926050] [<c00964c0>] (print_trace_line) from [<c0098710>] (ftrace_dump+0x204/0x254)
> [  448.934053] [<c0098710>] (ftrace_dump) from [<c0098780>] (trace_die_handler+0x20/0x34)
> [  448.941975] [<c0098780>] (trace_die_handler) from [<c003cff8>] (notifier_call_chain+0x48/0x6c)
> [  448.950581] [<c003cff8>] (notifier_call_chain) from [<c003d19c>] (__atomic_notifier_call_chain+0x3c/0x50)
> [  448.960142] [<c003d19c>] (__atomic_notifier_call_chain) from [<c003d1cc>] (atomic_notifier_call_chain+0x1c/0x24)
> [  448.970306] [<c003d1cc>] (atomic_notifier_call_chain) from [<c003d204>] (notify_die+0x30/0x3c)
> [  448.978908] [<c003d204>] (notify_die) from [<c001361c>] (die+0xc4/0x258)
> [  448.985604] [<c001361c>] (die) from [<c00173e8>] (__do_kernel_fault.part.0+0x5c/0x7c)
> [  448.993438] [<c00173e8>] (__do_kernel_fault.part.0) from [<c043a270>] (do_page_fault+0x158/0x394)
> [  449.002305] [<c043a270>] (do_page_fault) from [<c00174dc>] (do_DataAbort+0x40/0xec)
> [  449.009959] [<c00174dc>] (do_DataAbort) from [<c0009970>] (__dabt_svc+0x50/0x80)
> 
> Additionally, the address of data ptr keeps in the same value in multiple
> loops, the value of data buffer will not be picked forever.

So the bug looks like it was there since the original code was
introduced in 2008! There's two variables being increased in that loop
(i and j), and i follows the raw data, and j follows what is being
written into the buffer. The bug is that we are comparing the HEX_CHARS
to 'i' when we really should be comparing it to 'j'! As if 'j' goes
bigger than HEX_CHARS, it will overflow the destination buffer.

And, it should be noted, that this is to read a single word (long) and
not more. Thus, the "date += start_len" shouldn't be needed.

Could you send another patch that makes it only process a single word
and exit?

I'll tag it for stable when you do.

Thanks!

-- Steve


> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>  lib/seq_buf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 6aabb609dd87..948c8b55f666 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -229,7 +229,7 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
>  	WARN_ON(s->size == 0);
>  
>  	while (len) {
> -		start_len = min(len, HEX_CHARS - 1);
> +		start_len = min(len, MAX_MEMHEX_BYTES);
>  #ifdef __BIG_ENDIAN
>  		for (i = 0, j = 0; i < start_len; i++) {
>  #else
> @@ -248,6 +248,8 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
>  		seq_buf_putmem(s, hex, j);
>  		if (seq_buf_has_overflowed(s))
>  			return -1;
> +
> +		data += start_len;
>  	}
>  	return 0;
>  }

