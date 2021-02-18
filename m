Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE631E481
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhBRDW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBRDWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:22:48 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F49C06178B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:21:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id b14so936471qkk.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CB9XXZYfCi92ZZqhIlrCBfKt5Eaz4xz7mSDsgtik5fw=;
        b=wl5Zo2Z1d3OkD2LnENDJgjZdiSWnw1Iz/Kv2CM1ReP7bjhwUINKTjRQwwXQPrusDIJ
         zuxizfG4SSYlDJQ31m/GRZRJKPRISiyrkxpcSW93kx7SuXbKaOGOxIcKx2Aj9Z8pRKA2
         /GMWSe7GYo09avXQZKThhcMyRSFHYzLZeStbP7luO0NxPUMsfDK/MLe7TkplCDRqM8GX
         d2KGWyULWVsgDbDd6leaubhx5cZhNvpNsOenox5jRDuiF7nn7BdvWEctnvhINUT/YhPu
         hhm//p09JNh9iI+up8x1qZrcr/0BZTWmofEuYPpLQBLL38EluyrGWebFD+6I7sZD5LLV
         81/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CB9XXZYfCi92ZZqhIlrCBfKt5Eaz4xz7mSDsgtik5fw=;
        b=ObutgN9/cfW7FGiWYNYlK0DSHBS59uXls/cjUvhoI2SJ3u/vtYt+uoJih1C7ayT+6c
         8Si8cmeI+1YcfOPq0b9O8k50GYCURa4xKPH/MtLaAv5eHm/QF0dyWID6QYlTdeZ+d785
         h0Heg/uQg6FajIRQgMCsfCwmtFPhvAjWNlGhLg219PUKjTo2q69lD6P+BJCVPqBNa7mi
         EWswEwZoDwVMGwZJ68Fw9o21NOqtT6coMzToymuVcuWkcpCA64UbBy5XSddnOM3qyQF9
         frkEwF8Y4Cn1/nca3Cpn3NXvZblKSd2K/xlXr5ZEZF+RRzWgrw6Ar3aQv0omcr6aVvWT
         ZTKw==
X-Gm-Message-State: AOAM531JVBRWzsVUSxSngUdGLy91/DMU3gbcBRVNY8s0t0aRTykRTCNd
        qcBzqLVsUJWr9U4mbGZHThLAZA==
X-Google-Smtp-Source: ABdhPJx0LPGJmVHgO0DEiZ5v+XPXXIsMGh5EN6oDPK4U/NqcLiiq1wtHxay96Bxkz+EMcZoTqF91Lg==
X-Received: by 2002:a37:a004:: with SMTP id j4mr2460502qke.450.1613618515303;
        Wed, 17 Feb 2021 19:21:55 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id b24sm2578996qtt.44.2021.02.17.19.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:21:54 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     srinivas.kandagatla@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] fastrpc: always use fl->lock and remove fl->mutex
Date:   Wed, 17 Feb 2021 22:20:53 -0500
Message-Id: <20210218032055.28247-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210218032055.28247-1-jonathan@marek.ca>
References: <20210218032055.28247-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the broken behavior of having a separate mutex for locking at this
place, and use the same spinlock that is used to add/remove from the list.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/misc/fastrpc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f12e909034ac..4fabea0c1551 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -230,8 +230,6 @@ struct fastrpc_user {
 	int pd;
 	/* Lock for lists */
 	spinlock_t lock;
-	/* lock for allocations */
-	struct mutex mutex;
 };
 
 static void fastrpc_free_map(struct kref *ref)
@@ -267,16 +265,16 @@ static int fastrpc_map_find(struct fastrpc_user *fl, int fd,
 {
 	struct fastrpc_map *map = NULL;
 
-	mutex_lock(&fl->mutex);
+	spin_lock(&fl->lock);
 	list_for_each_entry(map, &fl->maps, node) {
 		if (map->fd == fd) {
 			fastrpc_map_get(map);
 			*ppmap = map;
-			mutex_unlock(&fl->mutex);
+			spin_unlock(&fl->lock);
 			return 0;
 		}
 	}
-	mutex_unlock(&fl->mutex);
+	spin_unlock(&fl->lock);
 
 	return -ENOENT;
 }
@@ -1200,7 +1198,6 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	fastrpc_session_free(cctx, fl->sctx);
 	fastrpc_channel_ctx_put(cctx);
 
-	mutex_destroy(&fl->mutex);
 	kfree(fl);
 	file->private_data = NULL;
 
@@ -1222,7 +1219,6 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 
 	filp->private_data = fl;
 	spin_lock_init(&fl->lock);
-	mutex_init(&fl->mutex);
 	INIT_LIST_HEAD(&fl->pending);
 	INIT_LIST_HEAD(&fl->maps);
 	INIT_LIST_HEAD(&fl->mmaps);
@@ -1233,7 +1229,6 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	fl->sctx = fastrpc_session_alloc(cctx);
 	if (!fl->sctx) {
 		dev_err(&cctx->rpdev->dev, "No session available\n");
-		mutex_destroy(&fl->mutex);
 		kfree(fl);
 
 		return -EBUSY;
-- 
2.26.1

