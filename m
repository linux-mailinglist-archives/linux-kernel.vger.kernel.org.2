Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2200394E21
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhE2URj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhE2URi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:17:38 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:16:00 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so6994236otc.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BPVIrimcUkfawrwhxQJhVkAGWp3nHZ+YOSsJJY8v6L4=;
        b=iQuuVP1mw7xS0oVBuoDB1d2rU7OlpTlPqQ0IaVF0yHf2MpVMWfXkFC10qrv82uK2U5
         SaHZuldF3r+r9sN2vf5poLCMNhCiw4T8OEEPsPGO2inlx4AVYBfiPjqYWQc57fm9xoIa
         ejdT9ZuCdr9nMc8TrFAl9+Ev6zQ7ln+rF4i9BC2opwJbJNv69xOAoIlEWPJQXRJYRXi+
         ajbKAIHElv4gkPByhQwih2Q/ZBU4ROJ9j4hVaNlMeLq6baigRAKk9P//pAyrnb2ekZ4D
         FMTGvqkCcv5vyvxVHB+ZBzLNos7mM7KanS1freHJ0lyGJ9wf1pZbTAw4mI8Ugvzymf0m
         aTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=BPVIrimcUkfawrwhxQJhVkAGWp3nHZ+YOSsJJY8v6L4=;
        b=CmT7bg9gxpgu/D9ZUjygeLFmg7yXr6c5UaFNOitm/F/BsVdM4tJI7soAJABfsYDygm
         2t2N+x1APIqaHXUK6fXhELp+TqyNlke76HXTsCa2ZGibXSpW0k28DbikVVWPwTovPYCs
         saPi2rcg1KTZhXm54GHIZBcAFrCeW0hl7i4XlO7V/YH43EI/LTOG/WPfwxrubA7vCmRz
         2nybAZrzKU4oErSh2sVrkt+eLW6r/c8SUrz+QwnbOjUwCzJiO0K8etgPDr0Iw5ZDDiC6
         /XPDDm+RbrYuhsdIPAuAxG/FfFW4znJ5u3Ibb9UJ9SbCQXUvBwpaWioeIhWxyshTAKOd
         u48Q==
X-Gm-Message-State: AOAM531gBVPwfGfSZdjWdwU8TA5GRO3OYBDVeDovv5JwRfqLMy6+jPIH
        vyPvoSznShOo1V0WRn8ipTNonA==
X-Google-Smtp-Source: ABdhPJyogzismKVV0E3uH+Va7htgK3+100Crb5uZ5iQLOJ94MJxXUtOjoTQEOG1L0pIBZB5Ej+gMHQ==
X-Received: by 2002:a9d:7315:: with SMTP id e21mr12058931otk.288.1622319359862;
        Sat, 29 May 2021 13:15:59 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r2sm1972883otq.28.2021.05.29.13.15.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 29 May 2021 13:15:59 -0700 (PDT)
Date:   Sat, 29 May 2021 13:15:43 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     "Lin, Ming" <minggr@gmail.com>, Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>, Peter Xu <peterx@redhat.com>,
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
Subject: Re: Sealed memfd & no-fault mmap
In-Reply-To: <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2105291315330.25425@eggly.anvils>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr> <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com> <20210429154807.hptls4vnmq2svuea@box>
 <20210429183836.GF8339@xz-x1> <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr> <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
 <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr> <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com> <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com>
 <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com> <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com> <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2021, Linus Torvalds wrote:
> On Fri, May 28, 2021 at 9:31 PM Lin, Ming <minggr@gmail.com> wrote:
> >
> > I should check the vma is not writable.
> >
> > -               if (!IS_NOFAULT(inode))
> > +               if (!IS_NOFAULT(inode) || (vma->vm_flags & VM_WRITE))
> >                          return -EINVAL;
> 
> That might be enough, yes.
> 
> But if this is sufficient for the compositor needs, and the rule is
> that this only works for read-only mappings, then I think the flag in
> the inode becomes the wrong thing to do.
> 
> Because if it's a read-only mapping, and we only ever care about
> inserting zero pages into the page tables - and they never become part
> of the shared memory region itself, then it really is purely about
> that mmap, not about the shm inode.
> 
> So then it really does become purely about one particular mmap, and it
> really should be a "madvise()" issue, not a "mark inode as no-fault".

Yes, madvise or mmap flag: the recipient of this fd ought not to be
(even capable of) interfering with other maps of the shared object.

And IIUC it would have to be the recipient (Wayland compositor) doing
the NOFAULT business, because (going back to the original mail) we are
only considering this so that Wayland might satisfy clients who predate
or refuse Linux-only APIs.  So, an ioctl (or fcntl, as sealing chose)
at the client end cannot be expected; and could not be relied on anyway.

> 
> I'd almost be inclined to just add a new "flags" field to the vma.
> We've been running out of vma flags for a long time, to the point that
> some of them are only available on 64-bit architectures.
> 
> I get the feeling that we should just bite the bullet and make
> "vm_flags" be an u64. Or possibly make it two explicitly 32-bit
> entities (vm_flags and vm_extra). Get rid of the silly 64-bit-only
> "high" flags, and get rid of our artificial "we don't have enough
> bits".

u64 saves messing around in the vma_merge() area, which has to
consider whether adjacent vm_flags are identical.

> 
> Because we already in practice *do* have enough bits, we've just
> artificially limited ourselves to "on 32-bit architectures we only
> have 32 bits in that field".

Yes, that artificial limitation to 32-bit has been silly all along.

> 
> But all of this is very much dependent on that "this NOFAULT case
> really only works for reads, not for writes".
> 
> (Alternatively, we could allow the *mapping* itself to be writable,
> but always fault on writes, and only insert a read-only zero page)

NOFAULT? Does BSD use "fault" differently, and in Linux terms we
would say NOSIGBUS to mean the same?

Can someone point to a specification of BSD's __MAP_NOFAULT?
Searching just found me references to bugs.

What mainly worries me about the suggestion is: what happens to the
zero page inserted into NOFAULT mappings, when later a page for that
offset is created and added to page cache?

Treating it as an opaque blob of zeroes, that stays there ever after,
hiding the subsequent data: easy to implement, but a hack that we would
probably regret.  (And I notice that even the quote from David Herrmann
in the original post allows for the possibility that client may want to
expand the object.)

I believe the correct behaviour would be to unmap the nofault page
then, allowing the proper page to be faulted in after.  That is
certainly doable (the old mm/filemap_xip.c used to do so), but might
get into some awkward race territory, with filesystem dependence
(reminiscent of hole punch, in reverse).  shmem could operate that
way, and be the better for it: but I wouldn't want to add that,
without also cleaning away all the shmem_recalc_inode() stuff.

Hugh
