Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBB431627
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhJRKeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:34:00 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:20531 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJRKd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:33:59 -0400
Date:   Mon, 18 Oct 2021 10:31:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail; t=1634553106;
        bh=HYCqN5T+QYzLh/zNNwmm3Jblg3/9nkHgKNp4c3zRw0E=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=iz1aBOLhcLUFZzHy48w+1/uKpOt/mY4U/WDXHPNkkh+DjIl6qys/9icS6CYXhHcl1
         Q85uMCjYqJqY18kz+SnEIq9l0yahlhsZkjATSG2L4iCtQyYmNA7cuXNOLczQklYKA9
         I+HqGiM1jna5pcCZ0eGV8A8eGXH5ABCdZN75vlvc=
To:     Yu Zhao <yuzhao@google.com>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Rune Kleveland <rune.kleveland@infomedia.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "containers\\\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [CFT][PATCH] ucounts: Fix signal ucount refcounting
Message-ID: <yDKmqVctE8MV6p62Ru2cNDTwa7XtEl9B_lMj4xabNKfbwR2A_aLWNvYpepdZBTbDZDJtMdTZtsdWLfp6SIRksWwfCOV6jJ1UuBRbLSsBxiI=@protonmail.ch>
In-Reply-To: <CAOUHufZJFAK3uBma0kgEjb7YK6Fq4vQqdGNFz6_=QkFBbqGBCw@mail.gmail.com>
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch> <20210930130640.wudkpmn3cmah2cjz@example.org> <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com> <878rz8wwb6.fsf@disp2133> <87v92cvhbf.fsf@disp2133> <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk> <87mtnavszx.fsf_-_@disp2133> <24192747-7f69-ef22-7bf1-96b2e7c2bca1@infomedia.dk> <CAOUHufZJFAK3uBma0kgEjb7YK6Fq4vQqdGNFz6_=QkFBbqGBCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 18th, 2021 at 6:25 AM, Yu Zhao <yuzhao@google.com> wrote=
:

> On Sun, Oct 17, 2021 at 10:47 AM Rune Kleveland
>
> rune.kleveland@infomedia.dk wrote:
>
> > Hi!
> >
> > After applying the below patch, the 5 most problematic servers have run
> >
> > without any issues for 23 hours. That never happened before the patch o=
n
> >
> > 5.14, so the patch seems to have fixed the issue for me.
>
> Confirm. I couldn't reproduce the problem on 5.14 either.
>

I'm also unable to reproduce the crash as for now. Thx for the patch.

Jordan

> > On Monday there will be more load on the servers, which caused them to
> >
> > crash faster without the patch. I will let you know if it happens again=
.
> >
> > Best regards,
> >
> > Rune
> >
> > On 16/10/2021 00:10, Eric W. Biederman wrote:
> >
> > > In commit fda31c50292a ("signal: avoid double atomic counter
> > >
> > > increments for user accounting") Linus made a clever optimization to
> > >
> > > how rlimits and the struct user_struct. Unfortunately that
> > >
> > > optimization does not work in the obvious way when moved to nested
> > >
> > > rlimits. The problem is that the last decrement of the per user
> > >
> > > namespace per user sigpending counter might also be the last decremen=
t
> > >
> > > of the sigpending counter in the parent user namespace as well. Which
> > >
> > > means that simply freeing the leaf ucount in __free_sigqueue is not
> > >
> > > enough.
> > >
> > > Maintain the optimization and handle the tricky cases by introducing
> > >
> > > inc_rlimit_get_ucounts and dec_rlimit_put_ucounts.
> > >
> > > By moving the entire optimization into functions that perform all of
> > >
> > > the work it becomes possible to ensure that every level is handled
> > >
> > > properly.
> > >
> > > I wish we had a single user across all of the threads whose rlimit
> > >
> > > could be charged so we did not need this complexity.
