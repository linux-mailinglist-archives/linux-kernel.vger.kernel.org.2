Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AB5388118
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352134AbhERUL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhERULF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:11:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA797C06138D
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:09:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n8so510339plf.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LzYS5XW9IU9WeuvRe7Xm3TQYgzZrKQqqoGt9pGR2ER4=;
        b=Dyn73zCInWwR0jUgSSodJFoBDUdQcKdyYDLvtZy1vDPowpkU+644nLJedCWDPyo6fr
         fzOde3MHpGW9X3EGHgRm2i91lgk/Q8rmbCMJRPyxRdrk7HoLBJs+mP01/z5gd0eT/CiE
         lJId2sYr5+NrLcTH/Dy/f/N4CbtGh53FaIsxA2t5tcxFB5DhcKAb8aST1cJ7OtPXb1Kg
         BwiCgVY/hGDKp2QNEe7F0HaUyE6R9WAqDEYnEWJ0klInM0z2rbpkuGZq60NTefri727C
         JdA7T/DCjWiAztK9LvyMxiM2xh3D56M1I015OzHQwYdJE0JDmvxrOWtm7zbw9oqioiQJ
         LcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LzYS5XW9IU9WeuvRe7Xm3TQYgzZrKQqqoGt9pGR2ER4=;
        b=hYpMxGHYg2dSjUbcnKbAo7P5LFXvo5B3XuEpxuIKd6Frj7L4OHgM1Gtu7LwdOaLIBM
         +uVfe5PpN8KMWcQ+4YRe9RDfMTb8fgv8I9aZdbazO5xzKWBubsA34wqb0oeDQnvwdp0e
         SNkQgPGZr0Rg25S5xpsrzn7PDy//mvFvkFytv9gkoMugmIK8j9TwRjnqid6JMFFrWkkP
         tLBsqZSTc7HgE3gt2QYk7F0qfzK2dgWYjk+xOwvOsSBnaKDOKF5V1cS26Od3VjaRIJIA
         n5ymd8U5+NZDJR7becoHmEauAY0b201HCr2O07iwvVG02D8sdDCGj0ATIfa4DE87cRJY
         3pcA==
X-Gm-Message-State: AOAM532rZ3YCKWqHrkQqsi9Ej+BxhUZZsKO6w5h+CRXf4BRkT5wUWmQQ
        HoRsn/9iclsOtU+NlAyh7/A=
X-Google-Smtp-Source: ABdhPJxUxa7CjFAYvxmnFzbaiLIg13AsFz80kCgmacAnTcEIhXrlbWq5f3PcBP5zu3cJtRjFO9mS/Q==
X-Received: by 2002:a17:902:ea06:b029:f1:9082:3ddc with SMTP id s6-20020a170902ea06b02900f190823ddcmr6566652plg.43.1621368584444;
        Tue, 18 May 2021 13:09:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9005:8001:6c07:1f32:4738:c807])
        by smtp.gmail.com with ESMTPSA id h22sm12794111pfn.55.2021.05.18.13.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:09:43 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mm/huge_memory.c: Remove unused variable unmap_success
Date:   Wed, 19 May 2021 01:39:27 +0530
Message-Id: <20210518200927.69011-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

   mm/huge_memory.c: In function 'unmap_page':
>> mm/huge_memory.c:2345:7: warning: variable 'unmap_success' set but not used [-Wunused-but-set-variable]
    2345 |  bool unmap_success;
         |       ^~~~~~~~~~~~~

Remove the unused variable unmap_success.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 mm/huge_memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 52ca04b905cf..ff79a12993c9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2342,14 +2342,13 @@ static void unmap_page(struct page *page)
 {
 	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
 		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
-	bool unmap_success;
 
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
 	if (PageAnon(page))
 		ttu_flags |= TTU_SPLIT_FREEZE;
 
-	unmap_success = try_to_unmap(page, ttu_flags);
+	try_to_unmap(page, ttu_flags);
 }
 
 static void remap_page(struct page *page, unsigned int nr)
-- 
2.25.1

