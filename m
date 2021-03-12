Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685FB33932E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhCLQZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhCLQY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:24:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CFDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:24:59 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 18so2201200pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waytkFv28UuOXcaaNeh19CxfKAUzKWp03mnaFrOUKvo=;
        b=dKfNn2iJY5E9p7zskcv9vdaz1urizBwgvTKpuJUzcyqpj4MgVPP8I/TnAVrOebY454
         Z5NvWmlvMvJM0XH6nL3T4Hx2y75PcNMtSfM3JU6m8w6uTbLnnX2QLEYEN8yFpG+Za8By
         M20XrRlEtrpK+LuEt6CvpXDeKVG9QRn7talC8t90SM5HiBlDs5vZ8+49KrcM85UVt4z8
         3yABuyzHsV3Q5L0rlkHH2DR0x9Om2ISFc7I418CjYQRN3nx8uoXyqtiQboA5/6yqRy/h
         /D/IuiUnaZ5pWORF2AIMCPh4mZAG5FXz97ppqCFqOr+Ly9R3l5rIXJcY2ydZEX+U2SPb
         vihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waytkFv28UuOXcaaNeh19CxfKAUzKWp03mnaFrOUKvo=;
        b=n6EUY95iD8srd3diJq7aIwEi2t01/xVBh9g60iM62x0HFyIXe36p512DgCV4CxbDtS
         30598gvwLhz3JS79YZIJFen8Vl5fr1MGJV+4zK9MW5hAOcnjkCmg9XLF5zB1v8NvsmZC
         4Nvliybbw54cbBQ57ubCFwcYcdxDYeOCfBiJoNOAuKOqSmnBAqZQH8TfDHuFoRBMpov2
         V67Mj7fjCFyXlP0pFFq77yZV5Vo62SygkPwcLxvGrUm9aOoqfxX8RxIt7v9HJG+eCl90
         oyvf2xFVwkiHZhO19Dg01KHB4wbmFGKqv2l+rfM9ISPWkH2GogKQ9h8oK0ky8b211azQ
         xQ1A==
X-Gm-Message-State: AOAM530aeAZS9YqYme6WFpgu9FhoDsG5bC/GgV+XBWWhUIMhxzEvpCHJ
        mNZj/jYtD1GtTgSfxUW7ORKW6w==
X-Google-Smtp-Source: ABdhPJwe6MsgvkUtAkvoJC5S6pbE/3NgIMb3TzqdAmrlhzcoXLzkqS1fjpoI580QTCX+eKXoHnZoRw==
X-Received: by 2002:a63:5924:: with SMTP id n36mr12926892pgb.183.1615566298659;
        Fri, 12 Mar 2021 08:24:58 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:24:58 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 03/17] remoteproc: Add new RPROC_ATTACHED state
Date:   Fri, 12 Mar 2021 09:24:39 -0700
Message-Id: <20210312162453.1234145-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
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

