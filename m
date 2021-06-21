Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAD13AE558
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhFUI44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:56:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55022 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhFUI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:56:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DBFA421A5F;
        Mon, 21 Jun 2021 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624265647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z29NiOZnPCs3ZLnHpWRg/UID2y5f48OSKobcQVNlz/8=;
        b=LCfYWum8p/HMD3YLqAgxSJhd8QQx3lFwHSuJ6bgkJzfOP7xoleVw0UyDlAqNX78HOIBUin
        W7oTmhhYv9BVkgZkpiU4AR28n0y8rbS596r8hmNFgeSVeIwy0R6q9N+OnXeySnybx8hUWs
        TcDOiVEbb/wooP5tbOU+G468s4Ao8AM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 32B7EA3BA2;
        Mon, 21 Jun 2021 08:54:07 +0000 (UTC)
Date:   Mon, 21 Jun 2021 10:54:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v7 0/5] printk: Userspace format indexing support
Message-ID: <YNBTrhErZsp0jKYG@alley>
References: <cover.1623775748.git.chris@chrisdown.name>
 <YMsfo3/b1LvOoiM0@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMsfo3/b1LvOoiM0@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-17 12:10:43, Petr Mladek wrote:
> On Tue 2021-06-15 17:52:20, Chris Down wrote:
> > We have a number of systems industry-wide that have a subset of their
> > functionality that works as follows:
> > 
> > 1. Receive a message from local kmsg, serial console, or netconsole;
> > 2. Apply a set of rules to classify the message;
> > 3. Do something based on this classification (like scheduling a
> >    remediation for the machine), rinse, and repeat.
> > 
> > This provides a solution to the issue of silently changed or deleted
> > printks: we record pointers to all printk format strings known at
> > compile time into a new .printk_index section, both in vmlinux and
> > modules. At runtime, this can then be iterated by looking at
> > <debugfs>/printk/index/<module>, which emits the following format, both
> > readable by humans and able to be parsed by machines:
> > 
> >     $ head -1 vmlinux; shuf -n 5 vmlinux
> >     # <level[,flags]> filename:line function "format"
> >     <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
> >     <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
> >     <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
> >     <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
> >     <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"
> > 
> > This mitigates the majority of cases where we have a highly-specific
> > printk which we want to match on, as we can now enumerate and check
> > whether the format changed or the printk callsite disappeared entirely
> > in userspace. This allows us to catch changes to printks we monitor
> > earlier and decide what to do about it before it becomes problematic.
> > 
> > There is no additional runtime cost for printk callers or printk itself,
> > and the assembly generated is exactly the same.
> > 
> > Chris Down (5):
> >   string_helpers: Escape double quotes in escape_special
> >   printk: Straighten out log_flags into printk_info_flags
> >   printk: Rework parse_prefix into printk_parse_prefix
> >   printk: Userspace format indexing support
> >   printk: index: Add indexing support to dev_printk
> 
> The patchset looks ready for linux-next from my POV. I could fixup the
> messages as suggested by Andy when pushing.
> 
> Well, I would still like to get acks from:
> 
>    + Andy for the 1st patch
>    + Jessica for the changes in the module loader code in 4th patch.

They provided the Acks, so that we could push it.

Andrew, this patchset depends on seq_file and string_helpers changes
that are in -mm tree:

lib-string_helpers-switch-to-use-bit-macro.patch
lib-string_helpers-move-escape_np-check-inside-else-branch-in-a-loop.patch
lib-string_helpers-drop-indentation-level-in-string_escape_mem.patch
lib-string_helpers-introduce-escape_na-for-escaping-non-ascii.patch
lib-string_helpers-introduce-escape_nap-to-escape-non-ascii-and-non-printable.patch
lib-string_helpers-allow-to-append-additional-characters-to-be-escaped.patch
lib-test-string_helpers-print-flags-in-hexadecimal-format.patch
lib-test-string_helpers-get-rid-of-trailing-comma-in-terminators.patch
lib-test-string_helpers-add-test-cases-for-new-features.patch
maintainers-add-myself-as-designated-reviewer-for-generic-string-library.patch
seq_file-introduce-seq_escape_mem.patch
seq_file-add-seq_escape_str-as-replica-of-string_escape_str.patch
seq_file-convert-seq_escape-to-use-seq_escape_str.patch
nfsd-avoid-non-flexible-api-in-seq_quote_mem.patch
seq_file-drop-unused-_escape_mem_ascii.patch


Would you mind to take this patchset via -mm tree as well, please?

You were not in CC. Should Chris send v8 with all the Acks and
you in CC?

Best Regards,
Petr
