Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2F630AED9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhBASPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhBASOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:14:36 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D455C061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:13:56 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m12so75409pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROzSJ+k0Uh2r90d58CiYcoDg2pZWWxblaGujvBNFeHM=;
        b=i/YienVEz3qdYBF4/nwO9CuFleIBj9s7iADd2yhy+/daqfs2BU7+4zjKP1FZV5GNvo
         P1R16Ux80wWZqWcQOcGJKIUm8Qq5q7GOfOXXRhsTOElL4JLG19wGMfx87P+IP7dMeOUq
         SxlJ8KZXCEC7r79V6RMiYsRguCQWchHWHAvihsG+8uq39wZxS30OgputLXrZtMcvoXmD
         z7033e1g4QSh74kiJAMeepULA6Q895iQ3Jzq0Yysctuq5jLG5ZVTfo3UPUlG0qthaAUe
         1ZCzga5/EyRhintg9SwJ2cCUaMXQX552G5tkKahUobQjuRAaSCNiTqJyo8N2nMy0pxN0
         Mg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROzSJ+k0Uh2r90d58CiYcoDg2pZWWxblaGujvBNFeHM=;
        b=CGWbyWN33wFbDKNvGZdETEXzJzQfrsk+2WeQ5wx+7p08HrlYQuxRrML/y8gTUBwIvc
         aFyvUNfiGQN4zVSjynbhL/UwEpw88vpfKLkbLaEizfEEUgt4x7kCTVAzWIxtz5GvmAWZ
         zChXpz6L5Ofk1JRGx68tDksuHtbXF4HXtFEzeoBMhpc92vPhVU/5eq0uIdw+8W8AVYGY
         umtefxgK4DTUt1BuqiNYOaynQE7M7GWYPCFTCpLBe9PzGax0S10IORWW98Yf1ya9E6sf
         tyV02ugIByC58y+eRNAVQcZmpNiLoVpn+HLOE9edukLDdUELObXw2xUT+LMOh09531G4
         H7gg==
X-Gm-Message-State: AOAM5321jpsvKjgAtFiru+GpOQ5xO9CcKH3KtDm2xl4UA6vmnOAviOz+
        c8vFduJ5oQLf6v7A0+3OdMA3qV6W4jmzig==
X-Google-Smtp-Source: ABdhPJz52cgRFfXtGh3utHNSaJuqXeFHReNAE8Ak2VwKdK2GWTHpyvL9GsV0UOY/whGmI3IGufyilA==
X-Received: by 2002:a17:903:2285:b029:e1:58a2:b937 with SMTP id b5-20020a1709032285b02900e158a2b937mr6528736plh.68.1612203236195;
        Mon, 01 Feb 2021 10:13:56 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:13:55 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/31] coresight: etm4x: Handle access to TRCSSPCICRn
Date:   Mon,  1 Feb 2021 11:13:23 -0700
Message-Id: <20210201181351.1475223-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

TRCSSPCICR<n> is present only if all of the following are true:
	TRCIDR4.NUMSSCC > n.
	TRCIDR4.NUMPC > 0b0000 .
	TRCSSCSR<n>.PC == 0b1

Add a helper function to check all the conditions.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-2-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 29 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.h |  2 ++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 8c4b0c46c8f3..4b615e9f3d76 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -59,6 +59,22 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
 
 static enum cpuhp_state hp_online;
 
+/*
+ * Check if TRCSSPCICRn(i) is implemented for a given instance.
+ *
+ * TRCSSPCICRn is implemented only if :
+ *	TRCSSPCICR<n> is present only if all of the following are true:
+ *		TRCIDR4.NUMSSCC > n.
+ *		TRCIDR4.NUMPC > 0b0000 .
+ *		TRCSSCSR<n>.PC == 0b1
+ */
+static inline bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
+{
+	return (n < drvdata->nr_ss_cmp) &&
+	       drvdata->nr_pe &&
+	       (drvdata->config.ss_status[n] & TRCSSCSRn_PC);
+}
+
 static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
 {
 	/* Writing 0 to TRCOSLAR unlocks the trace registers */
@@ -270,8 +286,9 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 			       drvdata->base + TRCSSCCRn(i));
 		writel_relaxed(config->ss_status[i],
 			       drvdata->base + TRCSSCSRn(i));
-		writel_relaxed(config->ss_pe_cmp[i],
-			       drvdata->base + TRCSSPCICRn(i));
+		if (etm4x_sspcicrn_present(drvdata, i))
+			writel_relaxed(config->ss_pe_cmp[i],
+				       drvdata->base + TRCSSPCICRn(i));
 	}
 	for (i = 0; i < drvdata->nr_addr_cmp; i++) {
 		writeq_relaxed(config->addr_val[i],
@@ -1324,7 +1341,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		state->trcssccr[i] = readl(drvdata->base + TRCSSCCRn(i));
 		state->trcsscsr[i] = readl(drvdata->base + TRCSSCSRn(i));
-		state->trcsspcicr[i] = readl(drvdata->base + TRCSSPCICRn(i));
+		if (etm4x_sspcicrn_present(drvdata, i))
+			state->trcsspcicr[i] = readl(drvdata->base + TRCSSPCICRn(i));
 	}
 
 	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
@@ -1440,8 +1458,9 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 			       drvdata->base + TRCSSCCRn(i));
 		writel_relaxed(state->trcsscsr[i],
 			       drvdata->base + TRCSSCSRn(i));
-		writel_relaxed(state->trcsspcicr[i],
-			       drvdata->base + TRCSSPCICRn(i));
+		if (etm4x_sspcicrn_present(drvdata, i))
+			writel_relaxed(state->trcsspcicr[i],
+				       drvdata->base + TRCSSPCICRn(i));
 	}
 
 	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 3dd3e0633328..80e480c7fe5c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -179,6 +179,8 @@
 #define TRCSTATR_PMSTABLE_BIT		1
 #define ETM_DEFAULT_ADDR_COMP		0
 
+#define TRCSSCSRn_PC			BIT(3)
+
 /* PowerDown Control Register bits */
 #define TRCPDCR_PU			BIT(3)
 
-- 
2.25.1

