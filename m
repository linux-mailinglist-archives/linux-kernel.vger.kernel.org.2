Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5013F9762
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbhH0JnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244851AbhH0Jmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:42:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49550C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:41:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d26so9550080wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ua0URsGmpA85c1J9Q/0oD8kSmR0urI2TcJUSPZW85OY=;
        b=I/9t4a9WXxuIH0zC1qiZoDMYe1A/GDv3lAfc+kNpdI8yJX5aRBjc6Nyq07oxfDZ2ea
         BpDhD1Knt57oOQpinVZkqZHhnqvNET3Yo5bJbt2MeDl4hSYUFHVHab+DkcUkgc7PHnRb
         u5VCg0p1rIYePl/KQ6ZC9mT5Q4UFyg65pV8tvszSFC+p6pb+kPRBw1sNuwq5gH009R7y
         8eJG0MMEXs36oJk3oloHX8X1Mpj7dO/ju/zBaHXnhXBLp0hWtfgsVrobJfdrgKe27sGr
         r6Pe67Z0YHN0LwpQJWQmZmFKbwm9j9heCaOiTWELPpqqBSAL/JGYAhVOEb2zfFxB8T/B
         tkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ua0URsGmpA85c1J9Q/0oD8kSmR0urI2TcJUSPZW85OY=;
        b=AJTiKpisw+mpSkTaujuul+slIRlfSqtXL2r3SFuYgtB+VZME1iUwyEiYSPch+laZAP
         TN+8YMVa8YcpGD6XJvu6GaicyEwQv5tYym6PeZcasu2ZkzZ4XXg0VVBdGVDyGTXvxu9/
         J3F9DN4FgGbLaZ/OwSOolV5El26PmIxEdCk9OqDy0NIA3gqqaj0Il1oND/6hafHjJGt3
         K+3MNUuOK53p7AZlDdpMiqpSa4uEBDXmBExHwpQVjJkYu/DqSaBBw4b8u0HYQ18Kixhz
         bakmeg1RkPORYZp9iCpcNC/NfSBI11AvgXXwj9voYXLkqozS3S0LyqXWPSXlxIN1c+61
         6OgA==
X-Gm-Message-State: AOAM533oOwFvnhVCh797GWkUbAUgMGPYHr2/jONQ1mVXmi62cna+t93F
        qLK5WEt8EMzBIABAYErONMc=
X-Google-Smtp-Source: ABdhPJyv7oAIOS2YcIALkXCfzvIgTuUE3UTAdHR6/OAv6YsiCkUaF+biaXIN5EAwdimwF+KABJ+pew==
X-Received: by 2002:a5d:5241:: with SMTP id k1mr9375070wrc.14.1630057313986;
        Fri, 27 Aug 2021 02:41:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::884b])
        by smtp.gmail.com with ESMTPSA id b15sm6500034wru.1.2021.08.27.02.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 02:41:53 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: rename fields of struct dyn_primary_cca
Date:   Fri, 27 Aug 2021 11:41:42 +0200
Message-Id: <20210827094144.13290-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827094144.13290-1-straube.linux@gmail.com>
References: <20210827094144.13290-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename fields of struct dyn_primary_cca to avoid camel case.
PriCCA_flag -> pri_cca_flag
DupRTS_flag -> dup_rts_flag
Monitor_flag -> monitor_flag

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c | 8 ++++----
 drivers/staging/r8188eu/include/odm.h      | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 10fe1ecc0342..70afa0a21bf4 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -329,16 +329,16 @@ void odm_PrimaryCCA_Init(struct odm_dm_struct *dm_odm)
 {
 	struct dyn_primary_cca *PrimaryCCA = &dm_odm->DM_PriCCA;
 
-	PrimaryCCA->DupRTS_flag = 0;
+	PrimaryCCA->dup_rts_flag = 0;
 	PrimaryCCA->intf_flag = 0;
 	PrimaryCCA->intf_type = 0;
-	PrimaryCCA->Monitor_flag = 0;
-	PrimaryCCA->PriCCA_flag = 0;
+	PrimaryCCA->monitor_flag = 0;
+	PrimaryCCA->pri_cca_flag = 0;
 }
 
 bool ODM_DynamicPrimaryCCA_DupRTS(struct odm_dm_struct *dm_odm)
 {
 	struct dyn_primary_cca *PrimaryCCA = &dm_odm->DM_PriCCA;
 
-	return	PrimaryCCA->DupRTS_flag;
+	return PrimaryCCA->dup_rts_flag;
 }
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 19458e66603c..ee051e053ac6 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -154,11 +154,11 @@ struct false_alarm_stats {
 };
 
 struct dyn_primary_cca {
-	u8		PriCCA_flag;
+	u8		pri_cca_flag;
 	u8		intf_flag;
 	u8		intf_type;
-	u8		DupRTS_flag;
-	u8		Monitor_flag;
+	u8		dup_rts_flag;
+	u8		monitor_flag;
 };
 
 struct rx_hpc {
-- 
2.32.0

