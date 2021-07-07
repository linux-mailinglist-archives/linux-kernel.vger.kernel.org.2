Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB53BF0A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhGGUQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGGUQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:16:19 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B6C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:13:38 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id l17-20020a9d6a910000b029048a51f0bc3cso3472323otq.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=G6BcXcovuKQX32KS++TwaxPjbkiZXZqUSnhVU2rIm8s=;
        b=tEoOzZ1g/YIreTbMKj6zR9yAyFeSivYOPq+hYIi/iDVJTtoF1Dx2vOc1HmT845PkjJ
         HVFDPmHUa2mnIjl65c316SoGWqSvWJyUHmTIFEBuFA9EJB8y0j54IiKnPm46oqAmE0UJ
         7nb+3RnYxAKvlpIYin4xVMD9zayJEep6XK6OrCbBURG2UgCrgXWfTkIknWqG6TRl3mcC
         DMTgMDTNtXYMBJt8thR1IXs+E4mZBLCQi4Wn9mz6hGrj6++7FlJYZnTtX9bliBmrxNu4
         yueKDYwBhsRbwMj3G9SUSZIz5rJ+f+UnY3xAfh9my7EdN+KYkS6Fy5LgRQqbgnWjDNjx
         kd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=G6BcXcovuKQX32KS++TwaxPjbkiZXZqUSnhVU2rIm8s=;
        b=LCDMOdwnyRu4ZhNqYmSeoQJV3jfQwuCN7wd9ClZlsy/1qC6WpnAC3kM7sYk+wwCV1D
         JzVkzF+aFiPyC03uWrS32zjgdX5KfwhwPS+KddFU5k4TSINECMKyAOwcUZrldU3/6e2I
         DtfeFmIZAudRGZq3sfqR9/Aar+uNZSgBhdkJIrqst4GjlWpJa4sU4L7xWFGSYavyMjaN
         nNwtw2UFtsi4dgoXIi9mlnrWdYLJdx982ygfuo+avKBmR8vPKELBsGAPjabzanCMEq3S
         fmT6SmI+008WuO/Fl65answoHyeb/9mS2YB0b9mb01qb5gKOBBaCRfJ+qsCMRF8zbMhN
         rH0w==
X-Gm-Message-State: AOAM5320ci5O4J0MF2yczNGTK6HWXeMwI+SmcQesQ9jjs0uaKfogJxEM
        YLQ7TdfQuAGg+iFnUNOOY0x9NQ==
X-Google-Smtp-Source: ABdhPJy9GtfO7ixk82n+CnnqjqGznRdZMsyMi+BKZGN7Xsa/CU+WOyCKUSI8ZFeoVZcOXySTcqI/AQ==
X-Received: by 2002:a9d:6a81:: with SMTP id l1mr12953964otq.239.1625688817503;
        Wed, 07 Jul 2021 13:13:37 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s131sm4318378oib.52.2021.07.07.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 13:13:37 -0700 (PDT)
Date:   Wed, 7 Jul 2021 13:13:33 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 4/4] mm/rmap: try_to_migrate() skip zone_device
 !device_private
In-Reply-To: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
Message-ID: <1241d356-8ec9-f47b-a5ec-9b2bf66d242@google.com>
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know nothing about zone_device pages and !device_private pages; but
if try_to_migrate_one() will do nothing for them, then it's better that
try_to_migrate() filter them first, than trawl through all their vmas.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/rmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1235368f0628..795f9d5f8386 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1703,9 +1703,6 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 
-	if (is_zone_device_page(page) && !is_device_private_page(page))
-		return true;
-
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
@@ -1944,6 +1941,9 @@ void try_to_migrate(struct page *page, enum ttu_flags flags)
 					TTU_SYNC)))
 		return;
 
+	if (is_zone_device_page(page) && !is_device_private_page(page))
+		return;
+
 	/*
 	 * During exec, a temporary VMA is setup and later moved.
 	 * The VMA is moved under the anon_vma lock but not the
-- 
2.26.2

