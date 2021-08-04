Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839A43DF95B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 03:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhHDBp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 21:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhHDBpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 21:45:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAB8C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 18:45:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a20so1317470plm.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 18:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vNRaHSjm+7RgDJm/dANaaa1Byd60xBWxjojsFb0do0o=;
        b=Mp6mia+HG2mtMdqaolb2nl+HRUpIXgBSCat+o2FWXeZW8+nSOlwB47V8YSQ0HTUkM6
         /m64aBvS0GF71Ew/IlyVSKfsP2dn6XiDTOMdnDmJdvH0kFteMwC/Vq+orNNQTrX0IGuc
         uOJ/gopdHrNfoNe691bsKcnzIKGhHaOSqX2FGMThGp+W8QZHvfoaPWsQe18nhNCSrCnt
         IDj4KHH7qfZqfK35IGf6KkOSjLjXDC2proTiFN3sZP39mebU7GMueHoi2SULQXa942uy
         uxyDHPOOBZyGAK/tCJWtj+R0f6ASx0+WUCw8R8jcUv8FJH2BSmBOnod4801y7qU2dYkm
         4p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vNRaHSjm+7RgDJm/dANaaa1Byd60xBWxjojsFb0do0o=;
        b=XmP8o+/lS7EBV2q494vLZXPnnuWMoxEtAxh8ctO2AlR+AXyOhWFMJgXx3Oh1LV+sz3
         Hcxn63EY+lqS7adxfvkiUu2739MJ7UTDN5SaD5nl0ZVAzpul5tCfjzztAZ9KY3Dt7ywW
         nZcNbq+29mG1iMkJoq0gSO7TGwKYH6EoU0H/wurF8ioEl7jJ5gIbktIr7zuslYCYHbgw
         2yHACqTfkpKo/ZqHhpYuPNV07XKSl6mj8dk8VAQFHVCojn7hn5rZvZvHxDHgDxfSwAgE
         Qmqq4+RNPtDDB7jT/YwIdsoqNPHF9Hj+sMC0I2DXXHSBfDcxX6YcbKuJOFMdUIYB0Coy
         K2/Q==
X-Gm-Message-State: AOAM5308n17XSNJKNuH2TNSv+qSrLIs1llHJmMog55qtSw6qipd1knC1
        fu0brUJnOCNHMYMQ8oou+gk=
X-Google-Smtp-Source: ABdhPJzvR7WL4YbOVs8dGOps/kNt0aGMdVazGuJMy9N1YWA78Orj60RxPGiOlM59xnaKqvoAV/QUjA==
X-Received: by 2002:a17:90b:344:: with SMTP id fh4mr24879918pjb.29.1628041541758;
        Tue, 03 Aug 2021 18:45:41 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.49])
        by smtp.gmail.com with ESMTPSA id z124sm476074pgb.6.2021.08.03.18.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 18:45:40 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Tuo Li <islituo@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH v2] ocfs2: quota_local: fix possible uninitialized-variable access in ocfs2_local_read_info()
Date:   Tue,  3 Aug 2021 18:45:10 -0700
Message-Id: <20210804014510.29430-1-islituo@gmail.com>
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
v2:
* Replace kzalloc() with NULL assignment to oinfo->dqi_gqinode.
  Thank Joseph Qi for helpful advice.
---
 fs/ocfs2/quota_local.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index b1a8b046f4c2..de5aae584d5d 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -703,6 +703,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	oinfo->dqi_type = type;
 	INIT_LIST_HEAD(&oinfo->dqi_chunk);
 	oinfo->dqi_rec = NULL;
+	oinfo->dqi_gqinode = NULL;
 	oinfo->dqi_lqi_bh = NULL;
 	oinfo->dqi_libh = NULL;
 
-- 
2.25.1

