Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D9131E482
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBRDXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBRDWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:22:49 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB3CC061793
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:21:57 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id z190so873036qka.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbzAry+HXVVk5Jw3yl75zypO/Gw5eoDiCnFu+DpRBBk=;
        b=yF7SUFMop4IDVBG98n7+ZbBZHJheC/4KAcnWw/1ax2MwIwqSBdy7MP6qvpRcdh3uRt
         ZPFgnOgEr7a+fQAziXK0cxLsCBGPtulyeklqoz75kUCYt/tIcfIdmQ8dJ/+4uR1s28au
         +pJDJyqMi9XBpsm//9zVO+Fi3fBXjiyE7K/TCzR92js9LsPn5stQm4z0M4UVnmvlmQ49
         //HJrasc+i2VF9uvs6lrkrBhJYIeG4bFyaKlqZ246vBPjIs1DeYgdFo47nlro6SHYomc
         VGdFuv9HLh61j8F8mWdAUucx4/ld/p6jPjsKerlTgPJgx3EkXgLVdIkx9BZ55ULtPgeZ
         GhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbzAry+HXVVk5Jw3yl75zypO/Gw5eoDiCnFu+DpRBBk=;
        b=Nf8DplWKg4Dl8kVXK/N1OqCP78d4+YIYytcXdJ/HzYMhVnWH6PXYFNEI7V7WuFoYvN
         eUfqx1odeshlTHDaXVk2WS56B91byABZfsPHP+Betcoa06pfl02XKHCjFAHd7XgAUd/6
         7uFrXBYJxxF2D03R+46xdN3X0L6MOYvyWCCdftYPrgQo5jUXspKzaYItWAG5Ysk3jCpM
         RPir4QT2I7Q9K8zJ+zLhFdBefYR17zlbHHU4ZIJhzXwOS1asO4Fw7MwAI9KtEL8QrLpY
         7pmDemG1ruDiDpI8DSxJe1CGBReVP1Nfl7Pc7Mh/suUS351hf6sU7CFOJibiHLVyZGuc
         qaew==
X-Gm-Message-State: AOAM530gFEsDGAbfmv9pYn9No7/lWURkqTlvto0AZM4IK9DjKDROFkfA
        H2kgeTGS/lJ0UE2+rFv2UDdZDg==
X-Google-Smtp-Source: ABdhPJxRK1DQ7tsuLb3QYOvAaidyikcDIbIYXr2LzwaZh7+HJwOPO7u59wly1cuPy9ZZohx1e6M++Q==
X-Received: by 2002:a37:6ca:: with SMTP id 193mr2428821qkg.436.1613618516468;
        Wed, 17 Feb 2021 19:21:56 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id b24sm2578996qtt.44.2021.02.17.19.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:21:56 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     srinivas.kandagatla@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] fastrpc: move fl->maps list removal into fastrpc_free_map
Date:   Wed, 17 Feb 2021 22:20:54 -0500
Message-Id: <20210218032055.28247-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210218032055.28247-1-jonathan@marek.ca>
References: <20210218032055.28247-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the incredibly broken behavior of fastrpc_context_free(),
which calls fastrpc_map_put() but does not remove the map from the list
when it is free'd, causing use-after-free errors.

fl->lock needs to be held not just for list_del(), but also kref_put, to
avoid a race condition with fastrpc_map_find() logic.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/misc/fastrpc.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4fabea0c1551..170352b43ab6 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -245,19 +245,21 @@ static void fastrpc_free_map(struct kref *ref)
 		dma_buf_put(map->buf);
 	}
 
+	list_del(&map->node);
+
 	kfree(map);
 }
 
 static void fastrpc_map_put(struct fastrpc_map *map)
 {
-	if (map)
-		kref_put(&map->refcount, fastrpc_free_map);
+	spin_lock(&map->fl->lock);
+	kref_put(&map->refcount, fastrpc_free_map);
+	spin_unlock(&map->fl->lock);
 }
 
 static void fastrpc_map_get(struct fastrpc_map *map)
 {
-	if (map)
-		kref_get(&map->refcount);
+	kref_get(&map->refcount);
 }
 
 static int fastrpc_map_find(struct fastrpc_user *fl, int fd,
@@ -351,8 +353,10 @@ static void fastrpc_context_free(struct kref *ref)
 	ctx = container_of(ref, struct fastrpc_invoke_ctx, refcount);
 	cctx = ctx->cctx;
 
-	for (i = 0; i < ctx->nscalars; i++)
-		fastrpc_map_put(ctx->maps[i]);
+	for (i = 0; i < ctx->nscalars; i++) {
+		if (ctx->maps[i])
+			fastrpc_map_put(ctx->maps[i]);
+	}
 
 	if (ctx->buf)
 		fastrpc_buf_free(ctx->buf);
@@ -1103,12 +1107,8 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	fl->init_mem = NULL;
 	fastrpc_buf_free(imem);
 err_alloc:
-	if (map) {
-		spin_lock(&fl->lock);
-		list_del(&map->node);
-		spin_unlock(&fl->lock);
+	if (map)
 		fastrpc_map_put(map);
-	}
 err:
 	kfree(args);
 
@@ -1185,10 +1185,9 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 		fastrpc_context_put(ctx);
 	}
 
-	list_for_each_entry_safe(map, m, &fl->maps, node) {
-		list_del(&map->node);
+	list_for_each_entry_safe(map, m, &fl->maps, node)
 		fastrpc_map_put(map);
-	}
+	WARN_ON(!list_empty(&fl->maps));
 
 	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
 		list_del(&buf->node);
-- 
2.26.1

