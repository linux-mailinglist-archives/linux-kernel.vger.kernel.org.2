Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1077D400FDC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbhIENOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbhIENOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 09:14:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD60C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 06:12:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j2so2338038pll.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEM00qsPpIRL3lpy7qXqtObj3G0WQJvL4ysVAmwesIc=;
        b=kWZTvvlVS3+U03pD1Mty00yMJgFcyoC4I8DvlHrcLPvBEOLp7rLVzWjGk+2/4TzZ9+
         RT87zXTYkK7uQO84gz3LbH+rYlYnUB18E7UovxkrOAbxDNlyVB5nGLQPGz791c2/Z6gj
         Oo7IDba8LJVc4mn4MHSPhhaT1krJOIDxEAEppux64KlJwMGYeB+EMgwXACe0jNqMZ61d
         Cb0Co0fhhBEUZ2HvjlbwrbAaiX75MXlVD5oHIdQ0g6rNRYhFRrjwuSYOzRQRwFXg2pcy
         6vj888DV4VOs28abRL1IM00tsRr0K1hAO0IYYL4J5y9b2/4ogdeXatMd2PoDdCy8jRyY
         cNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEM00qsPpIRL3lpy7qXqtObj3G0WQJvL4ysVAmwesIc=;
        b=AZOWSQjFK62wSoHmwVi6yQffqs2sRr3B8CBsAxUMnAhUUg5ORvJi2tIejwOKg1ROGI
         9VyNyAN9aUAO0n+hTdOy4Exm76S5A/V07XzpFOvKoRu1vR4EgiJipbAEOmnbaMl34K7F
         tNevZczX8JRs4aC6mNt33XM/mZL5Bafgie9o1inNY3yV4emYWbto0qIYCZhtzpQDztB/
         1edraTqrBtAdy/WoOmR9yUEfaeh+1oL/onAotORdfDSmmveOZVRruU5Izkesd6yVtZl5
         0CltXYgDb/ws8dGulo4hqW0ERW3HJU3zi1+aEzvxRd7BEn6dPIH0X+kQQnVbIf/UGK4b
         ElDQ==
X-Gm-Message-State: AOAM532IEfF3G4Kpuzm0Ezy60nNwXr5Et/+eBm2Dtkjr6C65XUsIe7LY
        32l5YD0U5aEpY/CpXwQd9TOHMoFD+PiOSv6q7/E=
X-Google-Smtp-Source: ABdhPJwi8Vr/uRQdkhGN/jlvlisDkKGr3m1G7XRUkaNVdBfQL+6oytqammXV2p2YLE5I1ZpBY/ryjQ==
X-Received: by 2002:a17:903:41ce:b0:13a:21a7:1304 with SMTP id u14-20020a17090341ce00b0013a21a71304mr354750ple.65.1630847576575;
        Sun, 05 Sep 2021 06:12:56 -0700 (PDT)
Received: from localhost ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id x9sm4697035pjf.52.2021.09.05.06.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 06:12:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/2] coresight: Update comments for removing cs_etm_find_snapshot()
Date:   Sun,  5 Sep 2021 21:12:37 +0800
Message-Id: <20210905131237.1035322-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210905131237.1035322-1-leo.yan@linaro.org>
References: <20210905131237.1035322-1-leo.yan@linaro.org>
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

Updates the comments in drivers to reflect the changes.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index f775cbee12b8..1cdb627d6c38 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -557,7 +557,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
-	 * that were written.  User space function  cs_etm_find_snapshot() will
+	 * that were written.  User space function __auxtrace_mmap__read() will
 	 * figure out how many bytes to get from the AUX buffer based on the
 	 * position of the head.
 	 */
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index cd0fb7bfba68..a895931a2766 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -546,7 +546,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
-	 * that were written.  User space function  cs_etm_find_snapshot() will
+	 * that were written.  User space function __auxtrace_mmap__read() will
 	 * figure out how many bytes to get from the AUX buffer based on the
 	 * position of the head.
 	 */
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index d23c7690f29a..941abb70b827 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1573,7 +1573,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
-	 * that were written.  User space function  cs_etm_find_snapshot() will
+	 * that were written.  User space function __auxtrace_mmap__read() will
 	 * figure out how many bytes to get from the AUX buffer based on the
 	 * position of the head.
 	 */
-- 
2.25.1

