Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41353312F00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhBHK30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhBHKPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:15:44 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0562C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 02:15:03 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id f26so1000064oog.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 02:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCMmRzeRUvjiDoTmyzXxUn/Korqg8Etx51tp2C17oVg=;
        b=F3iTrEZ3iULk4I5TLTDKE5hqXWLowDwwMZ0ds6BMCd7y/FP0OCH4Jk4FuxzeoTEf3J
         xSpol477x+ZB9VMfjXkKz0PrImqS619nJi+pHochlvZk2coeDmsJAkAKDHr+2dxuAXso
         BjXIJhNrSrmzBncmBgvh9kJZnmiz4bJSX48lSeRiQlLHYmosCZVjQCldwvIIcUnzTVIv
         Kk2sDbrCau/ygmncrLr57RJEa61sPn7Cz2Uej26Xl8eWuACqQrG5b1wF66AeoYe9jTx9
         O6UGmSdA6uDMlKzL7ED1fWvvEJro8l4OqvD5qkNZEdMFTNLwiQxOnybapylmPQqjaxys
         VENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCMmRzeRUvjiDoTmyzXxUn/Korqg8Etx51tp2C17oVg=;
        b=RhZrcsKKiDL2YeEnKs1cBG2LtUwQFF6W3eWUDYmldQVsbabbnFvNufZ3CSlMHUs9V9
         NYZxKcbH+l8WpQCZHfkvWK68QaE4W7gsl0P9UsRRCmtvMpFr0q4KzrxTs1ttYsMJfbrx
         eIUv7fTSPmfnbzbQVfZDDkYK570OezoG4GKOSbFs9LAHKmLPtJhR/t18rIyWEN4ZcmQV
         VkKFImBL3cXOgW5mUMKN3ucv6UHRmkOJkuu52e+00hOeCL+FoSrKmZpr8Rf9rx8I3kRT
         w7n+R7kTcsLTwK4ZRwYwSaVj4tGSSbpQ7Vw9g4en3rcHJLsSspsYo/8mr9jPh/mEQtTM
         /+Pg==
X-Gm-Message-State: AOAM533W62HQ3YFEp9nc6YHKQJLbWMc0+8iXzXZViBi77+7NHulQ0x9U
        wOvPJJ+8eZwjeXDjrq5EHWc=
X-Google-Smtp-Source: ABdhPJy+b0GzW0jKEOCa0mciq9BdyBuax03BFKIo4Gkibq1omDLr8z/86pN0zQH4MLZZs0C9upYXZg==
X-Received: by 2002:a4a:8555:: with SMTP id l21mr12150459ooh.27.1612779303251;
        Mon, 08 Feb 2021 02:15:03 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id t3sm607226otb.36.2021.02.08.02.14.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 02:15:02 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, willy@infradead.org, cl@linux.com,
        linmiaohe@huawei.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 0/3] mm, vsprintf: introduce new format to dump full information of page flags 
Date:   Mon,  8 Feb 2021 18:14:36 +0800
Message-Id: <20210208101439.55474-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existed pGp shows the names of page flags only, rather than the full
information including section, node, zone, last cpuipid and kasan tag.
While it is not easy to parse these information manually because there
are so many flavors. We'd better interpret them in printf.

To avoid breaking some tools which parsing pGp via debugfs or affecting
the printf buffer, other new formats are introduced, so the user can choose
what and in which order they want, suggested by Andy. These new introduced
format as follows,
    pGpb: print other information first and then the names of page flags
    pGpl: print the names of page flags first and then the other info

The differece between them looks like the difference between big-endian and
little-endian, that's why they are named like that. The examples of the
output as follows,
    %pGpb 0x17ffffc0010200(node=0|zone=2|lastcpupid=0x1fffff|slab|head)
    %pGpl 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)

To be compitable with the existed format of pGp, the new introduced ones
also use '|' as the separator, then the user tools parsing pGp won't
need to make change, suggested by Matthew.

The doc and test cases are also updated. Below is the output of the
test cases,
[ 4299.847655] test_printf: loaded.
[ 4299.848301] test_printf: all 404 tests passed
[ 4299.850371] test_printf: unloaded.

This patchset also includes some code cleanup in mm/slub.c.

v3:
- coding improvement, per Joe and Andy
- the possible impact on debugfs and the fix of it, per Joe and Matthew
- introduce new format instead of changing pGp, per Andy

v2:
- various coding improvement, per Joe, Miaohe, Vlastimil and Andy
- remove the prefix completely in patch #2, per Vlastimil
- Update the test cases, per Andy

Yafang Shao (3):
  mm, slub: use pGp to print page flags
  mm, slub: don't combine pr_err with INFO
  vsprintf: introduce new format to dump full information of page flags

 Documentation/core-api/printk-formats.rst |   2 +
 lib/test_printf.c                         | 126 +++++++++++++++++++---
 lib/vsprintf.c                            | 115 +++++++++++++++++++-
 mm/slub.c                                 |  13 +--
 4 files changed, 233 insertions(+), 23 deletions(-)

-- 
2.17.1

