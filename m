Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF653DC788
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 19:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhGaRyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 13:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGaRyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 13:54:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29929C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 10:54:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s123-20020a2577810000b02904f84a5c5297so14336033ybc.16
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ivMf2Yjdch9nwF/G9GfQW4akc0oLsluxTWhSUC3fYFk=;
        b=vsTqgJfo8r39fd6ueado1agpNnb9dTqc/VMN8x6fR4O7y06NcFd3lmXN+8wLDk4WkH
         BYxhcEYJX+yNzyJgb4Eq++dHCzGGmsr1sn3ROHGVPvEdHk6ecxBRGA/wu9ByweKnzYMC
         +DCXItDJL/zP1x5OTLRDf8YF6PGSLicd9OLU1qllo2qFK7D3rcVEa6ITEJhfB6fkzpl0
         /jVusx2lewbkBmUvt8Gto17NK3EkSNhk/FHmkLX3IRD/iqFg3yJW6g6aM86EidMAkQA1
         Q3rOrFU0CceKyYCan9Ka0NrimT5mihwKaWMqXPI7uGBpW/TXAOCxHBgYLLnJSOQg4+R6
         eUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ivMf2Yjdch9nwF/G9GfQW4akc0oLsluxTWhSUC3fYFk=;
        b=ip+2h5CHFN3aG+7nKt81ptzyWWgcFuGerzXODM+rzznvHPLO92EFr3Qd6UrdqZrdm2
         C8PYaCJ+1GHw6oHaHeEk3AmaioHiuTkp4A+cQYZInigFXXI6trTt0EIQhLS+BCUBQX0h
         36xj++rZhnQc6MEtxa8ZCYrCwBPwRGwP5iLi5dvKPaPEwNV+wSkOD9ZrVqeherdq5YE3
         7NayYVwKmxVMAT1J2fjJUF0ZOiRJHwPicF/I8lCYTh+eByFd+1f6MjtWRO2OccRc0N/4
         IGynjHQvVmybnSMPhpj7lqcGb4uK3ZdztAZlFMxE1KZeGoezOqMbDWZMCjRU2vnTMOTS
         7WmQ==
X-Gm-Message-State: AOAM531PcQvG3M2pi4t8OsqFY+Bguxdl0vU6oPd7KE2vH+nTsIfZz7FH
        0LntmEOwgI4dspLlkSW00BaPEZKAZLRqWDlfdIqBiR3v976UA6VKF0azI/ql5saXfc4mEdcwGza
        OtXCndG5AzfBgIyWRRbmEW86XBH//3Oms2P8K19OfTuhoQ109jzGP71TGHJ0SxbTjhNLG2A==
X-Google-Smtp-Source: ABdhPJxp4EdwE4NDYsUcJ9AHAVwjadmWCd+NDw9IOLv27oyK70lPHY75R7Gly0kdMG1fohG1LG2o0lPZ96Q=
X-Received: from lrizzo2.svl.corp.google.com ([2620:15c:2c4:201:af39:9f08:202e:eb75])
 (user=lrizzo job=sendgmr) by 2002:a25:804d:: with SMTP id a13mr10669276ybn.431.1627754044283;
 Sat, 31 Jul 2021 10:54:04 -0700 (PDT)
Date:   Sat, 31 Jul 2021 10:53:41 -0700
Message-Id: <20210731175341.3458608-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
From:   Luigi Rizzo <lrizzo@google.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_vma() and variants need protection when used.
This patch adds mmap_assert_lock() calls in the functions.

To make sure the invariant is satisfied, we also need to add a
mmap_read_loc() around the get_user_pages_remote() call in
get_arg_page(). The lock is not strictly necessary because the mm
has been newly created, but the extra cost is limited because
the same mutex was also acquired shortly before in __bprm_mm_init(),
so it is hot and uncontended.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 fs/exec.c | 2 ++
 mm/mmap.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 38f63451b928..ac7603e985b4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -217,8 +217,10 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 	 * We are doing an exec().  'current' is the process
 	 * doing the exec and bprm->mm is the new process's mm.
 	 */
+	mmap_read_lock(bprm->mm);
 	ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
 			&page, NULL, NULL);
+	mmap_read_unlock(bprm->mm);
 	if (ret <= 0)
 		return NULL;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index ca54d36d203a..79f4f8ae43ec 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -534,6 +534,7 @@ static int find_vma_links(struct mm_struct *mm, unsigned long addr,
 {
 	struct rb_node **__rb_link, *__rb_parent, *rb_prev;
 
+	mmap_assert_locked(mm);
 	__rb_link = &mm->mm_rb.rb_node;
 	rb_prev = __rb_parent = NULL;
 
@@ -2303,6 +2304,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
 
+	mmap_assert_locked(mm);
 	/* Check the cache first. */
 	vma = vmacache_find(mm, addr);
 	if (likely(vma))
-- 
2.32.0.554.ge1b32706d8-goog

