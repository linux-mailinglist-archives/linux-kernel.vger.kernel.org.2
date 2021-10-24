Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC864389D4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhJXPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 11:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhJXPeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:34:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E10C60F21;
        Sun, 24 Oct 2021 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635089499;
        bh=rCLmnOPDWbzvIdvUEGs6ZnW1xYqd22FSEv9wsc2itJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cBcEA4Iom2lpL3bff2odUoc04Gx3+KHo8bEori5CKeAvCvO57hUPcrNB6H2IJTIpt
         FNYjgmtCfzRmho3pY1LhiPPBdLhoQqO/nydyFll32daFOxQLL3FCOLTNFJWyjFApxD
         zwvaSb2zteXOECzgXA4Ey/o1W/xhTcmznu4Oj6WTLQzOJ+hNuLafG0sEMd3Du3MupE
         G2WIDLDXlYSEl9cZc0fikIt1mOXWgoNpuma9OCjGUiGT9PWN+eepBS9+F63FO6bqtO
         CXl4XHxNc5IVT/p+HsmPnzuozoA+fJT90uSZBW+oFOkDQk11o7S3tArIdiGC2GimBZ
         OarueG4wDVPSw==
Date:   Sun, 24 Oct 2021 18:31:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>,
        Jordy Zomer <jordy@pwning.systems>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
Message-ID: <YXV8Uq17fjBVvQNn@kernel.org>
References: <00000000000062d0fc05cef24c57@google.com>
 <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com>
 <YXQp4MsT0EEKqMl/@kernel.org>
 <088FF23B-CD8E-4E53-B702-53E2C2382062@chromium.org>
 <YXSQuiahbU7YyYrk@casper.infradead.org>
 <YXTxN5skPPFPvScP@kernel.org>
 <YXU7/iRjf9v77gon@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXU7/iRjf9v77gon@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 11:57:02AM +0100, Matthew Wilcox wrote:
> On Sun, Oct 24, 2021 at 08:37:59AM +0300, Mike Rapoport wrote:
> > On Sat, Oct 23, 2021 at 11:46:18PM +0100, Matthew Wilcox wrote:
> > > On Sat, Oct 23, 2021 at 10:03:11AM -0700, Kees Cook wrote:
> > > > On October 23, 2021 8:27:28 AM PDT, Mike Rapoport <rppt@kernel.org> wrote:
> > > > >and my first reaction was to send a revert the untested commit 110860541f44
> > > > >("mm/secretmem: use refcount_t instead of atomic_t"). 
> > > 
> > > I think you should.  This isn't a real problem. 
> > 
> > Do you mean that creation of 4 billion of file descriptors is not feasible?
> 
> On a sufficiently large machine, it is.  But then we have the same
> problem with other atomic_t.  If you really care, just check whether
> secretmem_users has gone negative, and return -ENFILE.  It doesn't
> even have to be all that exact; you've got 2 billion values of slop
> to use before you hit the wrap from negative to 0 which is the actual
> problem.
> 
> ie this:
> 
> +++ b/mm/secretmem.c
> @@ -203,6 +203,8 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
> 
>         if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
>                 return -EINVAL;
> +       if (atomic_read(&secretmem_users) < 0)
> +               return -ENFILE;

So you suggest to prevent creation of the file descriptor to ensure there
is no overflow of secretmem_users. I don't feel it's a clean and elegant
solution.

> 
>         fd = get_unused_fd_flags(flags & O_CLOEXEC);
>         if (fd < 0)
> 
> 
> Also, why does secretmem depend on !EMBEDDED?

There was a request from tiny-config maintainers to keep this code outside
tiny-config and the best option I could find to make secretmem depend on
!EMBEDDED.

-- 
Sincerely yours,
Mike.
