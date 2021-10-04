Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD536421700
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhJDTI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhJDTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:08:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3EAC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7zYvaCcq57Js9HjY/9WIt0IYEIm/CuFzck0eVZIai9g=; b=vyk2lzF+2IZ/khyEnmhSkvPS8E
        VyUjFIxDfsc0bA6aExl92KlG4k5UD1AcK6KPGMjadqdtLDM3pf4ofruHu5qW0Is4kgOb8kfv+yY/3
        ZPQkg+HHdKFPxLcUF2WH0oKOLxK9/EG2AJbvBSMwC34Kn4CnucZtXKTUjy/mkqsUQm0CvicuvlcFa
        yL/oWXGOuNiJ1o9fNWzVLRErw7emIqwqDACX2xsp6Tc8bnAqElrZ2vqFZmrE4w4184QujRnofHMxO
        KZ9jhxS6EF46riwLNtFOFqxUAvfOPtvQTaMgfhdpUKmSJQaZhvc7Djco/xhBTyCa3as+fP7RLle7c
        XwRlbf1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXTGx-00HDiE-U4; Mon, 04 Oct 2021 19:05:35 +0000
Date:   Mon, 4 Oct 2021 20:05:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     Song Liu <song@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Message-ID: <YVtQZ1vxhe/W+adm@casper.infradead.org>
References: <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
 <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org>
 <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <YVT+KWFA8hfSKU+m@casper.infradead.org>
 <CAPhsuW7tDh2cbA6QpZ993fuwOK=LKVsDYjymA4983riQw4QTkA@mail.gmail.com>
 <8d8fb192-bd8d-8a08-498d-ca7204d4a716@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d8fb192-bd8d-8a08-498d-ca7204d4a716@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 01:26:50AM +0800, Rongwei Wang wrote:
> Hi,
> I have run our cases these two days to stress test new Patch #1. The new
> Patch #1 mainly add filemap_invalidate_{un}lock before and after
> truncate_pagecache(), basing on original Patch #1. And the crash has not
> happened.

You shouldn't need most of patch 1.

In fact, the only two patches you should need would be this:

+++ b/mm/filemap.c
@@ -2093,7 +2093,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
                if (!xa_is_value(page)) {
                        if (page->index < start)
                                goto put;
-                       VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
                        if (page->index + thp_nr_pages(page) - 1 > end)
                                goto put;
                        if (!trylock_page(page))

(already in Andrew's tree) and:

> -               if (filemap_nr_thps(inode->i_mapping))
> +               if (filemap_nr_thps(inode->i_mapping)) {
> +                       filemap_invalidate_lock(inode->i_mapping);
>                         truncate_pagecache(inode, 0);
> +                       filemap_invalidate_unlock(inode->i_mapping);
> +               }

If you can still hit a bug with just those two patches, then something
else is going wrong, and needs to be investigated.
