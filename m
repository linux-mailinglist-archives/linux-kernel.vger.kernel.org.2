Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC9421C93
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhJEC2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhJEC2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:28:34 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AE3C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 19:26:45 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id z3so4382830qvl.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8cHPpsVizZea7NsbBw7SVnOsWB/6elo5w86EKzAOmIk=;
        b=j8DLVwTUpEAf6Y73mxShEhwi4H+DQpscONlj8i3Trup9IZM1OOuqRsEnn2w4sUqOSb
         B0+h1fbOcqYElpz7+3jKi943bfvpRx+sO6+ih7Ls1A4IAgB7nDqrn6wYnlhk4TTv6/01
         AlmNFEzTggVNRd7dEvu/H80Z/52RcszT9UpYLOmC5gu8Tc9mew6AK8y6iHDw3LdiqCm2
         /N/iIkiVr1cwGgitq+z9gjJd+tKbqX8+ZOSJhQSTsONflHCMs1gkmz609oXoL/tiCeGO
         phYPa9EqrK/cQGGsY/J2vWq2SF85ogcWz9AyQwtFr9/qoCQJAf8FYLdp9Ts11gAJ5Rs3
         kEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=8cHPpsVizZea7NsbBw7SVnOsWB/6elo5w86EKzAOmIk=;
        b=snrGGhKZ+vMihqWGdq3Ck+2054Wf493rcv/ERLv1RA9GMp+4PArnJAIJuguo3ErNJm
         lla2feWZRQQl9BXWYOh+D1B48sJYzRrF20zWK58BsWKcQj43kilSxuAKyit/wTIewz9B
         qjlKpsaZYa1leqTYhDCgIYcQ2lWj5X7IN/wbZ4JewCa3kNiyoGvrjAf7aKfCfMrsoFK3
         bC6A0UGjIeLKgSu4cIrst0rLVNYUJ2DuwdOsr/36P4fZILaPvUt6uKH5NdzaahfPeACZ
         eJ3ATXHGAMbgD63CRaKHK0NJHVVDEnUAjpvQA5weBCTPBVaxQcPrR49dLg5cNgh/leSD
         7aCQ==
X-Gm-Message-State: AOAM530sO7EzM6nP/GVMLaCW44mLgV/2GaJKLeN4fNi+3e0Tkw3U/KlB
        q3iZLRrufFoMiPIchPuDNuSqyg==
X-Google-Smtp-Source: ABdhPJzyonfVmn1mBoFuvKgBM5UYIT9oqXrt17Nhvj6nKQ/v3gorQs900qw5CuXCpbP+//3WR3Eluw==
X-Received: by 2002:ad4:4b09:: with SMTP id r9mr5044184qvw.10.1633400804146;
        Mon, 04 Oct 2021 19:26:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 130sm8713094qkh.99.2021.10.04.19.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 19:26:43 -0700 (PDT)
Date:   Mon, 4 Oct 2021 19:26:23 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Yang Shi <shy828301@gmail.com>, Hao Sun <sunhao.th@gmail.com>,
        Hugh Dickins <hughd@google.com>, Song Liu <song@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
In-Reply-To: <YVtWhVNFhLbA9+Tl@casper.infradead.org>
Message-ID: <a07564a3-b2fc-9ffe-3ace-3f276075ea5c@google.com>
References: <YVSopxYWegtQJ3iD@casper.infradead.org> <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com> <67906bf5-4de9-8433-3d70-cc8fc5cc2347@linux.alibaba.com> <CAPhsuW4_-ju9QgB7J4imrhQvH6ZqoOkVtVOVX11Yk_ZRakwQ+A@mail.gmail.com>
 <3d264ed9-f8fd-60d4-7125-f9f745ebeb52@google.com> <YVXXq0ssvW6P525J@casper.infradead.org> <f889db88-7b7d-ddb0-a7ed-3eda85d3eb96@google.com> <CAHbLzkq7=FsXtp4YcjeruJwbYyhsRGCq+eC8uwC-Tg06JBTUUA@mail.gmail.com> <YViSGYhn+zTShwFP@casper.infradead.org>
 <CAHbLzkosZr_ugNAMbXreUumSyAUMH1hPhTaiXXXRUNx88J9Xsw@mail.gmail.com> <YVtWhVNFhLbA9+Tl@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2021, Matthew Wilcox wrote:
> On Mon, Oct 04, 2021 at 11:28:45AM -0700, Yang Shi wrote:
> > On Sat, Oct 2, 2021 at 10:09 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Thu, Sep 30, 2021 at 10:39:14AM -0700, Yang Shi wrote:
> > > > On Thu, Sep 30, 2021 at 9:49 AM Hugh Dickins <hughd@google.com> wrote:
> > > > > I assume you're thinking of one of the fuzzer blkdev ones:
> > > > > https://lore.kernel.org/linux-mm/CACkBjsbtF_peC7N_4mRfHML_BeiPe+O9DahTfr84puSG_J9rcQ@mail.gmail.com/
> > > > > or
> > > > > https://lore.kernel.org/lkml/CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com/
> > > > >
> > > > > I haven't started on those ones yet: yes, I imagine one or both of those
> > > > > will need a further fix (S_ISREG() check somewhere if we're lucky; but
> > > > > could well be nastier); but for the bug in this thread, I expect
> > > >
> > > > Makes sense to me. We should be able to check S_ISREG() in khugepaged,
> > > > if it is not a regular file, just bail out. Sounds not that nasty to
> > > > me AFAIU.
> > >
> > > I don't see why we should have an S_ISREG() check.  I agree it's not the
> > > intended usecase, but it ought to work fine.  Unless there's something
> > > I'm missing?
> > 
> > Check out this bug report:
> > https://lore.kernel.org/lkml/CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com/
> > and the patch from me:
> > https://lore.kernel.org/linux-mm/20210917205731.262693-1-shy828301@gmail.com/
> > 
> > I don't think we handle buffers correctly for file THP, right? My
> > patch is ad hoc, so I thought Hugh's suggestion makes some sense to
> > me. Why do we have THP collapsed for unintended usecase in the first
> > place?
> 
> OK, I've done some more digging.  I think what's going on with this
> report is userspace opens the block device RO, causes the page cache to
> be loaded with data, then khugepaged comes in and creates THPs.

Yes.

> What confuses me is that these THPs have private data attached to them.
> I don't know how that happens.  If it's block device specific, then
> yes, something like your S_ISREG() idea should work fine.  Otherwise,
> we might need to track down another problem.

Agreed, the file THP is created without PagePrivate, so the puzzle was
why the read-only cached page would later become page_has_private().

The C repro showed that it uses (a BTRFS_IOC_ADD_DEV ioctl which might
not be relevant and) a BLKRRPART ioctl 0x125f: I didn't follow BLKRRPART
all the way down, but imagine it has to attach buffer-heads to re-read
the partition table.  Which would explain it.

Aside from that particular ioctl, it seems a good idea to insist on
S_ISREG just to shrink the attack surface: as Yang Shi says, executable
THP on block device was never an intended usecase, and not a usecase
anyone is likely to miss! And that fuzzer appears to delight in
tormenting /dev/nullb0, so let's just seal off that avenue.

You're right to have some doubt, as to whether there might be other
ways for buffer-heads to get attached, even on a read-only regular
file; but no way has sprung to my mind, and READ_ONLY_THP_FOR_FS has
survived well in its intended usage: so I think we should proceed on
the assumption that no further bugs remain - then fix them when found.

I wasn't able to reproduce the problem with the repro, would need to
waste many hours to do so.  But here's the untested S_ISREG patch I
came up with.  Sorry, I've mixed something else in: in moving the
alignment part to clarify the conditions, I was alarmed to see that
shmem with !shmem_huge_enabled was falling through to THP_FOR_FS to
give unexpected huge pages: fixed that, though later found there's
a separate shmem_huge_enabled() check which should exclude it.

--- 5.15-rc4/mm/khugepaged.c	2021-09-12 17:39:21.943438422 -0700
+++ linux/khugepaged.c	2021-10-03 20:41:13.194822795 -0700
@@ -445,22 +445,25 @@ static bool hugepage_vma_check(struct vm
 	if (!transhuge_vma_enabled(vma, vm_flags))
 		return false;
 
+	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
+					vma->vm_pgoff, HPAGE_PMD_NR))
+		return false;
+
 	/* Enabled via shmem mount options or sysfs settings. */
-	if (shmem_file(vma->vm_file) && shmem_huge_enabled(vma)) {
-		return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
-				HPAGE_PMD_NR);
-	}
+	if (shmem_file(vma->vm_file))
+		return shmem_huge_enabled(vma);
 
 	/* THP settings require madvise. */
 	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
 		return false;
 
 	/* Read-only file mappings need to be aligned for THP to work. */
-	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
-	    !inode_is_open_for_write(vma->vm_file->f_inode) &&
-	    (vm_flags & VM_EXEC)) {
-		return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
-				HPAGE_PMD_NR);
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	    (vm_flags & VM_EXEC) && vma->vm_file) {
+		struct inode *inode = vma->vm_file->f_inode;
+
+	        return !inode_is_open_for_write(inode) &&
+			S_ISREG(inode->i_mode);
 	}
 
 	if (!vma->anon_vma || vma->vm_ops)
