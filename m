Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD932BCFA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbhCCPMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:12:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:54078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241090AbhCCK0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:26:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614767159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=62KK1EtrPwDpveUviuINUmjHcRrckD3Hrdf208FRBvY=;
        b=NpZLN3MbUIPglvtn76MoeqxABY4sIVponKFYMpU/RMBDzXGNDYLccQP9CFwhpmcBJ89XOq
        KvpSufVHkZNN9Pz9Mqhi/pWxhQcVdDurgnHvg/EU3guj1mopTFoDy2mQmMZeJFW41deuYY
        BX/DB2mg7p7e58bJINgTUW4V3+4aSnU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8308FAC54;
        Wed,  3 Mar 2021 10:25:59 +0000 (UTC)
Date:   Wed, 3 Mar 2021 11:25:58 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
Message-ID: <YD9kNphaSRPk83KJ@alley>
References: <20210301174749.1269154-1-swboyd@chromium.org>
 <20210301174749.1269154-6-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301174749.1269154-6-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-03-01 09:47:47, Stephen Boyd wrote:
> The %pS printk format (among some others) is used to print kernel
> addresses symbolically. When the kernel prints an address inside of a
> module, the kernel prints the addresses' symbol name along with the
> module's name that contains the address. Let's make kernel stacktraces
> easier to identify on KALLSYMS builds by including the build ID of a
> module when we print the address.
> 
> This is especially helpful for crash debugging with pstore or crashdump
> kernels. If we have the build ID for the module in the stacktrace we can
> request the debug symbols for the module from a remote debuginfod server

I have read the thread so for. IMHO, all mentioned variants complicate
the logs a lot. Either the backtrace lines are hard to parse.
Or the OOps/panic blocks gets too long when the ID is mentioned
for every loaded module. IMHO, neither proposed solution
is acceptable to be always used.

First, I think that only I some developers would actually use
this information. Many of them either know what module was
used or they do not have an easy way to get the debugging
information by the ID. So, it should be configurable
at minimum.

Second, I am not sure that it should be part of each OOps/panic blob.
One solution would be to print the ID by the module loader when
the module gets loaded. It would be mentioned earlier in the log
then.

Or we could make it available, for example, via /proc. It is a kind
of information that might be gathered later on a rebooted system.
SUSE has "supportconfig" command that allows to gather a lot
of similar information about the system. We use it when
analyzing crashdumps and kernel bugs in general.

Anyway, I consider this a very detailed information that is not
suitable for everyone. It should be availabe on request, like
for example, backtraces from all CPUs, list of tasks, memory info.

Alternative solution would be to minimize the information, for
example, by printing only the modules that appear in the backtrace.
But this might be complicated to implement.

Best Regards,
Petr
