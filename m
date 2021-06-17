Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79FF3AB106
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhFQKMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:12:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36102 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhFQKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:12:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9A94F21AF4;
        Thu, 17 Jun 2021 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623924643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z/Tg1xYBUHCdisRFNoOsIDUWocH7Vjwkw65wtMWykNs=;
        b=MdAgQmG2FQlzMntzs+JY+z9cSccKoS833Mmtp16XSq4G1WDQIqnIom+rDuld9wyF0FhOvD
        AUdG2yIAmb2eDyHFNxw7asy/Yxq8Dky/D1t7oX6+A5YBix78WUsi0DI3wutUgdOgnS7o+q
        StFkhhD6e7zqO+BqGV9L+GLrJR08aho=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7772DA3BB8;
        Thu, 17 Jun 2021 10:10:43 +0000 (UTC)
Date:   Thu, 17 Jun 2021 12:10:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
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
Message-ID: <YMsfo3/b1LvOoiM0@alley>
References: <cover.1623775748.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623775748.git.chris@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-15 17:52:20, Chris Down wrote:
> We have a number of systems industry-wide that have a subset of their
> functionality that works as follows:
> 
> 1. Receive a message from local kmsg, serial console, or netconsole;
> 2. Apply a set of rules to classify the message;
> 3. Do something based on this classification (like scheduling a
>    remediation for the machine), rinse, and repeat.
> 
> This provides a solution to the issue of silently changed or deleted
> printks: we record pointers to all printk format strings known at
> compile time into a new .printk_index section, both in vmlinux and
> modules. At runtime, this can then be iterated by looking at
> <debugfs>/printk/index/<module>, which emits the following format, both
> readable by humans and able to be parsed by machines:
> 
>     $ head -1 vmlinux; shuf -n 5 vmlinux
>     # <level[,flags]> filename:line function "format"
>     <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
>     <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
>     <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
>     <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
>     <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"
> 
> This mitigates the majority of cases where we have a highly-specific
> printk which we want to match on, as we can now enumerate and check
> whether the format changed or the printk callsite disappeared entirely
> in userspace. This allows us to catch changes to printks we monitor
> earlier and decide what to do about it before it becomes problematic.
> 
> There is no additional runtime cost for printk callers or printk itself,
> and the assembly generated is exactly the same.
> 
> Chris Down (5):
>   string_helpers: Escape double quotes in escape_special
>   printk: Straighten out log_flags into printk_info_flags
>   printk: Rework parse_prefix into printk_parse_prefix
>   printk: Userspace format indexing support
>   printk: index: Add indexing support to dev_printk

The patchset looks ready for linux-next from my POV. I could fixup the
messages as suggested by Andy when pushing.

Well, I would still like to get acks from:

   + Andy for the 1st patch
   + Jessica for the changes in the module loader code in 4th patch.

Best Regards,
Petr
