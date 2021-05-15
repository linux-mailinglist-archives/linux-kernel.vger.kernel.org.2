Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348D83819F4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhEOQs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhEOQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:48:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A68DC061573;
        Sat, 15 May 2021 09:47:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s8so2116620wrw.10;
        Sat, 15 May 2021 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pE29kkTNVgaqIoZ2qWVYXC1cONHAz+tF4/QgcXzl/dc=;
        b=V3UCUnhGCXj3vVY/uPBwCbSa1dYDyw0W5O/V4tjSLOvku38JRvJdqgNL/9/D7qYmW1
         SSYZHN9QoD01yA5Qhh+2j79rapkFjHkRn/KEUppTLgPPvzRiZgf1YXcFtECYXIZU+2X3
         vEjbky8yEs+g/8/OGqvTcnoaKmXEkLlakuI09dWT6JKymK0rqFDwPXz2O4IiW1KDMjaR
         auAXFe/nofwIIl9QIB7AMojn9xx3X9n5BH4bS6yxb31JSmOFfNUVYvF3tBbU94JSbKuh
         X/yb1s+hqkBywQMeHFe8/cSsJhxnK7mm9Kh7Hc7K0XburYLfXTsjd3jhhkmILvBAsf/T
         CC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pE29kkTNVgaqIoZ2qWVYXC1cONHAz+tF4/QgcXzl/dc=;
        b=YB7O43kEcCXXMp1nk1spzAp6u359upOs34WtBiZh67ef6oEIPIcFpW9OYoOpqq5qmv
         rZkDLoj8xBIqM6OGVNXoJb3BH5bFakq+bgBD8D33PBa0o6dN/OMTDxhJgcOXh7zAd4Ee
         OZBBIFHl/93z/9np4WVuqW/I3/P/7IrZKGgDFCfKlgIe0/0wvevoiDlP3yFtLv3MNnU2
         VSZmqZBw5BFGrvUmt0iu90DC7do3wslNm/34pkOosqLWkc3p9CtZeU0Fty9vDHpoVVrM
         EwNdD9KnJ75AT7LtxGVSSSWnuBwYnsnHVWqCHaHvKadJcHRKHvJdWjDxygGPscl/7TS8
         0EYg==
X-Gm-Message-State: AOAM533Q1HhOy4KX1+ATQNvSKmSmob55K+uZY7D7rm5UUdaX8FWE0l5i
        sHRm9+cVWb/N5q6+bqx9XRo=
X-Google-Smtp-Source: ABdhPJwAvxD1gItpO2Xvv1BIlPDwjtd3lT03gz4NShUrWqGaZSUYp2ZFYZvzYq8aAlVBi+e7aJYJVQ==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr65166806wrv.153.1621097261791;
        Sat, 15 May 2021 09:47:41 -0700 (PDT)
Received: from localhost.localdomain ([197.240.82.148])
        by smtp.gmail.com with ESMTPSA id k11sm10136810wrm.62.2021.05.15.09.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 09:47:41 -0700 (PDT)
From:   Khaled ROMDHANI <khaledromdhani216@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH-next] sched: Fix Null pointer derefrence
Date:   Sat, 15 May 2021 17:46:45 +0100
Message-Id: <20210515164645.22849-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'curr' variable could be NULL and derefrenced by
pick_next_entity. Fix this by adding a check that prevent
the invocation of pick_next_entity with a NULL passed argument.

Addresses-Coverity: ("Explicit null dereferenced")
Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92aa1c79..490948df94fe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7075,7 +7075,7 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 			else
 				curr = NULL;
 
-			if (unlikely(check_cfs_rq_runtime(cfs_rq)))
+			if (unlikely(check_cfs_rq_runtime(cfs_rq) || !curr))
 				goto again;
 		}
 
-- 
2.17.1

