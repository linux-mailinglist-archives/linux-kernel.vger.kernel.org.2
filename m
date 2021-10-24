Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905B6438866
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 12:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhJXLBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 07:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhJXLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 07:01:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAACC061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 03:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1WmP+gAtrr+hBBZNGYOjzFyf/MsLtOyQb5e86llFOPw=; b=qpiNEPZK0nPCwvG+gkVrid1KMS
        cXMyo7kHfyZeHmK/GOTseHSf4JMoNOk3b/t+C17+nPiAXkd6gs8/hzsfXgIbCuGx16XW5sJbVyYlK
        3w1GJ88fADaXAuCn+Qb+43/MXXLnJVZUjTQijaI9NIdqAD0e9Gz8Igqxtq4ZycsoTPhuShwb2Mr6N
        QjLuDxxBNTL4p606LF66T1qe4BKpyWc9Jx2kVDgA8pfvS2FQyZFMbgBqjMLM4/JVLmY+4lwANQkYj
        +FAWMic8OHMNSsceGXZqkGnJwc0OxUGZA4l4qE5X7PIKBHAiW+6gwWgG7Z8+rzs5icU4KzFBbep+W
        9ZZgagXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mebBW-00FIDk-Uq; Sun, 24 Oct 2021 10:57:24 +0000
Date:   Sun, 24 Oct 2021 11:57:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>,
        Jordy Zomer <jordy@pwning.systems>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
Message-ID: <YXU7/iRjf9v77gon@casper.infradead.org>
References: <00000000000062d0fc05cef24c57@google.com>
 <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com>
 <YXQp4MsT0EEKqMl/@kernel.org>
 <088FF23B-CD8E-4E53-B702-53E2C2382062@chromium.org>
 <YXSQuiahbU7YyYrk@casper.infradead.org>
 <YXTxN5skPPFPvScP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXTxN5skPPFPvScP@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 08:37:59AM +0300, Mike Rapoport wrote:
> On Sat, Oct 23, 2021 at 11:46:18PM +0100, Matthew Wilcox wrote:
> > On Sat, Oct 23, 2021 at 10:03:11AM -0700, Kees Cook wrote:
> > > On October 23, 2021 8:27:28 AM PDT, Mike Rapoport <rppt@kernel.org> wrote:
> > > >and my first reaction was to send a revert the untested commit 110860541f44
> > > >("mm/secretmem: use refcount_t instead of atomic_t"). 
> > 
> > I think you should.  This isn't a real problem. 
> 
> Do you mean that creation of 4 billion of file descriptors is not feasible?

On a sufficiently large machine, it is.  But then we have the same
problem with other atomic_t.  If you really care, just check whether
secretmem_users has gone negative, and return -ENFILE.  It doesn't
even have to be all that exact; you've got 2 billion values of slop
to use before you hit the wrap from negative to 0 which is the actual
problem.

ie this:

+++ b/mm/secretmem.c
@@ -203,6 +203,8 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)

        if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
                return -EINVAL;
+       if (atomic_read(&secretmem_users) < 0)
+               return -ENFILE;

        fd = get_unused_fd_flags(flags & O_CLOEXEC);
        if (fd < 0)


Also, why does secretmem depend on !EMBEDDED?

config EMBEDDED
        bool "Embedded system"
        select EXPERT
        help
          This option should be enabled if compiling the kernel for
          an embedded system so certain expert options are available
          for configuration.

This is the only Kconfig option that depends on !EMBEDDED.  It's usually
used to avoid showing questions.  It means that my allmodconfig build
*doesn't* build secretmem, which is surely not what you wanted.

+++ b/mm/Kconfig
@@ -892,7 +892,7 @@ config IO_MAPPING
        bool

 config SECRETMEM
-       def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
+       def_bool ARCH_HAS_SET_DIRECT_MAP

 source "mm/damon/Kconfig"


