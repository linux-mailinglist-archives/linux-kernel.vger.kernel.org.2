Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7CA401CEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbhIFOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243062AbhIFOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:23:35 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E65BC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 07:22:30 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c17so6998686pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w89QJOJUofr5afp33CsgBGmBRnz5Ud0ct/p4R26CQ/M=;
        b=0y0XkLZwrpYFfSPINqXEhaFQFR0DS/S6j2k4uMY+9xKwngUTJUKdo/6QOR4acOMcR0
         Km3nIjmjEdA2xuEIa8mGl8sTM+HdV3eRs8T5ICkiMrTP0Js1D+AVlFNtXbfK5BZ0gMO7
         Bb0JpFk+KE5T4ZDTnjKk8qopqcWZbBH3rYt1OsQ3p1xrP7rYsr/VP//XHNthjS27Xo6M
         r/tZQb/sMjLJE1Lvoo5/ZQvfWoLGmzFUYcM5rKBIVdHBP+UVEDryL8+yHv5xer61C2qf
         snCYg2ibchFf1YEq5xXz5g7hCMW5U6cqzpwEexRgm1Geet07RS1agnrYNp8dESC9mT1i
         W/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w89QJOJUofr5afp33CsgBGmBRnz5Ud0ct/p4R26CQ/M=;
        b=VV507cHG1K//aE/cOMncxSkZeutTRquhQY/R37qB4EJG+HPFQUx2oLm+sSwAI1LLN+
         XG79GOF1IQgBUlLDThbG6PB1v6hmBSPy+cmkP7v+U9oxaXk57hnBBDumrYM2KXizSzGJ
         pvtdg6ROJbqO6Q2gwysghA7Mi5phF900GlVP6uIYjr9YDiiF0eOOMt059uzk9+zX8YK/
         S2FcWwAdNS+3dg4WnMgw2nkU6715SWimlqgciwbebdiXCtyFvBnXc9z4oqv6lGXvkxOa
         6Qm+Yzuofs0eCHLFZ02/fb6UgDXlqu7T6pXWVHcmNw4x5SKDnTrrNIm1QUl95EN5Ti5B
         gXrw==
X-Gm-Message-State: AOAM530nt2tvSnJneaenscu9XXke2ulnRHQ1Io1azFZXkrmQLwVK0Zwz
        QHNMf5l9U0rE69qTxDLiTTHK
X-Google-Smtp-Source: ABdhPJw2AfCXXiCm9jYBqy59wbP1wID98KweZg1mdK7laFctasrZSnFREgOv8Tq+FNRMXqDBJSyngQ==
X-Received: by 2002:a62:8048:0:b0:416:2682:e56a with SMTP id j69-20020a628048000000b004162682e56amr2244737pfd.73.1630938150016;
        Mon, 06 Sep 2021 07:22:30 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id l75sm9470366pga.19.2021.09.06.07.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 07:22:29 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vduse: Cleanup the old kernel states after reset failure
Date:   Mon,  6 Sep 2021 22:21:58 +0800
Message-Id: <20210906142158.181-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should cleanup the old kernel states e.g. interrupt callback
no matter whether the userspace handle the reset correctly or not
since virtio-vdpa can't handle the reset failure now.

Otherwise, the old state might be used after reset which might
break something, e.g. the old interrupt callback might be triggered
by userspace after reset, which can break the virtio device driver.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 59a93e5b967a..61695521066c 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -665,13 +665,11 @@ static void vduse_vdpa_set_config(struct vdpa_device *vdpa, unsigned int offset,
 static int vduse_vdpa_reset(struct vdpa_device *vdpa)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
-
-	if (vduse_dev_set_status(dev, 0))
-		return -EIO;
+	int ret = vduse_dev_set_status(dev, 0);
 
 	vduse_dev_reset(dev);
 
-	return 0;
+	return ret;
 }
 
 static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
-- 
2.11.0

