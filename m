Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A5F338C35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhCLMA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhCLMA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:00:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84EBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:00:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso15010923wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5UMSCe0vmgofjLfGXC2dqndVDx3SCra42urjGkx2FI=;
        b=Nt9ZBV3nfcXevgLOhmcv3mpcPVnLP6rZ1H0C09HFJfJtby13DIfhYUYaGYGm4s6rW7
         D+ky2wsBj3cfmw8DTRi52RAOwccl6WfgDFxOjCKSghzT7xvvkYDcyCWiuuNiyvxRpj7y
         5eeMUVEkF8AU7Xe/TrlSPw1GMFtMFvc2nWTj2MWQhGsoKx/7+CwZlG6fMQf00mzFKqrr
         AkrSpa1he6GRmqssvShKBz1p4KF3Mh8TuJWdciUYh+fhu4K4QN8+HVN9O9duSje8MSLy
         oNt2CXgBch/3YXCXrvMTmKGPYvsjQFa6lTQOorWRAsDCPgPR5x8K2zhn0YiP7uQvZwdE
         Ns7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5UMSCe0vmgofjLfGXC2dqndVDx3SCra42urjGkx2FI=;
        b=rm4dDk+pP9fkVQROrs/qcHpTom5/xX7uvm2g5YJU5/c6UXffvnkAHNUH/vSSyOvr/I
         MoOkeLkSpTM5tF/XaGGy3ChJ+CAETYYqP67n5G55ZOrEUx3nifnRFjCEPnoXTpQJH/Nf
         tIarnx30mViP4QYBmUmWcwPNGsSnZEHcNFvnerFArFyyt4AClC6a5vLT3AIJ6RLp6bnY
         +xOLBUru1GS07hWlZCHtoI4OJJT9qLAXk5PDAnw580mkaz3b3zww+PU92LkeZ5B3Gh5L
         QsLhBX/dmTc0aVeCdHeKRtCl0ujbFpVpweLbBwEyE3Oqf9xOVY0E4SxphaPSXL+AES+G
         QqVQ==
X-Gm-Message-State: AOAM531XwYYSOSoshjLurR8zzc11rJ2SvDuhOSfEnK05i07zrOhL4MaB
        ouQLnet4bRR8g+d3+0QKugu6+g==
X-Google-Smtp-Source: ABdhPJwhd4bkdARLj0koN7Eu8meG+HnheqN2+Je2CxV9trNDKRbhtPFwWAZZwprkTasNyVFFUJpXhQ==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr12918925wmf.17.1615550427439;
        Fri, 12 Mar 2021 04:00:27 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h25sm2268315wml.32.2021.03.12.04.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:00:27 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 4/9] soundwire: qcom: start the clock during initialization
Date:   Fri, 12 Mar 2021 12:00:04 +0000
Message-Id: <20210312120009.22386-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
References: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
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

