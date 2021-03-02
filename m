Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C1532A82A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245556AbhCBROJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384493AbhCBPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE02C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=goohwlevuJkiPEJ0sTSvtztSg0MP/O0Yn+wj3YqwVhU=; b=NSV1CvnTBbHjdAdg7o0PaNVfFs
        tmNkXfLUYklr+6K915FB6jEhTnjHdm5MPLr2jmcYdW5xnvMfPnQvZ2iQQwLeNcuHrT2Onj+EFb2ef
        X59o9K5iFjZWb8Y1umOsXZ1adD6oQApO9uAlKJSee3WaHX51Gi4x0L44VJS3uk1amoWQFoKoc1LQO
        61Avj2sqj7prZ7cWWOIUzVrriNb+wgAjPUQLWxJ8aSwgGAWW41dSgKvxDerVV5/S2FccBUixh/Ige
        0lQ2XTIiv7w08MEdEebbIRMkX6NCGMba2AeP0zV/1rsnQmXhacDvfJK0LFGZpIHAWWcvxuih73PXc
        bWTT1oXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lH67I-00HH07-Qw; Tue, 02 Mar 2021 14:35:23 +0000
Date:   Tue, 2 Mar 2021 14:35:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Timur Tabi <timur@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
Message-ID: <20210302143516.GY2723601@casper.infradead.org>
References: <20210214161348.369023-1-timur@kernel.org>
 <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
 <YD49x/UGUq6MSE39@alley>
 <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
 <CAMuHMdUB4DZxHo=j1+EsSsoGCdWmDO9mBo0cUtAH4OYHy3sBzw@mail.gmail.com>
 <20210302090811.620ae7d0@gandalf.local.home>
 <YD5LKqtSz5r1Xp7B@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD5LKqtSz5r1Xp7B@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 03:26:50PM +0100, Marco Elver wrote:
> +static const char no_hash_pointers_warning[9][55] __initconst = {
> +	"******************************************************",
> +	"   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   ",
> +	"                                                      ",
> +	" This system shows unhashed kernel memory addresses   ",
> +	" via the console, logs, and other interfaces. This    ",
> +	" might reduce the security of your system.            ",
> +	" If you see this message and you are not debugging    ",
> +	" the kernel, report this immediately to your system   ",
> +	" administrator!                                       ",
> +};
> +
>  static int __init no_hash_pointers_enable(char *str)
>  {
> +	const int lines[] = { 0, 1, 2, 3, 4, 5, 2, 6, 7, 8, 2, 1, 0 };
> +	int i;
> +
>  	no_hash_pointers = true;
>  
> -	pr_warn("**********************************************************\n");
> -	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> -	pr_warn("**                                                      **\n");
> -	pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> -	pr_warn("** via the console, logs, and other interfaces. This    **\n");
> -	pr_warn("** might reduce the security of your system.            **\n");
> -	pr_warn("**                                                      **\n");
> -	pr_warn("** If you see this message and you are not debugging    **\n");
> -	pr_warn("** the kernel, report this immediately to your system   **\n");
> -	pr_warn("** administrator!                                       **\n");
> -	pr_warn("**                                                      **\n");
> -	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> -	pr_warn("**********************************************************\n");
> +	for (i = 0; i < ARRAY_SIZE(lines); i++)
> +		pr_warn("**%s**\n", no_hash_pointers_warning[lines[i]]);

+	for (i = 0; i < 3; i++)
+		pr_warn("**%s**\n", no_hash_pointers_warning[lines[2 - i]]);

