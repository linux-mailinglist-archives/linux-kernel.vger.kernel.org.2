Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFDD316BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhBJQ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:58:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232315AbhBJQ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:58:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9185264DF6;
        Wed, 10 Feb 2021 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612976240;
        bh=SmlTPkoQPYtqVBpQwnlQoRLZYtYp2qGxncjY48CBIHk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i3/7z1DNhGZIs3g2MS165pNH1D0ND9R4ZRN91flOgCa9G2Zh9PqueIqPoC3K5GKMo
         dp8dj3e0FA5HIWY3clDHWRsouMFh7MobaLmZwFi3CIHjWEvRPMW24tHgIBA8QkIHvk
         bimFwoTbkh9SMF/dgRIshSUdJp88MSlIEIBKhGa7TjvApbw0hU8U/O3aksZ8cFLUY8
         XxgeKMchn2/0n27sFhS+jQF//0AvV+LVoSbWOMeziZRlRPctTkZj9Y1PldQifO7h8H
         +dUW8ruQV0fUaXyvIiMKwFMdQtaf/h7stuH9L/kb/7w6b8aHLh7BwSFBhvO/h1Vy4r
         TWw3QDpdYxAjw==
Subject: Re: [PATCH 0/3][RESEND] add support for never printing hashed
 addresses
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20210210051814.845713-1-timur@kernel.org>
 <CAHp75Vfai3cdBmxqE1mW27xj=+E2aWRoVfN-6mXw0miMAe-Exg@mail.gmail.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <56d3df88-4a9e-389a-7ec4-64022f67e303@kernel.org>
Date:   Wed, 10 Feb 2021 10:57:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfai3cdBmxqE1mW27xj=+E2aWRoVfN-6mXw0miMAe-Exg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/21 5:47 AM, Andy Shevchenko wrote:
> It's a bit hard in some mailers (like Gmail) to see the different
> versions of your patches.
> Can you use in the future
>   - either `git format-patch -v<N> ...`, where <N> is a version
>   - or `git format-patch --subject-prefix="PATCH vX / RESEND / etc" ...`
> ?

Yes, of course.  Sorry about that.  Like I said earlier, I really 
shouldn't be posting patches late at night, when I will just forget 
important details.
