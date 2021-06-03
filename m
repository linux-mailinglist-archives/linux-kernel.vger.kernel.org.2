Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E161439A1BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFCNCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:02:54 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:22510 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhFCNCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:02:53 -0400
Date:   Thu, 03 Jun 2021 13:01:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1622725266;
        bh=g5sGIL5X/dIixwzZThRSrnzhyX4qPO3WP6FfFa5urDI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=U+ebCt29XcCUOVQmAKecrKW5cJJH1m2/GrTsXodWhZ8hC3qxWTFmMYm0caVgO0YZF
         F5Rbv7z64pujOuEjj3FrpFU4uWGpD14HSYAI/pcPh31T50n5zlVURdOiX/A0h43wKS
         aEvw0cJbgxLFMhLvSZsFufN1qgvWeJZ8Atj7rpSXLarXql90AjGGHezF3XdfJ4ds/0
         IEvHCtyDqJwRzqoWFeOYJXTIjDSnvFIJK8bGjRvslX9TLWkLEg+coa5mgB38iJq34A
         eaZ1pqtkJuTqRQ1mAm2zwaaBGGLYLWqdzNhOUs5mo2DG3wti30tSZml7knY9ZRFNHO
         cvkAEZj2rFtiw==
To:     Ming Lin <minggr@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: Sealed memfd & no-fault mmap
Message-ID: <8By7yERxX_qlsLZuOeJihJqeU-pZtFxsS2zrQ1ssN6-NkyIRrv-r81Ux_PTcb8qy7QA1HmkRxTeixT5MaJs7NKk0rqxDC9Nu9DoTRmS0UHw=@emersion.fr>
In-Reply-To: <0464f8dd-d082-b246-83ff-609f0f48de59@gmail.com>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr> <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com> <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com> <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com> <alpine.LSU.2.11.2105291315330.25425@eggly.anvils> <36fc2485-11f1-5252-904d-f26b63a6cd58@gmail.com> <e7454046-c071-888d-f673-276f9c24d9d3@gmail.com> <CAHk-=whce3vmj+g7jcE0rasoDavJutxno3ZZrvvWYQywWXH31Q@mail.gmail.com> <0464f8dd-d082-b246-83ff-609f0f48de59@gmail.com>
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

On Tuesday, June 1st, 2021 at 9:08 AM, Ming Lin <minggr@gmail.com> wrote:

> On 5/31/2021 11:24 PM, Linus Torvalds wrote:
> > On Mon, May 31, 2021 at 11:13 AM Ming Lin <minggr@gmail.com> wrote:
> >>
> >> OK, I borrowed code from filemap_xip.c and implemented this behavior.
> >
> > I think that "unmap page" is too complicated and fragile.
> >
> > The only page that could possibly validly be unmapped is a stale zero
> > page, but that code in shmem_unmap_nofault_page() seems to try to
> > handle other cases too (ie that whole page_remove_rmap() - afaik a
> > zero page has no rmap).
> >
> > I get the feeling that the simpler thing to do is to just say "if you
> > use MAP_NOSIGBUS, and you access pages that don't have a backing
> > store, you will get zero pages, and they will NOT BE SYNCHRONIZED with
> > the backing store possibly later being updated".
> >
> > IOW, just document the fact that a MAP_NOSIGBUS mapping isn't coherent
> > wrt shmem contents that are expanded and filled in later.
> >
> > Don't try to "fix" it - because any user that uses MAP_NOSIGBUS had
> > better just accept that it's not compatible with expanding the shmem
> > backing store later.
> >
> > Keep it simple and stupid. Hmm?
>
> Simon,
>
> Is this "simple" solution good enough for Wayland compositor use case?

I've tried your patch "mm: adds MAP_NOSIGBUS extension for shmem read" with=
 a
libwayland hack [1] and a Wayland client that shrinks a shm file after the
compositor has mmap'ed it [2]. It seems to work nicely, thanks!

Regarding the requirements for Wayland:

- The baseline requirement is being able to avoid SIGBUS for read-only mapp=
ings
  of shm files.
- Wayland clients can expand their shm files. However the compositor doesn'=
t
  need to immediately access the new expanded region. The client will tell =
the
  compositor what the new shm file size is, and the compositor will re-map =
it.
- Ideally, MAP_NOSIGBUS would work on PROT_WRITE + MAP_SHARED mappings (of
  course, the no-SIGBUS behavior would be restricted to that mapping). The
  use-case is writing back to client buffers e.g. for screen capture. From =
the
  earlier discussions it seems like this would be complicated to implement.
  This means we'll need to come up with a new libwayland API to allow
  compositors to opt-in to the read-only mappings. This is sub-optimal but
  seems doable.
- Ideally, MAP_SIGBUS wouldn't be restricted to shm. There are use-cases fo=
r
  using it on ordinary files too, e.g. for sharing ICC profiles. But from t=
he
  earlier replies it seems very unlikely that this will become possible, an=
d
  making it work only on shm files would already be fantastic.

Thanks again for working on this! Let me know if the above is unclear
or if some info is missing.

Simon

[1]: https://gitlab.freedesktop.org/wayland/wayland/-/merge_requests/145
[2]: https://github.com/emersion/wleird/blob/master/sigbus.c
