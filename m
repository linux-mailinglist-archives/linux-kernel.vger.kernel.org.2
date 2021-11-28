Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764AB4607E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358899AbhK1RPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358561AbhK1RNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:13:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702AAC06175B
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:54 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v11so31347070wrw.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgDZB4IOfVNqZTR87ZkJaDoJSzG0JEfpGt4NxaNH5O8=;
        b=XHWsM9bGdj+C+ALNXaw7Cesk99xKLHDLbYk8FdSjGB8ryBu1cSZSB1QvdGOxIKQyJS
         K5lTZRchM4Oo9s+mzHz793uaTsP2+ymZWOHqDq3rUMB71eWa2erxS9s8gU77ykb3fCjK
         HYYmN7CemC5zORA+0vX6QoR+odrlvOngsNS7M/o073H9ueHNMtZdvQQdpb67574tBdHi
         1fEHy0VNSuyKHJcnUGXzx7uyw836rifM8BujtOhR9T/j6qLs75yfX4m/h4u16E0u6M1B
         9wjNxVYWPrMzySYq7agu+wkVUe+tk26kcn2QqFPF73u5fQZVXxz/Mw1JUTIxgxgapgT1
         XyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgDZB4IOfVNqZTR87ZkJaDoJSzG0JEfpGt4NxaNH5O8=;
        b=nj/lBrQBb4V/WuaV8qo+XlTMXe11y2AvTb7b6anq77epKM0F+BODjMDaLwqcovijjx
         ipFQYhRoTzgiq1eFRFsAt65NcwM6Xrlt9QWL3vVHtrsvSN8set7i06mfqnwzJWYBPI4j
         F9RdRrZTIGYNdI6SZ9rdA9q30/nPWQj9LSJ59kZq5lo7dDHSCfDMhSdwMvq5WX35RPtI
         vu8h7w41WAr2eyYkwEdcdcFyBuCWd26rhqghGQtpT+I3timu7JVOxhg9f2YdPueeD7gD
         Sr0D23Rvk3a9ijgjNZjRKl0b1WregZuPbxWU7wZKy/9iCrzOLW1eUKidtStx6QtXJa7i
         YJUQ==
X-Gm-Message-State: AOAM532VfGF7RtXdryl4N7VYUvWGdZBdSYWVAuIRomsAX0UHcu8Krcqs
        QR6TKRm7O7ZUpyi6OTkfm6g=
X-Google-Smtp-Source: ABdhPJy3YtK0RnONZD0mFCYUxzld5NHoCF57wM7gTyPXdnYBbSkmSxnpeVJ8fLX0U8WbCOLVO/93zg==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr28058733wrj.338.1638119393128;
        Sun, 28 Nov 2021 09:09:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id n15sm18243845wmq.38.2021.11.28.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:09:52 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 07/10] staging: r8188eu: remove rf_type from bb_reg_dump()
Date:   Sun, 28 Nov 2021 18:09:21 +0100
Message-Id: <20211128170924.5874-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128170924.5874-1-straube.linux@gmail.com>
References: <20211128170924.5874-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf_type is always RF_1T1R. Remove it from bb_reg_dump() and remove
resulting dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 27 +++++++-------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 52d42e576443..0d8b0b9a9851 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3611,27 +3611,18 @@ static void bb_reg_dump(struct adapter *padapter)
 
 static void rf_reg_dump(struct adapter *padapter)
 {
-	int i, j = 1, path;
+	int i, j = 1, path = 0;
 	u32 value;
-	u8 rf_type, path_nums = 0;
-	GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 	pr_info("\n ======= RF REG =======\n");
-	if ((RF_1T2R == rf_type) || (RF_1T1R == rf_type))
-		path_nums = 1;
-	else
-		path_nums = 2;
-
-	for (path = 0; path < path_nums; path++) {
-		pr_info("\nRF_Path(%x)\n", path);
-		for (i = 0; i < 0x100; i++) {
-			value = rtl8188e_PHY_QueryRFReg(padapter, path, i, 0xffffffff);
-			if (j % 4 == 1)
-				pr_info("0x%02x ", i);
-			pr_info(" 0x%08x ", value);
-			if ((j++) % 4 == 0)
-				pr_info("\n");
-		}
+	pr_info("\nRF_Path(%x)\n", path);
+	for (i = 0; i < 0x100; i++) {
+		value = rtl8188e_PHY_QueryRFReg(padapter, path, i, 0xffffffff);
+		if (j % 4 == 1)
+			pr_info("0x%02x ", i);
+		pr_info(" 0x%08x ", value);
+		if ((j++) % 4 == 0)
+			pr_info("\n");
 	}
 }
 
-- 
2.34.0

