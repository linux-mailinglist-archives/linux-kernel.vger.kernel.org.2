Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A3031CBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhBPOcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBPOcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:32:16 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B28C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 06:31:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s11so12407026edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 06:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cwp0GvNwrAKCsxhmN2M2a4yWcZ0QuLL5twK22get2lQ=;
        b=qJlG9FlA7//SkKP/KnlTJeFd6JUIm4cekamkBIQ/iXSOVyrdk18xUSllNJ4yqhudNj
         0T0x2Lgq/YuugQp4tqCIVxr5a5x1SIES65IWUxlfEnQH0KZUFz+zdymaLQ0384Dj53Dm
         0zTYT+CPtNsDSqDxlb5EqzolLdigLgLZHpm49UEm/hYLZeG+AqlyfYLgD9CVblwWFEaJ
         nHo57+pnHaKALVgGE6gghdqaPz9uZa9mbzZFOyOp+gSOv2G7wkg8EovSY4fGuYWvZCUe
         y21vzEydXuDUw/ARNI7vcaXaQ5LHaHiUcbYQ4iFIo7Oz2VBK95wJMPLXt7njAuGITUwd
         UA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cwp0GvNwrAKCsxhmN2M2a4yWcZ0QuLL5twK22get2lQ=;
        b=pp3YmdT3cGxVUOBQ0sJ73iurh1iV8lft4bfC+akAEyinutqGy5cFoxI8br1mcUdcsV
         UDPlbS9WCRrj2Y2SQYZ1iAtkTFK8Fs8MnBT32MsMTPc8luIVzvCEvLsM54FxpOPyWhWJ
         U7jCk3JQk1YkY+oqHw1atsGpcJhhFIElb4AB0mOKaB4u3hp/Ad/3cyo+0kapzUtUmKnn
         D0lQz5F4neVDhU+Xh+amF5I7OlAjpqFULN8T9OJf7wjkmH6fmG0ErS/ZxMdhyDEyQvuh
         go7poQz1+2BTjnGYqTxVoY0OBnuOysTAzTroj0yyfDflE9RCLLU6zRoyh50nRCpN5MjU
         9hYw==
X-Gm-Message-State: AOAM533MPy6W9GCTTwuSsnBE2DayNhHguJzST8UfVJ4J7LOb/epaAZlN
        cQ9Lp3YDDVhgpbQimQJg+6rz/4nYHPnkkj1O8o44QSYpFEuaomvW
X-Google-Smtp-Source: ABdhPJysJT0RF7U5yKNSmD/jkMS3xj72OfKUlQ8vlUlq2ZOgMW5AzeNvFj4Rde7f7LSsNc5ePhNzOSjpLi1FnchyB8Q=
X-Received: by 2002:a50:a6ce:: with SMTP id f14mr20984271edc.346.1613485894678;
 Tue, 16 Feb 2021 06:31:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a50:6cc7:0:0:0:0:0 with HTTP; Tue, 16 Feb 2021 06:31:33
 -0800 (PST)
X-Originating-IP: [5.35.34.67]
In-Reply-To: <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
References: <20210125154937.26479-1-kda@linux-powerpc.org> <20210127175742.GA1744861@infradead.org>
 <CAOJe8K0MC-TCURE2Gpci1SLnLXCbUkE7q6SS0fznzBA+Pf-B8Q@mail.gmail.com>
 <20210129082524.GA2282796@infradead.org> <CAOJe8K0iG91tm8YBRmE_rdMMMbc4iRsMGYNxJk0p9vEedNHEkg@mail.gmail.com>
 <20210129131855.GA2346744@infradead.org> <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
From:   Denis Kirjanov <kda@linux-powerpc.org>
Date:   Tue, 16 Feb 2021 17:31:33 +0300
Message-ID: <CAOJe8K00srtuD+VAJOFcFepOqgNUm0mC8C=hLq2=qhUFSfhpuw@mail.gmail.com>
Subject: Re: [PATCH] fs: export kern_path_locked
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/21, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Jan 29, 2021 at 01:18:55PM +0000, Christoph Hellwig wrote:
>> On Fri, Jan 29, 2021 at 04:11:05PM +0300, Denis Kirjanov wrote:
>> > Do you mean just:
>>
>> We'll still need to lock the parent inode.
>
> Not just "lock", we wouldd need to have the lock _held_ across the
> entire sequence.  Without that there's no warranty that it will refer
> to the same object we'd created.
>
> In any case, unlink in any potentially public area is pretty much
> never the right approach.  Once mknod has happened, that's it - too
> late to bail out.
>
> IIRC, most of the PITA in that area is due to unix_autobind()
> iteractions.  Basically, we try to bind() an unbound socket and
> another thread does sendmsg() on the same while we are in the
> middle of ->mknod().  Who should wait for whom?
>
> ->mknod() really should be a point of no return - any games with
> "so we unlink it" are unreliable in the best case, and that's
> only if we do _not_ unlock the parent through the entire sequence.
>
> Seeing that we have separate bindlock and iolock now...  How about
> this (completely untested) delta?

We had a change like that:
Author: WANG Cong <xiyou.wangcong@gmail.com>
Date:   Mon Jan 23 11:17:35 2017 -0800

    af_unix: move unix_mknod() out of bindlock

    Dmitry reported a deadlock scenario:

    unix_bind() path:
    u->bindlock ==> sb_writer

    do_splice() path:
    sb_writer ==> pipe->mutex ==> u->bindlock

    In the unix_bind() code path, unix_mknod() does not have to
    be done with u->bindlock held, since it is a pure fs operation,
    so we can just move unix_mknod() out.


>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 41c3303c3357..c21038b15836 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1034,6 +1034,14 @@ static int unix_bind(struct socket *sock, struct
> sockaddr *uaddr, int addr_len)
>  		goto out;
>  	addr_len = err;
>
> +	err = mutex_lock_interruptible(&u->bindlock);
> +	if (err)
> +		goto out;
> +
> +	err = -EINVAL;
> +	if (u->addr)
> +		goto out_up;
> +
>  	if (sun_path[0]) {
>  		umode_t mode = S_IFSOCK |
>  		       (SOCK_INODE(sock)->i_mode & ~current_umask());
> @@ -1041,18 +1049,10 @@ static int unix_bind(struct socket *sock, struct
> sockaddr *uaddr, int addr_len)
>  		if (err) {
>  			if (err == -EEXIST)
>  				err = -EADDRINUSE;
> -			goto out;
> +			goto out_up;
>  		}
>  	}
>
> -	err = mutex_lock_interruptible(&u->bindlock);
> -	if (err)
> -		goto out_put;
> -
> -	err = -EINVAL;
> -	if (u->addr)
> -		goto out_up;
> -
>  	err = -ENOMEM;
>  	addr = kmalloc(sizeof(*addr)+addr_len, GFP_KERNEL);
>  	if (!addr)
> @@ -1090,7 +1090,6 @@ static int unix_bind(struct socket *sock, struct
> sockaddr *uaddr, int addr_len)
>  	spin_unlock(&unix_table_lock);
>  out_up:
>  	mutex_unlock(&u->bindlock);
> -out_put:
>  	if (err)
>  		path_put(&path);
>  out:
>
