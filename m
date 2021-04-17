Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFDC36323B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 22:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhDQUbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 16:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbhDQUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 16:31:20 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F68EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 13:30:54 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXraU-0068dY-GZ; Sat, 17 Apr 2021 20:30:42 +0000
Date:   Sat, 17 Apr 2021 20:30:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
Message-ID: <YHtFciNvBWYJ0ku2@zeniv-ca.linux.org.uk>
References: <20210416192413.1514419-1-eric.dumazet@gmail.com>
 <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com>
 <CAHk-=wgdyusj4Sz6zVOGvD8pNiYmPik3t4-o0TXB9cTUgz_0uw@mail.gmail.com>
 <CAHk-=wjYVZZpqDGH2Q=kMOyOqBhpbt8t8JdEWZHDGrPiV=_ifA@mail.gmail.com>
 <YHskaCSFOE1AYyoP@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHskaCSFOE1AYyoP@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[tytso Cc'd]

On Sat, Apr 17, 2021 at 06:09:44PM +0000, Al Viro wrote:

> > Al - fairly trivial patch applied, comments?
> 
> Should be fine...  FWIW, I've a patch in the same area, making those suckers
> return bool.  Seeing that they are only ever called via dir_emit(), dir_emit_dot()
> and dir_emit_dotdot() and all of those return ->actor(...) == 0...
> 
> Anyway, that'd be trivial to rebase on top of yours.

Actually... looking through that patch now I've noticed something fishy:
in 1f60fbe72749 ("ext4: allow readdir()'s of large empty directories to
be interrupted" we had
@@ -169,6 +169,8 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
        }
        dirent = buf->previous;
        if (dirent) {
+               if (signal_pending(current))
+                       return -EINTR;

and that thing is still there.  However, it does *NOT* do what it might
appear to be doing; it ends up with getdents() returning -EINVAL instead.
What we need is
			buf->error = -EINTR;
in addition to that return (in all 3 such places).  Do you have any problems with
the following delta?

diff --git a/fs/readdir.c b/fs/readdir.c
index 19434b3c982c..c742db935847 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -239,8 +239,10 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 		return -EOVERFLOW;
 	}
 	prev_reclen = buf->prev_reclen;
-	if (prev_reclen && signal_pending(current))
+	if (prev_reclen && signal_pending(current)) {
+		buf->error = -EINTR;
 		return -EINTR;
+	}
 	dirent = buf->current_dir;
 	prev = (void __user *) dirent - prev_reclen;
 	if (!user_write_access_begin(prev, reclen + prev_reclen))
@@ -321,8 +323,10 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	if (reclen > buf->count)
 		return -EINVAL;
 	prev_reclen = buf->prev_reclen;
-	if (prev_reclen && signal_pending(current))
+	if (prev_reclen && signal_pending(current)) {
+		buf->error = -EINTR;
 		return -EINTR;
+	}
 	dirent = buf->current_dir;
 	prev = (void __user *)dirent - prev_reclen;
 	if (!user_write_access_begin(prev, reclen + prev_reclen))
@@ -488,8 +492,10 @@ static int compat_filldir(struct dir_context *ctx, const char *name, int namlen,
 		return -EOVERFLOW;
 	}
 	prev_reclen = buf->prev_reclen;
-	if (prev_reclen && signal_pending(current))
+	if (prev_reclen && signal_pending(current)) {
+		buf->error = -EINTR;
 		return -EINTR;
+	}
 	dirent = buf->current_dir;
 	prev = (void __user *) dirent - prev_reclen;
 	if (!user_write_access_begin(prev, reclen + prev_reclen))
