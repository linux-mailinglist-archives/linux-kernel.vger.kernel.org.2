Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90BB308BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhA2RgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhA2Rdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:33:41 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253BDC061793
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:33:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f16so7435204wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eONmBCImMt12oRSP39RxbUr8Npi7ApzTyCqDK+i9RD4=;
        b=I3pg9tfLnTHfjB2H0AIKW/Sy2XzgCDvoebmNiJAxjzvE84bV+3IVDhFWh7xjv/BHwE
         a4N7DEV9M1285ElbyqbZZVo1nOaibXGfVJVKX1oJ29h600KK/VD6orbi8rKA/DVIXo8t
         /hTV/0LBmFWB+8vE4PM1D7YUBHvHgH0bOWKIxnlEbzlMl6M455aBBAUkZkp/UMRh1uuz
         tigaQ4VoODJ7Uvu96qi1JajZgStNH9buqm3A2C2PvwSLQGRI/lQjSCzvPrqepqfkSeBI
         QRA8OyqheqLFYa0j0N/erYU9g9q7Oeu8AL1TZt7qIj7GivpC9YyjHlLUI84+hmeoeLdm
         SaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eONmBCImMt12oRSP39RxbUr8Npi7ApzTyCqDK+i9RD4=;
        b=r7/nBh1E3A0PX3ZNciZPRzVQVF2TYOpC2j0Gm4GFmaNe65xHKp9LesJhvy4cOYhlzl
         ZFcUcQUe6JKdVLoPjysIKgpLSP9OAgpZ/PkeeT18zo83tzOM2qk0HqVy8y5ECMy5J0iq
         bGGRzBxtV0Uffp5TMNsTTmVXkzIKH8ZP4ZtVrzMBFPF+vemzlK5NwWN11ij6g+44TPR/
         +jA62uX0yFZTqPkidRz6yRoyXW6442nnJboXQMnvpw53/JEyGE3cbPPfmovQ83cp8pq2
         CZ/3RXAt+5pJT8iokS+fBwlyi/ObRrDlP9ikLXiawxeLtWiVHZspht2nWcJGMjVJhWnN
         Oz/Q==
X-Gm-Message-State: AOAM533EHRM0fukP8xfNtX4/WG0PMsad9d8rwuoJpcBQ30YqCDDYSC+R
        JD8UKrGxvb97KoyFDzcEjPe9gbqzpSrO+A==
X-Google-Smtp-Source: ABdhPJxi3zNFX7lDhzWQF3xuka/mdUMJ2B/LfYFZGdOvLMOEwSnE4U5Xz/11texoMUiaiMkOYjSt6Q==
X-Received: by 2002:a05:600c:27d1:: with SMTP id l17mr4816004wmb.18.1611941579861;
        Fri, 29 Jan 2021 09:32:59 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h18sm13202294wru.65.2021.01.29.09.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:32:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/6] soundwire: qcom: start the clock during initialization
Date:   Fri, 29 Jan 2021 17:32:46 +0000
Message-Id: <20210129173248.5941-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start the clock during initialization.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 3669bac11a32..83df15d83935 100644
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
@@ -345,6 +347,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
+	ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
 	/* Configure number of retries of a read/write cmd */
 	if (ctrl->version_major == 1 && ctrl->version_minor >= 5 &&
 	    ctrl->version_step >= 1) {
-- 
2.21.0

