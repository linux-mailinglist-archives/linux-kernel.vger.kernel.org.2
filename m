Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A66233C2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhCOQ5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbhCOQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:56:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AF0C061765
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so16918676wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdZJGNP62lIlEnEmG/cCC95BLhByXorN62IvToLdpl4=;
        b=WAQzO0mHPFAvj8xI6C+JLfJgBcnurW3P3e7LtcjfLvIf+WQJ9obNauAt0jq26jtK76
         OyiyoEK6/MtbMXRt7XjRdOfJdHcAeqCq6igi58b20Juqge1uldi96B7qgd+Q+qFAzpDp
         cv5NKQbh9xv73qG55vroWhwyxUzHUj+xzuSXUNcJDqHlssvr60Je4bnPaVeRebskFXGT
         tU+CQee1BdIR8CdSHwrSxbFv98zZDq0mUWHSwA0QMsp5HXjxlzXpdqOIQ1q514Ee9jAq
         2vbwOuX3taRNxDjolBiT71am2IVNcwP3DfTisGlPnMKTIoUrIk/KcyVIS2loXhcjnM2b
         Qb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdZJGNP62lIlEnEmG/cCC95BLhByXorN62IvToLdpl4=;
        b=aZXDliyFf/3E8rL0N7FyLcGLMlQ7OtgGXiKB5MfBlNdLoXqwCOG/wWIPUJRvxhRRmP
         VtKq7SUzDWO/lvCcm2EgraC/jKKQ9PS4RdcFuifQQp5PuBP57/U38tSJ1Y9TIhsEz6Aj
         Gb8A6L267RFKp0GrF3GyZvWaiFP0x/S0r8dkdriZk2MG6kyHwQuW1oEs22WdhU1mn5kk
         G1+R4Q5p6IKxZawP5s3NUoaqi+fxmLsZ3d8J8fH9LJ0vnbFcT7J/n+8nn52YxOkGwVmM
         SAsjiCoN2VPPQZPSYq+8UXTTFSBiVVDji9GmVZ3EXtfUfLw4dSo5ohkZrX3oGgR1xZmt
         gDYw==
X-Gm-Message-State: AOAM5329VHTgLDZYXEBq8zi3blpnNMGW/yBC6H+KZRhg9oBnmx8JGOqo
        egJtqHYEemus8pFkaz2gB/u/2g==
X-Google-Smtp-Source: ABdhPJz+BWyXwz0jvNyXMbTMfZ43xKFg0RJhHtzf6kb7SKHhgc0lis02/+Wod6+ttRTzO1PhItkG9w==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr601189wmi.178.1615827415959;
        Mon, 15 Mar 2021 09:56:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o2sm227656wmc.23.2021.03.15.09.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:56:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 2/5] soundwire: qcom: update port map allocation bit mask
Date:   Mon, 15 Mar 2021 16:56:47 +0000
Message-Id: <20210315165650.13392-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
References: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
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

