Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EDC31F6F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhBSJ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhBSJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:59:22 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E73C061786
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:58:41 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n10so3603987pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9R7TqZBC+3ku7IayrARzfjApMcK4UJZfz3xwuRBDZoU=;
        b=rhErhTWx/rsHtg84Tlq7Cl7aiIuZldMn3rlvsQySywuE5mIExqh/EcuMe/5uWqrWPc
         X0ZH3JU4Zo89eG/pq638CmZlwvdgC38EOLXdEtxuq3yTiqJ6FhNQl0KTe1NGTrcYr3GA
         /wwmNNzHuMUfldh5rACGTQAsR6CvtAq9BghUN3CkLx4HSHLB/Ht8lFAuRFFxaOpUrwuK
         KnPC5notjGtMan8Yi6EBaU7TU8ZPFd4cBkVROLlOJUlPimpuszdwRbzb82yVSd/Ob/DG
         bbD8pqcc2ZcT1ZGyyCCsmzG7JJmpi6fFfnhamrD+7bgdAatTQFYSDKuFGillgc14GMOP
         rBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9R7TqZBC+3ku7IayrARzfjApMcK4UJZfz3xwuRBDZoU=;
        b=evO4GmwwK4hvifrVKj9UC3+HdOEJ/Bf7vB6uzT5hjHXCh3SuOUSd/Dfxxjygb96jB6
         WgdMFcu1lZHERTxMt0rYqKkqvAtfZfjOBkb0KIuIs33zGkm9oA6pUp36srgMD0Iutc5m
         sZNFlHI36BPLpn633t8GZsqj7tlWoi74lAQGmSjRafxYB2Hg534Fe5qcpoJkUYIYWaPG
         7goD6QrCzzLuCQhlns2hHkUEu204mMRYcZVeTNCv99rqixP3CG5/MvVKBxdnInoBv0pi
         aSlTsWm1xFxzReQFNuHUQhMSEMMQbmDIHBvCrZg51qgBGoQw6xi5SpEKrnDshst9Uuy/
         oHNw==
X-Gm-Message-State: AOAM530E5Q9TvTqngum04VthAZFWRVLwAtaHMbKE6DHhCN4Vh5zwsjQj
        l2F14dAui9vy36ludCAVB5A=
X-Google-Smtp-Source: ABdhPJwfXKl74BMTlb9TrVSg1BpPcW2GcKyq81oK/YUci3i9Db+JCllTh0I19NhAodM+qs1oBsVSDA==
X-Received: by 2002:a63:4e44:: with SMTP id o4mr7970778pgl.46.1613728720586;
        Fri, 19 Feb 2021 01:58:40 -0800 (PST)
Received: from localhost.localdomain ([116.73.181.117])
        by smtp.gmail.com with ESMTPSA id i15sm3980371pjl.54.2021.02.19.01.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 01:58:40 -0800 (PST)
From:   Selvakumar Elangovan <selvakumar16197@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        tvboxspy@gmail.com, oscar.carter@gmx.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] staging: vt6656: fixed a CamelCase coding style issue.
Date:   Fri, 19 Feb 2021 15:28:35 +0530
Message-Id: <20210219095835.9687-1-selvakumar16197@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase macros uVar and uModulo into u_var and
u_module in device.h

This issue was reported by checkpatch.pl

Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
---
 drivers/staging/vt6656/device.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index 947530fefe94..6615d356f74a 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -385,11 +385,11 @@ struct vnt_private {
 	struct ieee80211_low_level_stats low_stats;
 };
 
-#define ADD_ONE_WITH_WRAP_AROUND(uVar, uModulo) {	\
-	if ((uVar) >= ((uModulo) - 1))			\
-		(uVar) = 0;				\
+#define ADD_ONE_WITH_WRAP_AROUND(u_var, u_modulo) {	\
+	if ((u_var) >= ((u_modulo) - 1))			\
+		(u_var) = 0;				\
 	else						\
-		(uVar)++;				\
+		(u_var)++;				\
 }
 
 int vnt_init(struct vnt_private *priv);
-- 
2.17.1

