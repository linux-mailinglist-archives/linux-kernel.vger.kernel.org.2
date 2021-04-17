Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FF93631CB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 20:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhDQSTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbhDQSTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 14:19:50 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32330C061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 11:09:49 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXpO4-0067B4-1n; Sat, 17 Apr 2021 18:09:44 +0000
Date:   Sat, 17 Apr 2021 18:09:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
Message-ID: <YHskaCSFOE1AYyoP@zeniv-ca.linux.org.uk>
References: <20210416192413.1514419-1-eric.dumazet@gmail.com>
 <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com>
 <CAHk-=wgdyusj4Sz6zVOGvD8pNiYmPik3t4-o0TXB9cTUgz_0uw@mail.gmail.com>
 <CAHk-=wjYVZZpqDGH2Q=kMOyOqBhpbt8t8JdEWZHDGrPiV=_ifA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjYVZZpqDGH2Q=kMOyOqBhpbt8t8JdEWZHDGrPiV=_ifA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 09:27:04AM -0700, Linus Torvalds wrote:
> On Sat, Apr 17, 2021 at 9:08 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Side note: I'm, looking at the readdir cases that I wrote, and I have
> > to just say that is broken too. So "stones and glass houses" etc, and
> > I'll have to fix that too.
> 
> In particular, the very very old OLD_READDIR interface that only fills
> in one dirent at a time didn't call verify_dirent_name(). Same for the
> compat version.
> 
> This requires a corrupt filesystem to be an issue (and even then,
> most/all would have the length of a directory entry in an 'unsigned
> char', so even corrupt filesystems would generally never have a
> negative name length).
> 
> So I don't think it's an issue in _practice_, but at the same time it
> is very much an example of the same issue that put_cmsg() has in
> net-next: unsafe user copies should be fully guarded and not have some
> "but this would never happen because callers would never do anything
> bad".
> 
> Al - fairly trivial patch applied, comments?

Should be fine...  FWIW, I've a patch in the same area, making those suckers
return bool.  Seeing that they are only ever called via dir_emit(), dir_emit_dot()
and dir_emit_dotdot() and all of those return ->actor(...) == 0...

Anyway, that'd be trivial to rebase on top of yours.
