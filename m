Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC49F3AB005
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhFQJp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:45:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47324 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhFQJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:45:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 019F81FDBF;
        Thu, 17 Jun 2021 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623923029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFbML/Oep3LvS/U9xwYfXnNl7AEm54HwbIMYPmjktMU=;
        b=qgex8SLuV2jdeAzWQ3/MICZvm1vE8GxXB5QwJQEVzOhJzsO/ruy4iaUF54L6P4Ek9wGmt2
        k4TkHBGMQUAx3lzT0vHa2LOeV/VNYfF8V1kNH2fZaQl3VVBR83Y+q6S8/5PEH5m/aXAqA8
        yAEiCuSjlRObje6EszPee8xYk0iskH8=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DA120A3BBB;
        Thu, 17 Jun 2021 09:43:48 +0000 (UTC)
Date:   Thu, 17 Jun 2021 11:43:48 +0200
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
Subject: Re: [PATCH v7 4/5] printk: Userspace format indexing support
Message-ID: <YMsZVEr20oMF2LJk@alley>
References: <cover.1623775748.git.chris@chrisdown.name>
 <e42070983637ac5e384f17fbdbe86d19c7b212a5.1623775748.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42070983637ac5e384f17fbdbe86d19c7b212a5.1623775748.git.chris@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-15 17:52:53, Chris Down wrote:
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
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>

This version looks fine to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
