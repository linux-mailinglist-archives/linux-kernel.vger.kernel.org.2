Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75559316B05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhBJQTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232273AbhBJQTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:19:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A479164E05;
        Wed, 10 Feb 2021 16:18:37 +0000 (UTC)
Date:   Wed, 10 Feb 2021 11:18:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [PATCH 0/3][RESEND] add support for never printing hashed
 addresses
Message-ID: <20210210111836.2468f10a@gandalf.local.home>
In-Reply-To: <6da0be5a-7cb0-4943-e61f-7c3275e60cb6@i-love.sakura.ne.jp>
References: <20210210051814.845713-1-timur@kernel.org>
        <6da0be5a-7cb0-4943-e61f-7c3275e60cb6@i-love.sakura.ne.jp>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 00:46:15 +0900
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> Oh, I was wishing
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b53c73580c5..34c7e145ac3c 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -802,7 +802,7 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
>  	 * Print the real pointer value for NULL and error pointers,
>  	 * as they are not actual addresses.
>  	 */
> -	if (IS_ERR_OR_NULL(ptr))
> +	if (IS_ERR_OR_NULL(ptr) || IS_ENABLED(CONFIG_DEBUG_DONT_HASH_POINTERS))
>  		return pointer_string(buf, end, ptr, spec);
>  
>  	/* When debugging early boot use non-cryptographically secure hash. */
> 
> change as a kernel config option, for more we try to switch using kernel command line options,
> more we likely make errors with sharing appropriate kernel command line options
> (e.g. https://github.com/google/syzkaller/commit/99c64d5c672700d6c0de63d11db25a0678e47a75 ).

The entire point of this exercise is not to make it easy to add this
feature. Linus was absolutely against a config option, and I am too.

The point of this exercise is to be able to debug the *same* kernel that
someone is having issues with. And this is to facilitate that debugging.
Whereas the example you show, the command line modifies how the kernel
works. This command line only modifies what the kernel displays. Big
difference.

-- Steve
