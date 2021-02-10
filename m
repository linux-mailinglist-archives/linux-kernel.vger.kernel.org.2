Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4716B316CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhBJR2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:28:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhBJR2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:28:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70FA764E77;
        Wed, 10 Feb 2021 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612978070;
        bh=idCIC6KkKWnS8zqMzwGmRPIjOPqsJEjt8EXLdQqg03Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K43DgBzYwjHUq+RQv45uKHMAkGBTS9sQqMOudLcBbIwAx/+0/1aaS1vFpIA4G3Czq
         qhRx8ZNNITd7QlL6Yh7Ylkm9/tb6FqBaF7udNOpA9BGDCn+sOwl/RR8rAazwEXwR4g
         l12UehSBtx6m8I5SRVu01ofvVeS8WEKT/6MizuCZWQsZnDKjFsHKak4ieKOggb5gx2
         a7A+08GPdL6OFPc7UKhh6gDIeyrlg+s5lJwZjENqK14oc9RgSlzLztwOjm1tbNfT3C
         NOaSogVRTiz4W6IYvEIDQWf0Qs8gQ/iyzbf6SunsQxHQx6oqK9tTuCEsifVd3qBdqn
         zXj5iBtf/4DAA==
Subject: Re: [PATCH 3/3] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
To:     Petr Mladek <pmladek@suse.com>
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
References: <20210210051814.845713-1-timur@kernel.org>
 <20210210051814.845713-4-timur@kernel.org> <YCPily3XZY4Cw6tU@alley>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <ca1371e2-8df3-3e28-b5d6-b4bc0fbe6b70@kernel.org>
Date:   Wed, 10 Feb 2021 11:27:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCPily3XZY4Cw6tU@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/21 7:41 AM, Petr Mladek wrote:
> 
> The option causes that vsprintf() will not hash pointers. Yes, it is
> primary used by printk(). But it is used also in some other
> interfaces, especially trace_printk(), seq_buf() API. The naked
> pointers might appear more or less anywhere, including procfs,
> sysfs, debugfs.

Fair point.  Shouldn't calls to seq_buf_printf() (and any printk usage 
that always exists in the context of a user-space process) use %pK anyway?

Hmmm.... maybe vsprintf() should automatically replace %p with %pK if it 
detects a user-space context?

> IMHO, we should fix this. The long discussion was about how to make
> this option safe. Users should be aware that it is not only about
> the kernel log.

Agreed.

> I suggest to rename the parameter "debug_never_hash_pointer" and use
> the same name for the parameter and the variable.

Will do.

> We also should make the warning more generic. I suggest to replace the
> first paragraph with something like:
> 
> 	pr_warn("** The hashing of printed pointers has been disabled   **\n");
> 	pr_warn("** for debugging purposes.                             **\n");
> 
> Feel free to use a better wording. I am not a native speaker.

You could have fooled me.

> Of course, also kernel-parameters.txt has to be updated accordingly.

Ok.
