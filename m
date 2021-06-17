Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E53AB0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhFQKEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:04:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35576 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFQKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:04:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 22B0E21AF5;
        Thu, 17 Jun 2021 10:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623924152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ojBtLjKaTiNoUvukSQBDvFG3kZgKSaHUvdZcj5mHzg8=;
        b=uzBXPGkpANMx7FCZGcH7yhpcFgcg19TErgQRmmrML3CURvcDsTbAOR3bxVeQ1k1qL3Gppo
        jVfGwJ3RKBxyi6EgIEIGYXp5VmqAjudMPZY2P5fto7CP78X1lMiz4UyXudURkPqpV+Gqt2
        rh7RnykaYPDPGSysIyEHMdjCiapjD58=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DD0EEA3BB7;
        Thu, 17 Jun 2021 10:02:31 +0000 (UTC)
Date:   Thu, 17 Jun 2021 12:02:31 +0200
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
Subject: Re: [PATCH v7 5/5] printk: index: Add indexing support to dev_printk
Message-ID: <YMsdtyJxuSzcfD3H@alley>
References: <cover.1623775748.git.chris@chrisdown.name>
 <959c7aed1017cb2c9de922e0a820d397e29c6a5a.1623775748.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <959c7aed1017cb2c9de922e0a820d397e29c6a5a.1623775748.git.chris@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-15 17:52:56, Chris Down wrote:
> While for most kinds of issues we have counters, tracepoints, or metrics
> with a stable interface which can reliably be used to indicate issues,
> in order to react to production issues quickly we sometimes need to work
> with the interface which most kernel developers naturally use when
> developing: printk, and printk-esques like dev_printk.
> 
> dev_printk is by far the most likely custom subsystem printk to benefit
> from the printk indexing infrastructure, since niche device issues
> brought about by production changes, firmware upgrades, and the like are
> one of the most common things that we need printk infrastructure's
> assistance to monitor.
> 
> Often these errors were never expected to practically manifest in
> reality, and exhibit in code without extensive (or any) metrics present.
> As such, there are typically very few options for issue detection
> available to those with large fleets at the time the incident happens,
> and we thus benefit strongly from monitoring netconsole in these
> instances.
> 
> As such, add the infrastructure for dev_printk to be indexed in the
> printk index. Even on a minimal kernel config, the coverage of the base
> kernel's printk index is significantly improved:
> 
> Before:
> 
>     [root@ktst ~]# wc -l /sys/kernel/debug/printk/index/vmlinux
>     4497 /sys/kernel/debug/printk/index/vmlinux
> 
> After:
> 
>     [root@ktst ~]# wc -l /sys/kernel/debug/printk/index/vmlinux
>     5573 /sys/kernel/debug/printk/index/vmlinux
> 
> In terms of implementation, in order to trivially disambiguate them,
> dev_printk is now a macro which wraps _dev_printk.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
