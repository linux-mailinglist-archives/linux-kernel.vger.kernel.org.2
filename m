Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE0396D53
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhFAG0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFAG0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:26:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB0CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 23:24:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q7so20033624lfr.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 23:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtIHbTQEWZy03u+F/1bX9f+NRkMDtukdZ6wYfFJ5x2k=;
        b=XgRh5D8kPOBUFMoADvss3cc0DR+uLPy1UvRB6CNpi0uy2MKHLssEm9xlNM8k8vofWB
         M6H/dPrzWE78mQwAP9igsuCAeZYDAU+LOsg8UtnsTfENk5jFRwd2PYwVN+NzbLsRSOYB
         3CBlfXdSCpwLafhzh9ucwlfibNxyaOWr+V0jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtIHbTQEWZy03u+F/1bX9f+NRkMDtukdZ6wYfFJ5x2k=;
        b=aG1ebOjtA+ZsNK5ORpWwRjr5wRlBLCvsRDxpLw3SkbfPNj6GSKWoybFO7MYlc+1QBX
         dX6cfxJuq6/wkO3/UkbQlc5c5ZsXfdJh7zB3RHgEuJMEpN46D1K2ricgmR8k0uCWcc1o
         FlinRt9i49WDRupvDK+bquyYQLKtUCV55/P2ExwH90uW8Tu6dP1uk0EAyvqDQZxzmcM/
         VdCo6j7w1WEURI/2JgzJRR/KLAITRP7nKwK/oxjOwBaqK+ZD2iWm50q0ys/F87g032Dj
         nPpdfWkK6LvOLj3akWBeERZHvm0h9NC4Vse5lFGLhZIjwMurgFJBVoOJwHNiNbbdmlAs
         SrkA==
X-Gm-Message-State: AOAM531AojSHyntcy1hRukl+EF9behKPEWiwLLIJn1+9fYGzKiVYH17s
        WJKHQi2qSf0oSC/L2BNt5fQSp5Z/wei/nymv
X-Google-Smtp-Source: ABdhPJwu1lQH04W97FNLvmNLEE3iHDc9Y8K0PdRvIsT+32QlelA3xzWa4k6fWKBAIdfoZkB07oYM/Q==
X-Received: by 2002:ac2:5cd6:: with SMTP id f22mr9945435lfq.73.1622528664867;
        Mon, 31 May 2021 23:24:24 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id n5sm1578848lft.139.2021.05.31.23.24.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 23:24:24 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id q1so20037476lfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 23:24:23 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr11385070lfa.421.1622528663766;
 Mon, 31 May 2021 23:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
 <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
 <20210429154807.hptls4vnmq2svuea@box> <20210429183836.GF8339@xz-x1>
 <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr>
 <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
 <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr>
 <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com>
 <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com> <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com>
 <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com> <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com>
 <alpine.LSU.2.11.2105291315330.25425@eggly.anvils> <36fc2485-11f1-5252-904d-f26b63a6cd58@gmail.com>
 <e7454046-c071-888d-f673-276f9c24d9d3@gmail.com>
In-Reply-To: <e7454046-c071-888d-f673-276f9c24d9d3@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 May 2021 20:24:07 -1000
X-Gmail-Original-Message-ID: <CAHk-=whce3vmj+g7jcE0rasoDavJutxno3ZZrvvWYQywWXH31Q@mail.gmail.com>
Message-ID: <CAHk-=whce3vmj+g7jcE0rasoDavJutxno3ZZrvvWYQywWXH31Q@mail.gmail.com>
Subject: Re: Sealed memfd & no-fault mmap
To:     Ming Lin <minggr@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Simon Ser <contact@emersion.fr>,
        Peter Xu <peterx@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 11:13 AM Ming Lin <minggr@gmail.com> wrote:
>
> OK, I borrowed code from filemap_xip.c and implemented this behavior.

I think that "unmap page" is too complicated and fragile.

The only page that could possibly validly be unmapped is a stale zero
page, but that code in shmem_unmap_nofault_page() seems to try to
handle other cases too (ie that whole page_remove_rmap() - afaik a
zero page has no rmap).

I get the feeling that the simpler thing to do is to just say "if you
use MAP_NOSIGBUS, and you access pages that don't have a backing
store, you will get zero pages, and they will NOT BE SYNCHRONIZED with
the backing store possibly later being updated".

IOW, just document the fact that a MAP_NOSIGBUS mapping isn't coherent
wrt shmem contents that are expanded and filled in later.

Don't try to "fix" it - because any user that uses MAP_NOSIGBUS had
better just accept that it's not compatible with expanding the shmem
backing store later.

Keep it simple and stupid. Hmm?

                  Linus
