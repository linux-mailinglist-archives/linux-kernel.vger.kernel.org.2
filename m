Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37677308BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhA2RgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhA2Rdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:33:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79035C06178C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:32:59 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c127so7791964wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8hpcip3PXhBpcFLltkTNxBYpR7n84DXjgnndbZ1mXc=;
        b=lFNFqvVWqV9aow8jD/7DF+uocMYN37pBLHG1Kkn/idkWqoEmdIglXcvAnWUrx/9eCI
         doV2gUyptrAzeMoiD4bHFkJKdncjFZvl8eMTsXtL/jtBGorCWoaFWcVw0gV55YNWjubN
         nHGWpxaRE42YuxcZIHKdIO0atC0o1ZAhTjPYzZAZCvdrF5i7YqE37FR3NVc+Saw18vMl
         0Q6TfuJhdpPOR/3FvufFBsaRqtEk+0IqyQPwYshaQRSvgo/9AnN9Q6xYQZ9bHONcMSof
         HuRDWmBdMQb2c7wVfuy46RdVWsWS8gHh4hKOVm3/bZPewtVyjNVYnvmzoWNJ3dCJPAjj
         2bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8hpcip3PXhBpcFLltkTNxBYpR7n84DXjgnndbZ1mXc=;
        b=A1BvKAJ3ehkw8yyvbEQIV6neJIECqHf8xxQh92T3BWSBBEXiw0SMUlEKiXGaw4nwO5
         FNo6fBxYxt1gMMPltsTZ2FaVG3syL9GASQVVqVF6zhYX3ZF1i9kC6i6meWiPn43BtC+n
         ZFmdgBNbmyWt+G/WzJYPGAPvNW94wRPK7fwbHMhlCAMcOUC7lOxALFoTJL2SiHa/f7Yg
         gv77KdTzQDlKXmHIuGvoA8PC3KaiEsjdII6cNvVzOOKeGRq6Y/1xO0vRfzM1aAixJlzG
         PFEOBZu6KCmSF+U2ml12nvE4e/ldqjF4MBWxGqNoc/sHVhfIg7XwNRQAiY9CVb+MmvLv
         BQgw==
X-Gm-Message-State: AOAM531WZ43f54N9od8QxyWR4jyV+cMY1XBJ6G0cCrECdErO3eFGOfoA
        PVX28L5WqtkSV9/rCwPUNs8d2g==
X-Google-Smtp-Source: ABdhPJw2YrZLOMzpNnJ98kK1QF7imjjFe8Fx1+ZCLaqGx4WV3G/hF6n8QrMJY5OqV1ks+mp3SvU34g==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr4910575wmj.165.1611941578227;
        Fri, 29 Jan 2021 09:32:58 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h18sm13202294wru.65.2021.01.29.09.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:32:57 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/6] soundwire: qcom: set continue execution flag for ignored commands
Date:   Fri, 29 Jan 2021 17:32:45 +0000
Message-Id: <20210129173248.5941-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

version 1.5.1 and higher IPs of this controller required to set
continue execution on ingored command flag. This patch sets this flag.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index da6e0d4e9622..3669bac11a32 100644
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
@@ -345,7 +346,16 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
 	/* Configure number of retries of a read/write cmd */
-	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR, SWRM_RD_WR_CMD_RETRIES);
+	if (ctrl->version_major == 1 && ctrl->version_minor >= 5 &&
+	    ctrl->version_step >= 1) {
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

