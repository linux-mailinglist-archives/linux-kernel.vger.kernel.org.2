Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216E832A758
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379968AbhCBQIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:08:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:44624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376699AbhCBNij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:38:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 141C2ABF4;
        Tue,  2 Mar 2021 13:37:20 +0000 (UTC)
To:     Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marco Elver <elver@google.com>, Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
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
References: <20210214161348.369023-1-timur@kernel.org>
 <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
 <YD49x/UGUq6MSE39@alley>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
Message-ID: <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
Date:   Tue, 2 Mar 2021 14:37:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YD49x/UGUq6MSE39@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/21 2:29 PM, Petr Mladek wrote:
> On Tue 2021-03-02 13:51:35, Geert Uytterhoeven wrote:
>> > > > +
>> > > > +       pr_warn("**********************************************************\n");
>> > > > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
>> > > > +       pr_warn("**                                                      **\n");
>> > > > +       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
>> > > > +       pr_warn("** via the console, logs, and other interfaces. This    **\n");
>> > > > +       pr_warn("** might reduce the security of your system.            **\n");
>> > > > +       pr_warn("**                                                      **\n");
>> > > > +       pr_warn("** If you see this message and you are not debugging    **\n");
>> > > > +       pr_warn("** the kernel, report this immediately to your system   **\n");
>> > > > +       pr_warn("** administrator!                                       **\n");
>> > > > +       pr_warn("**                                                      **\n");
>> > > > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
>> > > > +       pr_warn("**********************************************************\n");
>> > > > +
>> > > > +       return 0;
>> > > > +}
>> > > > +early_param("no_hash_pointers", no_hash_pointers_enable);
>> > >
>> > > While bloat-o-meter is not smart enough to notice the real size impact,
>> > > this does add more than 500 bytes of string data to the kernel.
>> > > Do we really need such a large message?
>> > > Perhaps the whole no_hash_pointers machinery should be protected by
>> > > "#ifdef CONFIG_DEBUG_KERNEL"?
> 
> This was the deal. The configure option is a no-go, see below and also
> https://lore.kernel.org/r/CAHk-=wgaK4cz=K-JB4p-KPXBV73m9bja2w1W1Lr3iu8+NEPk7A@mail.gmail.com

I think it's a no-go only when enabling such option equals to "no_hash_pointers"
being always passed. What Geert suggests is that you need both
CONFIG_DEBUG_KERNEL *and* no_hash_pointers and that's different.

>> > We recently stumbled across this, and it appears an increasing number
>> > of production kernels enable CONFIG_DEBUG_KERNEL [1], so it likely
>> > isn't the solution (we tried to use CONFIG_DEBUG_KERNEL in similar
>> 
>> I guess the people who do care about kernel size do know to disable
>> CONFIG_DEBUG_KERNEL, so it would help them.
>> The everything-but-the-kitchen-sink distro people don't care about kernel
>> size anyway.
> 
> The problem with the configure option is not about size. The problem is
> that there would be many kernels in the wild with this option enabled.
> People would install them without knowing that they are less secure.

Same as above.

> Distros would need to provide both kernels. Well, they already do.
> But it might be worse. Some distros might even want to enable it
> by default.
> 
> Also many bugs might be debugged without this option. Some bugs
> are hard to reproduce and might be visible only on production
> systems. It should be possible to enable this only when really
> needed and the user must be aware of the risk.

So this is basically a kernel tinyfication issue, right? Is that still pursued
today? Are there better config options suitable for this than CONFIG_DEBUG_KERNEL?

>> > Would placing the strings into an __initconst array help?
>> 
>> That would indeed help to reduce run-time memory consumption.
> 
> Sure. We could do this. Do you want to send a patch, please?
> 
>> It would not solve the raw kernel size increase.
> 
> I see. Well, the compression should be pretty efficient
> for a text (with many spaces).
> 
> Best Regards,
> Petr
> 

