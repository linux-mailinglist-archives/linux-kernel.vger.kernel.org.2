Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E15410039
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244366AbhIQULm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233730AbhIQULe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:11:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0E1D60F92;
        Fri, 17 Sep 2021 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631909411;
        bh=4CV71PX5L1bAnolYAfoAUtbpOQPUt68lFyDFbREQEmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Issk0ybUjlf7y1iOIPDxsvLfWYtqR9GRdqpBO1JE/xGyy8SnVm+UHn4IiXb4fVvpL
         y0+jXlqMtE2A9janN+d4cBD+QrOEApyHywDG75/OAW/7BcNXIC77cqaDR7IpqWmdy4
         AmgBS6D0HY90knefZJ16ClvIko8NbY3uUgCzDT5OxP7AsmM35nYlWnDAbiYl5YnFU2
         /0eLyURolKCAVteNR4+NDurkPWgcLRdkFlOz3ybNV5/Qir9J5O5f+dC9dGZk7tlLNt
         0m1+2VOn02yo6HHpz01uwXu9ET2SSYLrJV6bttem1LuhIVM1HwxMQ95Gxg3DIAgg9Q
         rgi9yyP6EoYMQ==
Date:   Fri, 17 Sep 2021 23:10:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
Message-ID: <YUT2Hjr0DDA6wnGd@kernel.org>
References: <20210914105620.677b90e5@oasis.local.home>
 <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:01:31AM -0700, Linus Torvalds wrote:
> On Tue, Sep 14, 2021 at 7:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > A couple of memory management fixes to the bootconfig code
> 
> These may be fixes, but they are too ugly to merit the tiny
> theoretical leak fix.
> 
> All of these are just plain wrong:
> 
> > +static void *init_xbc_data_copy __initdata;
> > +static phys_addr_t init_xbc_data_size __initdata;
> > +               init_xbc_data_copy = copy;
> > +               init_xbc_data_size = size + 1;
> > +       memblock_free(__pa(init_xbc_data_copy), init_xbc_data_size);
> 
> because the xbc code already saves these as xbc_data/xbc_data_size and
> that final free should just be done in xbc_destroy_all().
> 
> So this fix is pointlessly ugly to begin with.
> 
> But what I _really_ ended up reacting to was that
> 
> > +               memblock_free(__pa(copy), size + 1);
> 
> where that "copy" was allocated with
> 
>         copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
> 
> so it should damn well be free'd without any crazy "__pa()" games.
> 
> This is a memblock interface bug, plain and simple.
> 
> Mike - this craziness needs to just be fixed. If memblock_alloc()
> returns a virtual address, then memblock_free() should take one.

Yep, it was on my todo list. But since it was like this for years with both
memblock and bootmem I didn't prioritise this.
 
> Let's just get these interfaces fixed. It might be as simple as having
> a "memblock_free_phys()" interface, and doing a search-and-replace
> with coccinelle of
> 
>      memblock_free(__pa(xyz), .. -> memblock_free(xyz, ...
>      memblock_free(other, .. -> memblock_free_phys(other, ..
> 
> and adding the (trivial) internal helper functions to memblock,
> instead of making the atcual _users_ of memblock do insanely stupid
> and confusing things.

I've done the automated search and replace, with several fixups here and
there, so there is now memblock_phys_free(phys_addr_t addr) to match
memblock_phys_alloc() and memblock_free(void *ptr) to match
memblock_alloc().

The initial version is in memblock tree

https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git/log/?h=memblock_free-cleanup/v0

I'm waiting for robots to run the builds before posting.

While doing the replacement I've found one mismatch in Xen code which used
memblock_free() to free a virtual pointer, but except that users seem to do
the correct thing, even if it is ugly __pa() conversions.

-- 
Sincerely yours,
Mike.
