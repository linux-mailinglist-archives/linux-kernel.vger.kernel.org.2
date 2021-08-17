Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6523EE7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbhHQIEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhHQIEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:04:41 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E6BC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:04:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 22so12729101qkg.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=I3eCW0EJLWa0OXWClQfPVWKDZ0F0mvi6iBQTgK33L6k=;
        b=fAq+nzkSfaFBcy+WbLhLfyqEa3yM7MJcF9DRCaZxwaBikIW8Bdca7VuEm0+bEyMIHB
         xpVxEbKi6drCLlUUW2y6lFbcF7EediSc2LG9UbWp5yH6/YhFL0H/TdINaJpaKvF7vs5R
         Vff1sTmLCF1V/pBMwjddFsWGRjLf1Mzcd6ni8J6DZvJkd2jHFQVRdAOOgybm2THIsRRV
         PEyWoEvSCifPjrXEoeUlaxo3Tt6Agt/szS6wLQwrt3hvjzS4H11unWhZy1EkCK9icWfQ
         h8AQck8Rl/GVbdKHbiLtl98lUumW7DN1TW1YjE+4y+LelRaFLXVgqJAdssxCbp3e/IaN
         fUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=I3eCW0EJLWa0OXWClQfPVWKDZ0F0mvi6iBQTgK33L6k=;
        b=Hc3s/OoyL5Gpr4yRplIZj4TYWs7kg93zbG0n9kMq22DuM90WOZU14d1tPpzU4maEJ6
         X30RxT0KARegJsGVdSiL2fXTLUjk/7kJnQUTqM/zEgdwcvQAi9/HtmcuMtoCBS0KNEbM
         FfHgCVWo05/IIbs2NsblH1ictoxCJxpP4Dc79a+MWxXjrkXMuBy+JIDvv684JLvPPcl/
         MjFFMqlJ7FgqxrCMnxmtuIc7kx24qJYjRYs+mxJ8oe29gwbFf9sbFNzJU/JcIm7KlfZ5
         eR9DBZvHun9bJ3J//mp8oIFMVFbTM0fkKaaU833eBMMhvBUh+qdjj1qIyE3fpREcgKBA
         a2Qw==
X-Gm-Message-State: AOAM530QkK/PALUlpz3dYOYoZmPzenBHWo4Dmx2n8U4zmNQm+xz2u2Y3
        nyJcNhoCGR1+8jKoWgE80uuZYg==
X-Google-Smtp-Source: ABdhPJw1m4ZxT2fB5sZSrVPdosAw5xyRDr0oCGLo586cy0sck6TqTzHsMql/nIjPVmBfYFsyfMpimg==
X-Received: by 2002:a05:620a:2297:: with SMTP id o23mr809471qkh.405.1629187446363;
        Tue, 17 Aug 2021 01:04:06 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h2sm891887qko.127.2021.08.17.01.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:04:05 -0700 (PDT)
Date:   Tue, 17 Aug 2021 01:03:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/9] huge tmpfs: shmem_is_huge() fixes and cleanups
Message-ID: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A series of huge tmpfs fixes and cleanups, suitable for 5.15, taken
from the earlier 16 "tmpfs: HUGEPAGE and MEM_LOCK fcntls and flags":
https://lore.kernel.org/linux-mm/2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com/

The API additions in that series have not yet been fully agreed, let's
revisit those after the 5.15 merge window, but please proceed now with
the uncontroversial preliminaries - thanks.

Still diffed against 5.14-rc3: no conflict yet with 5.14-rc6 or
linux-next or mmotm - no problems with the foliage.

Most exactly as in the 16, with a few commit comments clarified from
review; most already Reviewed-by Yang Shi (many thanks!), tags added.

Exceptions: 6/9 SGP_NOALLOC introduced to resolve our review doubts,
that and 7/9 not yet tagged, 9/9 now added from a posting last year:
Kirill's "What breaks?" if shmem_enabled "always" reminds me that
I'm still carrying the i915 THP fix, as corrected by Matthew.

1/9 huge tmpfs: fix fallocate(vanilla) advance over huge pages
2/9 huge tmpfs: fix split_huge_page() after FALLOC_FL_KEEP_SIZE
3/9 huge tmpfs: remove shrinklist addition from shmem_setattr()
4/9 huge tmpfs: revert shmem's use of transhuge_vma_enabled()
5/9 huge tmpfs: move shmem_huge_enabled() upwards
6/9 huge tmpfs: SGP_NOALLOC to stop collapse_file() on race
7/9 huge tmpfs: shmem_is_huge(vma, inode, index)
8/9 huge tmpfs: decide stat.st_blksize by shmem_is_huge()
9/9 shmem: shmem_writepage() split unlikely i915 THP

 include/linux/shmem_fs.h |   23 +++-
 mm/huge_memory.c         |    6 -
 mm/khugepaged.c          |    2 
 mm/shmem.c               |  229 ++++++++++++++++++-----------------------
 4 files changed, 129 insertions(+), 131 deletions(-)

Hugh
