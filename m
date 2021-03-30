Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6834EAF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhC3OsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhC3Ore (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:47:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F04C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 07:47:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u21so25192551ejo.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTtGVN1pUyN9IaMWG8AM0yqz3LAm7zkZxHqujW1MyRQ=;
        b=OPl/oeJNk1DkH3MimaRAzXR8S0CUMSUyo2Ud1RE6hDwPmdkI8wMy0A30fs+TS/lPTU
         0Kfu9ZygeGFVfOewRYqG3vD0BFuTRezb/jQpc1hrg3QMKV9PiO5bXp2K1AJVa8mywcwp
         A/aydET0pYuZ+rNkZ0xZGiVgz1H8PfklTGjcWlUXtOJ2Dh1thm4pgT/OHhBp/uUASTHg
         Ot17dpVDByMQJshKvoM/dbWZWbmWodQG7/W66rajHNY0QxL5L9jm3kfMcBfn2Joum+Br
         3N3+B+wUDUcP8N3aOniCFspsPbCSynweGhUTq3HUdNn7UP+wEcWFopF+HS7fZn8SUEuR
         dgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTtGVN1pUyN9IaMWG8AM0yqz3LAm7zkZxHqujW1MyRQ=;
        b=lQNRwsRG3O1MwAKt6g6KB6FIybTp0f8GIxaWR4bHuA7Equ6xVLFJCYV+69TbhH6u1H
         gREKQESGlisCKx+4uo0q9JPbgiKMfkNMQZfmugVa3EIA8M9QDlrwDBS/ZcvoCe6VbB0P
         7nlbCWvykH8XRks6Tgu1dQK5LmWK3fSx1JwVR7SsgXJCveZNK/s90SqbvdJtsurALyt1
         eLn3ZjexIcV+uJwJY/TrzkS6TY7KkuNOiH0C1D+qjD4rz5x3GNrDWByaahHtQdAlGCcV
         olRIM3TIR0pR1tGMjG0+BHpLgm6nU8bYYTzeo/jSHEl3fvSFqM0BG2fpz/FlSAry/OC9
         AneQ==
X-Gm-Message-State: AOAM531bdZQHYcTwgQ+mRO8EMFmXZHTxjDxcD3HXtH+LFGFUDS7yy0f1
        trJgLrLeWxx6rRf7Cb54gZ5amw==
X-Google-Smtp-Source: ABdhPJxl8V38895yHeOUfSa3zNqLHJrdgpnkU1fUpZY8d5zhQSUcipXXMjCUuuUQPCyj+oAkM/h4qQ==
X-Received: by 2002:a17:906:495a:: with SMTP id f26mr32959469ejt.271.1617115652384;
        Tue, 30 Mar 2021 07:47:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n16sm11520383edr.42.2021.03.30.07.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 07:47:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 3/9] soundwire: qcom: set continue execution flag for ignored commands
Date:   Tue, 30 Mar 2021 15:47:13 +0100
Message-Id: <20210330144719.13284-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
References: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
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
index fdcb8ffb4284..edc77d18c245 100644
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

