Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC372319713
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhBKXui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhBKXsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:48:08 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD16C0611BC
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e12so4201744pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waytkFv28UuOXcaaNeh19CxfKAUzKWp03mnaFrOUKvo=;
        b=KbxKOZQMaAycIE18CAf5wu1OBlPfG0cR5mApGKP4RfLjOjDlL2D8/lfvVD2porDZvx
         3JE2qjSISKthcDCRBzqSBcMX/6J8CzaGauhuZSTT97bOWs6xYNxRZqwsML2SG1SY1HB3
         7lWsIaKBt3xqQxFEMnxZpiHo6O2PYgIW38f3VhXqHdzUndeexhx32Gz7YhZ6qrXh1QTV
         zocoRY+IWe0I9PqLTuhfLY/7548FvGTFz2TvfBDCMw4LbMtHh3/YyVN4qUBujIYrzvHd
         7AtWEaUtPOutyioGfaValaT4vO+t6OEm/FhoUmewhPAA5v5jgh3qHCmM4VlAtwqmarX5
         tgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waytkFv28UuOXcaaNeh19CxfKAUzKWp03mnaFrOUKvo=;
        b=ulAHy9MncCx7vsowJ0grj7BwPdg/oqACBTqtzD/VHH1MZbu/SW215fZgMB9arnrYCx
         I7GSyzcpWbuJIy9V4GfpIqOjHOdQy0+elyUJdMut22bPJ8cDznR62WtDBRhmAuS/i0Tq
         jPaJ8FTR5k4oCemTQBcNOz2AWH86z65tZbtWy8XL91sKdnohv3dzBiYqqUaDlpRK2NzR
         0CHGvH7EbcwZp4zSKb2COfjDTFEGjbjWd3KAhzyNtqZW/8d7EEdC1ZYT5QzwjVfghoDe
         Uol74HwbP2HDktPlyvi3ivVl49LvqNdfLxlmoA8a8NjoXupD3J7yriNOceDF510sUYuM
         pLbw==
X-Gm-Message-State: AOAM532yi0Ax27aWrCP5IH/nKyETrYsRVpJ1F9tqhXjN+xMx5GMp2/4g
        czqP2DU7k+Q3HVSyMdoDCB6lqA==
X-Google-Smtp-Source: ABdhPJzsJkd3WW+noin+H47UTtffjj8xEwP7bv3xBB2e83VstK8JzPqf//Rf0IUal6WT14enyT7ifw==
X-Received: by 2002:a17:90a:c08d:: with SMTP id o13mr128236pjs.149.1613087193787;
        Thu, 11 Feb 2021 15:46:33 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id iq6sm5932740pjb.6.2021.02.11.15.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:46:33 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 05/19] remoteproc: Add new RPROC_ATTACHED state
Date:   Thu, 11 Feb 2021 16:46:13 -0700
Message-Id: <20210211234627.2669674-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
References: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new RPROC_ATTACHED state to take into account scenarios
where the remoteproc core needs to attach to a remote processor
that is booted by another entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_sysfs.c | 1 +
 include/linux/remoteproc.h            | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 1dbef895e65e..4b4aab0d4c4b 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -172,6 +172,7 @@ static const char * const rproc_state_string[] = {
 	[RPROC_RUNNING]		= "running",
 	[RPROC_CRASHED]		= "crashed",
 	[RPROC_DELETED]		= "deleted",
+	[RPROC_ATTACHED]	= "attached",
 	[RPROC_DETACHED]	= "detached",
 	[RPROC_LAST]		= "invalid",
 };
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index f28ee75d1005..b0a57ff73849 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -405,6 +405,8 @@ struct rproc_ops {
  * @RPROC_RUNNING:	device is up and running
  * @RPROC_CRASHED:	device has crashed; need to start recovery
  * @RPROC_DELETED:	device is deleted
+ * @RPROC_ATTACHED:	device has been booted by another entity and the core
+ *			has attached to it
  * @RPROC_DETACHED:	device has been booted by another entity and waiting
  *			for the core to attach to it
  * @RPROC_LAST:		just keep this one at the end
@@ -421,8 +423,9 @@ enum rproc_state {
 	RPROC_RUNNING	= 2,
 	RPROC_CRASHED	= 3,
 	RPROC_DELETED	= 4,
-	RPROC_DETACHED	= 5,
-	RPROC_LAST	= 6,
+	RPROC_ATTACHED	= 5,
+	RPROC_DETACHED	= 6,
+	RPROC_LAST	= 7,
 };
 
 /**
-- 
2.25.1

