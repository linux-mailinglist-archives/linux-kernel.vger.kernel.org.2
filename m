Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B33E22A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 06:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbhHFEey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 00:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbhHFEek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 00:34:40 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC48DC06179A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 21:34:24 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w6so10422163oiv.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 21:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=zoxn86tI0OeId1+HsMFj7XfTnI0a8mb/MBGQLX/EXMQ=;
        b=vHJ6XPyUZn6HJNpOvReBw9udckcsYokef5di4Syl6LKnkAactsc4UI9tj9lhQKRc0p
         i/+4HPQobOZvRyjNn4Zebf2F1yOcSKsOn5V8tBuYKsk+PFIOtt1jrMEl8xd9Ztx5wzIT
         n1MAnsVD+YiW8TTm0+g7+a2VsbVcGvGNym6KWmauxtV7zjI5v3XCM763w7dEODDSFNa4
         uQvcfkiiE2EZApZ+s4qyMeJUKiqubOkwcYJT9ybNscj3gYQHSv5qHjzvedj9jcAMlbI6
         Hf1bmO06V/2hWuag9tcb5QyIhNQNwLNAoczuTesYJsa7F0HDtlZdIRlHkTJLI4nHQAol
         9/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=zoxn86tI0OeId1+HsMFj7XfTnI0a8mb/MBGQLX/EXMQ=;
        b=kiRZjRmxbP6gVBRyxTrBhh8mLNfFAdtMg7QHPMP0jnyZCUb75QlGZ9R06niPZRr6Aq
         A9IPyL1f36eZbFUTH8o1u80ERMGBTI4E4OnVqsZY0Hwz3L0f3m9XXfTJns1fa7Ot6erI
         I+oO/t7AtvoGl3gRGft+QzCJdyp2nj5/4wMnf9IAQzjquUaydcDIfbTfcmcrLDeO5KDi
         dG0IJosDaM+3Gi3u4KWXoigR+jdcbtpX1P9R56otMf1LAg+Pf1Aesc5lzQO3lqFmimLE
         rY9k/zrelHB4jCgrrYpc9Jkj+ELraCnJtXda5+XWi1ToiqWQdVbz8aa9XGUwIDC96TfX
         8Mng==
X-Gm-Message-State: AOAM533LdFsMD+tNbvjtRiQ84g2jqNMVH2/2YAXnfew3mPQJzBrnOy2h
        cvtt7vu1vzoDlHj3IiKGQIfe9g==
X-Google-Smtp-Source: ABdhPJy5u56QxNQUqymSFnehqcKPsPChropjc6cHc2YkxdrkZ0dZqTbexTDkIM8YqLF7bAvQLHej5w==
X-Received: by 2002:aca:b909:: with SMTP id j9mr13116203oif.9.1628224463623;
        Thu, 05 Aug 2021 21:34:23 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n1sm1358979otk.34.2021.08.05.21.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 21:34:22 -0700 (PDT)
Date:   Thu, 5 Aug 2021 21:34:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/16] huge tmpfs: fcntl(fd, F_HUGEPAGE) and fcntl(fd,
 F_NOHUGEPAGE)
In-Reply-To: <20210804140805.vpuerwaiqtcvc5or@box.shutemov.name>
Message-ID: <caf82af1-1412-c8d7-e622-4f391689f8fe@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <1c32c75b-095-22f0-aee3-30a44d4a4744@google.com> <20210804140805.vpuerwaiqtcvc5or@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2021, Kirill A. Shutemov wrote:
> On Fri, Jul 30, 2021 at 12:48:33AM -0700, Hugh Dickins wrote:
> > Add support for fcntl(fd, F_HUGEPAGE) and fcntl(fd, F_NOHUGEPAGE), to
> > select hugeness per file: useful to override the default hugeness of the
> > shmem mount, when occasionally needing to store a hugepage file in a
> > smallpage mount or vice versa.
> 
> Hm. But why is the new MFD_* needed if the fcntl() can do the same.

That I've just addressed in the MFD_HUGEPAGE 07/16 thread.

> 
> > These fcntls just specify whether or not to try for huge pages when
> > allocating to the object later: F_HUGEPAGE does not touch small pages
> > already allocated (though khugepaged may do so when the file is mapped
> > afterwards), F_NOHUGEPAGE does not split huge pages already allocated.
> > 
> > Why fcntl?  Because it's already in use (for sealing) on memfds; and I'm
> > anxious to keep this simple, just applying it to whole files: fallocate,
> > madvise and posix_fadvise each involve a range, which would need a new
> > kind of tree attached to the inode for proper support.
> 
> Most of fadvise() operations ignore the range. I like fadvise() because
> it's less prescriptive: kernel is free to ignore it.

As to ignoring the range, yes, I see now that some do; and I'm relieved
to see "Len == 0 means as much as possible", that's great, I was afraid
of compat bugs over 0xffy numbers for the len.  And we would want, not
to ignore the range, but insist on offset 0, len 0 for now, if there's
any intention (not mine) of extending it to ranges in the future.

As to ignoring the prescription, that's just a matter of how we describe
it in the manpage, no matter whether it's fadvise() or fcntl().

And in the 07/16 thread you also said:

> 
> If a tunable needed, I would rather go with fadvise(). It would operate on
> a couple of bits per struct file and they get translated into VM_HUGEPAGE
> and VM_NOHUGEPAGE on mmap().

Not so sure about that detail: the point here is to decide what kind
of allocations to try for, before the file is mmap()ed; and it is the
file (the underlying object) that I want to condition here, rather than
the struct file of who has it open at the time, or their mmap()s.

But adding the flags into the vm_flags on mmap(): that's an interesting
idea, I haven't played with that at all.  Offhand, I don't think it will
give different allocation results from what I'm already doing, but might
affect what is shown by default in /proc/<pid>/smaps.

> 
> Later if needed fadvise() implementation may be extended to track
> requested ranges. But initially it can be simple.

I still prefer fcntl() myself, but we can go with either: what I'd
like to hear is the preference of linux-fsdevel and linux-api people.

Aside from the unused offset+len, my main problem with fadvise()
is that... it doesn't exist.  It's posix_fadvise() or fadvise64() or
fadvise64_64(), and all its good advices are POSIX_MADV_whatever.

Are we comfortable now adding LINUX_MADV_HUGEPAGE, LINUX_MADV_NOHUGEPAGE?

I find myself singing 64 64 Zoo Lane.

Hugh
