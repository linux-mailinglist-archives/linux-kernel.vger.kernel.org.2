Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0E35D86A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbhDMG7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbhDMG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:58:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A0C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:58:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so10184878pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rlxS2NP/wFG07icClsRwQltSV/pe4IUbel0wnvFN2yM=;
        b=kKWMZutIU29NqKffRf7Rn3aW5tj6h3ArneM4CjccRqhy83CknU6Gjh1hdO/OGbN9XD
         /d1X8d4GxEXJfe28RTBxeBtSIC/pRUZCLQ96RzX42IWktE6+V4s0YNzR5GCwuPrtv+ub
         uA3slpqDt404SoidWY6YzIg5SBoKC+FvmC8b5ADeGs1v85JFo+AoOULYxXA+ndidbZfm
         6AzqCNtTMtve4/uLh/ID2es0t1iHBlF2/ac2pnRjtwTpQpO8ZQAq45dVJ5jO52h8Y57A
         chftzkHYqBMkhc3ji88AaC8sNoUayvBuxLOp6AyqFKxjEglR2CqYIuE5NFz8JkaFA00k
         PTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlxS2NP/wFG07icClsRwQltSV/pe4IUbel0wnvFN2yM=;
        b=U98gawebEtqfEFQuvsnB+4uQv/giDA9XOAYw/IQ+iquwfdXEb3CO8pJFErkEfZhniE
         EXIkhQEuxFdg7VUO8fZx5rgmFxhkTWO/0d7/MdM0Vvda1wixVhTvHKmkSydkvHqABHP1
         ekekdBZ140sI6Emv7qMJ04YrgUIBADlpTapa+xkJQaAFcH2Vz7MjUkhFUHj3Wlg6DeU7
         ANGiy0UURsUYBhr7PNbjKXqy9lJfLdCeZscNigtqU3tZPwXwh6yifbqno0HvJ8Ad7aed
         OamQBYfUHma6f9W8WTGOZmGGm56c+MhLHn1hz+fiZjM6L9bp3HDZ3ESKckckSlL0s9IH
         KWLQ==
X-Gm-Message-State: AOAM5322CGEEXqrHwHl+MXQtez8yDtIzmWJ4q2TpH6WZUfvQtrkyydxw
        hZwY3kWsHNBinWNuE/LBh3kfLg==
X-Google-Smtp-Source: ABdhPJxxd8+LsLVbpUFdRYV2g1kphK8cC2VJ47h5BOjiz+ON6vX30VKce7mGgwpcf0LEwmJYYA4EKw==
X-Received: by 2002:a17:90a:e50a:: with SMTP id t10mr3417568pjy.32.1618297082039;
        Mon, 12 Apr 2021 23:58:02 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 78sm11508562pfu.40.2021.04.12.23.57.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 23:58:01 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 6/7] mm: memcontrol: move obj_cgroup_uncharge_pages() out of css_set_lock
Date:   Tue, 13 Apr 2021 14:51:52 +0800
Message-Id: <20210413065153.63431-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210413065153.63431-1-songmuchun@bytedance.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The css_set_lock is used to guard the list of inherited objcgs. So there
is no need to uncharge kernel memory under css_set_lock. Just move it
out of the lock.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 42d8c0f4ab1d..d9c7e44abcd0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -289,9 +289,10 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
-	spin_lock_irqsave(&css_set_lock, flags);
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
+
+	spin_lock_irqsave(&css_set_lock, flags);
 	list_del(&objcg->list);
 	spin_unlock_irqrestore(&css_set_lock, flags);
 
-- 
2.11.0

