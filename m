Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9283104F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 07:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhBEG3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 01:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhBEG3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 01:29:42 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B0FC06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 22:29:02 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o16so3850215pgg.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 22:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QF0he1VW/PCEQZ3zvHTH+OFfohkfMVY0GDe6DZx57Hw=;
        b=mj7FWoJGFrcDOyAz41eFXfoppM9M6PPJ32NbJyxstX+ZDQjXJigyQZplmJkH1qTaAI
         tm89hJvYutfGv0GWNXUUQeCzoJ4C1a7kocoby20QK3xTwDOYU/yJA0TF1WaRDHIUUUdC
         0EWmCqXSeA0fyGWqsNXnOD836itIMNkR8oUG61F/cNHeTPby+jkXrI5RCBcFZzO81HU8
         BN1Tb9aUvc0GqHGTD/r/CFvwf9C+OvZYdrFV4VIhdqahmaktNx4YjXoYrf4mTytMSB+O
         rtJ4q/JfOEKmZiEiZ6H65IwVAg6QM2ai3mfUyEUMJMhZ7LKuc7hL/E3I8Uwbj2NN4jIy
         JCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QF0he1VW/PCEQZ3zvHTH+OFfohkfMVY0GDe6DZx57Hw=;
        b=lwiSktSNB0djp2n4PaQw/iY5gTMlWpbgupabNM2kBSlmvItYh7W1DqVLN7kT/S5hLl
         GRF2gxfFaTqGYNouE50fGapzke/1Ve5AIZBzKFooOehCwv+wmmhmxvCqD44IV92dDcSQ
         z1RLohyx8P6mzbfrDlX2sF3gMPRw6s1hWax2B6tRGk46Yao7UPqpQTwkuMSICsZQgx3h
         FtwjeWZLRWrv8nxqalJK6GYQKNzMwCRxVI1ri6OKP5M8W8Oa7plRa49WrxIyDur7DCn1
         Uuch/ROqq1qgGxZ54h63PCBj3YbdDr86ipXNXcuKPpBEZscmQ4ekclL5ZrViVF8wPlvc
         nRoA==
X-Gm-Message-State: AOAM5300SZAqrQnrqab5IIJEH3lrO+ZwH2gr81lPBd2dTXzQrxMOEEZV
        iVDHhbph5WCJVy+XeLw/lzmjcQ==
X-Google-Smtp-Source: ABdhPJz3xSak1Dn+1ZNBcoidjGDQlEMM7oxnX3oxqr4zZSU6RqBaCShF9omCB+EjG8E8nejz7cbpsQ==
X-Received: by 2002:a63:db05:: with SMTP id e5mr3016291pgg.104.1612506541740;
        Thu, 04 Feb 2021 22:29:01 -0800 (PST)
Received: from localhost.localdomain ([240e:b1:e401:3::f])
        by smtp.gmail.com with ESMTPSA id z2sm8644919pgl.49.2021.02.04.22.28.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 22:29:01 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: remove rcu_read_lock from get_mem_cgroup_from_page
Date:   Fri,  5 Feb 2021 14:27:19 +0800
Message-Id: <20210205062719.74431-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_mem_cgroup_from_page() is called under page lock, so the page
memcg cannot be changed under us. Also, css_get is enough because page
has a reference to the memcg.

If we really want to make the get_mem_cgroup_from_page() suitable for
arbitrary page, we should use page_memcg_rcu() instead of page_memcg()
and call it after rcu_read_lock().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 87f01bc05d1f..6c7f1ea3955e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1063,16 +1063,15 @@ EXPORT_SYMBOL(get_mem_cgroup_from_mm);
  */
 struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg;
 
 	if (mem_cgroup_disabled())
 		return NULL;
 
-	rcu_read_lock();
 	/* Page should not get uncharged and freed memcg under us. */
-	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
-		memcg = root_mem_cgroup;
-	rcu_read_unlock();
+	memcg = page_memcg(page) ? : root_mem_cgroup;
+	css_get(&memcg->css);
+
 	return memcg;
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_page);
-- 
2.11.0

