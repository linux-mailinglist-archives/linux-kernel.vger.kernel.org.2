Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1FE34A1FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhCZGlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhCZGlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:41:22 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DBEC0613B0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ce10so6771827ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pBsk7JwZ/LZ6cSzAnPDMM/93PskvajNpLm1bjDKAXDA=;
        b=TtM2fa7PbzOgQLB4fpw6IimpLrH2OIlw5m0waALp7JmZ+C3gb5XD8n3yBIREwNonVa
         eiYQVl4WckcL3VU5o6QVL9+Gt21DvsXfwX83rwmtT0IvG/p2VEz3u5m9IjoEA+B004RT
         g+GbAD9CBQbkk/Yaa2PmOIEq1C8DIPunDBpI2xttCSBMJG8BG7nj+xtBxiJp07agBWdY
         2SYEGcnSUiOqGU0hsvdaYPL4c1pQ81TDFomf619Eo6/we+hcPB44KSSX92+wxneFaQi/
         3YulS9egaP/f79BP6NJ3BF/VuYgahZqoyMrzJYyfntol5uOV1EzXjFSdErmobMSOeNpM
         bAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pBsk7JwZ/LZ6cSzAnPDMM/93PskvajNpLm1bjDKAXDA=;
        b=O4GKKktVbnp1Ap8inxBk0HuU+JpWR3boqawDWoBrZSVmRgrqzJaNXIFUDEWm4PWsZM
         42SryEOvhdAv3buUSPcZCiXJm9CADE2bvvgeqPazz62UKX0VN0BEyT1GZMYv7HIyqkCX
         RNxsY9aN+Ma7AVijfyvR0674T11+EOWYTgCXrdzSNb4oTfpwD7u4uLW21bE9ZBeeM8AV
         FTPO6rh3D0b1VR4aEasBj7TQTqWjfyIuEfKBWmlymWpDbMjEb4JaNSbovzUDnOs1eOwL
         aKzNNY3PALjzSkI/FikETCrdZOA4Qv8QLl9wwb4V0kdqq4oFAJ00OedyXCT5RIYHVSud
         jjBA==
X-Gm-Message-State: AOAM530eEqw1u+vuBD2ElPn2V+2Fxzzusi2GA+dP15X6MuYnOYT1llcM
        7GTSkwYV8+shXYkYXSZ4s91G0g==
X-Google-Smtp-Source: ABdhPJxM2pWHo5EX4fBrgBkHiE+kpNUhbDi/gLNPEs47hwEYC7Gt7x5YLuJrgOtzXhNHd3tDFabfDA==
X-Received: by 2002:a17:906:72d1:: with SMTP id m17mr13391086ejl.118.1616740879057;
        Thu, 25 Mar 2021 23:41:19 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id ci22sm125325ejc.54.2021.03.25.23.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 23:41:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 3/9] soundwire: qcom: set continue execution flag for ignored commands
Date:   Fri, 26 Mar 2021 06:39:38 +0000
Message-Id: <20210326063944.31683-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
References: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

version 1.5.1 and higher IPs of this controller required to set
continue execution on ignored command flag. This patch sets this flag.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/qcom.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index d05e41f68658..43ec22a5e332 100644
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

