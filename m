Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DCD3F1DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhHSQbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHSQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:31:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6056C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:30:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g14so5988864pfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fpkD+6OCoRzfkOeMTubr6LoF+sjAXSBjcDQsaNzJiUQ=;
        b=GLcx+rGTfAkrzYH9INJLyXKNKRZucLOxvUvYmeInROcKbJbm+K+zI1dqs0skv5CP9x
         44xiv/Kk3kudHFveMfbhqZXzEoH3fAPjgu0xnDuHtsgKEMt2lW1wpDTkrUTPt192i6nU
         YEneL0cX16fnC85Eb3UYudifAXi7m+aoGCik5GQgz9E8rcwhhImB2TxA7nkLiJM9N5Ph
         Dnl16YKBASVVYpwqcwo9ZP4kilBD5Ly2C3aFxnxg6DQE4MGeFF1+hXurlhYR9hSzgvMn
         Va+0a4Yj8oWWMRIl0nwMyyWuY7R3S4P5l8Ce+6yITrCPD0dsdAvXiU/usNX3K6hnKN5s
         w8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fpkD+6OCoRzfkOeMTubr6LoF+sjAXSBjcDQsaNzJiUQ=;
        b=j0pZFXNReK8DktRyOPH0aA2OAkAVH8C2RBa7CY+gRgF2+F2rPr+V4HEZ2Ggb7i8AgV
         jnHVrhUQRhenCN/MI7ij2MSB15ZYcn0omMaMzAG5yNHTFnPhq4FuANQGwdjP6ffn+CHj
         BAZznSj76FAsUkg/WpjXFRtFI/i56vEiqEcwTWeBSd8f+SY2uQtvppBoDOVLnB3WBK5+
         Gu0rE493Hf0De8Ac/w13hVRObGX81kd9HosMpAz3ZXI2iHgFy3u3ZG5Ki9T4h6hx8GNW
         eLqMwl7PQ2uAArOCTYhgXYc/Yvfi5i4xL1TdGWyKBCXACKzcfkcUbLMmY2Y3hWsPyn5e
         gfEw==
X-Gm-Message-State: AOAM533aY/pRe00BIGJixKuaJn2Rq3JeyNCa2MyfqU5HBZNn5Bx3OLeQ
        nlBIM8mvEPqHQlX9rHlaUW8=
X-Google-Smtp-Source: ABdhPJyZ32hcCoHBVF5/ronUjvjqCmf9FjAS/yuTlL2qRVd2fmTE17GEVg28GZTRPck3LmuoG/HIDw==
X-Received: by 2002:a05:6a00:1511:b0:3e1:6801:3402 with SMTP id q17-20020a056a00151100b003e168013402mr15475104pfu.23.1629390659284;
        Thu, 19 Aug 2021 09:30:59 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id v1sm4303751pgj.40.2021.08.19.09.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:30:58 -0700 (PDT)
From:   Hao Lee <haolee.swjtu@gmail.com>
X-Google-Original-From: Hao Lee <haolee@didiglobal.com>
Date:   Thu, 19 Aug 2021 16:30:56 +0000
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, haolee.swjtu@gmail.com
Subject: [PATCH] mm: vmscan: consistent update to pgdeactivate and pgactivate
Message-ID: <20210819163056.GA9764@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit 912c05720f00 ("mm: vmscan: consistent update to
pgrefill"), pgrefill is consistent with pgscan and pgsteal. Only under
global reclaim, are they updated at system level. Apart from that,
pgdeactivate is often used together with pgrefill to measure the
deactivation efficiency and pgactivate is used together with
pgscan to measure the reclaim efficiency. It's also necessary to
make pgdeactivate and pgactivate consistent with this rule.

Signed-off-by: Hao Lee <haolee@didiglobal.com>
---
 mm/vmscan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 403a175a720f..9242c01d03ac 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1814,7 +1814,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 	free_unref_page_list(&free_pages);
 
 	list_splice(&ret_pages, page_list);
-	count_vm_events(PGACTIVATE, pgactivate);
+	if (!cgroup_reclaim(sc))
+		count_vm_events(PGACTIVATE, pgactivate);
 
 	return nr_reclaimed;
 }
@@ -2427,7 +2428,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	/* Keep all free pages in l_active list */
 	list_splice(&l_inactive, &l_active);
 
-	__count_vm_events(PGDEACTIVATE, nr_deactivate);
+	if (!cgroup_reclaim(sc))
+		__count_vm_events(PGDEACTIVATE, nr_deactivate);
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-- 
2.31.1

