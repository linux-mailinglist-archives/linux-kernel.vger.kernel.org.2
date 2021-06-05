Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E512F39C536
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhFECre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhFECre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:47:34 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64762613EA;
        Sat,  5 Jun 2021 02:45:46 +0000 (UTC)
Date:   Fri, 4 Jun 2021 22:45:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jacob Wen <jian.w.wen@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] tracing: Add a verifier to check string pointers
 for trace events
Message-ID: <20210604224544.134c652f@rorschach.local.home>
In-Reply-To: <20210604222830.2505d67a@rorschach.local.home>
References: <20210226185909.100032746@goodmis.org>
        <20210226190705.871102407@goodmis.org>
        <YLrRUmwjjaozIt4K@google.com>
        <20210604222830.2505d67a@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 22:28:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> What you described to me does not sound like a false positive, and
> converting to __string() is not a workaround but an actual fix, and
> would also need to be backported to stable.

If the event you are talking about is kvm_nested_vmenter_failed, which
records a pointer to the message, then, yes, that is unsafe and buggy.

If that event is defined by the kvm module, and used in kvm_intel. If
you have this:

	# echo 1 > /sys/kernel/tracing/events/kvm/kvm_nested_vmenter_failed

	# do_whatever_causes_that_to_trigger

	# rmmod kvm_intel

	# cat trace

Then that pointer to the string will point to some random memory.
Before this patch, it could even possibly crash the kernel!

There's two fixes you can do with this. One is to covert that to use
__string, the other is to do what RCU does, and use the
tracepoint_string() functionality.

RCU has:

	#define TPS(x)	tracepoint_string(x)

And wrap all strings with that TPS(), like in nested_vmx_reflect_vmexit():

        if (unlikely(vmx->fail)) {
                trace_kvm_nested_vmenter_failed(
-                       "hardware VM-instruction error: ",
+                       TPS("hardware VM-instruction error: "),
                        vmcs_read32(VM_INSTRUCTION_ERROR));
                exit_intr_info = 0;
                exit_qual = 0;
                goto reflect_vmexit;
        }

What the tracepoint_string does is to save the string into core kernel
memory (there's logic to use the same string if it is already
available), and it wont free it when the module is unloaded.

This makes the string safe to use by the trace event directly.

Not only is the TPS safe, it also allows userspace tools to know what
the string is, as it is exported in printk_formats. Otherwise trace-cmd
and perf will only display a pointer hex value as it has no idea what
its pointing to (both TPS and __string fixes this).

-- Steve
