Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D474230AEE6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhBASQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhBASOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:14:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ABCC061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:13:57 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s15so10466704plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O41rJTlMZTVcMIElK5KqNnqfKtFcYHMw/qm7GjAEOtc=;
        b=SicjLH2B3f1NYan3zMCEi76cHb9l2J3UEvYZ9aVjRskpwK1cLtxtylONvSM+kUdSgr
         tbafOxWVBf5DdwXdQFI4nDmU4peqLTunvKCeEaU6LOv4dasiv+NzY56WnXBVUv+IKp0T
         4Q3uaNYQN+vfEJFYN9Tdp95GqZrZ3pG5tUaXB6pJNYwxr/hNqzlHWNYyUAYe1QRqAXpf
         LdiW8Fw+DSmIDHIqdo0qNi6IzRTHOfObJ6wx5+52Qsi3BpTkvQj9N29BOVVqv7mmEI4w
         lj44xGnxqRKOifns++V8Nop0HvCZPl1i+NP5QUcUccF2EgCXKgXVT8FyMtCzZJdDw1wi
         xZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O41rJTlMZTVcMIElK5KqNnqfKtFcYHMw/qm7GjAEOtc=;
        b=b/S6qN/DLglpzjPgRwNI+tNdECviUa/k5z+7Ps62cGNo6TRCBqF8eYS6aQzu8ZIpco
         TBwttJLi0GnuwCGmMvU10INhug5tIosgrh/9HM96T904FuJYD65awPgFWk2vIQCvdgBb
         DPA/yhAnUtFYCD3r3NQysq9ukhPVJL+KEyG4DjC1ebyQD/d7OPJivua+1pD2c3ghEUBY
         xoX4DBH9Q2udG4NFrJdxhUPA2HCyvdPUoHlA3jCIUc5YZZs9Nc1bMCcjH7HAP6gIl8XK
         NWaYeOAaKiDZ+IZGpvOI+Vo8+tVysKj0niG6pIp0Lqj4ZGMIFwCkltwhdVN9lFM4Ugoo
         AI0g==
X-Gm-Message-State: AOAM530J63yqcHnI029BN24rz92thb0tX8UBA3LeFPO6NeJrad/9/QSm
        fsKaYe0Ki4ElIbk0IBKfd7xDGw==
X-Google-Smtp-Source: ABdhPJwvsIXJgpAx3CYkvtgGeS+y+LHSVT2dOhln0HvqlMpx4ib1syz0J/T0PMim1vZZ1xcsQuLZCA==
X-Received: by 2002:a17:902:bd0a:b029:e0:612:ad38 with SMTP id p10-20020a170902bd0ab02900e00612ad38mr19262845pls.30.1612203237104;
        Mon, 01 Feb 2021 10:13:57 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:13:56 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/31] coresight: etm4x: Skip accessing TRCPDCR in save/restore
Date:   Mon,  1 Feb 2021 11:13:24 -0700
Message-Id: <20210201181351.1475223-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

When the ETM is affected by Qualcomm errata, modifying the
TRCPDCR could cause the system hang. Even though this is
taken care of during enable/disable ETM, the ETM state
save/restore could still access the TRCPDCR. Make sure
we skip the access during the save/restore.

Found by code inspection.

Fixes: 02510a5aa78d ("coresight: etm4x: Add support to skip trace unit power up")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-3-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 4b615e9f3d76..0924c376e35a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1373,7 +1373,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 
 	state->trcclaimset = readl(drvdata->base + TRCCLAIMCLR);
 
-	state->trcpdcr = readl(drvdata->base + TRCPDCR);
+	if (!drvdata->skip_power_up)
+		state->trcpdcr = readl(drvdata->base + TRCPDCR);
 
 	/* wait for TRCSTATR.IDLE to go up */
 	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
@@ -1391,9 +1392,9 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	 * potentially save power on systems that respect the TRCPDCR_PU
 	 * despite requesting software to save/restore state.
 	 */
-	writel_relaxed((state->trcpdcr & ~TRCPDCR_PU),
-			drvdata->base + TRCPDCR);
-
+	if (!drvdata->skip_power_up)
+		writel_relaxed((state->trcpdcr & ~TRCPDCR_PU),
+				drvdata->base + TRCPDCR);
 out:
 	CS_LOCK(drvdata->base);
 	return ret;
@@ -1488,7 +1489,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 
 	writel_relaxed(state->trcclaimset, drvdata->base + TRCCLAIMSET);
 
-	writel_relaxed(state->trcpdcr, drvdata->base + TRCPDCR);
+	if (!drvdata->skip_power_up)
+		writel_relaxed(state->trcpdcr, drvdata->base + TRCPDCR);
 
 	drvdata->state_needs_restore = false;
 
-- 
2.25.1

