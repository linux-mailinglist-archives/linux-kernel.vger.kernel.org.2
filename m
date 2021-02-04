Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C1A30A119
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBAFNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhBAFLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:11:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A049AC06178C
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:10:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c13so18226949ybg.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tsR7HhO1/8EFXvkT3LKZR+I5g9ZmXVYdpiXsfnhKFQE=;
        b=QgFCJZ3xzkCAoqSWhXrvZT70j/Q7cwSPGtKhI7Je9lsUxvdvYXi1lsBrw7M0Nohodv
         0kcdEpCgZfznz6jmbcmulGx5B5I6PlZWZwaOijLJ0Mbh/r1QSAWvlnfV+fF6Yzp8lweX
         HzXR6CPtlPbERPMSWloeAVJ9Zsuce0qi/FR3F4W468QNwUL+/MYTOHBDEBckkQmJg8Qm
         3H8qMtyNUVq9QN1MjJY6BlxwgJOrhdzxU/ZiDHnCNBfvjYN60vqK5B/aUaI6cf3ycpxM
         eUgMYlSNik/htHhk6osRvPrf4MSzB1TwV/wvWNj0rPhov0g9hU/9G8waYxji5xqxD9rl
         Y+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tsR7HhO1/8EFXvkT3LKZR+I5g9ZmXVYdpiXsfnhKFQE=;
        b=IUqWxxItyaCjI+TcZnLAYaodoDZMyb9/z2SlyxB0DEBEIyZwwnABRxtXyJ6BulVwtF
         1AernSINGOC94qCFbf+VxpeLANSKWCnJKCskx06w1DA5uCbbfZFyJQeMRoII85NJNsRZ
         8jDNi/S2tKgzOCf/IgT2PUieYakFuGzqBP030V4BJDN47G+CXoXguFjRDjFMYIN3sexE
         +h7JjIa/HvGTRsRZ4XOFihuTRaBWkZj2OAOuFPqvSpxMSvxep/I22PWo47vL1MvTSSzq
         JAey2bFGRD5zRpQNQ7ufv+qJp00O34R9yhyBsg+FRtQKp/eWrxKV1r42tn2+KqbHyQCQ
         tIFw==
X-Gm-Message-State: AOAM531nhSXlYw2WWKLOplghti9Uy0o6NHqAQTC+Lbh+uPDG0qgJ9oSV
        gV5GWTX1fT4mIf9xzACFH0uMSp393kM=
X-Google-Smtp-Source: ABdhPJzHvb+x5wi/WXBWFc/y/S6NWvFLWKYpHtLIzOFQg75s1lLXTb+FaOcNF1B8+TRzc4ds1FTwCDFqop4=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:1402:: with SMTP id 2mr19186874ybu.15.1612156236927;
 Sun, 31 Jan 2021 21:10:36 -0800 (PST)
Date:   Mon,  1 Feb 2021 05:10:19 +0000
In-Reply-To: <20210201051019.1174983-1-satyat@google.com>
Message-Id: <20210201051019.1174983-6-satyat@google.com>
Mime-Version: 1.0
References: <20210201051019.1174983-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 5/5] dm: set DM_TARGET_PASSES_CRYPTO feature for some targets
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
2.30.0.365.g02bc693789-goog

