Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C40407D6D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 14:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhILNA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 09:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbhILNAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 09:00:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 05:59:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f65so6278769pfb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LUjyxV8BtGhFPa51IbiHrjlhZUEm+8dMwVn2qq2CO44=;
        b=cK2ur31iPfkXfQPbzTRryVz5JXP9qqDMwSSqgEym/7idT16odJ+izdxuVLUsxGhaCz
         TaIbawNHSecwZaYHlfzHGxS2L0KfmU0rf0Pe3xd6pIRP+kgPC28Nkx5P6F66BzdVEdxL
         bEG8ixtYaT0uNDKSTOxpn3ta8WvYHIGhiszSDEZF0598oTVhHyltK9lRnpD9rsJ7rTep
         Rl7eVWGL25cMOYMc/nBhHMhBcy6Id0drToaZbdkHI4MTOlKRgy14AvKVg23/C5kCuW5J
         WhxfS7yrvpQHjyJBO8zR2Yqk7qeOXxN9kthHA0hhkJWcEaZjFDSBU1y4jRP5PT2fo5L8
         05fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUjyxV8BtGhFPa51IbiHrjlhZUEm+8dMwVn2qq2CO44=;
        b=lOrIUInk4RZwJhpB0MIy8BjGcZIjdxDzPN4msFZDVa/MKScUtnGEpS0o1rBDPZMkV6
         OMDpOe/8sS3xU7Fsx/LEyQeqWp5nLL2Y/ovI51X6EC+x4nXntD4pndDsZrehh/GkRrxz
         a5tlVT7wqcLya5je5yam1vx0BGn/QHiQaR303slv9cyUgBofZSAG9qumWq+0Dp5pwEFI
         54JId/YDvatQuDibx7/TcxHHcMGArEnTXJwV5FoS2lY61h0hmrv5vu+7XgJn5MT3LWjA
         ynpywEOozowGenu0ANMhq4Mo3zct11+B6WGz4LuRdUpND/xswxuDmeW4w63GsNejw/Ns
         J9ww==
X-Gm-Message-State: AOAM532Yyrf6RKIU4HmAON6CFYUBpYkBCMDN9dP9YQP45YM063Ts726M
        XhIPUnV5xLJjrUgTXEKwI0ncLw==
X-Google-Smtp-Source: ABdhPJwaBc3Db4ci6LeZlY8uRCNKuMLLR/w8zQBawRb117S+4c4UYShQmCFd9a/5aUheXHBGQF4mkQ==
X-Received: by 2002:a63:5663:: with SMTP id g35mr6523750pgm.368.1631451579735;
        Sun, 12 Sep 2021 05:59:39 -0700 (PDT)
Received: from localhost ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id t10sm4617334pge.10.2021.09.12.05.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 05:59:39 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 2/2] coresight: Update comments for removing cs_etm_find_snapshot()
Date:   Sun, 12 Sep 2021 20:57:48 +0800
Message-Id: <20210912125748.2816606-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912125748.2816606-1-leo.yan@linaro.org>
References: <20210912125748.2816606-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2f01c200d440 ("perf cs-etm: Remove callback cs_etm_find_snapshot()")
has removed the function cs_etm_find_snapshot() from the perf tool in the
user space, now CoreSight trace directly uses the perf common function
__auxtrace_mmap__read() to calcualte the head and size for AUX trace data
in snapshot mode.

This patch updates the comments in drivers to make them generic and not
stick to any specific function from perf tool.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 5 ++---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 5 ++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index f775cbee12b8..efa39820acec 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -557,9 +557,8 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
-	 * that were written.  User space function  cs_etm_find_snapshot() will
-	 * figure out how many bytes to get from the AUX buffer based on the
-	 * position of the head.
+	 * that were written.  User space will figure out how many bytes to get
+	 * from the AUX buffer based on the position of the head.
 	 */
 	if (buf->snapshot)
 		handle->head += to_read;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index cd0fb7bfba68..b416b1951d3e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -546,9 +546,8 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
-	 * that were written.  User space function  cs_etm_find_snapshot() will
-	 * figure out how many bytes to get from the AUX buffer based on the
-	 * position of the head.
+	 * that were written.  User space will figure out how many bytes to get
+	 * from the AUX buffer based on the position of the head.
 	 */
 	if (buf->snapshot)
 		handle->head += to_read;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index d23c7690f29a..ce14eb83925c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1573,9 +1573,8 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
-	 * that were written.  User space function  cs_etm_find_snapshot() will
-	 * figure out how many bytes to get from the AUX buffer based on the
-	 * position of the head.
+	 * that were written.  User space will figure out how many bytes to get
+	 * from the AUX buffer based on the position of the head.
 	 */
 	if (etr_perf->snapshot)
 		handle->head += size;
-- 
2.25.1

