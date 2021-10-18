Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1F431082
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 08:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhJRG2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 02:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhJRG2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:28:16 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBDDC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:26:06 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id f4so3783396uad.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hyNbtoXj6gpz4GVzyiBy/BcrMKlU7PR5ScmW7Ah/0c=;
        b=fUoWDbarHptRaSJPZZmT2Ezo0RZISM9rh5s8evrCkVqnsmUDqct9pNJCt6UgP34gsu
         //k3IqFxT6I1pFaSnTEdzarl4ScQw4UqJSZb7AZp2uB4i9PWTHRi7dddDE8Bm5U2/y6X
         TrWAoVlheTVniBRFlgV5OPQuyXUzo03PX27Frzoqm9RPPlLSaKwAt3AUi8mYHf0cbpac
         ItwK1PtmtJpg/6gkYvNKt6Zpg8sU+1xsFRQWxdH8M/7MJBnqVA/+Hh6pXv9O2tJoUnXO
         HyTJ0FdgHfp2aGnq+CsMhhFoHWlBVuEGH77ze9DERaTmv/Gfj4QN8CK3FDDCwClcnuY2
         D4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hyNbtoXj6gpz4GVzyiBy/BcrMKlU7PR5ScmW7Ah/0c=;
        b=65vC5EPcraSWPJgcQ7AC92dmxi+utwwquV76sVSWRwlAfvwPqABbpyOTOcxpqRp69p
         DgL+C1kI6ze3zPik1CZnkPXQQ3hn14Yy9fTqYpfSzSebYJZOEU26zk1YNJ4HIdV+uN+t
         0WBJlie8Qe3bniyEOofL7/fAAuYJsGn5rIlHnIiQtftWPH/19mSYibCRmU0FHsWH6FN7
         jmSa8RH69naDQQtWT+/+ln9fI38s7optVSf1mLy5pUy5msbhUguNYNPYLTS/BfMT7rJv
         H2ag6jkI+ztBurUK/1L28QHx3g/COXwqg0AmO1cpLhkTx5YttWFsUtwwI1xNPOYPsa5w
         A1Lg==
X-Gm-Message-State: AOAM533fmoF06g33deNnB4TxTQujgD4FoRkRmXIsJ3ezIgopPoOWdmKZ
        /RjaGttdzp7n3GZnVBQR0OQsfBCVyP0o/aMGOkgu0Q==
X-Google-Smtp-Source: ABdhPJwLVSsvksTT5AZxm0evVbJT73BF/2Vlm124e/F9zu//3HXW69tjV+llW2vhLcKMEXT5XQWM34JmpeIdNDgHo80=
X-Received: by 2002:ab0:49ca:: with SMTP id f10mr23313822uad.61.1634538365121;
 Sun, 17 Oct 2021 23:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
 <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
 <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
 <878rzw77i3.fsf@disp2133> <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
 <20210929173611.fo5traia77o63gpw@example.org> <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
 <20210930130640.wudkpmn3cmah2cjz@example.org> <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
 <878rz8wwb6.fsf@disp2133> <87v92cvhbf.fsf@disp2133> <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk>
 <87mtnavszx.fsf_-_@disp2133> <24192747-7f69-ef22-7bf1-96b2e7c2bca1@infomedia.dk>
In-Reply-To: <24192747-7f69-ef22-7bf1-96b2e7c2bca1@infomedia.dk>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 18 Oct 2021 00:25:54 -0600
Message-ID: <CAOUHufZJFAK3uBma0kgEjb7YK6Fq4vQqdGNFz6_=QkFBbqGBCw@mail.gmail.com>
Subject: Re: [CFT][PATCH] ucounts: Fix signal ucount refcounting
To:     Rune Kleveland <rune.kleveland@infomedia.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "containers\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 10:47 AM Rune Kleveland
<rune.kleveland@infomedia.dk> wrote:
>
> Hi!
>
> After applying the below patch, the 5 most problematic servers have run
> without any issues for 23 hours. That never happened before the patch on
> 5.14, so the patch seems to have fixed the issue for me.

Confirm. I couldn't reproduce the problem on 5.14 either.

> On Monday there will be more load on the servers, which caused them to
> crash faster without the patch. I will let you know if it happens again.
>
> Best regards,
> Rune
>
> On 16/10/2021 00:10, Eric W. Biederman wrote:
> >
> > In commit fda31c50292a ("signal: avoid double atomic counter
> > increments for user accounting") Linus made a clever optimization to
> > how rlimits and the struct user_struct.  Unfortunately that
> > optimization does not work in the obvious way when moved to nested
> > rlimits.  The problem is that the last decrement of the per user
> > namespace per user sigpending counter might also be the last decrement
> > of the sigpending counter in the parent user namespace as well.  Which
> > means that simply freeing the leaf ucount in __free_sigqueue is not
> > enough.
> >
> > Maintain the optimization and handle the tricky cases by introducing
> > inc_rlimit_get_ucounts and dec_rlimit_put_ucounts.
> >
> > By moving the entire optimization into functions that perform all of
> > the work it becomes possible to ensure that every level is handled
> > properly.
> >
> > I wish we had a single user across all of the threads whose rlimit
> > could be charged so we did not need this complexity.
