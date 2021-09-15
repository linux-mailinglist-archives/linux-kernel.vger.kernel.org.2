Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489F140C2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhIOJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:29:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47326 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhIOJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:29:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5A13221EC;
        Wed, 15 Sep 2021 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631698106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKnk6K1PQeRI3usztj+elqZdoJBzOLfZdcbOjbB+Uak=;
        b=h1W6aOujV4DecO4MFGTmcp/kiPOykON2cIN1Bqgs9oiNkbUQoPm9SYDoxgMAwCOAzD7RrY
        Mgj4ESq2Civ+4v9o1Z/0idDF4VhfV+LCWLNb2z6HvhlAoyMkdAQyRV1a7VMJCAfVMaCB3T
        SOjwPZ5mMwqEPVj1OCNiTlANS0CqshA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631698106;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKnk6K1PQeRI3usztj+elqZdoJBzOLfZdcbOjbB+Uak=;
        b=aLbDAyUUnVFj9UYzZrryquEdbZiFc3h3kvIXyu1823l0E5f1EfRfw6P9RLjhvDPUkZt23W
        iIu1ZsAZnjO9qNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD9EB13AD4;
        Wed, 15 Sep 2021 09:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QkVgLbq8QWEuVwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Sep 2021 09:28:26 +0000
Message-ID: <8a32b437-4cea-f265-b26e-509466d5290b@suse.cz>
Date:   Wed, 15 Sep 2021 11:28:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210914105620.677b90e5@oasis.local.home>
 <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
 <20210914145953.189f15dc@oasis.local.home>
 <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
 <CAHk-=wg5tJ_+sKKnkzc6nxpfEvvbUG2Yg3zF-vVfUfZD=PFy7Q@mail.gmail.com>
 <CAHk-=whBd5Sgg4if7HB4o0Zrj3eNprKv9U02uEUB1QhQvrsQZw@mail.gmail.com>
 <CAHk-=wipBkq-OeUBsgv-_hvTfg=nveTpiZonWeY1dBMofkjEuw@mail.gmail.com>
 <20210914170553.7c1e1faa@oasis.local.home>
 <4392e867-0cce-d04a-e3d1-cba152daaa1f@suse.cz>
 <CAHk-=wimTmUcYC_BPvwv-48OFwpzJhzrX-_9afk--ND6en81Xg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=wimTmUcYC_BPvwv-48OFwpzJhzrX-_9afk--ND6en81Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 01:29, Linus Torvalds wrote:
> On Tue, Sep 14, 2021 at 3:48 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> Well, looks like I can't. Commit 77e02cf57b6cf does boot fine for me,
>> multiple times. But so now does the parent commit 6a4746ba06191. Looks like
>> the magic is gone. I'm now surprised how deterministic it was during the
>> bisect (most bad cases manifested on first boot, only few at second).
> 
> Well, your report was clearly memory corruption by the invalid
> memblock_free() just ending up causing random problems later on.

> So it could easily be 100% deterministic with a certain memory layout
> at a particular commit. And then enough other changes later, and it's
> all gone, because the memory corruption now hits something else that
> didn't even care.
> 
> The code for your oops was
> 
>    0: 48 8b 17              mov    (%rdi),%rdx
>    3: 48 39 d7              cmp    %rdx,%rdi
>    6: 74 43                je     0x4b
>    8: 48 8b 47 08          mov    0x8(%rdi),%rax
>    c: 48 85 c0              test   %rax,%rax
>    f: 74 23                je     0x34
>   11: 49 89 c0              mov    %rax,%r8
>   14:* 48 8b 40 10          mov    0x10(%rax),%rax <-- trapping instruction
> 
> and that's the start of rb_next(), so what's going on is that
> "rb->rb_right" (the second word of 'struct rb_node') ends up having
> that value in %rax:
> 
>   RAX: 343479726f6d656d
> 
> which is ASCII "44yromem" rather than a valid pointer if I looked that up right.

Yep, I was pretty sure it was related to the
"/sys/bus/memory/devices/memory44" sysfs object and bisection would lead to
kobject/sysfs or some memory hotplug related changes. So the result was a
surprise.

> And just _slightly_ different allocation patterns, and your 'struct
> rb_node' gets allocated somewhere else, and you don't see the oops at
> all, or you get it later in some different place.
> 
> Most memory corruption doesn't cause oopses, because most memory isn't
> used as pointers etc.
> 
> What you _could_ try if you care enough is
> 
>  - go back to the thing you bisectted to where you can still hopefully
> recreate the problem
> 
>  - apply that patch at that point with no other changes
> 
> and then the test would hopefully be closer to the state you could
> re-create the problem.
> 
> And hopefully it would still not reproduce, just because the bug is
> fixed, of course ;)

Yeah, that worked! Commit 40caa127f3c7 was still broken, and cherry-pick of
77e02cf57b6cf on top fixed it. Thanks!

> The very unlikely alternative is that your bisect was just pure random
> bad luck and hit the wrong commit entirely, and the oops was due to
> some other problem.
> 
> But it does seem unlikely to be something else. Usually when bisects
> go off into the weeds due to not being reproducible, they go very
> obviously off into the weeds rather than point to something that ends
> up having a very similar bug.
> 
>            Linus
> 

