Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A4A36C0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhD0IZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:25:57 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:29285 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbhD0IZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:25:55 -0400
Date:   Tue, 27 Apr 2021 08:24:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1619511910;
        bh=4HSy2peeOUh+Sk0/LYpC/GuLIdId71wOZKqgB55PQe8=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=IH1gMJIkBL6Rq7XG2TuitQx8L+5vdyeKrcgfGpQugBovC9zRchEZQ+5VydqO6BanU
         4rYc2FNQAIOIZgJI3LLEfKbwLAG9uKoI5fLXKbbFonuquWKKeqI2Hf92z63xoB2X0U
         SQBS0sb2jDbym2sB5fUt/RJ0zTBRygDuf+p2KdW878rylJ8DDyuwOX1lgsLkMSwlbi
         gs9mgQ5UU1TRtcHY9iVQgz+TZJyBWO0JV+DoJZPuLpuymKRlPymkmm6QhYMeUQv/db
         QpyrapM5OY53c4g+vZHEjSOScTVjdbfsL2EAGcVLJYfVA+A2RbanplJ5/xgegDfx3s
         gSPEE4BBkDs+Q==
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Sealed memfd & no-fault mmap
Message-ID: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm a user-space developer working on Wayland compositors.

Back in 2014, David Herrmann has posted a patchset [1] to introduce memfd
and file sealing. The patchset reads:

>   1) Graphics Compositors
>      If a graphics client creates a memory-backed render-buffer and passe=
s a
>      file-decsriptor to it to the graphics server for display, the server
>      _has_ to setup SIGBUS handlers whenever mapping the given file. Othe=
rwise,
>      the client might run ftruncate() or O_TRUNC on the on file in parall=
el,
>      thus crashing the server.
>      With sealing, a compositor can reject any incoming file-descriptor t=
hat
>      does _not_ have SEAL_SHRINK set. This way, any memory-mappings are
>      guaranteed to stay accessible. Furthermore, we still allow clients t=
o
>      increase the buffer-size in case they want to resize the render-buff=
er for
>      the next frame. We also allow parallel writes so the client can rend=
er new
>      frames into the same buffer (client is responsible of never renderin=
g into
>      a front-buffer if you want to avoid artifacts).
>
>      Real use-case: Wayland wl_shm buffers can be transparently converted

Fast-forward to 7 years later, and notice that there doesn't exist a
single Wayland compositor that enforces file sealing for its clients.

The reason is that there will always exist clients which are either old
(and predate file sealing) or refuse to use Linux-only APIs (they don't
use memfd and file sealing, instead they use e.g. shm_open). Requiring
sealed memfds in compositors would break these clients.

I don't believe the situation is about to change.

Rather than requiring changes in all compositors *and* clients, can we
maybe only require changes in compositors? For instance, OpenBSD has a
__MAP_NOFAULT flag. When passed to mmap, it means that out-of-bound
accesses will read as zeroes instead of triggering SIGBUS. Such a flag
would be very helpful to unblock the annoying SIGBUS situation.

Would something among these lines be welcome in the Linux kernel?

Thanks,

Simon

[1]: https://lwn.net/Articles/591108/
