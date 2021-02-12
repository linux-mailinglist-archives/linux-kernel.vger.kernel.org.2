Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D328319DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhBLLyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:54:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:39810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhBLLwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:52:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613130722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y/PuJ4QsOK7MgaeHvEagRzBSM3sKp/kTBUCgRC9w1bg=;
        b=gF0pnQ+comDa2B0B2jDLYmlq32hIiXju0e3yoB4Xrf+cq0UrgAqe0kaLTRl5rvDfTm9t+o
        EoSjDH15+fGRm/gUtp8x9USIwMLaWicR5nEJ9G8Ka+/zl7AxSH7AJ3HwRLrOUDmfjQVPlg
        UlcdCO4eU4kTaGAQiKhEZrSM27Dfz+Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37EC8B814;
        Fri, 12 Feb 2021 11:52:02 +0000 (UTC)
Date:   Fri, 12 Feb 2021 12:52:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <YCZr4WrcwfWxVVad@alley>
References: <20210210051814.845713-1-timur@kernel.org>
 <20210210051814.845713-4-timur@kernel.org>
 <YCPily3XZY4Cw6tU@alley>
 <ca1371e2-8df3-3e28-b5d6-b4bc0fbe6b70@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1371e2-8df3-3e28-b5d6-b4bc0fbe6b70@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have realized that I did not comment the two ideas.

On Wed 2021-02-10 11:27:45, Timur Tabi wrote:
> 
> 
> On 2/10/21 7:41 AM, Petr Mladek wrote:
> > 
> > The option causes that vsprintf() will not hash pointers. Yes, it is
> > primary used by printk(). But it is used also in some other
> > interfaces, especially trace_printk(), seq_buf() API. The naked
> > pointers might appear more or less anywhere, including procfs,
> > sysfs, debugfs.
>
> Fair point.  Shouldn't calls to seq_buf_printf() (and any printk usage that
> always exists in the context of a user-space process) use %pK anyway?

seq_buf is a handy API that might be used for different purpose.
For example, it seems to be used ftrace where people might want
to see real pointers when debugging.

> Hmmm.... maybe vsprintf() should automatically replace %p with %pK if it
> detects a user-space context?

I am not sure if there is an easy and reliable way how to detect the
user-space context. On some architectures, it might be possible to
guess it by the address of the buffer. But it will not work when
the message is temporary printed into a local buffer and copied
later.

Let's keep it simple. Heuristics often become very complex over time.

Best Regards,
Petr
