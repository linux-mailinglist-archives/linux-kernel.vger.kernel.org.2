Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3AD330FF7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhCHNup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhCHNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:50:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B54CC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:50:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e10so11489255wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5gULezL58sP0wsRShFvX5Wql1j67V0uYQzISlfsBbw=;
        b=R6N/KE4sh9d+LpUIxGfmSJSCiVnd+ls3H11acC3Uqdv1Yt/y1r9P/fKqdUiCYDeIFv
         KpaXSnrThQbxtiBuObpV8cljnguNK04m1hGgTNnhiONZ7pBuaGvSUkLdZwnTWCebSn9F
         cnmaFsvOxzj9Er2Gt35/kQ23rceD4yxwe1wPOw3XCMWJ6RC7VIOYM8Y0vkrF55U9sowo
         07bTFBpB0bDjabPPFyi78YVn0xAvdx2YuKo2aR6ne7SOl/niSWqumM/wTmdOtcbGQVbh
         gXmo7Ur5u8TXrk2x9DfQvRfUSZvPQfIszB3iW2NtAI1BaNZGJzivw5b7Ve4vTuBQZj4b
         1dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5gULezL58sP0wsRShFvX5Wql1j67V0uYQzISlfsBbw=;
        b=R3hwEzGBs0pbkKyDG8ITWjGWjYr3uwm1w1QeZmW6Hk7qPgWtA53we6SUoi7cTJ7gQY
         mcCZaDwM+c7e2yuvCEqRjdSH5FqT7yiNereT9GACgjnc2gk7FL8pD6YZVnf+ehSkX8A+
         s3VhqRvvoLgi2LXyvCUdaVNKCdKDX2doPssMB2RqAoZ6feHspUY/f7qzWLyVP6c2tyhq
         xGGNNhPLT2NJeAryliAuKbRyFnVmgyqi36ze78DGRUuV7xN67sk8TQncx/EwiNV3Z1gW
         k2OldSBZVUU9SbK1G8CH2eAmb+xGhSvr+vHje1eSb167YM9uZ1qbqRhR1pCidR/VFcCR
         Ncow==
X-Gm-Message-State: AOAM532OBUwzWCac8xWakCAFxRcFloYDAxlzP6GLSCMzn0Tan+NWCrZR
        3LLDy/ug2CvsQn1SYlUT1hHodDcsGZTyxQ==
X-Google-Smtp-Source: ABdhPJxCYCFRCOeIXxgmkBLAGHMI9EYpuvPj8tRs65vq3csayzLrTcykzQ1nC022pXly02zoG+Iadw==
X-Received: by 2002:adf:9261:: with SMTP id 88mr22485091wrj.270.1615211409057;
        Mon, 08 Mar 2021 05:50:09 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h22sm19490589wmb.36.2021.03.08.05.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:50:08 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 3/9] soundwire: qcom: set continue execution flag for ignored commands
Date:   Mon,  8 Mar 2021 13:49:51 +0000
Message-Id: <20210308134957.16024-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
References: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

version 1.5.1 and higher IPs of this controller required to set
continue execution on ignored command flag. This patch sets this flag.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6c7b811eea94..076a2b1b6d6d 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -40,6 +40,7 @@
 #define SWRM_CMD_FIFO_CMD					0x308
 #define SWRM_CMD_FIFO_STATUS					0x30C
 #define SWRM_CMD_FIFO_CFG_ADDR					0x314
+#define SWRM_CONTINUE_EXEC_ON_CMD_IGNORE			BIT(31)
 #define SWRM_RD_WR_CMD_RETRIES					0x7
 #define SWRM_CMD_FIFO_RD_FIFO_ADDR				0x318
 #define SWRM_ENUMERATOR_CFG_ADDR				0x500
@@ -343,7 +344,15 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
 	/* Configure number of retries of a read/write cmd */
-	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR, SWRM_RD_WR_CMD_RETRIES);
+	if (ctrl->version > 0x01050001) {
+		/* Only for versions >= 1.5.1 */
+		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
+				SWRM_RD_WR_CMD_RETRIES |
+				SWRM_CONTINUE_EXEC_ON_CMD_IGNORE);
+	} else {
+		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
+				SWRM_RD_WR_CMD_RETRIES);
+	}
 
 	/* Set IRQ to PULSE */
 	ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR,
-- 
2.21.0

