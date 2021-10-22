Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D476437458
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhJVJJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhJVJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:09:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5670EC061764;
        Fri, 22 Oct 2021 02:07:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f21so2277550plb.3;
        Fri, 22 Oct 2021 02:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LT6CARq18UAj8Ce53+t2XCRMifCgnD74jt9UaSc6Trg=;
        b=T875tlr7jMHbbft8AA8YRCf+O4ydPZscuaWc8kGDIWGWYGsxvjLLCseF6AtWEtb2CC
         S9wBQaHFrpLVncmmN0isi0Ssfi7ADKQ8DK9+jO0Mkr39yHPC6RRLLAlCKf8ks9fwY2bR
         hXS9vVYvb63Kvs2/fxHr8mS/Q3tg8ByQRSDp6ZgyNF52bry63rwndTeAISxQEQ6a9/eK
         sC8nnlI7yIEbW/B4HAvqskI09odzpZpxQbda7XLtF7gqXP9cg4b7pehMQSgtuGxDpQSF
         x0RN5Yd/Z/+cvKVhn9mab9Q8nIudih0wRMOGAKpm8WgDcHfXpz5OTQvMufhUDgTh4VYJ
         PjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LT6CARq18UAj8Ce53+t2XCRMifCgnD74jt9UaSc6Trg=;
        b=bU4KNxnNisvxLD259jieAVMRsXbWh4xXq/Hwxa/kQBljGDfcK0SDpgwWd4nOK1TReJ
         4JSwIr4w16Nt8/Efw6q5Lp37x9KtfJG65MZaVeiqCjMmi4KuuyCaiPCf3MCV7USBN0EZ
         twc/1yTS9jcISfD+vaNfLuRRUpvi3K0Rkfo1QWQcgmaeejF89xgQo52WzwK0v5hVe1Hv
         819ZJsuiboCK1RFyMWmB/pdrUK5JhBr4Wllnp0GaWBZLD00H0hQC5g6AGUa5XvuBBm39
         VsijPhcK6AjVjReYD6wU7/hbRkHeWLGECVb5U+n8vqO56Rc5CSivUSzfhGr48cMZgcmg
         5IWQ==
X-Gm-Message-State: AOAM532McZPgre7Fh4f8jTTAfK7fDCC1FbVnleCGVJhxE+ImVMLeKdYy
        bjfOwdyAb9YH/EpJBrgBcnE=
X-Google-Smtp-Source: ABdhPJzXMP7FE8cfFbUeeUS8t8atc4u4DHmG/6vtBRTevO9DstC9K+RlJ70CpHnXH3nDst78vZBSWQ==
X-Received: by 2002:a17:90b:380d:: with SMTP id mq13mr12926153pjb.131.1634893653951;
        Fri, 22 Oct 2021 02:07:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t14sm7477547pga.62.2021.10.22.02.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:07:33 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     matan@svgalib.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] platform/x86: lg-laptop: replace snprintf in show functions with sysfs_emit
Date:   Fri, 22 Oct 2021 09:07:22 +0000
Message-Id: <20211022090722.1065457-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING  use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/platform/x86/lg-laptop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 7e9351c36389..ae9293024c77 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -330,7 +330,7 @@ static ssize_t fan_mode_show(struct device *dev,
 	status = r->integer.value & 0x01;
 	kfree(r);
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(buffer, "%d\n", status);
 }
 
 static ssize_t usb_charge_store(struct device *dev,
@@ -372,7 +372,7 @@ static ssize_t usb_charge_show(struct device *dev,
 
 	kfree(r);
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(buffer, "%d\n", status);
 }
 
 static ssize_t reader_mode_store(struct device *dev,
@@ -414,7 +414,7 @@ static ssize_t reader_mode_show(struct device *dev,
 
 	kfree(r);
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(buffer, "%d\n", status);
 }
 
 static ssize_t fn_lock_store(struct device *dev,
@@ -455,7 +455,7 @@ static ssize_t fn_lock_show(struct device *dev,
 	status = !!r->buffer.pointer[0];
 	kfree(r);
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(buffer, "%d\n", status);
 }
 
 static ssize_t battery_care_limit_store(struct device *dev,
@@ -520,7 +520,7 @@ static ssize_t battery_care_limit_show(struct device *dev,
 	if (status != 80 && status != 100)
 		status = 0;
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(buffer, "%d\n", status);
 }
 
 static DEVICE_ATTR_RW(fan_mode);
-- 
2.25.1

