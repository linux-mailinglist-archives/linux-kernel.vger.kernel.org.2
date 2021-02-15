Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851B831B7CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 12:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhBOLJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 06:09:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:35418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230105AbhBOLJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:09:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613387303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7S1C0XYOSzC3LOFJ6RX1sKG5EzBtcUeAISRqXvqSfvo=;
        b=hoYQZLajtmvxvSJJ67GICSgu26cQWaoKkg52dtrEVHlHbdZ5aKUda12Zwn/e3mw1q6Kfgj
        iuS4q1CH0ghna27ESu8tMSLn9zxnLP8/0VMW6a2pgAXbzDpxgOo6agWJLyPVakUoAwRFjm
        E+fXdZAtXunCkW0u5WGdfmsWpTKAiE0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43C3AAE6D;
        Mon, 15 Feb 2021 11:08:23 +0000 (UTC)
Date:   Mon, 15 Feb 2021 12:08:21 +0100
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
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3][v4] add support for never printing hashed addresses
Message-ID: <YCpWJWkssy7xkgV0@alley>
References: <20210214161348.369023-1-timur@kernel.org>
 <2e7bd5a2-2def-e615-2b46-9d167bcf3439@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e7bd5a2-2def-e615-2b46-9d167bcf3439@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-02-14 10:18:39, Timur Tabi wrote:
> On 2/14/21 10:13 AM, Timur Tabi wrote:
> > Although hashing addresses printed via printk does make the
> > kernel more secure, it interferes with debugging, especially
> > with some functions like print_hex_dump() which always uses
> > hashed addresses.
> 
> I believe that this version addresses all outstanding issues, so unless
> there are any complaints, I would like for this patch set to be merged for
> 5.12-rc1.  I don't know who should pick it up, though.

I have pushed the patchset into printk/linux.git,
branch for-5.12-no_hash_pointers.

I am going to send the pull request on Thursday. Anyone still could
comment and even stop it until them. I just wanted to give it at
least few days in linux-next.

Best Regards,
Petr
