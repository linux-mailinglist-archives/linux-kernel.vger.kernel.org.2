Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD1332428E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhBXQw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbhBXQt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:49:57 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F09C061797
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:39 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q204so640466pfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVzkgrfLf0T+CIbuY1lXoJbd6D9eaR3FbByCkkzGJ2E=;
        b=A0Go0kgCBETN7Fn7r82a6SLtq+ooA0ifWJwR++ShHfElaFvdRFdtiS/B09l0xTgB0D
         lPXHVfEatpR7fJfOuYYYUI8x5Nti1XR94yD32fistterEmpIpWaAOXAeBnxbPqpCSyDV
         o/NWK9jXnkESjDxFR8/M6upaPm7QfizoXPuRF0mP6VzkjyNwuAnhd19zIsFJ5C8bw+uu
         Cxe7T2tluWzN/Sj7eEn3UwvbrnL2Tn/s1LOJHt6WlQ6yqDd0VwTG2/W6NRl1XpwKJZ+j
         CnNSeOO4gCSFfyYbe0gxn0DjqVPZeRWP+rmCTmMQjBLgtllHBxnGVc5siX2p/CH3q0U7
         dwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVzkgrfLf0T+CIbuY1lXoJbd6D9eaR3FbByCkkzGJ2E=;
        b=N+0hcAlkPvoT93FQVb0AWAfcMh13KboHgsvL4VPqiy3G+FwjHhnAEFk/jqFMLxLhHO
         kJ4QCo/FTDS4Owlqf1wjoBgcmuChQtWCVe8HBVcQY1P4KKyUqh1RECx+CNOAvijLwBiv
         ygwl8uRgj1IK2wh16pfC/iBIvIVVSzdjydXHydg84QWNq6ofF6yh+Odeus01fJoqwkWG
         +30veIAH0+or2Iw8iqY2ajBZAoQp99C4VrWKVctu+toI302Q/sF4qJy+eeRnvB+XWLOe
         GEJsAZDgzYvgBP9BxxVcIQ/9tlj/LjlfVelV4MGWYevC8LCcayPRcQRE+DvQTUqDyK1A
         vLZA==
X-Gm-Message-State: AOAM530aMw5qJgFDKFnllzHKo4++Fr7666jrBowAYpYy0Wi72oKWU3Em
        bSdEdCACdV1H6FntMdCpORs4BA==
X-Google-Smtp-Source: ABdhPJyuhPrrHnejA4mVwl3GuuL4knbEs6NwYzEczUvYRhJIv8C/loHBxqKykLthNhlFzGKNFitxTQ==
X-Received: by 2002:a63:1826:: with SMTP id y38mr29591584pgl.252.1614185318961;
        Wed, 24 Feb 2021 08:48:38 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m6sm3284793pfc.56.2021.02.24.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:48:38 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
Date:   Wed, 24 Feb 2021 09:48:31 -0700
Message-Id: <20210224164835.3497311-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

To get the changes in the commit:

  "coresight: etm-perf: Clarify comment on perf options".

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Link: https://lore.kernel.org/r/20210213113220.292229-2-leo.yan@linaro.org
---
 tools/include/linux/coresight-pmu.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index b0e35eec6499..5dc47cfdcf07 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -10,11 +10,18 @@
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 #define CORESIGHT_ETM_PMU_SEED  0x10
 
-/* ETMv3.5/PTM's ETMCR config bit */
-#define ETM_OPT_CYCACC  12
-#define ETM_OPT_CTXTID	14
-#define ETM_OPT_TS      28
-#define ETM_OPT_RETSTK	29
+/*
+ * Below are the definition of bit offsets for perf option, and works as
+ * arbitrary values for all ETM versions.
+ *
+ * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
+ * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
+ * directly use below macros as config bits.
+ */
+#define ETM_OPT_CYCACC		12
+#define ETM_OPT_CTXTID		14
+#define ETM_OPT_TS		28
+#define ETM_OPT_RETSTK		29
 
 /* ETMv4 CONFIGR programming bits for the ETM OPTs */
 #define ETM4_CFG_BIT_CYCACC	4
-- 
2.25.1

