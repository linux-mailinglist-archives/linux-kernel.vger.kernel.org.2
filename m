Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1D319621
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBKWzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhBKWzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:55:15 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A483AC061797
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:53:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u17so7701835ybi.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PxM9IT9eyGUZNP1LzuDRc/mngpIW4AQ9SBaT5vWfza8=;
        b=Ucglw7ZkrxpuhIWFGcDbMTMcG+6MYu5YOUu80nYNxay54B1uHqiuqCk1Qi8vWIzCBE
         gspPnFYy8NosLiC3gpvQJJPsGEwQLooMncjiDV24kf0b85qB2u/DqJ481HBQyjlKYKoe
         PRoym98ZiZRSORjEzkCqqkjGBMKGGv0J786/ccj+f79WfOZ+XKM2e0u76uQMfDjXO/36
         8PySDt9wc0r28i2GymYPEmEwEQnWynLeL7qMnNdR3a+E/OUDMFSoUNRDBOe24DdQVlwz
         LoMDhNNiYezk2MO4sPOMTVRmNJesB1d2e+Ft4TFy+dDbQacaFsvM5CUsdG5rW60f2vlx
         Wmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PxM9IT9eyGUZNP1LzuDRc/mngpIW4AQ9SBaT5vWfza8=;
        b=r6MwnqTEVvVrjMTrO2TZtUi7R9KGSsSzI2gGh6g6c9Tgd/frbEPmSFJX63Eg9IQn8E
         g8LsYMFEQ8dJAJei9807GGnKf9PNPVGT1rIcMNd41kq0vxgbGxn9eJZMvG3mWXX1b/t6
         L3TLrRgud7RhPJBfw2/v1vEWqVIdUa/Ib4E9JL7bMcE813zi6MWCI/oSXB/POpfDZ7v9
         WNpJ4u9yvw/GqPNQsv1KMQ6xD7SyprsC/fBEPygpjD7/ipuTXdrCFCy/onHt6put5u7Y
         6VnV39fAaqQNv5FoEBu1aIEGVuDMWKJWKHFPUefLFpU9dtPm5sGCbgq2g3Lf38rtuvK5
         Hddw==
X-Gm-Message-State: AOAM530tuzM6xVfDh0nwOfhyLtDOywRJ8qY68nYo3EnQO+Yh3/aN1cwO
        mFaA25YVj6RYgNFEmJYNTvb8TGUyYpU=
X-Google-Smtp-Source: ABdhPJyCcEkUUWB8T8w/MJOUbhtPs5xiGKEOUKflHC1JDKFUsf7YIQuwF9tUmiR7CFT6Wa50/QpxaMDywZM=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:b749:: with SMTP id e9mr170105ybm.457.1613084037955;
 Thu, 11 Feb 2021 14:53:57 -0800 (PST)
Date:   Thu, 11 Feb 2021 22:53:43 +0000
In-Reply-To: <20210211225343.3145732-1-satyat@google.com>
Message-Id: <20210211225343.3145732-6-satyat@google.com>
Mime-Version: 1.0
References: <20210211225343.3145732-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 5/5] dm: set DM_TARGET_PASSES_CRYPTO feature for some targets
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm-linear and dm-flakey obviously can pass through inline crypto support.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 drivers/md/dm-flakey.c | 4 +++-
 drivers/md/dm-linear.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index a2cc9e45cbba..30c6bc151213 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -482,8 +482,10 @@ static struct target_type flakey_target = {
 	.name   = "flakey",
 	.version = {1, 5, 0},
 #ifdef CONFIG_BLK_DEV_ZONED
-	.features = DM_TARGET_ZONED_HM,
+	.features = DM_TARGET_ZONED_HM | DM_TARGET_PASSES_CRYPTO,
 	.report_zones = flakey_report_zones,
+#else
+	.features = DM_TARGET_PASSES_CRYPTO,
 #endif
 	.module = THIS_MODULE,
 	.ctr    = flakey_ctr,
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 00774b5d7668..fc9c4272c10d 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -229,10 +229,11 @@ static struct target_type linear_target = {
 	.version = {1, 4, 0},
 #ifdef CONFIG_BLK_DEV_ZONED
 	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
-		    DM_TARGET_ZONED_HM,
+		    DM_TARGET_ZONED_HM | DM_TARGET_PASSES_CRYPTO,
 	.report_zones = linear_report_zones,
 #else
-	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT,
+	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
+		    DM_TARGET_PASSES_CRYPTO,
 #endif
 	.module = THIS_MODULE,
 	.ctr    = linear_ctr,
-- 
2.30.0.478.g8a0d178c01-goog

