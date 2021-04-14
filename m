Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE735FBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353384AbhDNTsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345326AbhDNTso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:48:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B781EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:48:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a4so21009701wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0q7AO+a1TFA9eFDCO6sk3DtCP8qPdgYDojCYV5YMQYI=;
        b=Q+ji8n9urUENtcCynWac2wuz8S/W13P/sF/B2RJEdtHx+mymfGzZvHyjntLDvuM7xV
         G058DsSkMuCG3lR7QAqjieaUX67U0ef1ZIdq0qlODX7WjBNtn+Ht9ViOHB6ks6xzEUyT
         nIMDXYpYS2Q4PvYmSWswigtQNmaftg2pjDqSi8GNkFw6YEOskWE3W8uV2rYv+9mGOwjz
         6A02NZp3RGwMeD8eMyWfp1pb7EP5cu6XytwNHDvi7Mkl0cUoMchXOctALvUpsfSiv55S
         7nk2GPMdiF/p9Hf5GYd2EQLmzKVr9RVlwGuPiFMY9rb1s2MpPLrqMf8+zxqRfxqq/e4C
         gs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0q7AO+a1TFA9eFDCO6sk3DtCP8qPdgYDojCYV5YMQYI=;
        b=imrGkokVekckvUEooXkOr4FszIOMn9fKcsvZKVQjeFQziMM26EH+jwXxqty+TFWvw2
         Cq0BTeNFXhR3sVOL9NT3s6beg/Gad36A8T/wyLUv0g8XUhinXKgbT/LFplwECeF16t+S
         8p74nQJPhqNeqQptiFUVWkE5C+78c3tXPxHEKUZUTs7SluaspnyyiyKSKPlIxX1CoXKF
         +QgZwU/HS9R3n3uhKtjnpLB37uixgKSuCVJWTr64PM733It5SqoTNw80xi5ERpojpspW
         yrzvMZHhXHtS+b1xRZeaBqia9mjVsJyaL6zx1uNG1B8tJS1n7UETZExlPRpPeD7VAsTh
         EBQQ==
X-Gm-Message-State: AOAM532lw2gNqGQ2B0vioWGxBQ0M2W+vfGrM7fKMIzzv3+vA5eCq5onC
        UciCiilymL89aLUHBYQb5ah0cQ==
X-Google-Smtp-Source: ABdhPJxgVZvSf1rv70nU2LtIB0FiIoLhR5emTfQDrxM+cF6N3zwfgRmD9snPR2eZ9eP3XZNGflv4Cg==
X-Received: by 2002:a05:6000:1acb:: with SMTP id i11mr44601759wry.68.1618429701495;
        Wed, 14 Apr 2021 12:48:21 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id v189sm280449wme.39.2021.04.14.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 12:48:21 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Cc:     leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] coresight: etm-perf: Fix define build issue when built as module
Date:   Wed, 14 Apr 2021 20:48:08 +0100
Message-Id: <20210414194808.22872-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CORESIGHT_SOURCE_ETM4X is undefined when built as module,
CONFIG_CORESIGHT_SOURCE_ETM4X_MODULE is defined instead.

Therefore code in format_attr_contextid_show() not correctly complied
when coresight built as module.

Use IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X) to correct this.

Fixes: 88f11864cf1d ("coresight: etm-perf: Support PID tracing for kernel at EL2")
Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 560baefdfed8..b2d6db78a025 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -78,7 +78,7 @@ static ssize_t format_attr_contextid_show(struct device *dev,
 {
 	int pid_fmt = ETM_OPT_CTXTID;
 
-#if defined(CONFIG_CORESIGHT_SOURCE_ETM4X)
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 	pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID2 : ETM_OPT_CTXTID;
 #endif
 	return sprintf(page, "config:%d\n", pid_fmt);
-- 
2.17.1

