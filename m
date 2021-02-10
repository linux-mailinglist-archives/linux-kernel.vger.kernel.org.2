Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23F9316A77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhBJPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:47:14 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:51685 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhBJPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:47:08 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11AFkPLq074787;
        Thu, 11 Feb 2021 00:46:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Thu, 11 Feb 2021 00:46:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11AFkKCH074770
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Feb 2021 00:46:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/3][RESEND] add support for never printing hashed
 addresses
To:     Timur Tabi <timur@kernel.org>
References: <20210210051814.845713-1-timur@kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <6da0be5a-7cb0-4943-e61f-7c3275e60cb6@i-love.sakura.ne.jp>
Date:   Thu, 11 Feb 2021 00:46:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210051814.845713-1-timur@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/02/10 14:18, Timur Tabi wrote:
> [accidentally sent from the wrong email address, so resending]
> 
> [The list of email addresses on CC: is getting quite lengthy,
> so I hope I've included everyone.]
> 
> Although hashing addresses printed via printk does make the
> kernel more secure, it interferes with debugging, especially
> with some functions like print_hex_dump() which always uses
> hashed addresses.

Oh, I was wishing

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b53c73580c5..34c7e145ac3c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -802,7 +802,7 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 	 * Print the real pointer value for NULL and error pointers,
 	 * as they are not actual addresses.
 	 */
-	if (IS_ERR_OR_NULL(ptr))
+	if (IS_ERR_OR_NULL(ptr) || IS_ENABLED(CONFIG_DEBUG_DONT_HASH_POINTERS))
 		return pointer_string(buf, end, ptr, spec);
 
 	/* When debugging early boot use non-cryptographically secure hash. */

change as a kernel config option, for more we try to switch using kernel command line options,
more we likely make errors with sharing appropriate kernel command line options
(e.g. https://github.com/google/syzkaller/commit/99c64d5c672700d6c0de63d11db25a0678e47a75 ).
