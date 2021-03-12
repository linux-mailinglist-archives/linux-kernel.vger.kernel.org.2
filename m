Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D66338BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhCLLj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCLLjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:39:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFDBC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:39:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j18so1592146wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdZJGNP62lIlEnEmG/cCC95BLhByXorN62IvToLdpl4=;
        b=CaEpGLROapFSyEsbpQ8h7ChCWbrVvjZu89qEwLT1qmPRGh3aFAt30AWwNPA12bdEA9
         3vmmAVbyF0ACcemSISR5fII2jLwnaYLUhLOhikeTRSQHuxTUV+zKCTRR5GvR6bMuLtqr
         mrS33KiXKmS0k873wvx1630n2bAyAIJwWnqhau07dPKibKzbPHU7yFGwcfGDzkrV/Vwb
         n7C+XxbkiYcMBg7KXoF0cNUPKMpS6VZPzx45z52B5AFKvDCyQwGWeBbJedxGlP9ED0U6
         hOFIzWWXh5miOpQw4Y2yJ3ReMN6NRid5HsUi8L9YnrF6+SL/1HD7iseiyzAvlUOdQQIQ
         LN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdZJGNP62lIlEnEmG/cCC95BLhByXorN62IvToLdpl4=;
        b=pSJ03MmuWToSvYop9A+MRzxHxjXU+MFtUIQ6vhmjkq29d+O8622avuWolrqbJ1CQvT
         wetQkSbT6/Tm0oGz0IoIXjWl7e03lOw58GA1NTEiOw7NxQi1Rd1z4pCuUMmIAMXdQlZs
         Z5zQAHm+diOxXReVuy3Y7M8cnNvnafHkqLQTbVaFM95C3ZdX71AGSImUPOFv34RzMx5t
         NUEqKVpwl2Ii2fil6qktVZstVK8hBN8pu2SeamcV5NyDhgLfJUR2jkhxrY8xKdrjOwVn
         djmHxFMyaHOufjYsDFiLdvhqdP05E/ozjRUnRGTA3vOLmSqLeiaE/7pi2FXfwHWFM/Te
         McfA==
X-Gm-Message-State: AOAM532e+YJutJowJBIzIzFDOlqwkdQG+ZHcVxlzBV9hdDGISlV/ZL7v
        jYJaeup9eLgL4tSIIFlUrxpwtA==
X-Google-Smtp-Source: ABdhPJxPiHqJ2teUxa1h+rK3erzgxHiWrKqOimyliV6bJaVVDR08JXlkk+Z3MPNe13ucAudHUMk+0Q==
X-Received: by 2002:a5d:4c84:: with SMTP id z4mr13452958wrs.158.1615549175874;
        Fri, 12 Mar 2021 03:39:35 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z1sm7412458wru.95.2021.03.12.03.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:39:35 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 2/5] soundwire: qcom: update port map allocation bit mask
Date:   Fri, 12 Mar 2021 11:39:26 +0000
Message-Id: <20210312113929.17512-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210312113929.17512-1-srinivas.kandagatla@linaro.org>
References: <20210312113929.17512-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently the internal bitmask used for allocating ports starts with offset 0.
This is bit confusing as data port numbers on Qualcomm controller are valid
from 1 to 14. So adjust this bit mask accordingly, this will also help while
adding static port map support.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6d22df01f354..9e70c53e2c7b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -519,7 +519,7 @@ static void qcom_swrm_stream_free_ports(struct qcom_swrm_ctrl *ctrl,
 			port_mask = &ctrl->din_port_mask;
 
 		list_for_each_entry(p_rt, &m_rt->port_list, port_node)
-			clear_bit(p_rt->num - 1, port_mask);
+			clear_bit(p_rt->num, port_mask);
 	}
 
 	mutex_unlock(&ctrl->port_lock);
@@ -552,13 +552,13 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
 				/* Port numbers start from 1 - 14*/
 				pn = find_first_zero_bit(port_mask, maxport);
-				if (pn > (maxport - 1)) {
+				if (pn > maxport) {
 					dev_err(ctrl->dev, "All ports busy\n");
 					ret = -EBUSY;
 					goto err;
 				}
 				set_bit(pn, port_mask);
-				pconfig[nports].num = pn + 1;
+				pconfig[nports].num = pn;
 				pconfig[nports].ch_mask = p_rt->ch_mask;
 				nports++;
 			}
@@ -580,7 +580,7 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 err:
 	if (ret) {
 		for (i = 0; i < nports; i++)
-			clear_bit(pconfig[i].num - 1, port_mask);
+			clear_bit(pconfig[i].num, port_mask);
 	}
 
 	mutex_unlock(&ctrl->port_lock);
@@ -754,6 +754,9 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	ctrl->num_dout_ports = val;
 
 	nports = ctrl->num_dout_ports + ctrl->num_din_ports;
+	/* Valid port numbers are from 1-14, so mask out port 0 explicitly */
+	set_bit(0, &ctrl->dout_port_mask);
+	set_bit(0, &ctrl->din_port_mask);
 
 	ret = of_property_read_u8_array(np, "qcom,ports-offset1",
 					off1, nports);
-- 
2.21.0

