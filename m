Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE03531A331
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhBLRC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhBLRC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:02:56 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A600AC061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:02:16 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id ba1so184010plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdVPqrFgHTgC5mTllAq9fBNSua/ngygoblWbV1oigUI=;
        b=Wqq++mXdhn6HE2fF23Wh8h9AFqcynW3GPMQs21nMApsmcn9L4h6O8KtYPRjAUeNCDn
         iNMu2YDjYyY8JDBGuTJAEVoQcXdkJcwdAMiDMk/43qpb0yi2y/gjcH86jMmW4oRF16x3
         L8UNDDz8q5XJPbV/D8jN4450QYrAUnCaJ5cUuSHsVoO/e/3r98A0TR3WAK0qaFp0ufcz
         5FcU7+Yz6okzH9k+R28b7nmm6Z9f63wUb2h6VTNDmLX3s/VAfDqzX8JRwrHt08eJ5okY
         cIbjgV0hM5kJGL5B1Ttc4NuCgqtZIs5c37uIrW6rDWoTarmMsvNlMxDDAHHWfGQAiIkl
         0GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdVPqrFgHTgC5mTllAq9fBNSua/ngygoblWbV1oigUI=;
        b=Ay+zWvD8xFuil81aFTe5qDw2SyScYgeOyx745nQAVTuTPNJofw4zQZ+h5qrFp8Zfto
         Z+I3FOh0TYgOt6bEnKxhTv5MZnaK7lwmzZYbHjnwswgnxS2BYoh302PKd64eHPlqiUG+
         PR0nqz3aJrM7ziensOtL0t5g1XRWuzRxHKYrdGgmm1bbtKsJXgqNxl8t2Ba2SPQT6MRW
         0NfZjjTcXhMYV+OjVdq0WMC1VzNW64ElswFDUbSgPAaY039F6u7k7IDEOQirsxcGs8/7
         Cn2BzhyKMItPZmf+yz/eGokPagueeVIDmvJ8HEM3F1jUcwJdOZUPNm6zxsn4rnJkkrfb
         LI9Q==
X-Gm-Message-State: AOAM533ck/K57G198uiJ7n/l3m7TUZBuhlU0OMwBoz178BBkhJ4wIWx9
        z0TyeoOwX0vkTEX6BY0TefMuZg==
X-Google-Smtp-Source: ABdhPJybZwdjimV2P5ym8dkQiRVRyC5DByFMgygAkBaUP5rkFW8O6XL/Sn6SVVsiqOEugp4e7rkVow==
X-Received: by 2002:a17:90b:2312:: with SMTP id mt18mr3636553pjb.81.1613149336083;
        Fri, 12 Feb 2021 09:02:16 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id e21sm9317815pgv.74.2021.02.12.09.02.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 09:02:15 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/4] mm: memcontrol: remove memcg check from memcg_oom_recover
Date:   Sat, 13 Feb 2021 01:01:56 +0800
Message-Id: <20210212170159.32153-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg_oom_recover() almost never do anything but the test (because
oom_disabled is a rarely used) is just waste of cycles in some hot
paths (e.g. kmem uncharge). And it is very small, so it is better to
make it inline. Also, the parameter of memcg cannot be NULL, so removing
the check can reduce useless check.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c035846c7a4..7afca9677693 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1925,7 +1925,7 @@ static int memcg_oom_wake_function(wait_queue_entry_t *wait,
 	return autoremove_wake_function(wait, mode, sync, arg);
 }
 
-static void memcg_oom_recover(struct mem_cgroup *memcg)
+static inline void memcg_oom_recover(struct mem_cgroup *memcg)
 {
 	/*
 	 * For the following lockless ->under_oom test, the only required
@@ -1935,7 +1935,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
 	 * achieved by invoking mem_cgroup_mark_under_oom() before
 	 * triggering notification.
 	 */
-	if (memcg && memcg->under_oom)
+	if (memcg->under_oom)
 		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
 }
 
-- 
2.11.0

