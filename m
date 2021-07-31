Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197603DC4B2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 09:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhGaH5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 03:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGaH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 03:57:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC2BC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 00:57:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j1so18500433pjv.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jQujshHE7jKWS1+C7xQP9tnfF3yH0GDVGZkIK3moVlU=;
        b=slmzD1H4xs8NDUowznIP2T5du5xI8BjgpOOPzgvx95aeZjZg/B8qmN4HcM51CpevUV
         KBYGghGY+U4maIDm9kvMvCAjAMOeR5roAID7WPmLZzDz0IUIamKKPdKiMAeAmtPeJiOE
         QeNXCtdz+xLuc+wgzu9M6B5zdr2rMGViheDqJMRmr452N8wMK3n7LL1iANtrePnKqmag
         634j3SWZYj5k/0z+iKkA3zEyJ1xEf17MDFECf1JpqCuvip16XhV5lZ/zvtxJMYhmsWQM
         pbPPiz4LGTn3XBpeD2kvRzErhopGL9f5IQJKWtyykY/SEzPwk+o6bBrNHAcYgvf30ROE
         1lDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jQujshHE7jKWS1+C7xQP9tnfF3yH0GDVGZkIK3moVlU=;
        b=H69H0D2HvC5FioyRSutC5P+DmXG0IJHO6aLnVZnJp9/qTRvm6TaWbHjCKBzjxWbg5k
         xcp/74MOVB+o8HrnviWIYeN0GUshOChAu0yDWSFRZT+XRDQPTPWAQfTZ/NXqjL7g3xal
         CpxOYeI2CBm0y3ItYWuiU4KkeycK7cDRKHg7gifS4nSJIv6SvEW6NJaa81hO2IJO7aat
         kMj8XrkX7w6szZRp+CIMzOXN5VDuYnEYlR8wnDrtU08v+BR3LEIUy8WiDCyR5Lf4RDAZ
         Pe/ZMWbaoFBukqbpgL3TSIfWcGGyhDRmYJs9/OyKYfpaJENh+onoZus4+d2mmMtxpjIt
         9Iiw==
X-Gm-Message-State: AOAM533oyorE86c+LnG9+RHm1ywNnrbDi9nAyG1I3e2e8iA8UAnaRHBm
        LP/plpivoWXokqQX2nbPvX4=
X-Google-Smtp-Source: ABdhPJxLWzpfwgdJKJml+8xRal8USXAvCo0f5vC8aGxcUOjHhaZnQcIlzhD4uSXkGEwAMEnCWlSGYw==
X-Received: by 2002:a17:902:ac94:b029:12c:9bae:7d with SMTP id h20-20020a170902ac94b029012c9bae007dmr3031701plr.32.1627718242052;
        Sat, 31 Jul 2021 00:57:22 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.29])
        by smtp.gmail.com with ESMTPSA id ge21sm4361615pjb.55.2021.07.31.00.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 00:57:21 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Tuo Li <islituo@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] ocfs2: quota_local: fix possible uninitialized-variable access in ocfs2_local_read_info()
Date:   Sat, 31 Jul 2021 00:56:59 -0700
Message-Id: <20210731075659.73505-1-islituo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory block is allocated through kmalloc(), and its return value is
assigned to the pointer oinfo. If the return value of
ocfs2_global_read_info() at line 709 is less than zero,
oinfo->dqi_gqinode may be not initialized. However, it is accessed at
line 775:
  iput(oinfo->dqi_gqinode);

To fix this possible uninitialized-variable access, replace kmalloc()
with kzalloc() when allocating memory for oinfo.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 fs/ocfs2/quota_local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index b1a8b046f4c2..4c1219e08b49 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -693,7 +693,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 
 	info->dqi_max_spc_limit = 0x7fffffffffffffffLL;
 	info->dqi_max_ino_limit = 0x7fffffffffffffffLL;
-	oinfo = kmalloc(sizeof(struct ocfs2_mem_dqinfo), GFP_NOFS);
+	oinfo = kzalloc(sizeof(struct ocfs2_mem_dqinfo), GFP_NOFS);
 	if (!oinfo) {
 		mlog(ML_ERROR, "failed to allocate memory for ocfs2 quota"
 			       " info.");
-- 
2.25.1

