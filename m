Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DF93BE5DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhGGJvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhGGJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:51:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645DDC061574;
        Wed,  7 Jul 2021 02:48:36 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v7so1660882pgl.2;
        Wed, 07 Jul 2021 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nDphwP7rk7MVmmwi41RmQwruvzgJtyrk5UC8vBfmCnU=;
        b=HAwqV7SRwg6Bmoo+IUskz5DjJH8OArmVvNbXrAsMJFs1WKQPXL4k8BMKwnvr8tsADx
         V+Kss4NWm4EsIyxBLRXjn20jxwQac+LwPilRbQCebnzRO9fHHDPUfsOLIyd1aflsfhrY
         eZRG9VycHCBnh9ASsKcssnV5YuYaHu7v5YQ9E0AL7uLvzx/E3KFR4DhrMCg7dAm/GuNX
         XSFQYJF47N/D9cKiDGVJEzWca8GP3OU8YxzWzS9DKK9tR7P0gc+uvIeEXzxjB/J1O3W5
         J7Zj9lYBjV0FGeERQcv0rBKI2/E6tv32w3NdOFSSr+kxAI7duSNB5bg/mAKgPGnfaSjh
         LJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nDphwP7rk7MVmmwi41RmQwruvzgJtyrk5UC8vBfmCnU=;
        b=D8ko6DHvKA8GFJm0J9HTwneW6BZu+T3/nDXWaNWepbhRX3bD5iUmVgoAJljaNPB55p
         4o6vHsExfP555awOXzsYTLXwVoZVO7t43OzDAC6U9wJnsBYfWhQBrHwkzeXeDmSCEZu1
         ghyOhdKqwSJmbMaTaI8R82FEHVNyKGGQnCWLGyncGV3XGEpyGb7J3nNfNqcqdEgNQJfM
         DqwnYjYcdxwMoUE3eYowW28oWa8gE+m1r5Md9Cyng851H6g55JfQsm68FPNcSz9EWUkP
         bNpym7A5LB2Wj8u58XVSByAUtdlUAm3sordO+zaMO8Z/gXyv7TxhJ4xFAZXOq4QrnSi4
         SyOg==
X-Gm-Message-State: AOAM5300twUNODA/65DuC0hibA/tDtYwst2ztJ0yLDGmfbcmoozqes3T
        5jg2u6jDztn0aU1G+mUvUr97JsKEf1I=
X-Google-Smtp-Source: ABdhPJwfBIm//0vrmwiLiPS+54Mmlpi6N+akqfKIqHiRb/aTPnQA4/MVR19oI8H7s/cNwoVt3/1o8g==
X-Received: by 2002:a65:62d8:: with SMTP id m24mr25729228pgv.150.1625651315958;
        Wed, 07 Jul 2021 02:48:35 -0700 (PDT)
Received: from carrot.localdomain (i60-35-90-140.s42.a014.ap.plala.or.jp. [60.35.90.140])
        by smtp.gmail.com with ESMTPSA id gd19sm80137pjb.38.2021.07.07.02.48.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jul 2021 02:48:34 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] nilfs2: fix NULL pointer in nilfs_##name##_attr_release
Date:   Wed,  7 Jul 2021 18:48:22 +0900
Message-Id: <1625651306-10829-3-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
References: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nanyong Sun <sunnanyong@huawei.com>

In nilfs_##name##_attr_release, kobj->parent should not be
referenced because it is a NULL pointer. The release() method of
kobject is always called in kobject_put(kobj), in the implementation
of kobject_put(), the kobj->parent will be assigned as NULL before
call the release() method. So just use kobj to get the subgroups,
which is more efficient and can fix a NULL pointer reference problem.

Link: https://lkml.kernel.org/r/20210629022556.3985106-3-sunnanyong@huawei.com
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/sysfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index b6a48492fed2..43f660beb9b4 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -64,11 +64,9 @@
 #define NILFS_DEV_INT_GROUP_TYPE(name, parent_name) \
 static void nilfs_##name##_attr_release(struct kobject *kobj) \
 { \
-	struct nilfs_sysfs_##parent_name##_subgroups *subgroups; \
-	struct the_nilfs *nilfs = container_of(kobj->parent, \
-						struct the_nilfs, \
-						ns_##parent_name##_kobj); \
-	subgroups = nilfs->ns_##parent_name##_subgroups; \
+	struct nilfs_sysfs_##parent_name##_subgroups *subgroups = container_of(kobj, \
+						struct nilfs_sysfs_##parent_name##_subgroups, \
+						sg_##name##_kobj); \
 	complete(&subgroups->sg_##name##_kobj_unregister); \
 } \
 static struct kobj_type nilfs_##name##_ktype = { \
-- 
1.8.3.1

