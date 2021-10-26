Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519E943BC62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhJZVbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbhJZVau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:30:50 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2D0C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 14:28:26 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w193so581662oie.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=otYjN9az6nPkaATonKfc0dOSOmU88ZE1cbGt7BRctxc=;
        b=LkZysTXZ1DLHHxC1+y//iILNS0jCdiDf7gt/eQBdMPlBlkZAdvOEIWTkIy+ccCp3SA
         189WXdO1AIjmaqPRr5f69d9/nUo9mTV7e/lZQAbvbHgR1xCEQcUThTgoJ6Iea+VxovNi
         Iku5ecZisAZ6fwmNDF0Dtg0sudQM6QbkhdzOsBmyBqnJVa6D46+cyk/kzeRZJxv1gpBL
         KsePun7Y0iarfnQDyj0G5XpomLbA71q4PSK9WiP+iUAicjTS5hzMa65Ki6o+aPyZLHLw
         50L5eYIHN3qEZLQJ8+vSErXxsCt9GGl8/pAoqPZlyXCISCCWLiPk/dG8s2F9zoFuUxeE
         MrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=otYjN9az6nPkaATonKfc0dOSOmU88ZE1cbGt7BRctxc=;
        b=gi1w01YA8FSdqlvLPlMnD2cOATAt/H4hGOFI5dkYUEehD7AAihcHUrZS85g6KwZ7GE
         bhmz0IXnwIM71L8jIir4CQdoPMPW5IScKl42Hubsdt562/PHAP0GanHbV4blFRWa30ec
         HWKniYPnSJOs2ZHXJa4bCDxR0I3BYnFlaygXv8HZTEBICz7Qjy/hEblEdCfmfw26l0t0
         XAqBFC4L1Uedy2XtlDwXrFjV8zlo/iGtuZBd8QgYWIcSgI8wvyh8MnM8yfRdwp4sgIrv
         p+LohqXEDOUCbaEj1P2rFBxYrpG2YwL7/AN1t7CeE2RfmWSnngXicy5ho0jE+saU119y
         dKdQ==
X-Gm-Message-State: AOAM531UXecBLxdahqZpJNY2uu2ob0QyVQ3G8cEkdq7qDz+Fy7EZ5WO9
        i6I6KjGKAXtgJEf4I49p7UI=
X-Google-Smtp-Source: ABdhPJwy5RmaUkFv5Tt+YnFiDI9CTREkD2Bnd8jXOqWsQLf1wpGJQ+IMxbzdNO5ggIyDyFrpK/iA3g==
X-Received: by 2002:aca:4356:: with SMTP id q83mr953667oia.157.1635283706144;
        Tue, 26 Oct 2021 14:28:26 -0700 (PDT)
Received: from localhost.localdomain ([181.23.91.138])
        by smtp.gmail.com with ESMTPSA id l26sm5002623oti.45.2021.10.26.14.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:28:25 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH] staging: vchiq_core: get rid of typedef
Date:   Tue, 26 Oct 2021 18:27:56 -0300
Message-Id: <20211026212756.25557-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of typedef and use proper kernel type instead.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c  | 6 +++---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h  | 4 +---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index ab97a35e63f9..7fe20d4b7ba2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -711,7 +711,7 @@ reserve_space(struct vchiq_state *state, size_t space, int is_blocking)
 }
 
 static void
-process_free_data_message(struct vchiq_state *state, BITSET_T *service_found,
+process_free_data_message(struct vchiq_state *state, u32 *service_found,
 			  struct vchiq_header *header)
 {
 	int msgid = header->msgid;
@@ -767,7 +767,7 @@ process_free_data_message(struct vchiq_state *state, BITSET_T *service_found,
 
 /* Called by the recycle thread. */
 static void
-process_free_queue(struct vchiq_state *state, BITSET_T *service_found,
+process_free_queue(struct vchiq_state *state, u32 *service_found,
 		   size_t length)
 {
 	struct vchiq_shared_state *local = state->local;
@@ -1981,7 +1981,7 @@ recycle_func(void *v)
 {
 	struct vchiq_state *state = v;
 	struct vchiq_shared_state *local = state->local;
-	BITSET_T *found;
+	u32 *found;
 	size_t length;
 
 	length = sizeof(*found) * BITSET_SIZE(VCHIQ_MAX_SERVICES);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 3e50910ecba3..53a98949b294 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -74,9 +74,7 @@
 	((fourcc) >>  8) & 0xff, \
 	(fourcc) & 0xff
 
-typedef u32 BITSET_T;
-
-static_assert((sizeof(BITSET_T) * 8) == 32);
+static_assert((sizeof(u32) * 8) == 32);
 
 #define BITSET_SIZE(b)        ((b + 31) >> 5)
 #define BITSET_WORD(b)        (b >> 5)
-- 
2.33.1

