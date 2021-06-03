Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D6B39A1F5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhFCNQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:16:36 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:57266 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhFCNQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:16:35 -0400
Date:   Thu, 03 Jun 2021 13:14:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1622726088;
        bh=zvZG+KNrKsbetpCBgPErfPJwO6MpNxHlXwG7DMuT3J4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=KLrPCUk/xa/J4AxaB3vZpUw7LDGaakyDvn37cAL+jfr6vlg3jC9MKqq4hzM964NPJ
         rmUciJgUMX39tk9SLPMJFZk+tfBtXMpf7/nrMNMmX3rvnSLAG3zrE+97SAmhW0b+A5
         WogkweWoBKYwmlq8mBE0WpdmRJNElUBKxUknUA48lODDpXmIB0KYKTgAeNKb9TvVQr
         ox1IHZ6HZ1llIuCu3Tc4gYYDnZRx/igojes/AqkbR7UU3321vI5dwusDAY1CQmgjNF
         M7AcT9L6ZKQd05h89IaNJd06AhsftywLt25vOHSMVBZTq4ZEnyu7NmOwASb5AqriVz
         3pfpv8akEgz2A==
To:     Hugh Dickins <hughd@google.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Lin, Ming" <minggr@gmail.com>, Peter Xu <peterx@redhat.com>,
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
Message-ID: <d9rpd_hm_ereswX76EqjEGkqfjFFSi-N_yj8b1pj4MZMFy-fpiicN_XrHl13sXqkkgzAJqZEy1roQsVklWEhY38-olslcbO34GB0YcjHks8=@emersion.fr>
In-Reply-To: <alpine.LSU.2.11.2105291315330.25425@eggly.anvils>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr> <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com> <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr> <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com> <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com> <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com> <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com> <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com> <alpine.LSU.2.11.2105291315330.25425@eggly.anvils>
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

On Saturday, May 29th, 2021 at 10:15 PM, Hugh Dickins <hughd@google.com> wr=
ote:

> And IIUC it would have to be the recipient (Wayland compositor) doing
> the NOFAULT business, because (going back to the original mail) we are
> only considering this so that Wayland might satisfy clients who predate
> or refuse Linux-only APIs.  So, an ioctl (or fcntl, as sealing chose)
> at the client end cannot be expected; and could not be relied on anyway.

Yes, that is correct.

> NOFAULT? Does BSD use "fault" differently, and in Linux terms we
> would say NOSIGBUS to mean the same?
>
> Can someone point to a specification of BSD's __MAP_NOFAULT?
> Searching just found me references to bugs.

__MAP_NOFAULT isn't documented, sadly. The commit that introduces the
flag [1] is the best we're going to get, I think.

> What mainly worries me about the suggestion is: what happens to the
> zero page inserted into NOFAULT mappings, when later a page for that
> offset is created and added to page cache?

Not 100% sure exactly this means what I think it means, but from my PoV,
it's fine if the contents of an expanded shm file aren't visible from the
process that has mapped it with MAP_NOFAULT/MAP_NOSIGBUS. In other words,
it's fine if:

- The client sets up a 1KiB shm file and sends it to the compositor.
- The compositor maps it with MAP_NOFAULT/MAP_NOSIGBUS.
- The client expands the file to 2KiB and writes interesting data in it.
- The compositor still sees zeros past the 1KiB mark. The compositor needs
  to unmap and re-map the file to see the data past the 1KiB mark.

If the MAP_NOFAULT/MAP_NOSIGBUS flag only affects the mapping itself and
nothing else, this should be fine?

> Treating it as an opaque blob of zeroes, that stays there ever after,
> hiding the subsequent data: easy to implement, but a hack that we would
> probably regret.  (And I notice that even the quote from David Herrmann
> in the original post allows for the possibility that client may want to
> expand the object.)
>
> I believe the correct behaviour would be to unmap the nofault page
> then, allowing the proper page to be faulted in after.  That is
> certainly doable (the old mm/filemap_xip.c used to do so), but might
> get into some awkward race territory, with filesystem dependence
> (reminiscent of hole punch, in reverse).  shmem could operate that
> way, and be the better for it: but I wouldn't want to add that,
> without also cleaning away all the shmem_recalc_inode() stuff.

[1]: https://github.com/openbsd/src/commit/37f480c7e4870332b7ffb802fa6578f5=
47c8a19f
