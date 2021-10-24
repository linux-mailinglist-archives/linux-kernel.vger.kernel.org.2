Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58236438BC0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhJXUOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 16:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJXUOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 16:14:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89441C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RJQdurXKvs7hMco6+dlt3T0Xdny16zyR0j2g0ugIG4Y=; b=e5WOt05knlgal0p+feSq0qQGcW
        qtAr3FD+few2Cp/Yd7t4osiw/nBrGJINOze+1DS7ZZNfDPeJNob7Pffcxxz73BE8zI+Dht+8cVn4k
        phPTKwiAoSzrJAa44K0Hu4Ti1GOXi1zuzMo3i1fLdKqbQD4YSin2vfdxaXoTpZEEozMFdX9oO4myR
        jBUi9DEH706FecX/Uy1LWxg12BrMbtHPOQHfp0ULW4IcFso0gtKvtWzW7JloGDK29bIh98lEL8hsD
        vP7/Yfl+iMaKFW6pBMXgJarff+iiuXP1mclulzMwbOEq1LU8EUlP+MO2zNZHf7zPLoPt5/ZzcyV78
        7VKD51dQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mejod-00Fb82-0b; Sun, 24 Oct 2021 20:10:18 +0000
Date:   Sun, 24 Oct 2021 21:09:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+75639e6a0331cd61d3e2@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        jordy@jordyzomer.github.io, jordy@pwning.systems,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] WARNING: refcount bug in memfd_secret
Message-ID: <YXW9lmQVx1PLX9aj@casper.infradead.org>
References: <00000000000064451505cf0a3aa2@google.com>
 <CAHk-=wj=jthBt0XOjqstiYYROGhJAM0xrsWBVQgGMk79JBaKDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj=jthBt0XOjqstiYYROGhJAM0xrsWBVQgGMk79JBaKDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 09:54:22AM -1000, Linus Torvalds wrote:
> On Sat, Oct 23, 2021 at 9:35 AM syzbot
> <syzbot+75639e6a0331cd61d3e2@syzkaller.appspotmail.com> wrote:
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=115a0328b00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=59f3ef2b4077575
> > dashboard link: https://syzkaller.appspot.com/bug?extid=75639e6a0331cd61d3e2
> > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a035c2b00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ae869f300000
> >
> > The issue was bisected to:
> >
> > commit 110860541f443f950c1274f217a1a3e298670a33
> 
> I think that commit is actually just buggy.
> 
> "secretmem_users" is not actually a reference count. There's no "magic
> happens when it goes down to zero".
> 
> It's purely a count of the number of existing users, and incrementing
> it from zero is not a probolem at all - it is in fact expected.
> 
> Sure, zero means "we can hibernate", so zero and overflow are somewhat
> special, but not special enough to cause these kinds of issues.
> 
> I have reverted this commit in my tree, because honestly, the whole
> "try to overflow exactly, and hibernate" threat model just isn't worth
> this all.
> 
> If people really care, I can suggest
> 
>  - use "atomic_long_t" instead. Let's face it, 32-bit isn't
> interesting any more, and 64-bit doesn't overflow.
> 
>  - make up some new "atomic_inc_nooverflow()" thing or whatever.
> 
> but for now this is just reverted.

There was a separate thread on an earlier version of this report.
https://lore.kernel.org/linux-mm/YXU7%2FiRjf9v77gon@casper.infradead.org/
I agree with you and suggested that if anybody really cares (I mean,
you need a multi-TB machine to produce this problem) that we simply do
what we did with the page refcount:

+++ b/mm/secretmem.c
@@ -203,6 +203,8 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)

        if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
                return -EINVAL;
+       if (atomic_read(&secretmem_users) < 0)
+               return -ENFILE;

        fd = get_unused_fd_flags(flags & O_CLOEXEC);
        if (fd < 0)

Mike didn't particularly like that answer though.
