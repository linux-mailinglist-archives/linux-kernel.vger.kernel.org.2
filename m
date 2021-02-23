Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48032279A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBWJOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhBWJOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:14:45 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE01C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 01:14:05 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 201so5284892pfw.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 01:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1n7Y9GM24hDTWc1FsL/bOM/drrMT62OKuzLMW2dMgNM=;
        b=e3jX2u6s3VNO9Cw7VBXkZbV2bsB7SfRMzFYUTKkWHJyx573pYFk9e8bA850LLGy1zU
         sp9XRciHMY1IdpiRsOzlRUZ9nKvsWvDEkV3wB2HEM/Uc7kdr7iWHWNgpqjdlWZtvqCS/
         esiRkQUaNnPh/g21Q5v+dXrNKO6O03WlCnLF67aMATaS5GHhxM+Vd+AHzSOLqP2iuMnm
         fFCC+VhlzWuktUIDIJlSgC+hRXgCyYrb/8EmjqrzjRA5vK/zO/fpEekigNKBtBDNq7tc
         rYc8vQB8fu0wD6/63bilnvLuMe0nbRDGKaScMwX6SBmpHfncr1UNLUuvHEpAoy3I6Vo6
         qRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1n7Y9GM24hDTWc1FsL/bOM/drrMT62OKuzLMW2dMgNM=;
        b=Uh18HyEpkZwttQb7KsE2+CQRLwIpgcOfvbSu6z2G9uPxcKVuaM3XAHJuCCTYZTpCWB
         zFArev0MgqUBOF+uhiPLlJcpMMhsnp0pFaaMiIdz1O6otDcMyUycu6pCcJQqcHiLwZ0S
         bcZ4LDkT90n5vIszrek7Zgwh96i4kXQgtZuh355h6/Xcz4A51V38LOV6NyO8eBw1yWBm
         mJglZ/6lkxait8+3IWa4f3NFFnhXEP6GB2okTFsl5uxsDYl6vmYC6a3R3vqpYWB4IiPx
         zmwF6c7DsC3hwaNjkXx1W/569VkB6xPDH7zY5HJyu2KxB5TnegxTQ6cOHYt0aZaIn7l0
         zU5A==
X-Gm-Message-State: AOAM532ZeCFcuV5nypImd/whRLgGkB44tEXyWN7waDpcHJVwIUZAcDe4
        AoC9mfe0jV0QobKY/sHyA5k6ng==
X-Google-Smtp-Source: ABdhPJxjwIrki8AHUFSLEKk6eN0jUQkjmWxert2aH1M0SJiUQd7Bg5clzlRzq7XqyZl7hRID5MPUtw==
X-Received: by 2002:aa7:854e:0:b029:1ec:eae7:1565 with SMTP id y14-20020aa7854e0000b02901eceae71565mr25803449pfn.35.1614071644734;
        Tue, 23 Feb 2021 01:14:04 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id c18sm19816267pgm.88.2021.02.23.01.14.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2021 01:14:04 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, guro@fb.com, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: fix get_active_memcg return value
Date:   Tue, 23 Feb 2021 17:11:01 +0800
Message-Id: <20210223091101.42150-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use a global percpu int_active_memcg variable to store the remote
memcg when we are in the interrupt context. But get_active_memcg always
return the current->active_memcg or root_mem_cgroup. The remote memcg
(set in the interrupt context) is ignored. This is not what we want.
So fix it.

Fixes: 37d5985c003d ("mm: kmem: prepare remote memcg charging infra for interrupt contexts")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index be6bc5044150..bbe25655f7eb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1061,13 +1061,9 @@ static __always_inline struct mem_cgroup *get_active_memcg(void)
 
 	rcu_read_lock();
 	memcg = active_memcg();
-	if (memcg) {
-		/* current->active_memcg must hold a ref. */
-		if (WARN_ON_ONCE(!css_tryget(&memcg->css)))
-			memcg = root_mem_cgroup;
-		else
-			memcg = current->active_memcg;
-	}
+	/* remote memcg must hold a ref. */
+	if (memcg && WARN_ON_ONCE(!css_tryget(&memcg->css)))
+		memcg = root_mem_cgroup;
 	rcu_read_unlock();
 
 	return memcg;
-- 
2.11.0

