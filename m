Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DDC330FFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhCHNut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhCHNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:50:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CF1C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:50:11 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso3834439wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9XrbiDhvP0gxPijEAUSSoalvOl5K//POj60zxztmUAs=;
        b=kE+OM2aBjpltfWtltwjlP+6iR+/LPf5s0WhqnXFlZ35c1q7cwW0SWIAtN3aknukLu+
         EB4XCMYwcQWbNAN6VlWw1iMG3GNAw+RFh7xzYJlg2tlwuNNh6nMmp5xMDhCZ8qndZCt+
         fN911dWcm/3aiLpFAM/9zXIp4ltH4u+NKxc1KC0LgydXEbzJq+dnn/UrGzdH+uEl6NfV
         Ox+PqDSnXL0omJDXNjRhxJFBAVwPF3J+s8gnclto/AXKyBAIB+OGBT4AhzbyiYZFD0kq
         nBcvPkobdN74K2CDdMTcfuCBte/dJ1zrVi7p0VX7IyWJK8izHN4o3stR1GdUslnnI5Tr
         UN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9XrbiDhvP0gxPijEAUSSoalvOl5K//POj60zxztmUAs=;
        b=MXbD2u5E0BGk9YTfEh8hUWdscvPLTTC5RoB9P/FGCy1YUlPq4BwXfafoHah4iZCjo6
         lnTNSsX+rmdlYgW8cyLVXJAwDfO7sZKPiH17TYMumsYoruTf/Fr81d+maOkJKJcbfli/
         047Nqwc2KkWzfJMFfjnaj5gsFrCcXgaOHgaLY1YUuU+v9oncWGN0GdGOT30xN0qE9YK0
         C7Cdjknnz50m0y1rvTq/8Y9jqPy25AhQJm6ayKKhVeOF3q2ZKwhzaKKe91w7NM6T2w/V
         xBaeHQlWIo5pBerFVPKyGiQOZhwuFp5Y74sFiqalIXTA4Z3t32xF7Ax1DGR5KdPsgiAB
         dvXQ==
X-Gm-Message-State: AOAM533p2HHit2knzseggrnyELIM0ktz41AxyZg0zJXQarkKqfGxaX1o
        9wWgfsWoinGG/9KOSDWxtWUcnA==
X-Google-Smtp-Source: ABdhPJxR3Rp7cA8Clm97GPcGoTTceotc9jg1rSAdJAiMJxxE/KWYenduMGDrgX2kqrvx7yTS8EiyPA==
X-Received: by 2002:a05:600c:284:: with SMTP id 4mr22672574wmk.24.1615211410097;
        Mon, 08 Mar 2021 05:50:10 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h22sm19490589wmb.36.2021.03.08.05.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:50:09 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 4/9] soundwire: qcom: start the clock during initialization
Date:   Mon,  8 Mar 2021 13:49:52 +0000
Message-Id: <20210308134957.16024-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
References: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
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
index 076a2b1b6d6d..071d05d3a971 100644
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

