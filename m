Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345CC3987CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhFBLS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhFBLS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622632605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n6ruBB0Ytz1nu7rTAZGTMPhHF3U9i3+0Qv8sww0BF7w=;
        b=E1P7gWaXkIGEzV+tT9mPoWOhUTS5i+vCxw/NZQoDVrW3BNtm7icwbn/WuixOy8M2f56Qs/
        qiFdN71RdRoO9LUFs/breWHwaCFmwG5/r/o8b2Jl+q9h4FYjavALh2v1cvec8GKOhQS8HH
        2xRlFcImUIQp8lv8/f/+6bm0PmRsGB0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-lpjEY_gvPeyypRAkyISe2w-1; Wed, 02 Jun 2021 07:16:44 -0400
X-MC-Unique: lpjEY_gvPeyypRAkyISe2w-1
Received: by mail-wm1-f70.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so488052wmh.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 04:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6ruBB0Ytz1nu7rTAZGTMPhHF3U9i3+0Qv8sww0BF7w=;
        b=JVW2fxeLdYQhxjXB2wHSaK6VrCG9T/kRSC7lVBcPujGDp+v6xEQJmyWA1Znjz4g2Ee
         gU0vUQoKmQnNOytXT2QWLnjDh87LFnyWgXMpgaumUVEvuQzJ7Hq/LBlOtIQNCcC9MeKn
         9gr79QNyhWa31ct/wOLqjm3wO6+I1Zz0ABqK1Bko15pFjMDWNRDggI+80LsqIBXYb1BX
         ZUX55TFtDEIx7JttIiyO7ggHPaN+87tRIj7T9Kbj0LhlD0feISrfK7KgGo3vUdl1qgx1
         SZMTPuSCB52BLlwK8qNXSjWSI2xIZmtMZx+UDh5mQDyZMj7sZ+4/jNDpyPLOLGz/W1pH
         S7AA==
X-Gm-Message-State: AOAM531Or0gjPBIjeOx+q9UEAn5wpmLqAvvMPM+YhfyK24epKNjoh6Hn
        PjzunMVtP51AY5uA/ggkKahU38UpEQwMhZAF22/NgzmMDo9rkURgWnypfoeajXOoHIf8LuZhAcm
        6NUb/OSaY8tJ0IoRKWBFsEmAYL4TL8kOtPkg680/x
X-Received: by 2002:adf:eac9:: with SMTP id o9mr17338204wrn.78.1622632603303;
        Wed, 02 Jun 2021 04:16:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvQfVLspuqWRiLVnfyZcyInXdEvPRHne1Wa0GUdhPjf6KYnH2vnLr99kOz5alPu9eAz6IUiT2mUWvuN+eIjQA=
X-Received: by 2002:adf:eac9:: with SMTP id o9mr17338194wrn.78.1622632603144;
 Wed, 02 Jun 2021 04:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210531170123.243771-1-agruenba@redhat.com> <20210531170123.243771-5-agruenba@redhat.com>
 <CAHk-=wiB9gvUsebmiOaRXzYVUxJDUt1SozGtRyxR_MDR=Nv7YQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiB9gvUsebmiOaRXzYVUxJDUt1SozGtRyxR_MDR=Nv7YQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 2 Jun 2021 13:16:32 +0200
Message-ID: <CAHc6FU4n_F9sPjP7getGRKLpB-KsZt_qhHctqwY5pJrxGxLr2w@mail.gmail.com>
Subject: Re: [RFC 4/9] gfs2: Fix mmap + page fault deadlocks (part 1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 8:00 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, May 31, 2021 at 7:01 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > Fix that by recognizing the self-recursion case.
>
> Hmm. I get the feeling that the self-recursion case should never have
> been allowed to happen in the first place.
>
> IOW, is there some reason why you can't make the user accesses always
> be done with page faults disabled (ie using the "atomic" user space
> access model), and then if you get a partial read (or write) to user
> space, at that point you drop the locks in read/write, do the "try to
> make readable/writable" and try again.
>
> IOW, none of this "detect recursion" thing. Just "no recursion in the
> first place".
>
> That way you'd not have these odd rules at fault time at all, because
> a fault while holding a lock would never get to the filesystem at all,
> it would be aborted early. And you'd not have any odd "inner/outer"
> locks, or lock compatibility rules or anything like that. You'd
> literally have just "oh, I didn't get everything at RW time while I
> held locks, so let's drop the locks, try to access user space, and
> retry".

Well, iomap_file_buffered_write() does that by using
iov_iter_fault_in_readable() and iov_iter_copy_from_user_atomic() as
in iomap_write_actor(), but the read and direct I/O side doesn't seem
to have equivalents. I suspect we can't just wrap
generic_file_read_iter() and iomap_dio_rw() calls in
pagefault_disable().

> Wouldn't that be a lot simpler and more robust?

Sure, with vfs primitives that support atomic user-space access and
with a iov_iter_fault_in_writeable() like operation, we could do that.

> Because what if the mmap is something a bit more complex, like
> overlayfs or userfaultfd, and completing the fault isn't about gfs2
> handling it as a "fault", but about some *other* entity calling back
> to gfs2 and doing a read/write instead? Now all your "inner/outer"
> lock logic ends up being entirely pointless, as far as I can tell, and
> you end up deadlocking on the lock you are holding over the user space
> access _anyway_.

Yes, those kinds of deadlocks would still be possible.

Until we have a better solution, wouldn't it make sense to at least
prevent those self-recursion deadlocks? I'll send a separate pull
request in case you find that acceptable.

Thanks,
Andreas

