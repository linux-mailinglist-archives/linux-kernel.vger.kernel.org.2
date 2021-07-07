Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FED3BE5DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhGGJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhGGJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:51:22 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78033C06175F;
        Wed,  7 Jul 2021 02:48:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f20so1637357pfa.1;
        Wed, 07 Jul 2021 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jm/J1o+TQpzcHBhxjA/suPmsl2pJmPGx91gwOJgbshQ=;
        b=SnViRNeGD8tPxOTvIR/wc5IFDeE9SYmRwqPj+In9bmtPibgokbUlvYrXcxnslfFu1w
         NyZ+anSqC5rW0YYwF5IXRm1AVD+Uoq2c3DFVlSgXzu7bmSE3LGDG7MjVJAQ6lL/j0FqA
         uT6eDsjlB+ucP+nBjr4H5XdQfO2dut2uTlHyL1TIZOPvDcvTu7Pq6RXZr+G+r062SVPd
         VPG6HfnSZzgxUPSmPRrE83sloro8UBVHYV7/mXC/fRMWqTDuXn2q4xgsHZiMeRS8YeNS
         Rz1p4ytOfbN8Fd38Ces8T4UleMd3hEgYPs+WLYp+qYHDc7gnEv0uz5bOsbtslX006L87
         6JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jm/J1o+TQpzcHBhxjA/suPmsl2pJmPGx91gwOJgbshQ=;
        b=kXLtsw+zBEQCS5XVE68VMLlK/8K6WP6dAhNnrPMpN5fJwhI6nimIdDdxK0CvFQln2l
         zlqAqBlS8YxFNUCQriNiyfW8dVwPce26Xwt6RC1uS98bbl8r59JQdwqcxULhpm/HZTj4
         0Y0rdMVShQVZ1sTQUpP3lGERfFXJUPmHnEyPkU2ZAOLE1gX1exX+pVnnF+QgBPhZ9nXt
         h5oNODrjD88RNixiKVYSlEso3Un22Y5ATvdF7FrMFKOrDEjQ1SyvM462xgcxjUIQRe8D
         +iVy6rD0XVxYCJpPG7gcfIs8XttaS+mhzGvsWy4Vbrm9JZ/TfwtfaXLqoQ39lnc2H/NJ
         BX8g==
X-Gm-Message-State: AOAM533tXqpW68T1U8wkfgI2mVjxWRiLjtWkmV6qN0yO3O/Wx7EeMhUA
        PNJ7fQzXC9i73PpY2/QjGPE=
X-Google-Smtp-Source: ABdhPJxogaYCSZCQzT0o0sXg+0YvYaC4mpAb/flGEhY0tbztFRf0RjxXN6TRmgqxa//e65djEn8j5w==
X-Received: by 2002:a63:2b91:: with SMTP id r139mr25048297pgr.242.1625651321000;
        Wed, 07 Jul 2021 02:48:41 -0700 (PDT)
Received: from carrot.localdomain (i60-35-90-140.s42.a014.ap.plala.or.jp. [60.35.90.140])
        by smtp.gmail.com with ESMTPSA id gd19sm80137pjb.38.2021.07.07.02.48.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jul 2021 02:48:39 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] nilfs2: fix memory leak in nilfs_sysfs_delete_##name##_group
Date:   Wed,  7 Jul 2021 18:48:24 +0900
Message-Id: <1625651306-10829-5-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
References: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nanyong Sun <sunnanyong@huawei.com>

The kobject_put() should be used to cleanup the memory associated with
the kobject instead of kobject_del. See the section "Kobject removal"
of "Documentation/core-api/kobject.rst".

Link: https://lkml.kernel.org/r/20210629022556.3985106-5-sunnanyong@huawei.com
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 5dc468ff5903..34893a57a7b9 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -97,7 +97,7 @@
 } \
 static void nilfs_sysfs_delete_##name##_group(struct the_nilfs *nilfs) \
 { \
-	kobject_del(&nilfs->ns_##parent_name##_subgroups->sg_##name##_kobj); \
+	kobject_put(&nilfs->ns_##parent_name##_subgroups->sg_##name##_kobj); \
 }
 
 /************************************************************************
-- 
1.8.3.1

