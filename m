Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43815396D18
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhFAGCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFAGCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:02:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3A4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 23:00:26 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x38so19916542lfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 23:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMK+BlVA/bqQ4G3j0umpuAtgbjll4fk10VR8BwqsbnM=;
        b=Cq1BJQXRRbsAXqGxRHmxlETFypstLuehMX0LFh5G4WwWip0G6ssEb7uQhJQf6qE/w6
         q99MLnXgThXbCZe6+0hy/V9sd6Z8pdAbXqzWYO7KoTJokBUNapDj13LzLPptKUN0dXDB
         dBnWVVEJ54OfnhbSAGqeb8GPq4vKV3/0PFITU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMK+BlVA/bqQ4G3j0umpuAtgbjll4fk10VR8BwqsbnM=;
        b=ftIwz5pvs1Il82SxYt78Wws13on6GhubhzrqDCYApUEF+sMydEHjyYvAx3WsTkfSJ0
         q2SdpddrVLp9nDIGbSPgF8NgjIMZ5vAicl3d1SwjNOI+6SzQfO/GW+0oOcuRJssJvW5+
         +ieI3KdxWRg2q14UYtq/ZE/6M16wcIAZ9/9ANVDzj6kQabGGrZR/FCH2FUkDLehXuS9z
         RhfrTzy2gv3guQUaOz8BnG8SwgEF/bgSB4TS3wntlNxuQaFBst9UVOm+OZ019xmEwzUW
         nwMJ4VxMNsAM76X6FZKKtVDItPZH2lIutz/fnxZosKSH/te0dKyDlzwsmgOkMOz9bvrX
         sLWw==
X-Gm-Message-State: AOAM530JDuV5ugO7Bu5zjfUOJEbXReleO4uyN6lKrSv3EBeAEyzuQEhq
        Iu2Qlg4bKkGEvS5U0V7h14hDoH8rI3lrv4tB
X-Google-Smtp-Source: ABdhPJy8Erz+FvHoBwp7fIe+mCwHInbs7O9x6gg8UyiYIKr6ZOYYbIOkNkwUEcfzUqiol6LG92Y0hQ==
X-Received: by 2002:a19:e212:: with SMTP id z18mr10759831lfg.55.1622527225154;
        Mon, 31 May 2021 23:00:25 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id n130sm1724572lfa.10.2021.05.31.23.00.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 23:00:24 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id a4so17630570ljd.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 23:00:24 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr1911003ljh.507.1622527224567;
 Mon, 31 May 2021 23:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210531170123.243771-1-agruenba@redhat.com> <20210531170123.243771-5-agruenba@redhat.com>
In-Reply-To: <20210531170123.243771-5-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 May 2021 20:00:08 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiB9gvUsebmiOaRXzYVUxJDUt1SozGtRyxR_MDR=Nv7YQ@mail.gmail.com>
Message-ID: <CAHk-=wiB9gvUsebmiOaRXzYVUxJDUt1SozGtRyxR_MDR=Nv7YQ@mail.gmail.com>
Subject: Re: [RFC 4/9] gfs2: Fix mmap + page fault deadlocks (part 1)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 7:01 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Fix that by recognizing the self-recursion case.

Hmm. I get the feeling that the self-recursion case should never have
been allowed to happen in the first place.

IOW, is there some reason why you can't make the user accesses always
be doen with page faults disabled (ie using the "atomic" user space
access model), and then if you get a partial read (or write) to user
space, at that point you drop the locks in read/write, do the "try to
make readable/writable" and try again.

IOW, none of this "detect recursion" thing. Just "no recursion in the
first place".

That way you'd not have these odd rules at fault time at all, because
a fault while holding a lock would never get to the filesystem at all,
it would be aborted early. And you'd not have any odd "inner/outer"
locks, or lock compatibility rules or anything like that. You'd
literally have just "oh, I didn't get everything at RW time while I
held locks, so let's drop the locks, try to access user space, and
retry".

Wouldn't that be a lot simpler and more robust?

Because what if the mmap is something a bit more complex, like
overlayfs or usefaultfd, and completing the fault isn't about gfs2
handling it as a "fault", but about some *other* entity calling back
to gfs2 and doing a read/write instead? Now all your "inner/outer"
lock logic ends up being entirely pointless, as far as I can tell, and
you end up deadlocking on the lock you are holding over the user space
access _anyway_.

So I literally think that your approach is

 (a) too complicated

 (b) doesn't actually fix the issue in the more general case

But maybe I'm missing something.

              Linus

                    Linus
