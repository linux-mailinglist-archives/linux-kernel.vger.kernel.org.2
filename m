Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B551341D0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347571AbhI3Ank (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346375AbhI3Anj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:43:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95BFE6141B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 00:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632962515;
        bh=PzetvSIBH0nHpjCfkosGz8w0xF2AGOfvYn0PYl9uTnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tHvGnAUf2p03b4VuiJlJfEM+cqdXsba27y9R93f4IpUYRSkbLucFCoC9EPQCA81sy
         oe6z4UkdAJMLpSJV8fLHNExXRrNozxgkA2WouD9CbJjHYyfJxh9DHj7dvLmrzdb2Lp
         kt2+H+IDJ0er4JQ/Jw5JblySNWGW1m00bwLXSsoOMSwlJIVt6iEzJ1Yo6CbRr+96Oc
         zfi8yWT4clw0Zl6t696CARtj4As/eWMBpcf86/LMty9qE1xGUNU+iVgkLq0Ej7vemh
         AKjSTIgiYe4vOZ7xquPcFGNYQoujqZw1q+OZoDCpAzYkhKiWYmB4XOTU8hJASdO+0Y
         7CZqIaglHXUVg==
Received: by mail-lf1-f43.google.com with SMTP id i4so18161948lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:41:55 -0700 (PDT)
X-Gm-Message-State: AOAM532eVHZvVY0MKO6XdiDTlodqA5BSmWVMxu4rDVUi5M5Y8BYFXRoL
        2TbEGAyVcw2jYu0fZBxrct+Ro5fUglKo3ojrw0k=
X-Google-Smtp-Source: ABdhPJyU9LE9+AHlG14cUPmwptUw4qZfXBv+4L08C0l2TA+wwHe38NDg2yVT4ofzU924KGEOpJ5pkWYk5EglNPXQuy0=
X-Received: by 2002:ac2:5617:: with SMTP id v23mr2775768lfd.114.1632962513928;
 Wed, 29 Sep 2021 17:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
 <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com> <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com> <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com> <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org> <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <YVT+KWFA8hfSKU+m@casper.infradead.org>
In-Reply-To: <YVT+KWFA8hfSKU+m@casper.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 29 Sep 2021 17:41:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7tDh2cbA6QpZ993fuwOK=LKVsDYjymA4983riQw4QTkA@mail.gmail.com>
Message-ID: <CAPhsuW7tDh2cbA6QpZ993fuwOK=LKVsDYjymA4983riQw4QTkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page cache
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 5:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Sep 29, 2021 at 04:41:48PM -0700, Song Liu wrote:
> > The issue is NOT caused by concurrent khugepaged:collapse_file() and
> > truncate_pagecache(inode, 0). With some printks, we can see a clear
> > time gap (>2 second )  between collapse_file() finishes, and
> > truncate_pagecache() (which crashes soon). Therefore, my earlier
> > suggestion that adds deny_write_access() to collapse_file() does NOT
> > work.
> >
> > The crash is actually caused by concurrent truncate_pagecache(inode, 0).
> > If I change the number of write thread in stress_madvise_dso.c to one,
> > (IOW, one thread_read and one thread_write), I cannot reproduce the
> > crash anymore.
> >
> > I think this means we cannot fix this issue in collapse_file(), because it
> > finishes long before the crash.
>
> Ah!  So are we missing one or more of these locks:
>
>         inode_lock(inode);
>         filemap_invalidate_lock(mapping);
>
> in the open path?

The following fixes the crash in my test. But I am not sure whether this is the
best fix.

Rongwei, could you please run more tests on it?

Thanks,
Song


diff --git i/fs/open.c w/fs/open.c
index daa324606a41f..d13c4668b2e53 100644
--- i/fs/open.c
+++ w/fs/open.c
@@ -856,8 +856,11 @@ static int do_dentry_open(struct file *f,
                 * of THPs into the page cache will fail.
                 */
                smp_mb();
-               if (filemap_nr_thps(inode->i_mapping))
+               if (filemap_nr_thps(inode->i_mapping)) {
+                       filemap_invalidate_lock(inode->i_mapping);
                        truncate_pagecache(inode, 0);
+                       filemap_invalidate_unlock(inode->i_mapping);
+               }
        }

        return 0;
