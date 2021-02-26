Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C389032651B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBZP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhBZP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:59:11 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C836C061786
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:58:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h98so9031680wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6iwwfKMWIFDQ+43ejDw0yyTPC7nDGOHpb1YvTLMM+pY=;
        b=lJa+LWz+nhevlCFIXZG2vl/SixnJIpkAtAaYFZiqA/BrQJV4yl/KGuTozzfwVGPZDd
         lEFLfkTP9mxY3gjwPao8hLdZmfRj8rbN5YYan0FErtusm5MgmD7MxCA2Pt1UfJ7Hd8yW
         x24LNGWTMgc4Qanh4PX/ePSkwXi4QKA5tOKwIZunJGDZyIzDfecvCbGS06hk3sT/IL/E
         FaqxXjwCWXq0qcBxaXusIjbgzIK35xeknJjZ/znTIIPoY6tzVMHAhhRbGjl8h4SNwfxJ
         cu7n2C+l2EJQTCOkMnVQ76qaN2b3jpKA/yGf6rDYKke4cVkfH3TnadhIjQkrC4KHPoES
         kD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iwwfKMWIFDQ+43ejDw0yyTPC7nDGOHpb1YvTLMM+pY=;
        b=isjqibAQpe3jNEhnEcn+ny9hxUCHCnZH/qfjk4tB5AZW0epj8h8Xg1SQFuTSfYwLp2
         otZl6J7T6C0Q1/n+TgC/KwOqSAyX763fIw5u3fV7JOneK5dEwp0jxrAX3K8DCk6rzVNT
         z9BLqXrzgscbCThEu+eM2pge7W0cPQ1XHjfx+00FZylPv/4z0r8hNuL3f4Qmto2DyXRQ
         f22bjo0xT7LilUkPRmcFDqFj0UOEVQkVSAsByHJP2f1ysw909ezC/Fv/dIcw8wEDhet0
         MjUfcVbdzOBmC/8QJN94nMFWWqoyFF560Hyqak8yVHwA0ZJ6MtoWNhs1aVC4KnmFZ7IO
         C+mQ==
X-Gm-Message-State: AOAM531BmOZDN9K6NCSGxZTnMBKPs+NR53uTJk70a4dtx/z4ExlK88Ch
        lhICiH/6BFOzzDuKKdecHSFOGA==
X-Google-Smtp-Source: ABdhPJx5LO07gjkW8d+WPCDupqSj2jdBvY3WVv67VqqAVj3NztPy5CMrcO8ETo7QUkAmsZHtoUH6Yg==
X-Received: by 2002:adf:d1ce:: with SMTP id b14mr3922281wrd.126.1614355108943;
        Fri, 26 Feb 2021 07:58:28 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v6sm14398945wrx.32.2021.02.26.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 07:58:28 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/5] soundwire: qcom: set continue execution flag for ignored commands
Date:   Fri, 26 Feb 2021 15:58:11 +0000
Message-Id: <20210226155814.27536-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
References: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
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
index fee7465c72c2..14d91b17a2ca 100644
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

