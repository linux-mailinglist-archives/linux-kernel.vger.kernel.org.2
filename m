Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F421832651C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhBZP7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhBZP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:59:13 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BE3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:58:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p3so7826829wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eo0RtghhK3XQkEA5nZiew5OMUkgRgswthSggX+F4cGU=;
        b=NCf/4swFemd12ZlF7HRvH3sPymFF2kxN9HWlL9SuvJk7JFVhawqCOGHepDmwkWUeN9
         Djz3GdWCH4YakndTUEzsrIGyjlNXgUqCv0p5g3nh2hBeg2ogoW9lMOhoiXCgqvJqAnUm
         h5u8zTKnkyjjfze6ePdJNRyQ02WNftES5TYhLNMkOmlIsf2rQqivx+qIy7w7lp8Zyhea
         8Pe4HRXP4Qw0R0Pbtf+DqhHjKZTKvYUm8j0wDXhsrbWU2nH3Ee5KBvmHVzP6KsUhzWfp
         mdXvrm1zeiVIhEtis1gP8KzGjdHzF3LORM3bThYxmi3Wn8D1tuHWXmcCopML840z8cTc
         gTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eo0RtghhK3XQkEA5nZiew5OMUkgRgswthSggX+F4cGU=;
        b=KbCMvq/0leRpAwN5+c2yIAH64JGbg0h7zGZpl9dYovcxIY/oUcrOHdkgnPl/ufX3+E
         ZObrNXPSOcyFxrojGvtojra3D7h7T29kJPi9aS2IyWjTyky+L5g7DpgguPY4K9e0gv1I
         3QwhvPvUQotqwkvla+JQuYz5+hqiYubHSP7Ss+4mLn80Z52cwzONeANol1daob2B94p+
         ScrkLhR0xD39m1VhWnGvbp8rCQ/eImCjS5ThTJODRbKloW8olERF1oExSGxyr65ByZk4
         f7K7ag/ALKq2wPcuUOG5beUOVHMcrmkh5wgrcxbvjpkr53RopLBYYKNtuYrZsrxVnuno
         41ow==
X-Gm-Message-State: AOAM532oEBZyIiodxRaS74Gt36mfdRiea8qCy/PJrDjVfsmy7q/qsV75
        dbik+OE1PAwhxkr37Us1HKvFvg==
X-Google-Smtp-Source: ABdhPJzEGVHU7TYPzCT/YfZes9+225wLcSr26J2iVRNJKQxFt2hhO6L0tbdmWlNziK1zmOHoUlHwAw==
X-Received: by 2002:a7b:c4d7:: with SMTP id g23mr3543519wmk.106.1614355110455;
        Fri, 26 Feb 2021 07:58:30 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v6sm14398945wrx.32.2021.02.26.07.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 07:58:29 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/5] soundwire: qcom: start the clock during initialization
Date:   Fri, 26 Feb 2021 15:58:12 +0000
Message-Id: <20210226155814.27536-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
References: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start the clock during initialization, doing this explicitly
will add more clarity when we are adding clock stop feature.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 14d91b17a2ca..6a7c0acc8d89 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -47,6 +47,8 @@
 #define SWRM_MCP_FRAME_CTRL_BANK_ADDR(m)		(0x101C + 0x40 * (m))
 #define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK			GENMASK(2, 0)
 #define SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK			GENMASK(7, 3)
+#define SWRM_MCP_BUS_CTRL					0x1044
+#define SWRM_MCP_BUS_CLK_START					BIT(1)
 #define SWRM_MCP_CFG_ADDR					0x1048
 #define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK		GENMASK(21, 17)
 #define SWRM_DEF_CMD_NO_PINGS					0x1f
@@ -343,6 +345,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
+	ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
 	/* Configure number of retries of a read/write cmd */
 	if (ctrl->version > 0x01050001) {
 		/* Only for versions >= 1.5.1 */
-- 
2.21.0

