Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD72434A20A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCZGmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhCZGlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:41:23 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A0CC0613B1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h13so5062019eds.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9w26BSmosHoWqHb4DQ0FR/rFMhDz7pjkPie7BkwBXHY=;
        b=xvmNm1nflRIeRx4LkKSGcrElPaSbjF1kN6QdiXw9op+BvHN1V7Jsui3LT/t16Kksh/
         RUKvfI4eDhhoJ7iFtaSpqk5mNYgh/mQMq+14xsE7KfK7Q5E1StGvvuuTh63rEXc8O2up
         xr2yn98r4/w8XonH/U89vhJmJjUYwbBTtcVjWPO5CGb84EBxwRcwz6IM0ikFDD6eSa4A
         aHS69DHtyqniONA1PeBfIi+aWSvUGlgndvZdtXEW2C7fbQE9p1jXoCogP1n/nfiYQu15
         I6cN5/AFcIC4KJsLnQkdf6iGTeWj6aU//HBeFGmilGb0K8y8jLPEYwM780wVxR5wDltp
         Xh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9w26BSmosHoWqHb4DQ0FR/rFMhDz7pjkPie7BkwBXHY=;
        b=hCQdtLkFT+TalymstxXT03IodTln3zK2gwtwJzQJUBdwnnq+5jlrfT+kBxoNHlyA+T
         jmI89A4p2Gt2W5YSzhwYSwLeOiyRV4+7wlKYnL2t8wFGtqiElhmbF8ca32aiixp+6F1l
         PhghCxJpflnlO99rNhpsdceYXJQh9USx/tCcIrHWjs8WotR+1FYkR6JmlWSTyNZ+LRlh
         Rry82mrPg4G3CdlIW0pFZ1jOXrqrivYrv1WjuXQnk6Xri9T2ZK/mDn/g0Z+EP1tnrTUe
         KuhzaCWzeu5Y/vOd1TUfCHA656YxaYCuPOgFBgMGV3P9/liskSXxLVzXxi05JHUYW/me
         W+3Q==
X-Gm-Message-State: AOAM5328v1bD1ctSh54JrOY73VCib9pSM9gWyl2Kb8gahI2hebfvOFjO
        inoKo06zX/IHEQyCBxOTWodPkA==
X-Google-Smtp-Source: ABdhPJyD6ZXOo0uH2byplvxKFOGNhtYjssgC3vW/C5IOn2jogunBIlScXNTSvyOG9QEfJsqJvAUPCA==
X-Received: by 2002:a05:6402:104c:: with SMTP id e12mr12739081edu.108.1616740880178;
        Thu, 25 Mar 2021 23:41:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id ci22sm125325ejc.54.2021.03.25.23.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 23:41:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 4/9] soundwire: qcom: start the clock during initialization
Date:   Fri, 26 Mar 2021 06:39:39 +0000
Message-Id: <20210326063944.31683-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
References: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start the clock during initialization, doing this explicitly
will add more clarity when we are adding clock stop feature.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 43ec22a5e332..2bcb4362f0e0 100644
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

