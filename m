Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3401A373880
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhEEKWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:22:32 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:18132 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbhEEKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:22:31 -0400
Date:   Wed, 05 May 2021 10:21:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1620210093;
        bh=3RksiCH8cPtPlWk0to7nyL1y138c0K4MSYx/+808EYk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=L1Pf1yT46Pzxfe9OzxG4g/ti/bt8/pX5+BOv5cn5Hz1sSX9ArWdWJg04JoFgxBkwa
         lDfZzBVdd1Sav2gpsHuJn2YY4i6ttsQ+Nt0Csvk03Dwi3hl977iSpRboqdkcK/J2Mu
         C3aENO9x9pWrufKsAjf4NtiQ6ipf9+sfrJWQhfxPRA6DF1JxscCIxyAp066yD0sFv/
         YcqRgPcCB7L3QDz4wCB8zNm6DX9HIJ1Uu44qS+A0vmsW5g1Y5PTRFOkn48UUStNFkN
         0l5iHCe2E18xiuCdXN40ST7SqCOwtbKPTnnJmWeBTROq3wFUS66UiV/lPYniRgrmL2
         1ykVAgbWiw+ew==
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Peter Xu <peterx@redhat.com>,
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
Message-ID: <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr>
In-Reply-To: <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr> <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com> <20210429154807.hptls4vnmq2svuea@box> <20210429183836.GF8339@xz-x1> <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr> <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
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

On Tuesday, May 4th, 2021 at 6:08 PM, Linus Torvalds <torvalds@linux-founda=
tion.org> wrote:

> On Tue, May 4, 2021 at 2:29 AM Simon Ser contact@emersion.fr wrote:
>
> > The remaining 10% is when the compositor needs a writable mapping for
> > things like screen capture. It doesn't seem like a SIGBUS handler can
> > be avoided in this case then=E2=80=A6 Oh well.
>
> So as Peter Xu mentioned, if we made it a "per inode" thing, we
> probably could make such an inode do the zero page fill on its own,
> and it might be ok for certain cases even for shared mappings.
> However, realistically I think it's a horrible idea for the generic
> situation, because I think that basically requires the filesystem
> itself to buy into it. And we have something like 60+ different
> filesystems.
>
> Is there some very specific and targeted pattern for that "shared
> mapping" case? For example, if it's always a shared anonymous mapping
> with no filesystem backing, then that would possibly be a simpler case
> than the "random arbitrary shared file descriptor".

Yes. I don't know of any Wayland client using buffers with real
filesystem backing. I think the main cases are:

- shm_open(3) immediately followed by shm_unlink(3). On Linux, this is
  implemented with /dev/shm which is a tmpfs.
- Abusing /tmp or /run's tmpfs by creating a file there and unlinking
  it immediately afterwards. Kind of similar to the first case.
- memfd_create(2) on Linux.

Is this enough to make it work on shared memory mappings? Is it
important that the mapping is anonymous?

Thanks,

Simon
