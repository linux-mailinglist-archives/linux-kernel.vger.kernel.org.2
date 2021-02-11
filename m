Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFB4318736
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhBKJhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhBKJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:23:25 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A91C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:22:44 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z22so6179937edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDVSyysENqV9wDTbalaf8CRZt4zONvUxJg+BfYAS7Nk=;
        b=T/UL3ICN6LwRJXDz6q627qAvZ+8S92YizHIBLf/dtWLuL9bPjkxjfKbFQb/4BlPQDv
         DGVJ0Q5JPs+XZaMz5CUbP6vXGl91iRBi+gV8mvNoG6RMLyTpegs/MNnaUAh4iONp1dIW
         ith7Mw6qFGD/uEHeCmlfQg+ZLyyE0enqHm9gws6cBZ9m2PxrnsL6c828xyiIYbjygeHI
         KFAEFxKjSnQUxmBGUbjY41xFZ+ircIBtUzDx9Eec26GGH5zPKT//3qay81aO1iR/F3CO
         UmBrhjs668GGQHpV3NQNgIjxs43IXT1Q7uOZ0c7PK+rIg+miuYaUbgXCwEp98AAHK4jX
         x1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDVSyysENqV9wDTbalaf8CRZt4zONvUxJg+BfYAS7Nk=;
        b=XQdwHyJU47qAzFDoxV+V2gcoG3q/3eooukDm512fHwcgn77zr0Aw7gxzSsL3Bbs6I3
         g70ywWET5ahHwBOd845Eq+tEhLOtZNMzZZZBD6TiQ+0a8avJqd+LW1yy5/B1s/OcrWBw
         oaumztU05N4FZwx33KKOBdagGJpe8CygciyR/ij6GM1LcM0JmGdscx7Pxr2wikIWusJJ
         R8kqd/XfST0gwtxrp8stkdU63+1u+S9XDu9nkBLtjEDEh2NxfElNoCLrd2oRNaW4s8bx
         FJcxjqnfmCMw21chgQaEfrxGhP0DXxeBFnsvSBBF3Jxikxl27yqYz5bDHeWqJANVWuHH
         Jwpg==
X-Gm-Message-State: AOAM5333rtmuzq5u2pI5r+th+N/dwXr3zkxkDV3OFyzFB6zlsOi+hBDO
        /WoRtFue9nWggOY8l2i2q4+YI4akbHs/Sw==
X-Google-Smtp-Source: ABdhPJyoxbrNK0/P2UNTUBNwEA+TLB320ytqsYJxJGXc1jgp3iX5Q0575Jbg+uRjPLVjWAXFEJQP6g==
X-Received: by 2002:a05:6402:105a:: with SMTP id e26mr7198980edu.60.1613035362571;
        Thu, 11 Feb 2021 01:22:42 -0800 (PST)
Received: from TRWS9215.usr.ingenico.loc ([95.13.23.74])
        by smtp.gmail.com with ESMTPSA id ga5sm3779324ejb.114.2021.02.11.01.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 01:22:42 -0800 (PST)
From:   Fatih Yildirim <yildirim.fatih@gmail.com>
To:     gregkh@linuxfoundation.org, gustavo@embeddedor.com
Cc:     Fatih Yildirim <yildirim.fatih@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next] staging: ks7010: Macros with complex values
Date:   Thu, 11 Feb 2021 12:22:39 +0300
Message-Id: <20210211092239.10291-1-yildirim.fatih@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for checkpatch.pl warning:
Macros with complex values should be enclosed in parentheses.

Signed-off-by: Fatih Yildirim <yildirim.fatih@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 39138191a556..c62a494ed6bb 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -498,20 +498,20 @@ struct hostif_mic_failure_request {
 #define TX_RATE_FIXED		5
 
 /* 11b rate */
-#define TX_RATE_1M	(u8)(10 / 5)	/* 11b 11g basic rate */
-#define TX_RATE_2M	(u8)(20 / 5)	/* 11b 11g basic rate */
-#define TX_RATE_5M	(u8)(55 / 5)	/* 11g basic rate */
-#define TX_RATE_11M	(u8)(110 / 5)	/* 11g basic rate */
+#define TX_RATE_1M	((u8)(10 / 5))	/* 11b 11g basic rate */
+#define TX_RATE_2M	((u8)(20 / 5))	/* 11b 11g basic rate */
+#define TX_RATE_5M	((u8)(55 / 5))	/* 11g basic rate */
+#define TX_RATE_11M	((u8)(110 / 5))	/* 11g basic rate */
 
 /* 11g rate */
-#define TX_RATE_6M	(u8)(60 / 5)	/* 11g basic rate */
-#define TX_RATE_12M	(u8)(120 / 5)	/* 11g basic rate */
-#define TX_RATE_24M	(u8)(240 / 5)	/* 11g basic rate */
-#define TX_RATE_9M	(u8)(90 / 5)
-#define TX_RATE_18M	(u8)(180 / 5)
-#define TX_RATE_36M	(u8)(360 / 5)
-#define TX_RATE_48M	(u8)(480 / 5)
-#define TX_RATE_54M	(u8)(540 / 5)
+#define TX_RATE_6M	((u8)(60 / 5))	/* 11g basic rate */
+#define TX_RATE_12M	((u8)(120 / 5))	/* 11g basic rate */
+#define TX_RATE_24M	((u8)(240 / 5))	/* 11g basic rate */
+#define TX_RATE_9M	((u8)(90 / 5))
+#define TX_RATE_18M	((u8)(180 / 5))
+#define TX_RATE_36M	((u8)(360 / 5))
+#define TX_RATE_48M	((u8)(480 / 5))
+#define TX_RATE_54M	((u8)(540 / 5))
 
 static inline bool is_11b_rate(u8 rate)
 {
-- 
2.20.1

