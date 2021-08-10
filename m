Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F19D3E8453
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhHJUaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhHJUaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:30:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CB4C061798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 13:29:43 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u16so22934509ple.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZjOsueYpGQZhP7Bl+kpLTfQ5nGKWlyBAih7CetRBqo=;
        b=d27jbU5RObYQHtJTomYK15bAtbSLjYnuuQGarNydT4VQfGjI3fgRutZKx9f9jnFgZF
         XdyptNt76rJ9ZDeUXc93+a+9ULz6cwZaJP7mqbiwyhRztgT2voZK8ZesrQxSEaWvhNVp
         Nt26APxgTiBvC3UogJ4qu3swuHbFNuQ6MSQiS8R6S0STbxDpN7o2ZxjAv/p5aEDY7zN3
         /Ahn/SVMsrbmC04xT6dyAZJs0RcjIfYG00VI5iRObuZwKJU6itBqmlPX5YKjuVzbeg3M
         uXlRpbtBhUhaPrE8i+i1w48acx8Ncvc9zR+h5mxZ+IKZmuJ029grf5jaipsfEv8mSxtJ
         tVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZjOsueYpGQZhP7Bl+kpLTfQ5nGKWlyBAih7CetRBqo=;
        b=JmIRZjh2h2VwPvGI4lYhwzNH6CIfCT6eJpBbBfOoDMzxzrC8q7R9lvH7/QBSOm9yj2
         i0IW78EYDl51RsYiJKcJ8soJKVBgU5+wKM5oN8xVij17Eru2+VdyIZdJTRjwLL9G5E50
         8CXdCYOHdqU6qhWGgSwTHq0iNXWPw2Qst5d1vl09kDJxZJvDpPFCALAy61fj+ekPJK6q
         tWm/Na/fZW3BYPo+x7/Q7o4cxqVEnTpnWKvOLhoj27sXUzmFtJ+I7IdaRrD7pg3QWmm8
         OLgVPslDnN+oJ+c5mP1ZbsTsYMJV5v9BRpVXl0YPzG9EXrYVA7YENGTpkyuyey68DZX6
         cX7A==
X-Gm-Message-State: AOAM533Lqi4L27iQFD6IFUc9sBDiPOZWGC2z9eJOl9XQMBwzej2QKv7L
        yjNN9G6lKOP9fcLLGzv7MYg=
X-Google-Smtp-Source: ABdhPJwxeNtymkuQhLsqn6aJPUCztLEhhXqt/9LBl9cBwT9fLTENQbvFeFkGhVctnCs6SIZMzlNn1w==
X-Received: by 2002:a62:e40d:0:b029:3ab:42cd:d156 with SMTP id r13-20020a62e40d0000b02903ab42cdd156mr24870896pfh.81.1628627383473;
        Tue, 10 Aug 2021 13:29:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id e12sm24697145pfc.214.2021.08.10.13.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 13:29:42 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     hughd@google.com, ying.huang@intel.com, linmiaohe@huawei.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Revert "mm: swap: check if swap backing device is congested or not"
Date:   Tue, 10 Aug 2021 13:29:36 -0700
Message-Id: <20210810202936.2672-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210810202936.2672-1-shy828301@gmail.com>
References: <20210810202936.2672-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the change about how block layer detects congestion the
justification of commit 8fd2e0b505d1 ("mm: swap: check if swap backing device
is congested or not") doesn't stand anymore, so the commit could be just
reverted in order to solve the race reported by commit 2efa33fc7f6e ("mm/shmem:
fix shmem_swapin() race with swapoff"). The fix was reverted by the
previous patch.

Suggested-by: Hugh Dickins <hughd@google.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/swap_state.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 1a29b4f98208..8d4104242100 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -628,13 +628,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	if (!mask)
 		goto skip;
 
-	/* Test swap type to make sure the dereference is safe */
-	if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
-		struct inode *inode = si->swap_file->f_mapping->host;
-		if (inode_read_congested(inode))
-			goto skip;
-	}
-
 	do_poll = false;
 	/* Read a page_cluster sized and aligned cluster around offset. */
 	start_offset = offset & ~mask;
-- 
2.26.2

