Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B239A2A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhFCOAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhFCOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:00:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C856DC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+FpiVrMEbOqRGaeMB09DrnctJgDKR4e1rzAT2/F3j5Y=; b=NzEdjOLTc4TIfA385DUiwiv9uV
        tBRBe3N2XKdxbiVKP2gfi1QztN63Cup2qCX3MbRjB/QeuyreB1xU+/uVGph1xSO5bUCz60LdN4xXH
        om/LQGbAcdREA/zxcdr4Tn1ZzKZ9D9LpxDJzfEtC1VRNGjce5AKHdEFnb95/hIu5vhUrcgsXYZFvf
        uR089iqb2JiFxtDsv5yLPfjcVvVLWeUpkam2Puv48OcScdMikD0QxxIjMQiha9mSm9xAvWuQFa5BL
        j7z6SdJMZQt7i55LI2t8fiEe9cdguaeaCp/TfFNzrRzkK3787Sf4Jww6V5iLlY+nu0JqKYqV+DjlC
        uXuOymzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lonqu-00CDEP-Lu; Thu, 03 Jun 2021 13:57:45 +0000
Date:   Thu, 3 Jun 2021 14:57:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Simon Ser <contact@emersion.fr>
Cc:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Lin, Ming" <minggr@gmail.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: Sealed memfd & no-fault mmap
Message-ID: <YLjf1Hmrkfwc5xUW@casper.infradead.org>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
 <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
 <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr>
 <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com>
 <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com>
 <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com>
 <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com>
 <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com>
 <alpine.LSU.2.11.2105291315330.25425@eggly.anvils>
 <d9rpd_hm_ereswX76EqjEGkqfjFFSi-N_yj8b1pj4MZMFy-fpiicN_XrHl13sXqkkgzAJqZEy1roQsVklWEhY38-olslcbO34GB0YcjHks8=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9rpd_hm_ereswX76EqjEGkqfjFFSi-N_yj8b1pj4MZMFy-fpiicN_XrHl13sXqkkgzAJqZEy1roQsVklWEhY38-olslcbO34GB0YcjHks8=@emersion.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 01:14:47PM +0000, Simon Ser wrote:
> On Saturday, May 29th, 2021 at 10:15 PM, Hugh Dickins <hughd@google.com> wrote:
> 
> > And IIUC it would have to be the recipient (Wayland compositor) doing
> > the NOFAULT business, because (going back to the original mail) we are
> > only considering this so that Wayland might satisfy clients who predate
> > or refuse Linux-only APIs.  So, an ioctl (or fcntl, as sealing chose)
> > at the client end cannot be expected; and could not be relied on anyway.
> 
> Yes, that is correct.
> 
> > NOFAULT? Does BSD use "fault" differently, and in Linux terms we
> > would say NOSIGBUS to mean the same?
> >
> > Can someone point to a specification of BSD's __MAP_NOFAULT?
> > Searching just found me references to bugs.
> 
> __MAP_NOFAULT isn't documented, sadly. The commit that introduces the
> flag [1] is the best we're going to get, I think.
> 
> > What mainly worries me about the suggestion is: what happens to the
> > zero page inserted into NOFAULT mappings, when later a page for that
> > offset is created and added to page cache?
> 
> Not 100% sure exactly this means what I think it means, but from my PoV,
> it's fine if the contents of an expanded shm file aren't visible from the
> process that has mapped it with MAP_NOFAULT/MAP_NOSIGBUS. In other words,
> it's fine if:
> 
> - The client sets up a 1KiB shm file and sends it to the compositor.
> - The compositor maps it with MAP_NOFAULT/MAP_NOSIGBUS.
> - The client expands the file to 2KiB and writes interesting data in it.
> - The compositor still sees zeros past the 1KiB mark. The compositor needs
>   to unmap and re-map the file to see the data past the 1KiB mark.
> 
> If the MAP_NOFAULT/MAP_NOSIGBUS flag only affects the mapping itself and
> nothing else, this should be fine?

This is going to operate at a page boundary, so the example you gave
will work.  How about this:

 - The client sets up a 1KiB shm file and sends it to the compositor.
 - The client expands the file to 5KiB
 - The compositor sees the new data up to 4KiB but zeroes past the 4KiB
   mark.

Does that still make userspace happy?
