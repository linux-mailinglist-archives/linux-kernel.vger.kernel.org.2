Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDC23DF9F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 05:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhHDDTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 23:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhHDDTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 23:19:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DC3C061575
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 20:19:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so6807784pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 20:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u4aFCESye5oCd8ozjWGaxQW4ltU+c58Zn/mosfi41Qk=;
        b=sBRpsCCaNk+En3W3/NK1zH/s+E8dbPlJMJ+liIl1ikHzk8HHY0hD9W/cHNaJdoZ1y/
         X/ZYcLnaifou9iyEYW/SZzIqjF0cWFi27sMlSMYU5apsVAj+2nVYDWZRa84qRHZSE07J
         L9cZ7AvkcRwKP4DBX81rK0LaM+++sPIvHEdNgnRG3wTbMQ7rzWu6LTNA4cQy4uqhUB6d
         HhfrUK6sR0Z+673hjAGqJo56hhzT5MIjqoRk8x11YyHAGohWBut0kUrE0Uv8Vek2E5HK
         LZVlyRp1x1JUZGO8vrzykDvSmLG76hEDk2w3fZRoZG0bmDQeMJL3q4dwOvyUpH1PhQbj
         p0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u4aFCESye5oCd8ozjWGaxQW4ltU+c58Zn/mosfi41Qk=;
        b=Xg3P4l0z3BYNupstbTgRKEl8GVceyGCsM8N4JtCE0aJcL1F2f12p381MgKDNCd4thI
         FNOSoRuP83cSAL0W4P11S/EduMKUHUbZ9RoyzAmO68CxeHUrWyIexOzW3EV8O1bJgs1n
         8mUBioOAl3XCOUPmaXMzugQbrYnJndwpXYupVjii5OGpWJdaynGwxvjxcstpCn5suE0H
         43eJrBO14/uhgJ0JopNiWJPpTvzLzd34atA9xt9mR4/KvvGT0VeT5k15a4GKtgXrSlr6
         cofHD+RTUTUDKSquE6MIpe0AZZjOZC2gONIAvBil5nDlFQb2KlsEXrnBfsUuR7AF7Cch
         WaJA==
X-Gm-Message-State: AOAM533j2sjA45TKb1jC58AFbsjcdwXbspRdB+400eK0G1pJR6cSQQyD
        TCkE7HR26Yc0elosQaraNCo=
X-Google-Smtp-Source: ABdhPJz+61y8oKEZlfd3ZvPj6B8cKNOShRk6IRWj1jRpM4L3FfiirA4SGwI7cfg7qxH9R+XNXERoSA==
X-Received: by 2002:a17:90a:8a8f:: with SMTP id x15mr25373472pjn.161.1628047148651;
        Tue, 03 Aug 2021 20:19:08 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.49])
        by smtp.gmail.com with ESMTPSA id w11sm689514pgk.34.2021.08.03.20.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 20:19:07 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Tuo Li <islituo@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH v3] ocfs2: quota_local: fix possible uninitialized-variable access in ocfs2_local_read_info()
Date:   Tue,  3 Aug 2021 20:18:32 -0700
Message-Id: <20210804031832.57154-1-islituo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory block is allocated through kmalloc(), and its return value is
assigned to the pointer oinfo. However, oinfo->dqi_gqinode is not
initialized but it is accessed in:
  iput(oinfo->dqi_gqinode);

To fix this possible uninitialized-variable access, assign NULL to
oinfo->dqi_gqinode, and add ocfs2_qinfo_lock_res_init()
behind the assignment in ocfs2_local_read_info(). Remove
ocfs2_qinfo_lock_res_init() in ocfs2_global_read_info().

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
v3:
* Update description.
* Assign NULL to oinfo->dqi_gqinode, and add ocfs2_qinfo_lock_res_init()
behind the assignment in ocfs2_local_read_info(). Remove
ocfs2_qinfo_lock_res_init() in ocfs2_global_read_info()
  Thank Joseph Qi for helpful advice.
v2:
* Replace kzalloc() with NULL assignment to oinfo->dqi_gqinode.
  Thank Joseph Qi for helpful advice.
---
 fs/ocfs2/quota_global.c | 1 -
 fs/ocfs2/quota_local.c  | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index eda83487c9ec..f033de733adb 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -357,7 +357,6 @@ int ocfs2_global_read_info(struct super_block *sb, int type)
 	}
 	oinfo->dqi_gi.dqi_sb = sb;
 	oinfo->dqi_gi.dqi_type = type;
-	ocfs2_qinfo_lock_res_init(&oinfo->dqi_gqlock, oinfo);
 	oinfo->dqi_gi.dqi_entry_size = sizeof(struct ocfs2_global_disk_dqblk);
 	oinfo->dqi_gi.dqi_ops = &ocfs2_global_ops;
 	oinfo->dqi_gqi_bh = NULL;
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index b1a8b046f4c2..0e4b16d4c037 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -702,6 +702,8 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	info->dqi_priv = oinfo;
 	oinfo->dqi_type = type;
 	INIT_LIST_HEAD(&oinfo->dqi_chunk);
+	oinfo->dqi_gqinode = NULL;
+	ocfs2_qinfo_lock_res_init(&oinfo->dqi_gqlock, oinfo);
 	oinfo->dqi_rec = NULL;
 	oinfo->dqi_lqi_bh = NULL;
 	oinfo->dqi_libh = NULL;
-- 
2.25.1

