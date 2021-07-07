Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE073BE5E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhGGJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhGGJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:51:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF4C061762;
        Wed,  7 Jul 2021 02:48:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a127so1604634pfa.10;
        Wed, 07 Jul 2021 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g65fz9nM8vuwTrmBSnevy9pcjESld9hrzhcHi3C3t4A=;
        b=ikrRirSr4cUmzEpdQmmFKc3izLb2YT7TEKkwWpA/6cJD74N7eMpo5j3U53PUJo1R0q
         CRonVthx/k2QMQG8mWc0UBQ2khL/d6GA+IxHqHfVXC/7+lSE0YM+TrqdilRXESMVh1ZH
         pqzRavBwP/YobXByESncEa1Y6EeZaf01367AMDI1gh2p3pEiGiL9/sfnOWcW3Qklw3Ba
         qXQwifUzvGFIDdCbZ/VZN9LJ0X7TlF3Wf/cLY08XOESlyb9Ck3IaDUG9edOp1NEieHwJ
         NFqzqa49e/h9nXKcaQC0MG42XoFkJlq5HjRmSxBgzBa0KtCVS34V2VAoi1T0FmBedHV+
         wFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g65fz9nM8vuwTrmBSnevy9pcjESld9hrzhcHi3C3t4A=;
        b=Q+nqScUHtflFAT4xHvI50OXx2th1sJhIOVfdYSCeiPFTHG9qj5mLpdRQjqHA2hvf/c
         zu5jqJUtkRNeMRzboP7MITuQImo1FBklfq1dgdQ+Ox9uWoBfqB937UW/Og4aMEOI3NNg
         n/0QO0uiJBfm3Lujjb8Qs0Mbluo6xgCHf+CV6ZvxmRmymFMwTHKFUM1sHPtUcQE+7+1Z
         M8lQCQPnx0RzIo0ousflYqZ267Y1qkRhu7gJKbvHA9TkkMP+AIblbW6EL4zfwJrnzQAi
         pz/mkD9VVSYZue+I4M6lxzho10+m7DB99GvTKOONZJVkUpxsbwkTfNmaU6Y5QnYlbfvV
         x4KA==
X-Gm-Message-State: AOAM532iBChIuG1zjrFyE/7QWIGXg485UlTcQjc2EZtPjEq5XKQIGQdS
        Ns2MfNKSjnibLIcct7F3ACA=
X-Google-Smtp-Source: ABdhPJyC5ySeJZHvaP9X87CXIp3oMaWO3ATcv9297oj5/4SWEPf2A49YcYrx5eFusVdUPu1uoQOYqQ==
X-Received: by 2002:aa7:9216:0:b029:2e5:6989:4f1a with SMTP id 22-20020aa792160000b02902e569894f1amr24373120pfo.50.1625651323405;
        Wed, 07 Jul 2021 02:48:43 -0700 (PDT)
Received: from carrot.localdomain (i60-35-90-140.s42.a014.ap.plala.or.jp. [60.35.90.140])
        by smtp.gmail.com with ESMTPSA id gd19sm80137pjb.38.2021.07.07.02.48.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jul 2021 02:48:42 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] nilfs2: fix memory leak in nilfs_sysfs_create_snapshot_group
Date:   Wed,  7 Jul 2021 18:48:25 +0900
Message-Id: <1625651306-10829-6-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
References: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nanyong Sun <sunnanyong@huawei.com>

If kobject_init_and_add returns with error, kobject_put() is needed
here to avoid memory leak, because kobject_init_and_add may return
error without freeing the memory associated with the kobject it allocated.

Link: https://lkml.kernel.org/r/20210629022556.3985106-6-sunnanyong@huawei.com
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 34893a57a7b9..44b9ad70a564 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -208,9 +208,9 @@ int nilfs_sysfs_create_snapshot_group(struct nilfs_root *root)
 	}
 
 	if (err)
-		return err;
+		kobject_put(&root->snapshot_kobj);
 
-	return 0;
+	return err;
 }
 
 void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
-- 
1.8.3.1

