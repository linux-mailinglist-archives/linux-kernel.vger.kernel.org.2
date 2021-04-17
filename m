Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D28636323C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 22:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbhDQUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbhDQUfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 16:35:50 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A4BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 13:35:23 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXrew-0068gI-84; Sat, 17 Apr 2021 20:35:18 +0000
Date:   Sat, 17 Apr 2021 20:35:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
Message-ID: <YHtGhqBXhWlUHHRm@zeniv-ca.linux.org.uk>
References: <20210416192413.1514419-1-eric.dumazet@gmail.com>
 <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com>
 <CAHk-=wgdyusj4Sz6zVOGvD8pNiYmPik3t4-o0TXB9cTUgz_0uw@mail.gmail.com>
 <CAHk-=wjYVZZpqDGH2Q=kMOyOqBhpbt8t8JdEWZHDGrPiV=_ifA@mail.gmail.com>
 <YHskaCSFOE1AYyoP@zeniv-ca.linux.org.uk>
 <YHtFciNvBWYJ0ku2@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHtFciNvBWYJ0ku2@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 08:30:42PM +0000, Al Viro wrote:

> and that thing is still there.  However, it does *NOT* do what it might
> appear to be doing; it ends up with getdents() returning -EINVAL instead.
> What we need is
> 			buf->error = -EINTR;
> in addition to that return (in all 3 such places).  Do you have any problems with
> the following delta?

No, wait - we have non-NULL buf->prev_reclen, so we'll hit
        if (buf.prev_reclen) {
		struct compat_linux_dirent __user * lastdirent;
		lastdirent = (void __user *)buf.current_dir - buf.prev_reclen;

		if (put_user(buf.ctx.pos, &lastdirent->d_off)) 
			error = -EFAULT;
		else
			error = count - buf.count;
	}
with buf->error completely ignored.  Nevermind.
