Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E539A33FCF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhCRCAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhCRCAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:00:05 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A0CC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:00:04 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id i83so11629922vki.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=v1M50zVO+qfyX8hHQPyP5qHNesgD9s9P1xyKpHxr+O4=;
        b=cbLMc8ExTKSMcFjJxmr7HW9m23mlVR3fNMnWGPh4+DjYZqiKhZUFQ4qcdVtPpzE/aA
         8mzuAfy1Q0Y7qSpp/xGenI6FdRQWsuCmLqLHAF1mcTH7SZsy6c4b5+2jf6nJ4d07Cbfq
         4v4LbsEel7zJtXZb2uQdbeUh1djn/FduBWLT8vHUZCzCeLdMhqzuFMfuR2MJROscijad
         cQ4Qt4Yu9kV7InlNKAAj+USa8pz9YiawXTdgmUDfXxvo13msqrp/Tk04Bqk0ldaoqsYw
         v7/o8ImE6egm/TTuhWC01bt5tIoIsowp7eUL6ELQhTEBEGO3lNsPjtUir0f1vCIdlEHf
         AvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=v1M50zVO+qfyX8hHQPyP5qHNesgD9s9P1xyKpHxr+O4=;
        b=TA3gKTbQijOFy1zCwtKmg0h5TQ6/Pfv3R7vLzRPqvAqSilb5i6eE6UbGC1po27Q50j
         9DIuXKgWeV5raKIJrqSou2FtkpsOYS14YY3ncUUMbmPQiGUBgsYyIKssArZhnUtLW8ZF
         4bY8s4yeR3/7YRU3kjHg6J999MSd6NUb51WgcA8v2oQFgpHgNVPkNhQ604oXQNfJXPet
         PzPl50c4sZwD4DSikPrXDeZfkLtfF1ZjtrZUXxeJPqAB2FkOlrBIW/wwVW3i+NlI4M2b
         imY0mf6do9NcxvRbNpKLyA3xiVlrZ83HouTtdG4HqE7JBcH/ms0R8S9f7gFnx3P8PqhZ
         nIVQ==
X-Gm-Message-State: AOAM530rOr/DbU8s/iokPUw8lMFCd7HTJ9KmIZ13CBNLGCWI2ifNlHZh
        xv4YtLH4dKaJaU4SncPijhkjAuJjUhrHow==
X-Google-Smtp-Source: ABdhPJw8W0/x+H/Lj+3kOZGld4iiR5NSu7ISSwZyTycTarKtlprPwF1Pzu5TDYhgohhf4nqt8oNMwjVJjI1ryA==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:6cf6:3db8:f12:ae7f])
 (user=shakeelb job=sendgmr) by 2002:a9f:2142:: with SMTP id
 60mr1202881uab.105.1616032804013; Wed, 17 Mar 2021 19:00:04 -0700 (PDT)
Date:   Wed, 17 Mar 2021 18:59:59 -0700
Message-Id: <20210318015959.2986837-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] memcg: set page->private before calling swap_readpage
From:   Shakeel Butt <shakeelb@google.com>
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function swap_readpage() (and other functions it call) extracts swap
entry from page->private. However for SWP_SYNCHRONOUS_IO, the kernel
skips the swapcache and thus we need to manually set the page->private
with the swap entry before calling swap_readpage().

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reported-by: Heiko Carstens <hca@linux.ibm.com>
---

Andrew, please squash this into "memcg: charge before adding to
swapcache on swapin" patch.

 mm/memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index aefd158ae1ea..b6f3410b5902 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3324,7 +3324,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					workingset_refault(page, shadow);
 
 				lru_cache_add(page);
+
+				/* To provide entry to swap_readpage() */
+				set_page_private(page, entry.val);
 				swap_readpage(page, true);
+				set_page_private(page, 0);
 			}
 		} else {
 			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-- 
2.31.0.rc2.261.g7f71774620-goog

