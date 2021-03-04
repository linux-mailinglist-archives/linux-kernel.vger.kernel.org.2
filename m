Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D07132CD21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhCDGp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbhCDGp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:45:29 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AC9C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 22:44:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e6so18260664pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 22:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNMnMqrp2HEKjdFiGupPYllLza/hG1Fb8IPo+AOqpUc=;
        b=ZugkI/Z2joHxCRCkM+/RQ5AJpo78d9DlDl93uGai8iNu+80c3d7Wb5M/YaRByzQVUE
         Xu0p6GpnKjLMbILkC4VxBlcKR91gvuldz369B7nsxBCzPVWXVlGyDO0babgmCCUL1gkj
         Jayy6MyYHqbYn9dMap2Gz2IIwtZurRgu1c/FCgJ6CUTrpsef/CM9FRpxmrZmGYlacs1D
         DHUh0tTsKlDLgpzcqxchPm8y4TkpsjhpV8/o+blsUWKuSb2Qqw6zV7c+GcVhnkg8KRDt
         ObvlW+CzjrZ/gfpb9l51zayjhdGSz7GYwVCt7mrNkooVTHNz8MXE47l8Es02sdGiHf1E
         sApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNMnMqrp2HEKjdFiGupPYllLza/hG1Fb8IPo+AOqpUc=;
        b=j6bmLU58VNzpljeew3x5Vbs1kjugIKO4n3oZxoq72WxAH+hwg+JgImbFRgqVPjS11k
         U9FOsRzbE/O4mb5scxjFCDOYvNh/YxdqWQ2hM7rXnBtIi+qfKtzR9T5UHEdWkAOLZ6gY
         +g/9SOjvtaXNt26e5ko6haLOX/xL/fMLV4kOLS650Gx/mt4HQt01LEmLjGWVP2LisLsp
         wRvjw3M4JCwhzv1Ivw0UbcwF0n0WD/dHREvhQrrG2Q3lrhVczkmUvIzVCguJhoNtHiZh
         Th8avdlFVJ7TBdOxg82eTpwW3MzPVADIcjyrlCpV+ZRolp4dBrUNt2pn2gn7yDAJR1TC
         oMaw==
X-Gm-Message-State: AOAM5321Og42BMNGx4250mczgS2jnGIWR2PCALh/tqrOakkD5b57qmov
        66A7jeyMBFA59PnDvfb5rA==
X-Google-Smtp-Source: ABdhPJzU83jInWMoRFJgTO3YLpdTDpMekD9NZvktN4FIRW3/y2yRQvRlSSvsLNVTvUwCdmDJvJ8ltg==
X-Received: by 2002:a05:6a00:14d5:b029:1ec:c5e5:6041 with SMTP id w21-20020a056a0014d5b02901ecc5e56041mr2388556pfu.36.1614840289043;
        Wed, 03 Mar 2021 22:44:49 -0800 (PST)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id z8sm8933267pjd.0.2021.03.03.22.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 22:44:48 -0800 (PST)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm, hwpoison: do not lock page again when me_huge_page() successfully recovers
Date:   Thu,  4 Mar 2021 15:44:37 +0900
Message-Id: <20210304064437.962442-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Currently me_huge_page() temporary unlocks page to perform some actions
then locks it again later. My testcase (which calls hard-offline on some
tail page in a hugetlb, then accesses the address of the hugetlb range)
showed that page allocation code detects the page lock on buddy page and
printed out "BUG: Bad page state" message.  PG_hwpoison does not prevent
it because PG_hwpoison flag is set on any subpage of the hugetlb page
but the 2nd page lock is on the head page.

This patch suggests to drop the 2nd page lock to fix the issue.

Fixes: commit 78bb920344b8 ("mm: hwpoison: dissolve in-use hugepage in unrecoverable memory error")
Cc: stable@vger.kernel.org
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git v5.11/mm/memory-failure.c v5.11_patched/mm/memory-failure.c
index e9481632fcd1..d8aba15295c5 100644
--- v5.11/mm/memory-failure.c
+++ v5.11_patched/mm/memory-failure.c
@@ -830,7 +830,6 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		}
-		lock_page(hpage);
 	}
 
 	return res;
@@ -1286,7 +1285,8 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 
 	res = identify_page_state(pfn, p, page_flags);
 out:
-	unlock_page(head);
+	if (PageLocked(head))
+		unlock_page(head);
 	return res;
 }
 
-- 
2.25.1

