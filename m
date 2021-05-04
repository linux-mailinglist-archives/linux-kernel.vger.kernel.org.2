Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8B2372819
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 11:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhEDJay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 05:30:54 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:38564 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhEDJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 05:30:53 -0400
Date:   Tue, 04 May 2021 09:29:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1620120596;
        bh=8iedi1sBuOfuU+AkuHmOzKPH2PiTW40aDNApIMiPXLA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=tAiyHvRC8v8kPq68agftdrYPHDxDVNL7m4bPC7JlHMKGC8VOcVvgzDhHnEDilDOGQ
         wOIzmq7e59KCBq+O2mcWmQFdfko89fvthHPX8BlVJ3K8UjGHpp9677/lZd3+DwWihW
         ySBr9RH/6OcaFlob4DSW6VB8XvCWxfg293MAPBBuGJb7Cs6nrBOwhPSWSRA7KkHG4U
         jXzhFWc5FZPlbg6BO45/YgDUuz1rBG0R+5QCmR32EkJ/oyf6b2iufODTMdQBuK8dSf
         rZuFyvoMjozWTMPVbOaHnEWcS/JsbAvEgy1IlsalVXfKuU7RNelAkP0cJ26qji1ibV
         MwepNZanJfCpg==
To:     Peter Xu <peterx@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr>
In-Reply-To: <20210429183836.GF8339@xz-x1>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr> <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com> <20210429154807.hptls4vnmq2svuea@box> <20210429183836.GF8339@xz-x1>
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

On Tuesday, April 27th, 2021 at 6:51 PM, Linus Torvalds <torvalds@linux-fou=
ndation.org> wrote:

> Hmm. It doesn't look too hard to do. The biggest problem is actually
> that we've run out of flags in the vma (on 32-bit architectures), but
> you could try this UNTESTED patch that just does the MAP_NOFAULT thing
> unconditionally.

Oh, thanks for the patch! Will test.

> Side note: this will only ever work for non-shared mappings. That's
> fundamental. We won't add an anonymous page to a shared mapping, and
> do_anonymous_page() does verify that. So a MAP_SHARED mappign will
> still return SIGBUS even with this patch (although it's not obvious
> from the patch - the VM_FAULT_SIGBUS will just be re-created by
> do_anonymous_page()).
>
> So if you want a _shared_ mapping to honor __MAP_NOFAULT and insert
> random anonymous pages into it, I think the answer is "no, that's not
> going to be viable".
>
> So _if_ this works for you, and if it's ok that only MAP_PRIVATE can
> have __MAP_NOFAULT, and if Kirill/Peter/Will don't say "Oh, Linus,
> you're completely off your rocker and clearly need to be taking your
> meds", something like this - if we figure out the conditional bit -
> might be doable.

Hm, that's unfortunate. For the use-case of a Wayland compositor this
doesn't seem like a complete show-stopper: in 90% of cases the compositor
only needs a read-only mapping. Wayland clients submit buffers they're
rendered pixels to, compositors only need to read them. So the compositor
could map with MAP_PRIVATE and still get up-to-date pages from a client
process I think.

The remaining 10% is when the compositor needs a writable mapping for
things like screen capture. It doesn't seem like a SIGBUS handler can
be avoided in this case then=E2=80=A6 Oh well.

> That's a fair number of "ifs".
>
> Ok, back to the merge window for me, I'll be throwing away this crazy
> untested patch immediately after hitting "send". This is very much a
> "throw the idea over to other people" patch, in other words.

Got it. I'll take over the patch if this is a good way forward.

