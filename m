Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5548139E7F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhFGT6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:58:31 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:41491 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhFGT62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:58:28 -0400
Received: by mail-lj1-f182.google.com with SMTP id z22so7890756ljh.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LJdE0/DOUMHrqesI+TC9uG48g5eWLGdmgXC+rBKWYk=;
        b=jq4wEsDdfDzBDd8wF08Z7U1wcIi/8IVpvGjKMjl6XhnY/ZS3tZh0wi2GySCz4dreC8
         12ec2GVcpWM7xD+rdbt+k+2UnY3bcr5GVx4/FjmjbgkSJ7gqkKEo7Wax5CnPkmacjZ40
         ktRBiCErqwr6bvjsnxafJrBNTFh3vYovlJnknW/597rkJ3F12+yKwna6UIgsacXymjD3
         Xys/VTk7EZJFbx02dJ7LlMsAHALzCtqFxoRQVj3Ulr0Ne+6JCZ4JZr0UrMVmYdzaBfTG
         qtMQfj4O+y+zenhGQ5IxYa07aDSH660rczA1ojHrgURK3desoY+WbHEQZozss75Lt1ix
         GXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LJdE0/DOUMHrqesI+TC9uG48g5eWLGdmgXC+rBKWYk=;
        b=Ii+i2+hcu+P80+x6vxJHYEuDNz0QHMRkropSccy+V0Fpp99s0WeJOx+Xo8h//6jTQv
         5ws98HX+2mzcy3FrBQFP/jJwfU/7u7Lz9/XVT115INb6DyUM7HjEFadNmXmcBApCjFlB
         MZ925yXsIfc4v7J3sACD2gZah1C7xz5lPUopbi5t6Fv3zB/hSKZdsEPlgLFG0aVliVkz
         vAM73yUkFlXa9YCq8cd575nBULfd30xv595MeEZt6sXw9J557+q7T9TRhfGpzpdV+rgf
         8uR5szZKO+oeqvXOyldlaIdWd0Au0H8zK8GT1tPMWHEmSf4cM0jXmmcVYa4tCHUMiqPe
         anFA==
X-Gm-Message-State: AOAM533EAgBldQIlnYEkivYbAQN7Tu0hUuhDp0/+yYKftp/EtdscoRut
        JKZQwO3dHvO+lXd/0Ud2V7ZBoq6umgoP5IcPjlB6hA==
X-Google-Smtp-Source: ABdhPJyFA7F43gQQ8CHg14LneeqgMAlavMivZIGL81fpZSDpUZHp85rgUDcvc1UaV4dhCuLt0y/QJWr/mOni0F+MtTo=
X-Received: by 2002:a05:651c:178f:: with SMTP id bn15mr16369600ljb.448.1623095735829;
 Mon, 07 Jun 2021 12:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000017977605c395a751@google.com> <CAG48ez0M=iwJu=Q8yUQHD-+eZDg6ZF8QCF86Sb=CN1petP=Y0Q@mail.gmail.com>
 <YL5fayfh03Wecyd7@casper.infradead.org>
In-Reply-To: <YL5fayfh03Wecyd7@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 7 Jun 2021 21:55:09 +0200
Message-ID: <CAG48ez08GhsK00-J=1hbZrccB7uZ10EbN8i1Zj4pfp4V=LZEZA@mail.gmail.com>
Subject: Re: split_huge_page_to_list() races with page_mapcount() on migration
 entry in smaps code? [was: Re: [syzbot] kernel BUG in __page_mapcount]
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        chinwen.chang@mediatek.com,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        syzbot <syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 8:03 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Jun 07, 2021 at 07:27:23PM +0200, Jann Horn wrote:
> > === Short summary ===
> > I believe the issue here is a race between /proc/*/smaps and
> > split_huge_page_to_list():
> >
> > The codepath for /proc/*/smaps walks the pagetables and (e.g. in
> > smaps_account()) calls page_mapcount() not just on pages from normal
> > PTEs but also on migration entries (since commit b1d4d9e0cbd0a
> > "proc/smaps: carefully handle migration entries", from Linux v3.5).
> > page_mapcount() expects compound pages to be stable.
> >
> > The split_huge_page_to_list() path first protects the compound page by
> > locking it and replacing all its PTEs with migration entries (since
> > the THP rewrite in v4.5, I think?), then does the actual splitting
> > using __split_huge_page().
> >
> > So there's a mismatch of expectations here:
> > The smaps code expects that migration entries point to stable compound
> > pages, while the THP code expects that it's okay to split a compound
> > page while it has migration entries.
>
> Will it be a colossal performance penalty if we always get the page
> refcount after looking it up?  That will cause split_huge_page() to
> fail to split the page if it hits this race.

Hmm - but with that approach I'm not sure you could even easily take a
refcount on a page whose refcount may be frozen and which may be in
the middle of being shattered? get_page_unless_zero() is wrong because
you can't take references on tail pages, right? (Or can you?) And
try_get_page() is wrong because it bugs out if the refcount is zero -
and even if it didn't do that, you might end up holding a reference on
the head page while the page you're actually interested in is a tail
page?

I guess if it was really necessary, it'd be possible to do some kind
of retry thing that grabs a reference on the compound head, then
checks that the tail page is still associated with the compound head,
and if not, drops the compound head and tries again?
